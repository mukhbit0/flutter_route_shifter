import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A builder class for creating custom animation curves.
///
/// This allows you to create sophisticated custom curves by defining
/// control points, or use preset curve combinations for complex animations.
class CustomCurveBuilder {
  final List<_CurvePoint> _points = [];
  final List<_CurveSegment> _segments = [];

  /// Adds a control point to the curve.
  ///
  /// Points should be added in order from t=0.0 to t=1.0.
  ///
  /// Example:
  /// ```dart
  /// final curve = CustomCurveBuilder()
  ///   .addPoint(0.0, 0.0)
  ///   .addPoint(0.3, 0.8)  // Overshoot
  ///   .addPoint(0.6, 0.9)  // Ease
  ///   .addPoint(1.0, 1.0)
  ///   .build();
  /// ```
  CustomCurveBuilder addPoint(double t, double value) {
    assert(t >= 0.0 && t <= 1.0, 'Time must be between 0.0 and 1.0');
    assert(value >= 0.0, 'Value must be >= 0.0');

    _points.add(_CurvePoint(t, value));
    return this;
  }

  /// Adds a curve segment between two time points.
  ///
  /// This allows you to use different curves for different parts
  /// of the animation timeline.
  ///
  /// Example:
  /// ```dart
  /// final curve = CustomCurveBuilder()
  ///   .addSegment(0.0, 0.5, Curves.easeOut)
  ///   .addSegment(0.5, 1.0, Curves.elasticOut)
  ///   .build();
  /// ```
  CustomCurveBuilder addSegment(double startT, double endT, Curve curve) {
    assert(startT >= 0.0 && startT <= 1.0,
        'Start time must be between 0.0 and 1.0');
    assert(endT >= 0.0 && endT <= 1.0, 'End time must be between 0.0 and 1.0');
    assert(startT < endT, 'Start time must be less than end time');

    _segments.add(_CurveSegment(startT, endT, curve));
    return this;
  }

  /// Creates an ease-in-out curve with custom control.
  ///
  /// Parameters control the sharpness of the ease in and ease out.
  CustomCurveBuilder easeInOut({double easeIn = 0.4, double easeOut = 0.6}) {
    return addPoint(0.0, 0.0)
        .addPoint(easeIn, 0.0)
        .addPoint(easeOut, 1.0)
        .addPoint(1.0, 1.0);
  }

  /// Creates a bounce curve with custom parameters.
  ///
  /// Allows you to control the bounce intensity and timing.
  CustomCurveBuilder bounce({int bounces = 3, double intensity = 0.3}) {
    addPoint(0.0, 0.0);

    for (int i = 1; i <= bounces; i++) {
      final t = i / (bounces + 1);
      final bounceHeight = intensity * (1.0 - t);
      addPoint(t - 0.05, 1.0 + bounceHeight);
      addPoint(t + 0.05, 1.0 - bounceHeight * 0.5);
    }

    addPoint(1.0, 1.0);
    return this;
  }

  /// Creates an overshoot curve.
  ///
  /// The animation goes beyond the target value before settling.
  CustomCurveBuilder overshoot(
      {double amount = 0.2, double returnPoint = 0.7}) {
    return addPoint(0.0, 0.0)
        .addPoint(returnPoint, 1.0 + amount)
        .addPoint(1.0, 1.0);
  }

  /// Creates an anticipation curve.
  ///
  /// The animation briefly moves backward before going forward.
  CustomCurveBuilder anticipate(
      {double amount = 0.1, double anticipatePoint = 0.2}) {
    return addPoint(0.0, 0.0)
        .addPoint(anticipatePoint, -amount)
        .addPoint(1.0, 1.0);
  }

  /// Creates a custom spring curve.
  ///
  /// Simulates spring physics with customizable parameters.
  CustomCurveBuilder spring({
    double tension = 400.0,
    double friction = 22.0,
    double velocity = 0.0,
  }) {
    // Simplified spring curve - in a real implementation,
    // you'd calculate spring physics points
    final damping = friction / (2.0 * math.sqrt(tension));
    final frequency = math.sqrt(tension) / (2.0 * math.pi);

    // Add calculated spring points
    for (int i = 0; i <= 20; i++) {
      final t = i / 20.0;
      final springValue =
          _calculateSpringValue(t, damping, frequency, velocity);
      addPoint(t, math.max(0.0, springValue));
    }

    return this;
  }

  /// Builds the custom curve.
  ///
  /// Returns a Curve that can be used in animations.
  Curve build() {
    if (_segments.isNotEmpty) {
      return _SegmentedCurve(_segments);
    } else if (_points.isNotEmpty) {
      return _InterpolatedCurve(_points);
    } else {
      return Curves.linear;
    }
  }

