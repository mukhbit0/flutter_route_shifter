import 'package:flutter/material.dart';
import '../../effects/fade_effect.dart';

/// Mixin that provides fade effects for RouteShifterBuilder.
mixin FadeEffects {
  List<dynamic> get effects;

  /// Adds a fade effect to the transition.
  dynamic fade({
    double beginOpacity = 0,
    double endOpacity = 1,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) {
    effects.add(FadeEffect(
      beginOpacity: beginOpacity,
      endOpacity: endOpacity,
      duration: duration,
      curve: curve,
      start: intervalStart,
      end: intervalEnd,
    ));
    return this;
  }

  /// Adds a fade in effect.
  dynamic fadeIn({
    Duration? duration,
    Curve curve = Curves.easeIn,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      fade(
        beginOpacity: 0,
        endOpacity: 1,
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );

  /// Adds a fade out effect.
  dynamic fadeOut({
    Duration? duration,
    Curve curve = Curves.easeOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      fade(
        beginOpacity: 1,
        endOpacity: 0,
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );
}
