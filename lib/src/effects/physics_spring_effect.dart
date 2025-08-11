// lib/src/effects/physics_spring_effect.dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'base_effect.dart';

/// A meta-effect that drives another effect using a physics-based SpringSimulation.
///
/// This creates a more natural and dynamic motion compared to standard curves.
class PhysicsSpringEffect extends RouteEffect {
  final RouteEffect effect;
  final double stiffness;
  final double damping;
  final double mass;

  const PhysicsSpringEffect({
    required this.effect,
    this.stiffness = 100.0,
    this.damping = 10.0,
    this.mass = 1.0,
    super.duration,
    super.curve,
    super.start,
    super.end,
  });

  @override
  Widget build(Animation<double> parentAnimation, Widget child) {
    // This effect needs its own AnimationController to be driven by physics.
    // We wrap it in a StatefulWidget to manage the controller's lifecycle.
    return _SpringEffectWrapper(
      parentAnimation: parentAnimation,
      effect: effect,
      stiffness: stiffness,
      damping: damping,
      mass: mass,
      child: child,
    );
  }

  // This buildTransition is not directly used because build() is overridden.
  @override
  Widget buildTransition(Animation<double> animation, Widget child) => child;

  @override
  RouteEffect copyWith({
    RouteEffect? effect,
    double? stiffness,
    double? damping,
    double? mass,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return PhysicsSpringEffect(
      effect: effect ?? this.effect,
      stiffness: stiffness ?? this.stiffness,
      damping: damping ?? this.damping,
      mass: mass ?? this.mass,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

class _SpringEffectWrapper extends StatefulWidget {
  final Animation<double> parentAnimation;
  final RouteEffect effect;
  final double stiffness;
  final double damping;
  final double mass;
  final Widget child;

  const _SpringEffectWrapper({
    required this.parentAnimation,
    required this.effect,
    required this.stiffness,
    required this.damping,
    required this.mass,
    required this.child,
  });

  @override
  _SpringEffectWrapperState createState() => _SpringEffectWrapperState();
}

class _SpringEffectWrapperState extends State<_SpringEffectWrapper>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _springAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _springAnimation = _controller.drive(Tween<double>(begin: 0.0, end: 1.0));

    // Listen to the parent animation to trigger the spring
    widget.parentAnimation.addListener(_onParentAnimationUpdate);
  }

  void _onParentAnimationUpdate() {
    if (widget.parentAnimation.status == AnimationStatus.forward) {
      final simulation = SpringSimulation(
        SpringDescription(
            mass: widget.mass,
            stiffness: widget.stiffness,
            damping: widget.damping),
        0.0, // start
        1.0, // end
        1.0, // velocity
      );
      _controller.animateWith(simulation);
    } else if (widget.parentAnimation.status == AnimationStatus.reverse) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    widget.parentAnimation.removeListener(_onParentAnimationUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the child effect's build method, but pass our spring-driven animation
    return widget.effect.build(_springAnimation, widget.child);
  }
}
