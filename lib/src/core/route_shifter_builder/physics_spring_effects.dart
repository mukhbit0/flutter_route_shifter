import '../../../flutter_route_shifter.dart';

/// Mixin that provides physics-based spring effects for RouteShifterBuilder.
mixin PhysicsSpringEffects {
  List<dynamic> get effects;

  /// Drives an effect using a physics-based spring simulation.
  dynamic spring({
    required RouteEffect effect,
    double stiffness = 100.0,
    double damping = 10.0,
    double mass = 1.0,
    Duration? duration,
  }) {
    effects.add(PhysicsSpringEffect(
      effect: effect,
      stiffness: stiffness,
      damping: damping,
      mass: mass,
      duration: duration,
    ));
    return this;
  }

  /// Creates a bouncy spring effect.
  dynamic bouncySpring({
    required RouteEffect effect,
    Duration? duration,
  }) =>
      spring(
        effect: effect,
        stiffness: 300.0,
        damping: 20.0,
        mass: 1.0,
        duration: duration,
      );

  /// Creates a gentle spring effect.
  dynamic gentleSpring({
    required RouteEffect effect,
    Duration? duration,
  }) =>
      spring(
        effect: effect,
        stiffness: 50.0,
        damping: 15.0,
        mass: 1.5,
        duration: duration,
      );

  /// Creates a snappy spring effect.
  dynamic snappySpring({
    required RouteEffect effect,
    Duration? duration,
  }) =>
      spring(
        effect: effect,
        stiffness: 500.0,
        damping: 30.0,
        mass: 0.8,
        duration: duration,
      );
}
