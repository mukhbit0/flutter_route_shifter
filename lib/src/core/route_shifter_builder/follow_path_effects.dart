import 'package:flutter/material.dart';
import '../../effects/creative/follow_path_effect.dart';

/// Extension methods for follow path effects on RouteShifterBuilder.
mixin FollowPathEffects {
  List<dynamic> get effects;

  /// Adds a follow path effect for non-linear motion.
  dynamic followPath({
    required Path path,
    bool rotateAlongPath = false,
    double rotationOffset = 0.0,
    Offset pathOrigin = Offset.zero,
    bool usePreciseMetrics = true,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    effects.add(FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      rotationOffset: rotationOffset,
      pathOrigin: pathOrigin,
      usePreciseMetrics: usePreciseMetrics,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a circular path effect.
  dynamic circularPath({
    required double radius,
    double startAngle = 0.0,
    double sweepAngle = 6.283185307179586, // 2 * pi
    Offset center = Offset.zero,
    bool clockwise = true,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.circular(
      radius: radius,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      center: center,
      clockwise: clockwise,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a wave path effect.
  dynamic wavePath({
    required double width,
    required double height,
    double amplitude = 50.0,
    double frequency = 2.0,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.wave(
      width: width,
      height: height,
      amplitude: amplitude,
      frequency: frequency,
      startPoint: startPoint,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a spiral path effect.
  dynamic spiralPath({
    required double maxRadius,
    double turns = 3.0,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.spiral(
      maxRadius: maxRadius,
      turns: turns,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds an S-curve path effect.
  dynamic sCurvePath({
    required double width,
    required double height,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.sCurve(
      width: width,
      height: height,
      startPoint: startPoint,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a heart-shaped path effect.
  dynamic heartPath({
    required double size,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.heart(
      size: size,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a figure-8 path effect.
  dynamic figure8Path({
    required double width,
    required double height,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    effects.add(FollowPathEffect.figure8(
      width: width,
      height: height,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a multi-segment path effect.
  dynamic multiSegmentPath({
    required List<PathSegment> segments,
    bool rotateAlongPath = false,
    SegmentTransition segmentTransition = SegmentTransition.smooth,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(MultiSegmentPathEffect(
      segments: segments,
      rotateAlongPath: rotateAlongPath,
      segmentTransition: segmentTransition,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a particle trail path effect.
  dynamic particleTrailPath({
    required Path path,
    int particleCount = 5,
    double trailFadeDuration = 0.3,
    bool rotateParticles = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    effects.add(ParticleTrailPathEffect(
      path: path,
      particleCount: particleCount,
      trailFadeDuration: trailFadeDuration,
      rotateParticles: rotateParticles,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a bezier curve path effect.
  dynamic bezierPath({
    required Offset start,
    required Offset end,
    required Offset control1,
    Offset? control2,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    final path = Path();
    path.moveTo(start.dx, start.dy);

    if (control2 != null) {
      path.cubicTo(
          control1.dx, control1.dy, control2.dx, control2.dy, end.dx, end.dy);
    } else {
      path.quadraticBezierTo(control1.dx, control1.dy, end.dx, end.dy);
    }

    return followPath(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }
}
