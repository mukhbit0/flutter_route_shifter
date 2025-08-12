import 'package:flutter/material.dart';
import '../../effects/creative/glass_morph_effect.dart';

/// Mixin that provides glass morphism effects for RouteShifterBuilder.
mixin GlassMorphEffects {
  List<dynamic> get effects;

  /// Adds a "frosted glass" or glassmorphism effect.
  dynamic glassMorph({
    double beginBlur = 0.0,
    double endBlur = 10.0,
    Color beginColor = Colors.transparent,
    Color endColor = const Color(0x1AFFFFFF),
    BorderRadius borderRadius = BorderRadius.zero,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(GlassMorphEffect(
      beginBlur: beginBlur,
      endBlur: endBlur,
      beginColor: beginColor,
      endColor: endColor,
      borderRadius: borderRadius,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a subtle glass effect.
  dynamic subtleGlass({
    Duration? duration,
  }) =>
      glassMorph(
        endBlur: 5.0,
        endColor: const Color(0x10FFFFFF),
        duration: duration,
      );

  /// Adds a strong glass effect.
  dynamic strongGlass({
    Duration? duration,
  }) =>
      glassMorph(
        endBlur: 20.0,
        endColor: const Color(0x30FFFFFF),
        duration: duration,
      );

  /// Adds a tinted glass effect.
  dynamic tintedGlass({
    Color tintColor = const Color(0x20000000),
    Duration? duration,
  }) =>
      glassMorph(
        endBlur: 15.0,
        endColor: tintColor,
        duration: duration,
      );
}
