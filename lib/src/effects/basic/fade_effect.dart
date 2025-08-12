import 'package:flutter/material.dart';
import '../base/effect.dart';

/// A fade transition effect that animates opacity from 0.0 to 1.0.
///
/// This effect creates a smooth fade-in animation for route transitions.
/// Can be combined with other effects for complex animations.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .fade(duration: Duration(milliseconds: 300))
///   .slide()
///   .toRoute(page: NextPage())
/// ```
class FadeEffect extends RouteEffect {
  /// The starting opacity value (0.0 to 1.0).
  final double beginOpacity;

  /// The ending opacity value (0.0 to 1.0).
  final double endOpacity;

  /// Creates a fade effect.
  ///
  /// [beginOpacity] defaults to 0.0 (fully transparent)
  /// [endOpacity] defaults to 1.0 (fully opaque)
  const FadeEffect({
    this.beginOpacity = 0.0,
    this.endOpacity = 1.0,
    super.duration,
    super.curve = Curves.easeInOut,
    super.start,
    super.end,
  })  : assert(beginOpacity >= 0.0 && beginOpacity <= 1.0,
            'beginOpacity must be between 0.0 and 1.0'),
        assert(endOpacity >= 0.0 && endOpacity <= 1.0,
            'endOpacity must be between 0.0 and 1.0');

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    // Create an opacity tween from begin to end
    final opacityTween = Tween<double>(
      begin: beginOpacity,
      end: endOpacity,
    );

    return FadeTransition(
      opacity: opacityTween.animate(animation),
      child: child,
    );
  }

  @override
  FadeEffect copyWith({
    double? beginOpacity,
    double? endOpacity,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return FadeEffect(
      beginOpacity: beginOpacity ?? this.beginOpacity,
      endOpacity: endOpacity ?? this.endOpacity,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a fade-in effect (from transparent to opaque).
  factory FadeEffect.fadeIn({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return FadeEffect(
      beginOpacity: 0.0,
      endOpacity: 1.0,
      duration: duration,
      curve: curve ?? Curves.easeIn,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a fade-out effect (from opaque to transparent).
  factory FadeEffect.fadeOut({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return FadeEffect(
      beginOpacity: 1.0,
      endOpacity: 0.0,
      duration: duration,
      curve: curve ?? Curves.easeOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FadeEffect &&
          beginOpacity == other.beginOpacity &&
          endOpacity == other.endOpacity;

  @override
  int get hashCode => Object.hash(super.hashCode, beginOpacity, endOpacity);

  @override
  String toString() => 'FadeEffect(begin: $beginOpacity, end: $endOpacity, '
      'duration: $duration, curve: $curve)';
}
