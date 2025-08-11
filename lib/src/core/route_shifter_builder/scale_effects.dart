import 'package:flutter/material.dart';
import '../../effects/scale_effect.dart';

/// Mixin that provides scale effects for RouteShifterBuilder.
mixin ScaleEffects {
  List<dynamic> get _effects;

  /// Adds a scale effect to the transition.
  dynamic scale({
    double beginScale = 0,
    double endScale = 1,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    _effects.add(ScaleEffect(
      beginScale: beginScale,
      endScale: endScale,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a scale up effect.
  dynamic scaleUp({
    double from = 0.0,
    Duration? duration,
    Curve curve = Curves.elasticOut,
  }) {
    return scale(
      beginScale: from,
      endScale: 1.0,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a scale down effect.
  dynamic scaleDown({
    double to = 0.0,
    Duration? duration,
    Curve curve = Curves.easeIn,
  }) {
    return scale(
      beginScale: 1.0,
      endScale: to,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a bounce scale effect.
  dynamic bounceScale({
    double from = 0.0,
    Duration? duration,
  }) {
    return scale(
      beginScale: from,
      endScale: 1.0,
      duration: duration,
      curve: Curves.bounceOut,
    );
  }
}
