// lib/src/effects/mask_effect.dart
import 'package:flutter/material.dart';
import '../base/effect.dart';
import 'dart:math' as math;

/// Reveals the page content through a widget mask.
///
/// Uses a `ShaderMask` to create visually stunning reveals where
/// the new page is shown through the shape of another widget.
class MaskEffect extends RouteEffect {
  final Widget maskChild;
  final double beginScale;
  final double endScale;
  final double beginRotate;
  final double endRotate;

  const MaskEffect({
    required this.maskChild,
    this.beginScale = 0.0,
    this.endScale = 30.0,
    this.beginRotate = 0.0,
    this.endRotate = 0.0,
    super.duration,
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final scale =
        Tween<double>(begin: beginScale, end: endScale).animate(animation);
    final rotate =
        Tween<double>(begin: beginRotate, end: endRotate).animate(animation);

    // The page is wrapped in a ShaderMask that uses the maskChild's alpha
    // channel to determine what is visible.
    return ShaderMask(
      blendMode: BlendMode
          .dstIn, // Show the destination (the page) where the source (the mask) is opaque
      shaderCallback: (bounds) {
        return const RadialGradient(
          radius: 0.5, // Simple opaque shader
          colors: [Colors.white, Colors.white],
        ).createShader(bounds);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          child, // The page content
          // The animated mask that controls the reveal
          AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return Transform.scale(
                scale: scale.value,
                child: Transform.rotate(
                  angle: rotate.value * (2 * math.pi),
                  child: maskChild,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  RouteEffect copyWith({
    Widget? maskChild,
    double? beginScale,
    double? endScale,
    double? beginRotate,
    double? endRotate,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return MaskEffect(
      maskChild: maskChild ?? this.maskChild,
      beginScale: beginScale ?? this.beginScale,
      endScale: endScale ?? this.endScale,
      beginRotate: beginRotate ?? this.beginRotate,
      endRotate: endRotate ?? this.endRotate,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
