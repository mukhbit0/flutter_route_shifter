// lib/src/effects/glass_morph_effect.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'base_effect.dart';

/// Creates a "frosted glass" or "glassmorphism" effect.
///
/// Combines a background blur with a semi-transparent color overlay,
/// a popular technique in modern UI design for modals and overlays.
class GlassMorphEffect extends RouteEffect {
  final double beginBlur;
  final double endBlur;
  final Color beginColor;
  final Color endColor;
  final BorderRadius borderRadius;

  const GlassMorphEffect({
    this.beginBlur = 0.0,
    this.endBlur = 10.0,
    this.beginColor = Colors.transparent,
    this.endColor = const Color(0x1AFFFFFF), // White with 10% opacity
    this.borderRadius = BorderRadius.zero,
    super.duration,
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final blur =
        Tween<double>(begin: beginBlur, end: endBlur).animate(animation);
    final color =
        ColorTween(begin: beginColor, end: endColor).animate(animation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, currentChild) {
        // Only apply the filter if there's a blur to avoid performance cost
        final bool isBlurring = blur.value > 0.01;
        return ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              // The child is always at the bottom
              currentChild!,
              // The glass effect is an overlay
              if (isBlurring)
                BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blur.value, sigmaY: blur.value),
                  child: Container(
                      color: Colors.transparent), // Needs a container to work
                ),
              Container(color: color.value),
            ],
          ),
        );
      },
      child: child,
    );
  }

  @override
  RouteEffect copyWith({
    double? beginBlur,
    double? endBlur,
    Color? beginColor,
    Color? endColor,
    BorderRadius? borderRadius,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return GlassMorphEffect(
      beginBlur: beginBlur ?? this.beginBlur,
      endBlur: endBlur ?? this.endBlur,
      beginColor: beginColor ?? this.beginColor,
      endColor: endColor ?? this.endColor,
      borderRadius: borderRadius ?? this.borderRadius,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
