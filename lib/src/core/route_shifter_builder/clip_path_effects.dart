import 'package:flutter/material.dart';
import '../../effects/creative/clip_path_effect.dart';

/// Mixin that provides clip path effects for RouteShifterBuilder.
mixin ClipPathEffects {
  List<dynamic> get effects;

  /// Adds a clip path effect for dramatic reveals.
  dynamic clipPath({
    ClipPathType type = ClipPathType.circle,
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    effects.add(ClipPathEffect(
      type: type,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a circle reveal clip path effect.
  dynamic circleReveal({
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.circle,
      direction: ClipDirection.center,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a rectangle reveal clip path effect.
  dynamic rectangleReveal({
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.rectangle,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a star reveal clip path effect.
  dynamic starReveal({
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.star,
      direction: ClipDirection.center,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a wave reveal clip path effect.
  dynamic waveReveal({
    ClipDirection direction = ClipDirection.left,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.wave,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a triangle reveal clip path effect.
  dynamic triangleReveal({
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.triangle,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a diamond reveal clip path effect.
  dynamic diamondReveal({
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.diamond,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }
}
