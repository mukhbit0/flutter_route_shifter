import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../base/effect.dart';

/// Creates stylistic skewing transitions.
///
/// This effect animates a "shear" or "skew" transformation, creating a stylish
/// effect where the page appears to slant or tilt into place. Perfect for
/// modern and dynamic app feels.
class ShearEffect extends RouteEffect {
  /// The starting shear offset.
  final Offset beginShear;

  /// The ending shear offset.
  final Offset endShear;

  /// The origin point for the shear transformation.
  final Alignment origin;

  /// Whether to apply the shear to the incoming page or outgoing page.
  final ShearTarget target;

  const ShearEffect({
    this.beginShear = const Offset(0.5, 0.0),
    this.endShear = Offset.zero,
    this.origin = Alignment.center,
    this.target = ShearTarget.incoming,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final shearAnimation = Tween<Offset>(
      begin: beginShear,
      end: endShear,
    ).animate(animation);

    return AnimatedBuilder(
      animation: shearAnimation,
      builder: (context, _) {
        return Transform(
          alignment: origin,
          transform: _createShearMatrix(shearAnimation.value),
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
    return ShearEffect(
      beginShear: beginShear,
      endShear: endShear,
      origin: origin,
      target: target,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a matrix for shear transformation.
  Matrix4 _createShearMatrix(Offset shear) {
    return Matrix4.identity()
      ..setEntry(0, 1, shear.dx) // Horizontal shear
      ..setEntry(1, 0, shear.dy); // Vertical shear
  }

  /// Creates a horizontal shear effect.
  factory ShearEffect.horizontal({
    double shearValue = 0.3,
    Alignment origin = Alignment.center,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
  }) {
    return ShearEffect(
      beginShear: Offset(shearValue, 0.0),
      endShear: Offset.zero,
      origin: origin,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a vertical shear effect.
  factory ShearEffect.vertical({
    double shearValue = 0.3,
    Alignment origin = Alignment.center,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
  }) {
    return ShearEffect(
      beginShear: Offset(0.0, shearValue),
      endShear: Offset.zero,
      origin: origin,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a diagonal shear effect.
  factory ShearEffect.diagonal({
    double shearValue = 0.2,
    Alignment origin = Alignment.center,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
  }) {
    return ShearEffect(
      beginShear: Offset(shearValue, shearValue),
      endShear: Offset.zero,
      origin: origin,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a perspective-like shear effect.
  factory ShearEffect.perspective({
    double intensity = 0.4,
    PerspectiveDirection direction = PerspectiveDirection.right,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
  }) {
    Offset shear;
    Alignment origin;

    switch (direction) {
      case PerspectiveDirection.left:
        shear = Offset(-intensity, 0.0);
        origin = Alignment.centerRight;
        break;
      case PerspectiveDirection.right:
        shear = Offset(intensity, 0.0);
        origin = Alignment.centerLeft;
        break;
      case PerspectiveDirection.top:
        shear = Offset(0.0, -intensity);
        origin = Alignment.bottomCenter;
        break;
      case PerspectiveDirection.bottom:
        shear = Offset(0.0, intensity);
        origin = Alignment.topCenter;
        break;
    }

    return ShearEffect(
      beginShear: shear,
      endShear: Offset.zero,
      origin: origin,
      duration: duration,
      curve: curve,
    );
  }
}

/// Target for the shear effect.
enum ShearTarget {
  /// Apply shear to the incoming page.
  incoming,

  /// Apply shear to the outgoing page.
  outgoing,

  /// Apply shear to both pages.
  both,
}

/// Direction for perspective-like shear effects.
enum PerspectiveDirection {
  left,
  right,
  top,
  bottom,
}

/// Advanced 3D-like shear effect with multiple axis transformations.
class AdvancedShearEffect extends RouteEffect {
  /// The X-axis shear animation curve.
  final Curve xCurve;

  /// The Y-axis shear animation curve.
  final Curve yCurve;

  /// The Z-axis rotation during shear.
  final double rotationZ;

  /// The perspective value for 3D effect.
  final double perspective;

  /// The shear values for each axis.
  final Offset beginShear;
  final Offset endShear;

  const AdvancedShearEffect({
    this.xCurve = Curves.easeOutCubic,
    this.yCurve = Curves.easeOutCubic,
    this.rotationZ = 0.0,
    this.perspective = 0.001,
    this.beginShear = const Offset(0.3, 0.1),
    this.endShear = Offset.zero,
    Duration? duration,
    Curve curve = Curves.easeOutCubic,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final xAnimation = CurvedAnimation(parent: animation, curve: xCurve);
    final yAnimation = CurvedAnimation(parent: animation, curve: yCurve);

    final xShear = Tween<double>(
      begin: beginShear.dx,
      end: endShear.dx,
    ).animate(xAnimation);

    final yShear = Tween<double>(
      begin: beginShear.dy,
      end: endShear.dy,
    ).animate(yAnimation);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final matrix = Matrix4.identity();

        // Add perspective
        if (perspective != 0.0) {
          matrix.setEntry(3, 2, perspective);
        }

        // Add rotation
        if (rotationZ != 0.0) {
          final rotationValue = rotationZ * (1.0 - animation.value);
          matrix.rotateZ(rotationValue);
        }

        // Add shear
        matrix.setEntry(0, 1, xShear.value);
        matrix.setEntry(1, 0, yShear.value);

        return Transform(
          alignment: Alignment.center,
          transform: matrix,
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
    return AdvancedShearEffect(
      xCurve: xCurve,
      yCurve: yCurve,
      rotationZ: rotationZ,
      perspective: perspective,
      beginShear: beginShear,
      endShear: endShear,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

/// Elastic shear effect that bounces back.
class ElasticShearEffect extends RouteEffect {
  /// The maximum shear value during the elastic motion.
  final double maxShear;

  /// The number of bounces in the elastic motion.
  final int bounces;

  /// The direction of the shear.
  final Axis direction;

  const ElasticShearEffect({
    this.maxShear = 0.4,
    this.bounces = 2,
    this.direction = Axis.horizontal,
    Duration? duration,
    Curve curve = Curves.elasticOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final elasticValue = _calculateElasticValue(animation.value);
        final matrix = Matrix4.identity();

        if (direction == Axis.horizontal) {
          matrix.setEntry(0, 1, elasticValue);
        } else {
          matrix.setEntry(1, 0, elasticValue);
        }

        return Transform(
          alignment: Alignment.center,
          transform: matrix,
          child: child,
        );
      },
    );
  }

  /// Calculates the elastic shear value with bounces.
  double _calculateElasticValue(double t) {
    if (t == 0.0 || t == 1.0) return 0.0;

    final frequency = bounces * math.pi;
    final elasticCurve =
        math.pow(2, -10 * t) * math.sin((t - 0.1) * frequency) + 1;
    return maxShear * (1.0 - t) * elasticCurve;
  }

  @override
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return ElasticShearEffect(
      maxShear: maxShear,
      bounces: bounces,
      direction: direction,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
