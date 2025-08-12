import 'package:flutter/material.dart';
import '../../effects/creative/glitch_effect.dart';

/// Mixin that provides glitch and digital effects for RouteShifterBuilder.
mixin GlitchEffects {
  List<dynamic> get effects;

  /// Adds a stylistic digital glitch effect.
  dynamic glitch({
    double intensity = 5.0,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(GlitchEffect(
      intensity: intensity,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a subtle glitch effect.
  dynamic subtleGlitch({
    Duration? duration,
  }) =>
      glitch(
        intensity: 2.0,
        duration: duration ?? const Duration(milliseconds: 200),
      );

  /// Adds an intense glitch effect.
  dynamic intenseGlitch({
    Duration? duration,
  }) =>
      glitch(
        intensity: 10.0,
        duration: duration ?? const Duration(milliseconds: 600),
      );

  /// Adds a quick glitch effect.
  dynamic quickGlitch({
    Duration? duration,
  }) =>
      glitch(
        intensity: 7.0,
        duration: duration ?? const Duration(milliseconds: 150),
      );

  /// Adds a slow motion glitch effect.
  dynamic slowGlitch({
    Duration? duration,
  }) =>
      glitch(
        intensity: 15.0,
        duration: duration ?? const Duration(milliseconds: 800),
      );
}
