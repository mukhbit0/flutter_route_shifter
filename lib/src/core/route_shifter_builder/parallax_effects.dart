import 'package:flutter/material.dart';
import '../../effects/parallax_effect.dart';

/// Extension methods for parallax effects on RouteShifterBuilder.
mixin ParallaxEffects {
  List<dynamic> get _effects;

  /// Adds a parallax effect for creating depth.
  dynamic parallax({
    double backgroundSpeed = 0.3,
    ParallaxDirection direction = ParallaxDirection.horizontal,
    bool blurBackground = false,
    double blurSigma = 2.0,
    bool scaleBackground = false,
    double backgroundScale = 0.95,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(ParallaxEffect(
      backgroundSpeed: backgroundSpeed,
      direction: direction,
      blurBackground: blurBackground,
      blurSigma: blurSigma,
      scaleBackground: scaleBackground,
      backgroundScale: backgroundScale,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a horizontal parallax effect.
  dynamic horizontalParallax({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Adds a vertical parallax effect.
  dynamic verticalParallax({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.vertical,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Adds a depth parallax effect with blur and scale.
  dynamic depthParallax({
    double speed = 0.2,
    double blurSigma = 3.0,
    double scale = 0.9,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: true,
      blurSigma: blurSigma,
      scaleBackground: true,
      backgroundScale: scale,
      duration: duration,
    );
  }

  /// Adds a multi-layer parallax effect.
  dynamic multiLayerParallax({
    List<double> layerSpeeds = const [0.1, 0.3, 0.6, 1.0],
    ParallaxDirection direction = ParallaxDirection.horizontal,
    bool useLayeredBlur = true,
    bool useLayeredScale = true,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    _effects.add(MultiLayerParallaxEffect(
      layerSpeeds: layerSpeeds,
      direction: direction,
      useLayeredBlur: useLayeredBlur,
      useLayeredScale: useLayeredScale,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a cinematic parallax effect.
  dynamic cinematicParallax({
    Duration? duration,
  }) {
    return multiLayerParallax(
      layerSpeeds: const [0.1, 0.25, 0.5, 0.75, 1.0],
      direction: ParallaxDirection.horizontal,
      useLayeredBlur: true,
      useLayeredScale: true,
      duration: duration,
    );
  }
}
