// lib/src/effects/perspective_effect.dart
import 'package:flutter/material.dart';
import 'base_effect.dart';
import 'dart:math' as math;

/// Creates a 3D perspective rotation effect for route transitions.
///
/// Animates the rotation of a page around the X or Y axis with a
/// sense of depth, creating "card flip" or "door swing" effects.
class PerspectiveEffect extends RouteEffect {
  /// The starting rotation around the X-axis in half-turns (0.5 = 90°).
  final double beginRotateX;

  /// The ending rotation around the X-axis.
  final double endRotateX;

  /// The starting rotation around the Y-axis.
  final double beginRotateY;

  /// The ending rotation around the Y-axis.
  final double endRotateY;

  /// The alignment for the rotation origin.
  final Alignment alignment;

  /// The perspective value for the Matrix4 transform.
  final double perspective;

  const PerspectiveEffect({
    this.beginRotateX = 0.0,
    this.endRotateX = 0.0,
    this.beginRotateY = 0.0,
    this.endRotateY = 0.0,
    this.alignment = Alignment.center,
    this.perspective = 0.001,
    super.duration,
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final rotateX =
        Tween<double>(begin: beginRotateX, end: endRotateX).animate(animation);
    final rotateY =
        Tween<double>(begin: beginRotateY, end: endRotateY).animate(animation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, currentChild) {
        return Transform(
          alignment: alignment,
          transform: Matrix4.identity()
            ..setEntry(3, 2, perspective) // Add perspective
            ..rotateX(rotateX.value * math.pi)
            ..rotateY(rotateY.value * math.pi),
          child: currentChild,
        );
      },
      child: child,
    );
  }

  @override
  RouteEffect copyWith({
    double? beginRotateX,
    double? endRotateX,
    double? beginRotateY,
    double? endRotateY,
    Alignment? alignment,
    double? perspective,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return PerspectiveEffect(
      beginRotateX: beginRotateX ?? this.beginRotateX,
      endRotateX: endRotateX ?? this.endRotateX,
      beginRotateY: beginRotateY ?? this.beginRotateY,
      endRotateY: endRotateY ?? this.endRotateY,
      alignment: alignment ?? this.alignment,
      perspective: perspective ?? this.perspective,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
