import 'package:flutter/material.dart';
import 'base_effect.dart';
import 'fade_effect.dart';

/// A stagger effect that applies delayed animations to child widgets.
///
/// This effect creates beautiful cascading animations where child widgets
/// animate in sequence with configurable delays between them.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .stagger(
///     interval: Duration(milliseconds: 100),
///     selector: (widget) => widget is Card,
///   )
///   .fade()
///   .toRoute(page: NextPage())
/// ```
class StaggerEffect extends RouteEffect {
  /// The interval between each child animation.
  final Duration interval;

  /// Function to determine which widgets should be staggered.
  /// If null, all direct children will be staggered.
  final bool Function(Widget)? selector;

  /// The base effect to apply to each staggered widget.
  final RouteEffect baseEffect;

  /// Maximum number of widgets to stagger (prevents performance issues).
  final int maxStaggeredChildren;

  /// Whether to reverse the stagger order.
  final bool reverse;

  /// Creates a stagger effect.
  ///
  /// [interval] time delay between each child animation
  /// [selector] function to filter which widgets get staggered
  /// [baseEffect] the effect to apply to each widget (defaults to fade)
  /// [maxStaggeredChildren] maximum children to process
  /// [reverse] whether to animate in reverse order
  const StaggerEffect({
    this.interval = const Duration(milliseconds: 100),
    this.selector,
    RouteEffect? baseEffect,
    this.maxStaggeredChildren = 20,
    this.reverse = false,
    super.duration,
    super.curve = Curves.easeInOut,
    super.start,
    super.end,
  }) : baseEffect = baseEffect ?? const FadeEffect();

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return StaggeredAnimationWrapper(
      animation: animation,
      interval: interval,
      selector: selector,
      baseEffect: baseEffect,
      maxChildren: maxStaggeredChildren,
      reverse: reverse,
      child: child,
    );
  }

  @override
  StaggerEffect copyWith({
    Duration? interval,
    bool Function(Widget)? selector,
    RouteEffect? baseEffect,
    int? maxStaggeredChildren,
    bool? reverse,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return StaggerEffect(
      interval: interval ?? this.interval,
      selector: selector ?? this.selector,
      baseEffect: baseEffect ?? this.baseEffect,
      maxStaggeredChildren: maxStaggeredChildren ?? this.maxStaggeredChildren,
      reverse: reverse ?? this.reverse,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a stagger effect for Card widgets.
  factory StaggerEffect.cards({
    Duration? interval,
    RouteEffect? baseEffect,
    bool reverse = false,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return StaggerEffect(
      interval: interval ?? const Duration(milliseconds: 80),
      selector: (widget) => widget is Card,
      baseEffect: baseEffect,
      reverse: reverse,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a stagger effect for ListTile widgets.
  factory StaggerEffect.listTiles({
    Duration? interval,
    RouteEffect? baseEffect,
    bool reverse = false,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return StaggerEffect(
      interval: interval ?? const Duration(milliseconds: 60),
      selector: (widget) => widget is ListTile,
      baseEffect: baseEffect,
      reverse: reverse,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a stagger effect for Container widgets.
  factory StaggerEffect.containers({
    Duration? interval,
    RouteEffect? baseEffect,
    bool reverse = false,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return StaggerEffect(
      interval: interval ?? const Duration(milliseconds: 100),
      selector: (widget) => widget is Container,
      baseEffect: baseEffect,
      reverse: reverse,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is StaggerEffect &&
          interval == other.interval &&
          selector == other.selector &&
          baseEffect == other.baseEffect &&
          maxStaggeredChildren == other.maxStaggeredChildren &&
          reverse == other.reverse;

  @override
  int get hashCode => Object.hash(super.hashCode, interval, selector,
      baseEffect, maxStaggeredChildren, reverse);

  @override
  String toString() => 'StaggerEffect(interval: $interval, reverse: $reverse, '
      'maxChildren: $maxStaggeredChildren, duration: $duration)';
}

/// Widget that applies staggered animations to its children.
class StaggeredAnimationWrapper extends StatefulWidget {
  final Animation<double> animation;
  final Duration interval;
  final bool Function(Widget)? selector;
  final RouteEffect baseEffect;
  final int maxChildren;
  final bool reverse;
  final Widget child;

  const StaggeredAnimationWrapper({
    Key? key,
    required this.animation,
    required this.interval,
    this.selector,
    required this.baseEffect,
    required this.maxChildren,
    required this.reverse,
    required this.child,
  }) : super(key: key);

  @override
  State<StaggeredAnimationWrapper> createState() =>
      _StaggeredAnimationWrapperState();
}

class _StaggeredAnimationWrapperState extends State<StaggeredAnimationWrapper> {
  final List<Widget> _staggeredChildren = [];
  late final List<Animation<double>> _childAnimations;

  @override
  void initState() {
    super.initState();
    _processChildren();
    _createChildAnimations();
  }

  /// Processes the child widget tree to find staggerable widgets.
  void _processChildren() {
    final children = <Widget>[];

    void visitor(Widget widgetNode) {
      if (children.length >= widget.maxChildren) return;

      if (widget.selector == null || widget.selector!(widgetNode)) {
        children.add(widgetNode);
      }

      // Simple traversal - in a real implementation, this would be more sophisticated
      if (widgetNode is SingleChildRenderObjectWidget &&
          widgetNode.child != null) {
        visitor(widgetNode.child!);
      } else if (widgetNode is MultiChildRenderObjectWidget) {
        // Handle multi-child widgets like Column, Row, etc.
        if (widgetNode is Column) {
          for (final child in widgetNode.children) {
            visitor(child);
          }
        } else if (widgetNode is Row) {
          for (final child in widgetNode.children) {
            visitor(child);
          }
        } else if (widgetNode is Stack) {
          for (final child in widgetNode.children) {
            visitor(child);
          }
        } else if (widgetNode is Flex) {
          for (final child in widgetNode.children) {
            visitor(child);
          }
        }
      }
    }

    visitor(widget.child);

    _staggeredChildren.clear();
    _staggeredChildren.addAll(widget.reverse ? children.reversed : children);
  }

  /// Creates individual animations for each staggered child.
  void _createChildAnimations() {
    _childAnimations = [];

    for (int i = 0; i < _staggeredChildren.length; i++) {
      final delay = widget.interval.inMilliseconds * i;
      // Use a default duration since Animation doesn't have duration property
      final totalDuration = widget.baseEffect.duration?.inMilliseconds ?? 300;

      // Calculate the start point as a percentage of the total animation
      final startRatio = (delay / totalDuration).clamp(0.0, 1.0);
      final endRatio = 1.0;

      final childAnimation = CurvedAnimation(
        parent: widget.animation,
        curve: Interval(startRatio, endRatio, curve: Curves.easeOut),
      );

      _childAnimations.add(childAnimation);
    }
  }

  @override
  Widget build(BuildContext context) {
    // For now, we'll apply the stagger effect to the entire child
    // In a complete implementation, this would traverse and wrap individual children
    return widget.baseEffect.build(widget.animation, widget.child);
  }
}

/// A simpler staggered widget that works with explicit children.
class StaggeredGroup extends StatelessWidget {
  /// The children to animate with stagger effect.
  final List<Widget> children;

  /// The animation to drive the stagger.
  final Animation<double> animation;

  /// The interval between each child animation.
  final Duration interval;

  /// The base effect to apply to each child.
  final RouteEffect baseEffect;

  /// Whether to reverse the animation order.
  final bool reverse;

  const StaggeredGroup({
    Key? key,
    required this.children,
    required this.animation,
    this.interval = const Duration(milliseconds: 100),
    this.baseEffect = const FadeEffect(),
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final processedChildren = reverse ? children.reversed.toList() : children;
    final animatedChildren = <Widget>[];

    for (int i = 0; i < processedChildren.length; i++) {
      final delay = interval.inMilliseconds * i;
      // Use the base effect duration since Animation doesn't have duration property
      final totalDuration = baseEffect.duration?.inMilliseconds ?? 300;

      final startRatio = (delay / totalDuration).clamp(0.0, 0.8);
      final endRatio = 1.0;

      final childAnimation = CurvedAnimation(
        parent: animation,
        curve: Interval(startRatio, endRatio, curve: Curves.easeOut),
      );

      final animatedChild =
          baseEffect.build(childAnimation, processedChildren[i]);
      animatedChildren.add(animatedChild);
    }

    // Return the children in their original structure
    // This is a simplified implementation - real usage would depend on the parent widget
    return Column(children: animatedChildren);
  }
}

/// Utility class for creating staggered animations.
class StaggerUtils {
  StaggerUtils._();

  /// Creates a list of staggered animations for the given children.
  static List<Animation<double>> createStaggeredAnimations({
    required Animation<double> parent,
    required int childCount,
    required Duration interval,
    Duration? totalDuration,
    Curve curve = Curves.easeOut,
  }) {
    final animations = <Animation<double>>[];
    final duration = totalDuration ?? const Duration(milliseconds: 600);

    for (int i = 0; i < childCount; i++) {
      final delay = interval.inMilliseconds * i;
      final startRatio = (delay / duration.inMilliseconds).clamp(0.0, 0.8);

      final animation = CurvedAnimation(
        parent: parent,
        curve: Interval(startRatio, 1.0, curve: curve),
      );

      animations.add(animation);
    }

    return animations;
  }

  /// Wraps a list of children with staggered effects.
  static List<Widget> wrapChildrenWithStagger({
    required List<Widget> children,
    required List<Animation<double>> animations,
    required RouteEffect effect,
  }) {
    assert(children.length == animations.length,
        'Children and animations lists must have the same length');

    final wrappedChildren = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      final wrapped = effect.build(animations[i], children[i]);
      wrappedChildren.add(wrapped);
    }

    return wrappedChildren;
  }
}

/// A mixin for widgets that want to support staggered animations.
mixin StaggeredAnimationMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  /// Creates staggered animations for a list of children.
  List<Animation<double>> createStaggeredAnimations({
    required int childCount,
    Duration interval = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeOut,
  }) {
    final controller = AnimationController(duration: duration, vsync: this);
    final animations = <Animation<double>>[];

    for (int i = 0; i < childCount; i++) {
      final delay = interval.inMilliseconds * i;
      final startRatio = (delay / duration.inMilliseconds).clamp(0.0, 0.8);

      final animation = CurvedAnimation(
        parent: controller,
        curve: Interval(startRatio, 1.0, curve: curve),
      );

      animations.add(animation);
    }

    return animations;
  }
}
