import 'package:flutter/material.dart';
import '../../effects/advanced/perspective_effect.dart';

/// Mixin that provides perspective and 3D effects for RouteShifterBuilder.
mixin PerspectiveEffects {
  List<dynamic> get effects;

  /// Adds a 3D perspective effect.
  dynamic perspective({
    double beginRotateX = 0.0,
    double endRotateX = 0.0,
    double beginRotateY = 0.0,
    double endRotateY = 0.0,
    Alignment alignment = Alignment.center,
    double perspective = 0.001,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(PerspectiveEffect(
      beginRotateX: beginRotateX,
      endRotateX: endRotateX,
      beginRotateY: beginRotateY,
      endRotateY: endRotateY,
      alignment: alignment,
      perspective: perspective,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a horizontal card flip effect.
  dynamic flipHorizontal({
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      perspective(beginRotateY: -0.5, alignment: alignment, duration: duration);

  /// Adds a vertical card flip effect.
  dynamic flipVertical({
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      perspective(beginRotateX: -0.5, alignment: alignment, duration: duration);

  /// Adds a 3D cube rotation effect.
  dynamic cubeRotation({
    double rotationX = 0.25,
    double rotationY = 0.25,
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      perspective(
        beginRotateX: rotationX,
        beginRotateY: rotationY,
        alignment: alignment,
        duration: duration,
      );
}
