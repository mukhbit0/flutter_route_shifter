import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../base/effect.dart';

/// Creates depth by moving screens at different speeds.
///
/// This effect creates a sense of depth by moving the outgoing screen at a
/// different speed than the incoming screen. As the new page slides in,
/// the old page slides out more slowly in the background.
class ParallaxEffect extends RouteEffect {
  /// The speed multiplier for the background layer (0.0 to 1.0).
  /// 0.0 means no movement, 1.0 means same speed as foreground.
  final double backgroundSpeed;

  /// The direction of the parallax movement.
  final ParallaxDirection direction;

  /// Whether to apply blur to the background layer for depth effect.
  final bool blurBackground;

  /// The sigma value for the background blur.
  final double blurSigma;

  /// Whether to scale the background layer.
  final bool scaleBackground;

  /// The scale factor for the background layer.
  final double backgroundScale;

  const ParallaxEffect({
    this.backgroundSpeed = 0.3,
    this.direction = ParallaxDirection.horizontal,
    this.blurBackground = false,
    this.blurSigma = 2.0,
    this.scaleBackground = false,
    this.backgroundScale = 0.95,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    // Note: This effect requires access to both incoming and outgoing pages
    // In a full implementation, this would be handled by the RouteShifter
    // using the secondaryAnimation parameter

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final offset = _calculateOffset(animation.value);

        Widget effectChild = child;

        // Apply blur if enabled
        if (blurBackground) {
          effectChild = _applyBlur(effectChild, animation.value);
        }

        // Apply scaling if enabled
        if (scaleBackground) {
          effectChild = _applyScale(effectChild, animation.value);
        }

        return Transform.translate(
          offset: offset,
          child: effectChild,
        );
      },
    );
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ParallaxEffect(
      backgroundSpeed: backgroundSpeed,
      direction: direction,
      blurBackground: blurBackground,
      blurSigma: blurSigma,
      scaleBackground: scaleBackground,
      backgroundScale: backgroundScale,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Calculates the offset based on direction and speed.
  Offset _calculateOffset(double progress) {
    final adjustedProgress = progress * backgroundSpeed;

    switch (direction) {
      case ParallaxDirection.horizontal:
        return Offset(-adjustedProgress * 300, 0); // Assuming screen width ~300
      case ParallaxDirection.vertical:
        return Offset(
            0, -adjustedProgress * 600); // Assuming screen height ~600
      case ParallaxDirection.diagonal:
        return Offset(-adjustedProgress * 300, -adjustedProgress * 600);
    }
  }

  /// Applies blur to create depth effect.
  Widget _applyBlur(Widget child, double progress) {
    final blurValue = blurSigma * progress;
    if (blurValue <= 0) return child;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
      child: child,
    );
  }

  /// Applies scaling to create depth effect.
  Widget _applyScale(Widget child, double progress) {
    final scale = 1.0 - ((1.0 - backgroundScale) * progress);
    return Transform.scale(
      scale: scale,
      child: child,
    );
  }

  /// Creates a horizontal parallax effect.
  factory ParallaxEffect.horizontal({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return ParallaxEffect(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Creates a vertical parallax effect.
  factory ParallaxEffect.vertical({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return ParallaxEffect(
      backgroundSpeed: speed,
      direction: ParallaxDirection.vertical,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Creates a depth parallax effect with blur and scale.
  factory ParallaxEffect.depth({
    double speed = 0.2,
    double blurSigma = 3.0,
    double scale = 0.9,
    Duration? duration,
  }) {
    return ParallaxEffect(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: true,
      blurSigma: blurSigma,
      scaleBackground: true,
      backgroundScale: scale,
      duration: duration,
    );
  }
}

/// Direction for parallax movement.
enum ParallaxDirection {
  horizontal,
  vertical,
  diagonal,
}

/// Advanced parallax effect with multiple layers.
class MultiLayerParallaxEffect extends RouteEffect {
  /// The speeds for each parallax layer (background to foreground).
  final List<double> layerSpeeds;

  /// The direction of movement.
  final ParallaxDirection direction;

  /// Whether to apply different blur levels to each layer.
  final bool useLayeredBlur;

  /// Whether to apply different scales to each layer.
  final bool useLayeredScale;

  const MultiLayerParallaxEffect({
    this.layerSpeeds = const [0.1, 0.3, 0.6, 1.0],
    this.direction = ParallaxDirection.horizontal,
    this.useLayeredBlur = true,
    this.useLayeredScale = true,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    // This would create multiple layers with different speeds
    // For demonstration, we'll apply the fastest layer speed
    final mainSpeed = layerSpeeds.isNotEmpty ? layerSpeeds.last : 1.0;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final offset = _calculateLayerOffset(animation.value, mainSpeed);

        Widget effectChild = child;

        if (useLayeredBlur) {
          final blurAmount = 2.0 * (1.0 - mainSpeed);
          effectChild = _applyBlur(effectChild, animation.value * blurAmount);
        }

        if (useLayeredScale) {
          final scale = 0.9 + (0.1 * mainSpeed);
          effectChild = Transform.scale(scale: scale, child: effectChild);
        }

        return Transform.translate(
          offset: offset,
          child: effectChild,
        );
      },
    );
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return MultiLayerParallaxEffect(
      layerSpeeds: layerSpeeds,
      direction: direction,
      useLayeredBlur: useLayeredBlur,
      useLayeredScale: useLayeredScale,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Calculates offset for a specific layer.
  Offset _calculateLayerOffset(double progress, double layerSpeed) {
    final adjustedProgress = progress * layerSpeed;

    switch (direction) {
      case ParallaxDirection.horizontal:
        return Offset(-adjustedProgress * 300, 0);
      case ParallaxDirection.vertical:
        return Offset(0, -adjustedProgress * 600);
      case ParallaxDirection.diagonal:
        return Offset(-adjustedProgress * 300, -adjustedProgress * 600);
    }
  }

  /// Applies blur effect.
  Widget _applyBlur(Widget child, double blurAmount) {
    if (blurAmount <= 0) return child;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
      child: child,
    );
  }
}

/// Curved parallax effect with non-linear movement paths.
class CurvedParallaxEffect extends RouteEffect {
  /// The curve for the background movement.
  final Curve backgroundCurve;

  /// The curve for the foreground movement.
  final Curve foregroundCurve;

  /// The amplitude of the curved movement.
  final double curveAmplitude;

  /// The frequency of the curved movement.
  final double curveFrequency;

  const CurvedParallaxEffect({
    this.backgroundCurve = Curves.easeOut,
    this.foregroundCurve = Curves.easeIn,
    this.curveAmplitude = 50.0,
    this.curveFrequency = 1.0,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final curvedProgress = foregroundCurve.transform(animation.value);
        final horizontalOffset = -curvedProgress * 300;
        final verticalOffset = curveAmplitude *
            math.sin(2 * math.pi * curveFrequency * curvedProgress);

        return Transform.translate(
          offset: Offset(horizontalOffset, verticalOffset),
          child: child,
        );
      },
    );
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return CurvedParallaxEffect(
      backgroundCurve: backgroundCurve,
      foregroundCurve: foregroundCurve,
      curveAmplitude: curveAmplitude,
      curveFrequency: curveFrequency,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
