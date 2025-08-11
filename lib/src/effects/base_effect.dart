import 'package:flutter/material.dart';

/// Base class for all route transition effects.
///
/// Each effect defines how to transform a widget during a route transition
/// using Flutter's animation system. Effects can be chained together to create
/// complex animations.
abstract class RouteEffect {
  /// The duration of this specific effect.
  /// If null, uses the default transition duration.
  final Duration? duration;

  /// The curve to apply to this effect's animation.
  final Curve curve;

  /// The start point of the animation (0.0 to 1.0).
  /// Allows for staggered animations where effects start at different times.
  final double start;

  /// The end point of the animation (0.0 to 1.0).
  /// Allows for effects that complete before the full transition ends.
  final double end;

  /// Creates a new route effect.
  const RouteEffect({
    this.duration,
    this.curve = Curves.linear,
    this.start = 0.0,
    this.end = 1.0,
  })  : assert(
            start >= 0.0 && start <= 1.0, 'start must be between 0.0 and 1.0'),
        assert(end >= 0.0 && end <= 1.0, 'end must be between 0.0 and 1.0'),
        assert(start <= end, 'start must be less than or equal to end');

  /// Builds the animated widget for this effect.
  ///
  /// Takes the parent [animation] and applies this effect to the [child] widget.
  /// The animation is automatically sliced based on [start] and [end] values.
  Widget build(Animation<double> parentAnimation, Widget child) {
    // Create a sliced animation if start/end are not 0.0/1.0
    final Animation<double> animation = (start == 0.0 && end == 1.0)
        ? parentAnimation
        : CurvedAnimation(
            parent: parentAnimation,
            curve: Interval(start, end, curve: curve),
          );

    return buildTransition(animation, child);
  }

  /// Builds the specific transition for this effect.
  ///
  /// Subclasses implement this method to define their animation behavior.
  /// The [animation] parameter is already sliced and curved appropriately.
  Widget buildTransition(Animation<double> animation, Widget child);

  /// Returns the effective duration of this effect.
  ///
  /// Used to calculate the overall transition duration when multiple effects
  /// are chained together.
  Duration getEffectiveDuration(Duration defaultDuration) {
    return duration ?? defaultDuration;
  }

  /// Creates a copy of this effect with modified parameters.
  RouteEffect copyWith({
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteEffect &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => Object.hash(runtimeType, duration, curve, start, end);
}
