import 'package:flutter/material.dart';
import 'base_effect.dart';

/// A slide transition effect that animates position from one offset to another.
///
/// This effect creates smooth slide animations commonly used in route transitions.
/// Supports all directions (left, right, up, down) with customizable offsets.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .slide(direction: SlideDirection.right)
///   .toRoute(page: NextPage())
/// ```
class SlideEffect extends RouteEffect {
  /// The starting offset position.
  final Offset begin;

  /// The ending offset position.
  final Offset offsetEnd;

  /// Creates a slide effect with custom begin and end offsets.
  /// [begin] is the starting position (typically off-screen)
  /// [offsetEnd] is the ending position (typically Offset.zero for on-screen)
  const SlideEffect({
    required this.begin,
    this.offsetEnd = Offset.zero,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  /// Creates a slide effect from the right edge of the screen.
  factory SlideEffect.fromRight({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SlideEffect(
      begin: const Offset(1.0, 0.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a slide effect from the left edge of the screen.
  factory SlideEffect.fromLeft({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SlideEffect(
      begin: const Offset(-1.0, 0.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a slide effect from the top edge of the screen.
  factory SlideEffect.fromTop({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SlideEffect(
      begin: const Offset(0.0, -1.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a slide effect from the bottom edge of the screen.
  factory SlideEffect.fromBottom({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SlideEffect(
      begin: const Offset(0.0, 1.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final offsetTween = Tween<Offset>(begin: begin, end: offsetEnd);
    return SlideTransition(
      position: offsetTween.animate(animation),
      child: child,
    );
  }

  @override
  SlideEffect copyWith({
    Offset? begin,
    Offset? offsetEnd,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return SlideEffect(
      begin: begin ?? this.begin,
      offsetEnd: offsetEnd ?? this.offsetEnd,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is SlideEffect &&
          begin == other.begin &&
          offsetEnd == other.offsetEnd;

  @override
  int get hashCode => Object.hash(super.hashCode, begin, offsetEnd);
}
