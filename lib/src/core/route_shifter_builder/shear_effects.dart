import 'package:flutter/material.dart';
import '../../effects/advanced/shear_effect.dart';

/// Extension methods for shear effects on RouteShifterBuilder.
mixin ShearEffects {
  List<dynamic> get effects;

  /// Adds a shear effect for stylistic skewing.
  dynamic shear({
    Offset beginShear = const Offset(0.5, 0.0),
    Offset endShear = Offset.zero,
    Alignment origin = Alignment.center,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    effects.add(ShearEffect(
      beginShear: beginShear,
      endShear: endShear,
      origin: origin,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a horizontal shear effect.
  dynamic horizontalShear({
    double shear = 0.3,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(shear, 0.0),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a vertical shear effect.
  dynamic verticalShear({
    double shear = 0.3,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(0.0, shear),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a diagonal shear effect.
  dynamic diagonalShear({
    double shear = 0.2,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(shear, shear),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a wobble shear effect.
  dynamic wobbleShear({
    double maxShear = 0.2,
    Duration? duration,
  }) {
    return this.shear(
      beginShear: Offset(maxShear, 0.0),
      endShear: Offset.zero,
      duration: duration,
      curve: Curves.elasticOut,
    );
  }

  /// Adds a shake shear effect.
  dynamic shakeShear({
    double intensity = 0.1,
    Duration? duration,
  }) {
    return this.shear(
      beginShear: Offset(intensity, 0.0),
      endShear: Offset(-intensity, 0.0),
      duration: duration,
      curve: Curves.bounceInOut,
    );
  }
}
