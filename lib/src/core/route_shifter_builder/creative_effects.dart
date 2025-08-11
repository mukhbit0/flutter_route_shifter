// lib/src/effects_mixin/creative_effects.dart
import 'package:flutter/material.dart';

import '../../../flutter_route_shifter.dart';
import '../../effects/glass_morph_effect.dart';
import '../../effects/glitch_effect.dart';
import '../../effects/mask_effect.dart';
import '../../effects/perspective_effect.dart';
import '../../effects/physics_spring_effect.dart';

/// Mixin that provides advanced and creative effects for RouteShifterBuilder.
mixin CreativeEffects {
  List<dynamic> get _effects;

  /// Adds a 3D perspective effect.
  dynamic perspective({
    double beginRotateX = 0.0,
    double endRotateX = 0.0,
    double beginRotateY = 0.0,
    double endRotateY = 0.0,
    Alignment alignment = Alignment.center,
    double perspective = 0.001,
    Duration? duration,
    Curve? curve,
  }) {
    _effects.add(PerspectiveEffect(
      beginRotateX: beginRotateX,
      endRotateX: endRotateX,
      beginRotateY: beginRotateY,
      endRotateY: endRotateY,
      alignment: alignment,
      perspective: perspective,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    ));
    return this;
  }

  /// Adds a horizontal card flip effect.
  dynamic flipHorizontal({
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      perspective(beginRotateY: -0.5, alignment: alignment, duration: duration);

  /// Adds a "frosted glass" or glassmorphism effect.
  dynamic glassMorph({
    double blur = 10.0,
    Color color = const Color(0x1AFFFFFF),
    BorderRadius borderRadius = BorderRadius.zero,
    Duration? duration,
  }) {
    _effects.add(GlassMorphEffect(
      endBlur: blur,
      endColor: color,
      borderRadius: borderRadius,
      duration: duration,
    ));
    return this;
  }

  /// Reveals the page using another widget as a mask.
  dynamic mask({
    required Widget maskChild,
    double beginScale = 0.0,
    double endScale = 30.0,
    Duration? duration,
    Curve? curve,
  }) {
    _effects.add(MaskEffect(
      maskChild: maskChild,
      beginScale: beginScale,
      endScale: endScale,
      duration: duration,
      curve: curve ?? Curves.easeOut,
    ));
    return this;
  }

  /// Drives an effect using a physics-based spring simulation.
  dynamic spring({
    required RouteEffect effect,
    double stiffness = 100.0,
    double damping = 10.0,
    double mass = 1.0,
  }) {
    _effects.add(PhysicsSpringEffect(
      effect: effect,
      stiffness: stiffness,
      damping: damping,
      mass: mass,
    ));
    return this;
  }

  /// Adds a stylistic digital glitch effect.
  dynamic glitch({
    double intensity = 5.0,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    _effects.add(GlitchEffect(
      intensity: intensity,
      duration: duration,
    ));
    return this;
  }
}