  double _calculateSpringValue(
      double t, double damping, double frequency, double velocity) {
    if (damping < 1.0) {
      // Underdamped spring
      final dampedFreq = frequency * math.sqrt(1.0 - damping * damping);
      return 1.0 -
          math.exp(-damping * frequency * t) *
              (math.cos(dampedFreq * t) +
                  (damping * frequency + velocity) /
                      dampedFreq *
                      math.sin(dampedFreq * t));
    } else if (damping == 1.0) {
      // Critically damped spring
      return 1.0 -
          math.exp(-frequency * t) * (1.0 + (frequency + velocity) * t);
    } else {
      // Overdamped spring
      final r1 = (-damping + math.sqrt(damping * damping - 1.0)) * frequency;
      final r2 = (-damping - math.sqrt(damping * damping - 1.0)) * frequency;
      final c1 = (velocity - r2) / (r1 - r2);
      final c2 = (r1 - velocity) / (r1 - r2);
      return 1.0 - (c1 * math.exp(r1 * t) + c2 * math.exp(r2 * t));
    }
  }
}

/// Represents a point on a custom curve.
class _CurvePoint {
  final double t;
  final double value;

  _CurvePoint(this.t, this.value);
}

/// Represents a curve segment with specific timing.
class _CurveSegment extends Curve {
  final double startT;
  final double endT;
  final Curve curve;

  _CurveSegment(this.startT, this.endT, this.curve);

  @override
  double transform(double t) {
    if (t <= startT) return 0.0;
    if (t >= endT) return 1.0;

    final segmentT = (t - startT) / (endT - startT);
    return curve.transform(segmentT);
  }
}

/// A curve that interpolates between defined points.
class _InterpolatedCurve extends Curve {
  final List<_CurvePoint> points;

  _InterpolatedCurve(this.points) {
    // Sort points by time
    points.sort((a, b) => a.t.compareTo(b.t));
  }

  @override
  double transform(double t) {
    if (points.isEmpty) return t;
    if (points.length == 1) return points.first.value;

    // Find the two points to interpolate between
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (t >= p1.t && t <= p2.t) {
        if (p1.t == p2.t) return p1.value;

        final segmentT = (t - p1.t) / (p2.t - p1.t);
        return p1.value + (p2.value - p1.value) * segmentT;
      }
    }

    // If t is outside our range, return the nearest value
    if (t <= points.first.t) return points.first.value;
    if (t >= points.last.t) return points.last.value;

    return t; // Fallback
  }
}

/// A curve composed of multiple segments.
class _SegmentedCurve extends Curve {
  final List<_CurveSegment> segments;

  _SegmentedCurve(List<_CurveSegment> segments)
      : segments = List.from(segments)
          ..sort((a, b) => a.startT.compareTo(b.startT));

  @override
  double transform(double t) {
    for (final segment in segments) {
      if (t >= segment.startT && t <= segment.endT) {
        final segmentT = (t - segment.startT) / (segment.endT - segment.startT);
        return segment.curve.transform(segmentT);
      }
    }

    // If no segment contains t, use linear interpolation
    return t;
  }
}

/// Pre-built custom curves for common use cases.
class CustomCurves {
  /// A dramatic bounce curve perfect for game achievements.
  static Curve get dramaticBounce =>
      CustomCurveBuilder().bounce(bounces: 4, intensity: 0.4).build();

  /// A smooth overshoot curve for premium feel.
  static Curve get smoothOvershoot =>
      CustomCurveBuilder().overshoot(amount: 0.15, returnPoint: 0.8).build();

  /// An anticipation curve for interactive elements.
  static Curve get anticipatedMotion => CustomCurveBuilder()
      .anticipate(amount: 0.08, anticipatePoint: 0.15)
      .build();

  /// A soft spring curve for gentle animations.
  static Curve get softSpring =>
      CustomCurveBuilder().spring(tension: 300.0, friction: 25.0).build();

  /// A sharp spring curve for dynamic animations.
  static Curve get sharpSpring =>
      CustomCurveBuilder().spring(tension: 600.0, friction: 20.0).build();

  /// A custom ease curve optimized for Material Design.
  static Curve get materialCustom => CustomCurveBuilder()
      .addPoint(0.0, 0.0)
      .addPoint(0.2, 0.1)
      .addPoint(0.4, 0.6)
      .addPoint(0.8, 0.9)
      .addPoint(1.0, 1.0)
      .build();

  /// A custom ease curve optimized for iOS.
  static Curve get cupertinoCustom =>
      CustomCurveBuilder().easeInOut(easeIn: 0.25, easeOut: 0.75).build();
}

/// Extension to add custom curve support to RouteShifterBuilder.
extension CustomCurveExtension on dynamic {
  /// Apply a custom curve to the animation.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .fade()
  ///   .withCustomCurve(CustomCurves.dramaticBounce)
  ///   .push(context);
  /// ```
  dynamic withCustomCurve(Curve curve) {
    // This would be implemented in the actual RouteShifterBuilder
    // to apply the curve to the most recent effect
    return this;
  }

  /// Apply a custom curve builder to the animation.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .fade()
  ///   .withCurveBuilder((builder) => builder
  ///     .overshoot(amount: 0.2)
  ///     .build())
  ///   .push(context);
  /// ```
  dynamic withCurveBuilder(Curve Function(CustomCurveBuilder) builder) {
    final curve = builder(CustomCurveBuilder());
    return withCustomCurve(curve);
  }
}
