import 'package:flutter/material.dart';
import '../../effects/creative/mask_effect.dart';

/// Mixin that provides mask effects for RouteShifterBuilder.
mixin MaskEffects {
  List<dynamic> get effects;

  /// Reveals the page using another widget as a mask.
  dynamic mask({
    required Widget maskChild,
    double beginScale = 0.0,
    double endScale = 30.0,
    Duration? duration,
    Curve curve = Curves.easeOut,
  }) {
    effects.add(MaskEffect(
      maskChild: maskChild,
      beginScale: beginScale,
      endScale: endScale,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Creates a circular mask reveal effect.
  dynamic circularReveal({
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      mask(
        maskChild: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        duration: duration,
      );

  /// Creates a square mask reveal effect.
  dynamic squareReveal({
    Alignment alignment = Alignment.center,
    Duration? duration,
  }) =>
      mask(
        maskChild: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
          ),
        ),
        duration: duration,
      );

  /// Creates a star-shaped mask reveal effect.
  dynamic starMaskReveal({
    Duration? duration,
  }) =>
      mask(
        maskChild: const Icon(
          Icons.star,
          color: Colors.white,
          size: 50,
        ),
        duration: duration,
      );
}
