import 'package:flutter/material.dart';

/// Extension to fix missing import
import 'dart:math' as math;

/// Custom animation curves following Material Design and platform conventions.
///
/// This class provides additional curves beyond Flutter's built-in curves,
/// specifically designed for route transitions and modern UI animations.
class MaterialCurves {
  MaterialCurves._();

  /// Standard easing curve for most Material transitions.
  /// Equivalent to cubic-bezier(0.2, 0.0, 0.0, 1.0).
  static const Curve standardEasing = Cubic(0.2, 0.0, 0.0, 1.0);

  /// Emphasized easing for attention-grabbing transitions.
  /// Equivalent to cubic-bezier(0.05, 0.7, 0.1, 1.0).
  static const Curve emphasizedEasing = Cubic(0.05, 0.7, 0.1, 1.0);

  /// Decelerated easing that starts fast and ends slowly.
  /// Equivalent to cubic-bezier(0.0, 0.0, 0.2, 1.0).
  static const Curve emphasizedDecelerateEasing = Cubic(0.0, 0.0, 0.2, 1.0);

  /// Accelerated easing that starts slowly and ends fast.
  /// Equivalent to cubic-bezier(0.3, 0.0, 1.0, 1.0).
  static const Curve emphasizedAccelerateEasing = Cubic(0.3, 0.0, 1.0, 1.0);

  /// Legacy Material easing curve (pre-Material 3).
  /// Equivalent to cubic-bezier(0.4, 0.0, 0.2, 1.0).
  static const Curve legacyEasing = Cubic(0.4, 0.0, 0.2, 1.0);

  /// Fade in easing curve.
  /// Equivalent to cubic-bezier(0.0, 0.0, 0.2, 1.0).
  static const Curve fadeInEasing = Cubic(0.0, 0.0, 0.2, 1.0);

  /// Fade out easing curve.
  /// Equivalent to cubic-bezier(0.4, 0.0, 1.0, 1.0).
  static const Curve fadeOutEasing = Cubic(0.4, 0.0, 1.0, 1.0);
}

/// Custom curves for iOS/Cupertino-style animations.
class CupertinoCurves {
  CupertinoCurves._();

  /// Standard iOS easing curve.
  /// Equivalent to cubic-bezier(0.25, 0.1, 0.25, 1.0).
  static const Curve easeInOut = Cubic(0.25, 0.1, 0.25, 1.0);

  /// iOS-style ease in curve.
  /// Equivalent to cubic-bezier(0.42, 0.0, 1.0, 1.0).
  static const Curve easeIn = Cubic(0.42, 0.0, 1.0, 1.0);

  /// iOS-style ease out curve.
  /// Equivalent to cubic-bezier(0.0, 0.0, 0.58, 1.0).
  static const Curve easeOut = Cubic(0.0, 0.0, 0.58, 1.0);

  /// iOS navigation transition curve.
  /// Equivalent to cubic-bezier(0.36, 0.66, 0.04, 1.0).
  static const Curve navigationTransition = Cubic(0.36, 0.66, 0.04, 1.0);

  /// iOS modal presentation curve.
  /// Equivalent to cubic-bezier(0.32, 0.72, 0.0, 1.0).
  static const Curve modalPresentation = Cubic(0.32, 0.72, 0.0, 1.0);
}

/// Custom curves for route shifter package.
class ShifterCurves {
  ShifterCurves._();

  /// Smooth curve for shared element transitions.
  static const Curve sharedElementFlight = Cubic(0.2, 0.0, 0.0, 1.0);

  /// Bouncy curve for playful animations.
  static const Curve playfulBounce = Cubic(0.68, -0.55, 0.265, 1.55);

  /// Gentle bounce for subtle effects.
  static const Curve gentleBounce = Cubic(0.25, 0.46, 0.45, 0.94);

  /// Sharp curve for quick transitions.
  static const Curve sharp = Cubic(0.4, 0.0, 0.6, 1.0);

  /// Smooth curve for elegant transitions.
  static const Curve smooth = Cubic(0.25, 0.1, 0.25, 1.0);

  /// Dramatic curve for attention-grabbing effects.
  static const Curve dramatic = Cubic(0.95, 0.05, 0.795, 0.035);

  /// Gentle curve for subtle animations.
  static const Curve gentle = Cubic(0.25, 0.46, 0.45, 0.94);

  /// Fast start, slow finish for modern feel.
  static const Curve fastToSlow = Cubic(0.4, 0.0, 0.2, 1.0);

  /// Slow start, fast finish for responsive feel.
  static const Curve slowToFast = Cubic(0.0, 0.0, 0.2, 1.0);
}

/// Collection of elastic curves for bouncy animations.
class ElasticCurves {
  ElasticCurves._();

  /// Light elastic effect.
  static const Curve light = ElasticOutCurve(0.7);

  /// Medium elastic effect.
  static const Curve medium = ElasticOutCurve(0.5);

  /// Strong elastic effect.
  static const Curve strong = ElasticOutCurve(0.3);

  /// Extra strong elastic effect.
  static const Curve extraStrong = ElasticOutCurve(0.1);

