import 'package:flutter/material.dart';
import '../../effects/slide_effect.dart';

/// Mixin that provides slide effects for RouteShifterBuilder.
mixin SlideEffects {
  List<dynamic> get _effects;

  /// Adds a slide effect to the transition.
  dynamic slide({
    Offset begin = const Offset(1.0, 0.0),
    Offset offsetEnd = Offset.zero,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    _effects.add(SlideEffect(
      begin: begin,
      offsetEnd: offsetEnd,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a slide from right effect.
  dynamic slideFromRight({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) =>
      slide(
        begin: const Offset(1, 0),
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );

  /// Adds a slide from left effect.
  dynamic slideFromLeft({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) =>
      slide(
        begin: const Offset(-1, 0),
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );

  /// Adds a slide from top effect.
  dynamic slideFromTop({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) =>
      slide(
        begin: const Offset(0, -1),
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );

  /// Adds a slide from bottom effect.
  dynamic slideFromBottom({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) =>
      slide(
        begin: const Offset(0, 1),
        duration: duration,
        curve: curve,
        start: start,
        end: end,
      );
}
