// file: lib/src/effects/stagger_effect.dart
import 'package:flutter/material.dart';
import '../base/effect.dart';
import '../basic/slide_effect.dart';

/// An effect that applies delayed animations to specific child widgets of a route.
class StaggerEffect extends RouteEffect {
  final Duration? interval;
  final bool Function(Widget)? selector;
  final RouteEffect? baseEffect;
  final int maxStaggeredChildren;
  final bool reverse;

  const StaggerEffect({
    this.interval,
    this.selector,
    this.baseEffect,
    this.maxStaggeredChildren = 30,
    this.reverse = false,
    super.duration,
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return _StaggerAnimationOverlay(
      animation: animation,
      child: child,
      staggerEffect: this,
    );
  }

  @override
  StaggerEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return StaggerEffect(
      interval: interval,
      selector: selector,
      baseEffect: baseEffect,
      maxStaggeredChildren: maxStaggeredChildren,
      reverse: reverse,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

/// This widget implements the "Layout and Overlay" technique for robust staggering.
class _StaggerAnimationOverlay extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;
  final StaggerEffect staggerEffect;

  const _StaggerAnimationOverlay({
    required this.animation,
    required this.child,
    required this.staggerEffect,
  });

  @override
  State<_StaggerAnimationOverlay> createState() =>
      _StaggerAnimationOverlayState();
}

class _StaggerAnimationOverlayState extends State<_StaggerAnimationOverlay> {
  final List<_StaggeredItem> _staggeredItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _discoverAndAnimate();
      }
    });
  }

  void _discoverAndAnimate() {
    final List<Element> foundElements = [];
    final selector = widget.staggerEffect.selector ?? (_) => false;
    final maxChildren = widget.staggerEffect.maxStaggeredChildren;

    void visit(Element element) {
      if (foundElements.length >= maxChildren) return;
      if (selector(element.widget)) {
        foundElements.add(element);
      }
      element.visitChildren(visit);
    }

    context.visitChildElements(visit);

    final orderedElements = widget.staggerEffect.reverse
        ? foundElements.reversed.toList()
        : foundElements;

    if (orderedElements.isEmpty) {
      setState(() {});
      return;
    }

    final effect = widget.staggerEffect;
    final parentAnimation = widget.animation;
    final baseEffect =
        effect.baseEffect ?? const SlideEffect(begin: Offset(0, 0.2));
    final effectDuration =
        baseEffect.duration ?? const Duration(milliseconds: 400);
    final staggerInterval = effect.interval ?? const Duration(milliseconds: 60);

    // *** THE FIX IS HERE ***
    // The total duration is now calculated dynamically to ensure it's long enough
    // for all staggered items to complete their animation.
    final totalDuration =
        (staggerInterval * (orderedElements.length - 1)) + effectDuration;

    for (int i = 0; i < orderedElements.length; i++) {
      final element = orderedElements[i];
      final renderBox = element.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) continue;

      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final rect = offset & size;

      final delay = staggerInterval * i;
      // These values are now guaranteed to be between 0.0 and 1.0.
      final startTime = delay.inMilliseconds / totalDuration.inMilliseconds;
      final endTime = (delay + effectDuration).inMilliseconds /
          totalDuration.inMilliseconds;

      final animation = CurvedAnimation(
        parent: parentAnimation,
        curve: Interval(
          startTime,
          endTime.clamp(startTime, 1.0), // Clamp is kept as a safeguard
          curve: effect.curve,
        ),
      );

      _staggeredItems.add(_StaggeredItem(
        rect: rect,
        widget: element.widget,
        animation: animation,
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Show the original child until the animated items are ready.
    if (_staggeredItems.isEmpty) {
      return widget.child;
    }

    return Stack(
      children: [
        Opacity(
          opacity: 0.0,
          child: widget.child,
        ),
        ..._staggeredItems.map((item) {
          final baseEffect = widget.staggerEffect.baseEffect ??
              const SlideEffect(begin: Offset(0, 0.2));
          return AnimatedBuilder(
            animation: item.animation,
            builder: (context, child) {
              return Positioned.fromRect(
                rect: item.rect,
                child: baseEffect.build(item.animation, item.widget),
              );
            },
          );
        }),
      ],
    );
  }
}

class _StaggeredItem {
  final Rect rect;
  final Widget widget;
  final Animation<double> animation;

  _StaggeredItem({
    required this.rect,
    required this.widget,
    required this.animation,
  });
}