  /// Custom elastic in curve.
  static const Curve elasticIn = ElasticInCurve(0.7);

  /// Custom elastic out curve.
  static const Curve elasticOut = ElasticOutCurve(0.7);

  /// Custom elastic in-out curve.
  static const Curve elasticInOut = ElasticInOutCurve(0.7);
}

/// Collection of anticipation curves that overshoot before settling.
class AnticipationCurves {
  AnticipationCurves._();

  /// Light anticipation effect.
  static const Curve light = _AnticipationCurve(0.1);

  /// Medium anticipation effect.
  static const Curve medium = _AnticipationCurve(0.2);

  /// Strong anticipation effect.
  static const Curve strong = _AnticipationCurve(0.3);

  /// Extra strong anticipation effect.
  static const Curve extraStrong = _AnticipationCurve(0.4);
}

/// A custom curve that creates an anticipation effect.
///
/// This curve goes slightly negative before progressing to positive,
/// creating an effect similar to a character winding up before jumping.
class _AnticipationCurve extends Curve {
  final double overshoot;

  const _AnticipationCurve(this.overshoot);

  @override
  double transformInternal(double t) {
    if (t < 0.2) {
      // Negative overshoot phase
      return -overshoot * (0.2 - t) / 0.2;
    } else {
      // Normal progression with slight overshoot at the end
      final adjusted = (t - 0.2) / 0.8;
      return Curves.easeOutBack.transform(adjusted);
    }
  }
}

/// Custom curve for staggered animations.
class StaggerCurve extends Curve {
  final double staggerRatio;
  final Curve baseCurve;

  const StaggerCurve(this.staggerRatio, [this.baseCurve = Curves.easeOut]);

  @override
  double transformInternal(double t) {
    if (t < staggerRatio) {
      return 0.0;
    }

    final adjustedT = (t - staggerRatio) / (1.0 - staggerRatio);
    return baseCurve.transform(adjustedT);
  }
}

/// Custom curve that creates a wave effect.
class WaveCurve extends Curve {
  final double frequency;
  final double amplitude;
  final Curve baseCurve;

  const WaveCurve({
    this.frequency = 2.0,
    this.amplitude = 0.1,
    this.baseCurve = Curves.linear,
  });

  @override
  double transformInternal(double t) {
    final baseValue = baseCurve.transform(t);
    final wave = amplitude * math.sin(frequency * math.pi * t);
    return (baseValue + wave).clamp(0.0, 1.0);
  }
}

/// Utility class for creating custom curves.
class CurveUtils {
  CurveUtils._();

  /// Creates a curve that combines two curves with a transition point.
  static Curve combine(Curve first, Curve second,
      [double transitionPoint = 0.5]) {
    return _CombinedCurve(first, second, transitionPoint);
  }

  /// Creates a curve with a pause in the middle.
  static Curve withPause(Curve curve, double pauseStart, double pauseEnd) {
    return _PauseCurve(curve, pauseStart, pauseEnd);
  }

  /// Creates a curve that reverses another curve.
  static Curve reverse(Curve curve) {
    return _ReverseCurve(curve);
  }

  /// Creates a curve with custom control points.
  static Curve cubicBezier(double x1, double y1, double x2, double y2) {
    return Cubic(x1, y1, x2, y2);
  }

  /// Creates a stepped curve with specified number of steps.
  static Curve stepped(int steps) {
    return _SteppedCurve(steps);
  }
}

/// A curve that combines two curves.
class _CombinedCurve extends Curve {
  final Curve first;
  final Curve second;
  final double transitionPoint;

  const _CombinedCurve(this.first, this.second, this.transitionPoint);

  @override
  double transformInternal(double t) {
    if (t < transitionPoint) {
      return first.transform(t / transitionPoint) * transitionPoint;
    } else {
      final adjustedT = (t - transitionPoint) / (1.0 - transitionPoint);
      return transitionPoint +
          second.transform(adjustedT) * (1.0 - transitionPoint);
    }
  }
}

/// A curve that includes a pause.
class _PauseCurve extends Curve {
  final Curve curve;
  final double pauseStart;
  final double pauseEnd;

  const _PauseCurve(this.curve, this.pauseStart, this.pauseEnd);

  @override
  double transformInternal(double t) {
    if (t < pauseStart) {
      return curve.transform(t / pauseStart) * pauseStart;
    } else if (t < pauseEnd) {
      return pauseStart;
    } else {
      final adjustedT = (t - pauseEnd) / (1.0 - pauseEnd);
      return pauseStart + curve.transform(adjustedT) * (1.0 - pauseStart);
    }
  }
}

/// A curve that reverses another curve.
class _ReverseCurve extends Curve {
  final Curve curve;

  const _ReverseCurve(this.curve);

  @override
  double transformInternal(double t) {
    return 1.0 - curve.transform(1.0 - t);
  }
}

/// A stepped animation curve.
class _SteppedCurve extends Curve {
  final int steps;

  const _SteppedCurve(this.steps);

  @override
  double transformInternal(double t) {
    return (t * steps).floor() / steps;
  }
}
