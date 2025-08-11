import 'package:flutter/material.dart';
import '../../effects/fade_effect.dart';

/// Mixin that provides fade effects for RouteShifterBuilder.
mixin FadeEffects {
  List<dynamic> get _effects;

  /// Adds a fade effect to the transition.
  dynamic fade({
    double beginOpacity = 0,
    double endOpacity = 1,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    _effects.add(FadeEffect(
      beginOpacity: beginOpacity,
      endOpacity: endOpacity,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a fade in effect.
  dynamic fadeIn({
    Duration? duration,
    Curve curve = Curves.easeIn,
    double start = 0,
    double end = 1,
  }) =>
      fade(
        beginOpacity: 0,
        endOpacity: 1,
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );

  /// Adds a fade out effect.
  dynamic fadeOut({
    Duration? duration,
    Curve curve = Curves.easeOut,
    double start = 0,
    double end = 1,
  }) =>
      fade(
        beginOpacity: 1,
        endOpacity: 0,
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );
}
