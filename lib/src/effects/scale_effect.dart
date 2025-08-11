import 'package:flutter/material.dart';
import 'base_effect.dart';

/// A scale transition effect that animates the size from one scale to another.
///
/// This effect creates smooth scaling animations, commonly used for pop-up
/// dialogs, zoom transitions, and Material Design shared axis transitions.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .scale(begin: 0.8, end: 1.0)
///   .fade()
///   .toRoute(page: NextPage())
/// ```
class ScaleEffect extends RouteEffect {
  /// The starting scale value.
  final double beginScale;

  /// The ending scale value.
  final double endScale;

  /// The alignment point for scaling.
  /// Defaults to center scaling.
  final Alignment alignment;

  /// Creates a scale effect.
  ///
  /// [beginScale] is the starting scale (typically 0.0-1.0 for scale-up)
  /// [endScale] is the ending scale (typically 1.0 for normal size)
  /// [alignment] determines the scaling origin point
  const ScaleEffect({
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.alignment = Alignment.center,
    super.duration,
    super.curve = Curves.easeInOut,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final scaleTween = Tween<double>(begin: beginScale, end: endScale);

    return ScaleTransition(
      scale: scaleTween.animate(animation),
      alignment: alignment,
      child: child,
    );
  }

  @override
  ScaleEffect copyWith({
    double? beginScale,
    double? endScale,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ScaleEffect(
      beginScale: beginScale ?? this.beginScale,
      endScale: endScale ?? this.endScale,
      alignment: alignment ?? this.alignment,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a scale-up effect (from small to normal size).
  factory ScaleEffect.scaleUp({
    double begin = 0.8,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ScaleEffect(
      beginScale: begin,
      endScale: 1.0,
      alignment: alignment ?? Alignment.center,
      duration: duration,
      curve: curve ?? Curves.easeOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a scale-down effect (from normal to small size).
  factory ScaleEffect.scaleDown({
    double end = 0.8,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? endInterval,
  }) {
    return ScaleEffect(
      beginScale: 1.0,
      endScale: end,
      alignment: alignment ?? Alignment.center,
      duration: duration,
      curve: curve ?? Curves.easeIn,
      start: start ?? 0.0,
      end: endInterval ?? 1.0,
    );
  }

  /// Creates a bounce scale effect that overshoots then settles.
  factory ScaleEffect.bounce({
    Alignment? alignment,
    Duration? duration,
    double? start,
    double? end,
  }) {
    return ScaleEffect(
      beginScale: 0.0,
      endScale: 1.0,
      alignment: alignment ?? Alignment.center,
      duration: duration,
      curve: Curves.elasticOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a pop effect with quick scale-up animation.
  factory ScaleEffect.pop({
    Alignment? alignment,
    Duration? duration,
    double? start,
    double? end,
  }) {
    return ScaleEffect(
      beginScale: 0.0,
      endScale: 1.0,
      alignment: alignment ?? Alignment.center,
      duration: duration ?? const Duration(milliseconds: 200),
      curve: Curves.easeOutBack,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ScaleEffect &&
          beginScale == other.beginScale &&
          endScale == other.endScale &&
          alignment == other.alignment;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, beginScale, endScale, alignment);

  @override
  String toString() => 'ScaleEffect(begin: $beginScale, end: $endScale, '
      'alignment: $alignment, duration: $duration, curve: $curve)';
}
