// file: lib/src/core/route_shifter_builder/advanced_effects.dart
import 'package:flutter/material.dart';
import '../../effects/blur_effect.dart';
import '../../effects/rotation_effect.dart';
import '../../effects/sequenced_effect.dart';
import '../../effects/stagger_effect.dart';
import '../../effects/base_effect.dart';

/// Mixin that provides advanced effects for RouteShifterBuilder.
mixin AdvancedEffects {
  List<dynamic> get effects;

  /// Adds a blur effect to the transition.
  dynamic blur({
    double beginSigma = 0,
    double endSigma = 5,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    effects.add(BlurEffect(
      beginSigma: beginSigma,
      endSigma: endSigma,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a blur in effect.
  dynamic blurIn({
    double maxBlur = 10,
    Duration? duration,
  }) =>
      blur(
        beginSigma: maxBlur,
        endSigma: 0,
        duration: duration,
        curve: Curves.easeOut,
      );

  /// Adds a blur out effect.
  dynamic blurOut({
    double maxBlur = 10,
    Duration? duration,
  }) =>
      blur(
        beginSigma: 0,
        endSigma: maxBlur,
        duration: duration,
        curve: Curves.easeIn,
      );

  /// Adds a rotation effect to the transition.
  dynamic rotation({
    double beginTurns = 0,
    double endTurns = 0.25, // 90 degrees
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    effects.add(RotationEffect(
      beginTurns: beginTurns,
      endTurns: endTurns,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a clockwise rotation effect.
  dynamic rotateClockwise({
    double turns = 0.25, // 90 degrees
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) =>
      rotation(
        beginTurns: 0,
        endTurns: turns,
        duration: duration,
        curve: curve,
      );

  /// Adds a counter-clockwise rotation effect.
  dynamic rotateCounterClockwise({
    double turns = 0.25, // 90 degrees
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) =>
      rotation(
        beginTurns: 0,
        endTurns: -turns,
        duration: duration,
        curve: curve,
      );

  /// Adds a stagger effect to the transition.
  dynamic stagger({
    Duration? interval,
    bool Function(Widget)? selector,
    RouteEffect? baseEffect,
    int maxStaggeredChildren = 20,
    bool reverse = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(StaggerEffect(
      interval: interval,
      selector: selector,
      baseEffect: baseEffect,
      maxStaggeredChildren: maxStaggeredChildren,
      reverse: reverse,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Animates widgets based on a manually defined sequence of timings.
  dynamic sequenced({
    required Map<Object, Duration> timings,
    RouteEffect? baseEffect,
    Duration? duration,
    Curve? curve,
  }) {
    effects.add(SequencedEffect(
      timings: timings,
      baseEffect: baseEffect,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    ));
    return this;
  }
}
