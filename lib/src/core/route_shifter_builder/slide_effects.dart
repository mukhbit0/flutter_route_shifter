import 'package:flutter/material.dart';
// file: lib/src/core/route_shifter_builder/slide_effects.dart
import '../../effects/basic/slide_effect.dart';

/// Mixin that provides slide effects for RouteShifterBuilder.
mixin SlideEffects {
  List<dynamic> get effects;

  /// Adds a slide effect to the transition.
  dynamic slide({
    Offset beginOffset = const Offset(1.0, 0.0),
    Offset endOffset = Offset.zero,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) {
    effects.add(SlideEffect(
      begin: beginOffset,
      offsetEnd: endOffset,
      duration: duration,
      curve: curve,
      start: intervalStart,
      end: intervalEnd,
    ));
    return this;
  }

  /// Adds a slide from right effect.
  dynamic slideFromRight({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      slide(
        beginOffset: const Offset(1, 0),
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );

  /// Adds a slide from left effect.
  dynamic slideFromLeft({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      slide(
        beginOffset: const Offset(-1, 0),
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );

  /// Adds a slide from top effect.
  dynamic slideFromTop({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      slide(
        beginOffset: const Offset(0, -1),
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );

  /// Adds a slide from bottom effect.
  dynamic slideFromBottom({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double intervalStart = 0,
    double intervalEnd = 1,
  }) =>
      slide(
        beginOffset: const Offset(0, 1),
        duration: duration,
        curve: curve,
        intervalStart: intervalStart,
        intervalEnd: intervalEnd,
      );
}
