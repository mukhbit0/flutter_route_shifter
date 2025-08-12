import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'base_effect.dart';

/// Creates non-linear motion by following a custom path.
///
/// This effect moves widgets along custom paths instead of linear transitions.
/// Useful for creating organic, curved, or complex motion patterns.
class FollowPathEffect extends RouteEffect {
  /// The path to follow during the transition.
  final Path path;

  /// Whether to rotate the widget to follow the path direction.
  final bool rotateAlongPath;

  /// Additional rotation offset in radians.
  final double rotationOffset;

  /// The origin for the path (start point).
  final Offset pathOrigin;

  /// Whether to use path metrics for precise positioning.
  final bool usePreciseMetrics;

  const FollowPathEffect({
    required this.path,
    this.rotateAlongPath = false,
    this.rotationOffset = 0.0,
    this.pathOrigin = Offset.zero,
    this.usePreciseMetrics = true,
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
        try {
          final progress = animation.value;
          final metrics = path.computeMetrics();

          // Safety check: Return child if path is empty
          if (metrics.isEmpty) {
            return Transform.translate(
              offset: pathOrigin,
              child: child,
            );
          }

          final pathMetric = metrics.first;
          final distance = pathMetric.length * progress;

          // Get position and tangent at current distance
          final tangent = pathMetric.getTangentForOffset(distance);
          final position = tangent?.position ?? Offset.zero;
          final angle = tangent?.angle ?? 0.0;

          Widget transformedChild = child;

          // Apply rotation if enabled
          if (rotateAlongPath) {
            transformedChild = Transform.rotate(
              angle: angle + rotationOffset,
              child: transformedChild,
            );
          }

          return Transform.translate(
            offset: position + pathOrigin,
            child: transformedChild,
          );
        } catch (e) {
          // Graceful fallback on any path calculation error
          return Transform.translate(
            offset: pathOrigin,
            child: child,
          );
        }
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
    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      rotationOffset: rotationOffset,
      pathOrigin: pathOrigin,
      usePreciseMetrics: usePreciseMetrics,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a circular path effect.
  factory FollowPathEffect.circular({
    required double radius,
    double startAngle = 0.0,
    double sweepAngle = 2 * math.pi,
    Offset center = Offset.zero,
    bool clockwise = true,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    final path = Path();
    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      clockwise ? sweepAngle : -sweepAngle,
    );

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }

  /// Creates a wave path effect.
  factory FollowPathEffect.wave({
    required double width,
    required double height,
    double amplitude = 50.0,
    double frequency = 2.0,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    for (double x = 0; x <= width; x += 2) {
      final y = startPoint.dy +
          amplitude * math.sin(2 * math.pi * frequency * x / width);
      path.lineTo(startPoint.dx + x, y);
    }

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }

  /// Creates a spiral path effect.
  factory FollowPathEffect.spiral({
    required double maxRadius,
    double turns = 3.0,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    final path = Path();
    path.moveTo(center.dx, center.dy);

    for (double angle = 0; angle <= turns * 2 * math.pi; angle += 0.1) {
      final radius = (angle / (turns * 2 * math.pi)) * maxRadius;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      path.lineTo(x, y);
    }

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }

  /// Creates an S-curve path effect.
  factory FollowPathEffect.sCurve({
    required double width,
    required double height,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    // Create S-curve using cubic bezier
    path.cubicTo(
      startPoint.dx + width * 0.25,
      startPoint.dy - height * 0.5,
      startPoint.dx + width * 0.75,
      startPoint.dy + height * 1.5,
      startPoint.dx + width,
      startPoint.dy + height,
    );

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }

  /// Creates a heart-shaped path effect.
  factory FollowPathEffect.heart({
    required double size,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    final path = Path();

    // Heart shape using parametric equations
    for (double t = 0; t <= 2 * math.pi; t += 0.1) {
      final x = center.dx + size * (16 * math.pow(math.sin(t), 3));
      final y = center.dy -
          size *
              (13 * math.cos(t) -
                  5 * math.cos(2 * t) -
                  2 * math.cos(3 * t) -
                  math.cos(4 * t));

      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }

  /// Creates a figure-8 path effect.
  factory FollowPathEffect.figure8({
    required double width,
    required double height,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    final path = Path();

    // Figure-8 using lemniscate curve
    for (double t = 0; t <= 2 * math.pi; t += 0.1) {
      final scale = 2 / (3 - math.cos(2 * t));
      final x = center.dx + width * scale * math.cos(t);
      final y = center.dy + height * scale * math.sin(2 * t) / 2;

      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    return FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    );
  }
}

/// Advanced path effect with multiple segments and varying speeds.
class MultiSegmentPathEffect extends RouteEffect {
  /// List of path segments to follow.
  final List<PathSegment> segments;

  /// Whether to rotate along the path.
  final bool rotateAlongPath;

  /// Transition style between segments.
  final SegmentTransition segmentTransition;

  const MultiSegmentPathEffect({
    required this.segments,
    this.rotateAlongPath = false,
    this.segmentTransition = SegmentTransition.smooth,
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
        final progress = animation.value;
        final segmentInfo = _getSegmentAtProgress(progress);

        if (segmentInfo == null) return child;

        final segment = segmentInfo.segment;
        final localProgress = segmentInfo.localProgress;

        final pathMetric = segment.path.computeMetrics().first;
        final distance = pathMetric.length * localProgress;
        final tangent = pathMetric.getTangentForOffset(distance);

        final position = tangent?.position ?? Offset.zero;
        final angle = tangent?.angle ?? 0.0;

        Widget transformedChild = child;

        if (rotateAlongPath) {
          transformedChild = Transform.rotate(
            angle: angle,
            child: transformedChild,
          );
        }

        return Transform.translate(
          offset: position,
          child: transformedChild,
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
    return MultiSegmentPathEffect(
      segments: segments,
      rotateAlongPath: rotateAlongPath,
      segmentTransition: segmentTransition,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Gets the current segment and local progress.
  _SegmentInfo? _getSegmentAtProgress(double progress) {
    if (segments.isEmpty) return null;

    double totalWeight =
        segments.fold(0.0, (sum, segment) => sum + segment.weight);
    double currentWeight = 0.0;

    for (final segment in segments) {
      final segmentProgress = segment.weight / totalWeight;
      if (progress <= currentWeight + segmentProgress) {
        final localProgress = (progress - currentWeight) / segmentProgress;
        return _SegmentInfo(segment, localProgress);
      }
      currentWeight += segmentProgress;
    }

    return _SegmentInfo(segments.last, 1.0);
  }
}

/// Represents a segment of a path with timing information.
class PathSegment {
  /// The path for this segment.
  final Path path;

  /// The relative weight/duration of this segment.
  final double weight;

  /// The curve to apply to this segment.
  final Curve curve;

  const PathSegment({
    required this.path,
    this.weight = 1.0,
    this.curve = Curves.linear,
  });
}

/// Information about current segment and progress.
class _SegmentInfo {
  final PathSegment segment;
  final double localProgress;

  _SegmentInfo(this.segment, this.localProgress);
}

/// Transition style between path segments.
enum SegmentTransition {
  /// Smooth transition between segments.
  smooth,

  /// Instant jump between segments.
  instant,

  /// Fade transition between segments.
  fade,
}

/// Path effect with particle trail.
class ParticleTrailPathEffect extends RouteEffect {
  /// The main path to follow.
  final Path path;

  /// Number of trail particles.
  final int particleCount;

  /// Trail fade duration as fraction of main duration.
  final double trailFadeDuration;

  /// Whether to rotate particles along path.
  final bool rotateParticles;

  const ParticleTrailPathEffect({
    required this.path,
    this.particleCount = 5,
    this.trailFadeDuration = 0.3,
    this.rotateParticles = false,
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
        final progress = animation.value;
        final pathMetric = path.computeMetrics().first;

        return Stack(
          children: [
            // Trail particles
            for (int i = 0; i < particleCount; i++)
              _buildTrailParticle(pathMetric, progress, i, child),

            // Main widget
            _buildMainWidget(pathMetric, progress, child),
          ],
        );
      },
    );
  }

  Widget _buildMainWidget(
      PathMetric pathMetric, double progress, Widget child) {
    final distance = pathMetric.length * progress;
    final tangent = pathMetric.getTangentForOffset(distance);
    final position = tangent?.position ?? Offset.zero;
    final angle = tangent?.angle ?? 0.0;

    Widget transformedChild = child;

    if (rotateParticles) {
      transformedChild = Transform.rotate(
        angle: angle,
        child: transformedChild,
      );
    }

    return Transform.translate(
      offset: position,
      child: transformedChild,
    );
  }

  Widget _buildTrailParticle(
      PathMetric pathMetric, double progress, int index, Widget child) {
    final trailProgress = progress - (index + 1) * 0.1;
    if (trailProgress <= 0) return const SizedBox();

    final distance = pathMetric.length * trailProgress;
    final tangent = pathMetric.getTangentForOffset(distance);
    final position = tangent?.position ?? Offset.zero;
    final angle = tangent?.angle ?? 0.0;

    final opacity = (1.0 - (index / particleCount)) * 0.5;

    Widget transformedChild = Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: 1.0 - (index / particleCount) * 0.3,
        child: child,
      ),
    );

    if (rotateParticles) {
      transformedChild = Transform.rotate(
        angle: angle,
        child: transformedChild,
      );
    }

    return Transform.translate(
      offset: position,
      child: transformedChild,
    );
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ParticleTrailPathEffect(
      path: path,
      particleCount: particleCount,
      trailFadeDuration: trailFadeDuration,
      rotateParticles: rotateParticles,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
