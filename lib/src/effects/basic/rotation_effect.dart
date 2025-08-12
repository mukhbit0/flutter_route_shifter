import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../base/effect.dart';

/// A rotation transition effect that animates rotation from one angle to another.
///
/// This effect creates smooth rotation animations, useful for creative transitions
/// and adding dynamic movement to route changes.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .rotation(turns: 0.25) // 90 degree rotation
///   .fade()
///   .toRoute(page: NextPage())
/// ```
class RotationEffect extends RouteEffect {
  /// The starting rotation in turns (0.0 = 0°, 0.5 = 180°, 1.0 = 360°).
  final double beginTurns;

  /// The ending rotation in turns.
  final double endTurns;

  /// The alignment point for rotation.
  final Alignment alignment;

  /// Creates a rotation effect.
  ///
  /// [beginTurns] is the starting rotation (0.0 = no rotation)
  /// [endTurns] is the ending rotation
  /// [alignment] determines the rotation origin point
  const RotationEffect({
    this.beginTurns = 0.0,
    this.endTurns = 0.0,
    this.alignment = Alignment.center,
    super.duration,
    super.curve = Curves.easeInOut,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final rotationTween = Tween<double>(begin: beginTurns, end: endTurns);

    return RotationTransition(
      turns: rotationTween.animate(animation),
      alignment: alignment,
      child: child,
    );
  }

  @override
  RotationEffect copyWith({
    double? beginTurns,
    double? endTurns,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return RotationEffect(
      beginTurns: beginTurns ?? this.beginTurns,
      endTurns: endTurns ?? this.endTurns,
      alignment: alignment ?? this.alignment,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a clockwise rotation effect.
  factory RotationEffect.clockwise({
    double turns = 1.0,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return RotationEffect(
      beginTurns: 0.0,
      endTurns: turns,
      alignment: alignment ?? Alignment.center,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a counter-clockwise rotation effect.
  factory RotationEffect.counterClockwise({
    double turns = 1.0,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return RotationEffect(
      beginTurns: 0.0,
      endTurns: -turns,
      alignment: alignment ?? Alignment.center,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a spin effect with multiple full rotations.
  factory RotationEffect.spin({
    double spins = 2.0,
    bool clockwise = true,
    Alignment? alignment,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return RotationEffect(
      beginTurns: 0.0,
      endTurns: clockwise ? spins : -spins,
      alignment: alignment ?? Alignment.center,
      duration: duration ?? const Duration(milliseconds: 800),
      curve: curve ?? Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a wobble effect that rotates back and forth.
  factory RotationEffect.wobble({
    double amplitude = 0.1, // Amount of wobble in turns
    Alignment? alignment,
    Duration? duration,
    double? start,
    double? end,
  }) {
    return RotationEffect(
      beginTurns: -amplitude,
      endTurns: amplitude,
      alignment: alignment ?? Alignment.center,
      duration: duration ?? const Duration(milliseconds: 400),
      curve: Curves.elasticInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Converts turns to degrees for display purposes.
  double get beginDegrees => beginTurns * 360;
  double get endDegrees => endTurns * 360;

  /// Converts turns to radians for mathematical operations.
  double get beginRadians => beginTurns * 2 * math.pi;
  double get endRadians => endTurns * 2 * math.pi;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RotationEffect &&
          beginTurns == other.beginTurns &&
          endTurns == other.endTurns &&
          alignment == other.alignment;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, beginTurns, endTurns, alignment);

  @override
  String toString() =>
      'RotationEffect(begin: ${beginDegrees.toStringAsFixed(1)}°, '
      'end: ${endDegrees.toStringAsFixed(1)}°, alignment: $alignment, '
      'duration: $duration, curve: $curve)';
}
