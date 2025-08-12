import 'package:flutter/material.dart';
import '../../core/sequenced_item_registry.dart';
import '../base/effect.dart';
import '../basic/slide_effect.dart';

/// Widget that provides animation state to descendant SequencedItem widgets
class SequencedAnimationProvider extends InheritedWidget {
  final bool isAnimating;
  final Set<Object> animatingIds;

  const SequencedAnimationProvider({
    super.key,
    required this.isAnimating,
    required this.animatingIds,
    required super.child,
  });

  static SequencedAnimationProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SequencedAnimationProvider>();
  }

  @override
  bool updateShouldNotify(SequencedAnimationProvider oldWidget) {
    return isAnimating != oldWidget.isAnimating ||
        !identical(animatingIds, oldWidget.animatingIds);
  }
}

/// An effect that animates widgets based on a manually provided sequence of timings.
class SequencedEffect extends RouteEffect {
  /// A map where keys are widget IDs and values are the animation delay.
  final Map<Object, Duration> timings;
  final RouteEffect? baseEffect;

  const SequencedEffect({
    required this.timings,
    this.baseEffect,
    super.duration,
    super.curve, // Constructor now correctly accepts a nullable Curve
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return _SequencedAnimationOverlay(
      animation: animation,
      child: child,
      effect: this,
    );
  }

  // Added the required implementation for the abstract copyWith method.
  @override
  SequencedEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SequencedEffect(
      timings: timings,
      baseEffect: baseEffect,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

class _SequencedAnimationOverlay extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;
  final SequencedEffect effect;

  const _SequencedAnimationOverlay({
    required this.animation,
    required this.child,
    required this.effect,
  });

  @override
  State<_SequencedAnimationOverlay> createState() =>
      _SequencedAnimationOverlayState();
}

class _SequencedAnimationOverlayState
    extends State<_SequencedAnimationOverlay> {
  final List<_AnimatedItem> _animatedItems = [];
  bool _animationsCreated = false;

  @override
  void initState() {
    super.initState();
    _tryCreateAnimations();
  }

  void _tryCreateAnimations() {
    // Schedule repeated attempts to create animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_animationsCreated) {
        _createAnimations();

        // If animations weren't created (items not ready), try again
        if (!_animationsCreated) {
          Future.delayed(const Duration(milliseconds: 50), () {
            _tryCreateAnimations();
          });
        }
      }
    });
  }

  void _createAnimations() {
    final effect = widget.effect;
    final parentAnimation = widget.animation;

    int registeredCount = 0;
    effect.timings.forEach((id, delay) {
      final data = SequencedItemRegistry.instance.get(id);
      if (data != null && data.rect != null) {
        registeredCount++;
      }
    });

    // If not all items are registered yet, don't create animations
    if (registeredCount < effect.timings.length) {
      return;
    }

    // Use a default for the base effect, then get its duration.
    final RouteEffect baseEffect =
        effect.baseEffect ?? const SlideEffect(begin: Offset(0, 0.2));
    final Duration effectDuration =
        baseEffect.duration ?? const Duration(milliseconds: 400);

    Duration totalDuration =
        effect.duration ?? const Duration(milliseconds: 600);
    effect.timings.forEach((id, delay) {
      if (delay + effectDuration > totalDuration) {
        totalDuration = delay + effectDuration;
      }
    });

    _animatedItems.clear(); // Clear any previous items

    effect.timings.forEach((id, delay) {
      final data = SequencedItemRegistry.instance.get(id);
      if (data == null || data.rect == null) {
        return;
      }

      final startTime = delay.inMilliseconds / totalDuration.inMilliseconds;
      final endTime = (delay + effectDuration).inMilliseconds /
          totalDuration.inMilliseconds;

      final animation = CurvedAnimation(
        parent: parentAnimation,
        curve: Interval(
          startTime.clamp(0.0, 1.0),
          endTime.clamp(0.0, 1.0),
          // Use the effect's curve directly since it's not nullable in the new implementation
          curve: effect.curve,
        ),
      );

      _animatedItems.add(_AnimatedItem(
        rect: data.rect!,
        widget: data.widget,
        animation: animation,
      ));
    });

    _animationsCreated = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_animatedItems.isEmpty) {
      return widget.child;
    }

    // Create set of IDs that are currently being animated
    final animatingIds = Set<Object>.from(widget.effect.timings.keys);

    // Simply overlay the animated items on top of the original content
    // The SequencedItems in the original content will be invisible during animation
    return Stack(
      children: [
        // Show the original child with provider that hides SequencedItems during animation
        SequencedAnimationProvider(
          isAnimating: true,
          animatingIds: animatingIds,
          child: widget.child,
        ),
        // Show the animated versions of the sequenced items
        ..._animatedItems.map((item) {
          final baseEffect = widget.effect.baseEffect ??
              const SlideEffect(begin: Offset(0, 0.2));
          return AnimatedBuilder(
            animation: item.animation,
            builder: (context, child) {
              // Calculate the animated position - move from original position to top
              final progress = item.animation.value;
              final startRect = item.rect;

              // Animate from original position to center top of screen
              final screenSize = MediaQuery.of(context).size;
              final targetX = (screenSize.width - startRect.width) / 2;
              final targetY = 100.0; // Position near top

              final animatedLeft =
                  startRect.left + (targetX - startRect.left) * progress;
              final animatedTop =
                  startRect.top + (targetY - startRect.top) * progress;

              return Positioned(
                left: animatedLeft,
                top: animatedTop,
                width: startRect.width,
                height: startRect.height,
                child: baseEffect.build(item.animation, item.widget),
              );
            },
          );
        }),
      ],
    );
  }
}

class _AnimatedItem {
  final Rect rect;
  final Widget widget;
  final Animation<double> animation;

  _AnimatedItem({
    required this.rect,
    required this.widget,
    required this.animation,
  });
}
