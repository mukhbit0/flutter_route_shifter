import 'package:flutter/material.dart';

/// Extension to fix missing import
import 'dart:math' as math;

/// Safe wrapper for any curve that ensures bounds are never exceeded.
class SafeCurve extends Curve {
  final Curve _inner;
  const SafeCurve(this._inner);

  @override
  double transformInternal(double t) {
    final clamped = t.clamp(0.0, 1.0);
    // Use the inner curve's transform (not transformInternal) to be safe.
    final result = _inner.transform(clamped);
    return result.clamp(0.0, 1.0);
  }
}

/// Safe wrapper for Interval curves that ensures bounds are never exceeded.
class SafeInterval extends Curve {
  final double begin;
  final double end;
  final Curve curve;

  const SafeInterval(this.begin, this.end, {this.curve = Curves.linear});

  @override
  double transformInternal(double t) {
    // Ensure input is clamped
    t = t.clamp(0.0, 1.0);

    // Ensure begin and end are valid
    final safeBegin = begin.clamp(0.0, 1.0);
    final safeEnd = end.clamp(safeBegin, 1.0);

    if (t < safeBegin) {
      return 0.0;
    } else if (t > safeEnd) {
      return 1.0;
    } else {
      final adjustedT = (t - safeBegin) / (safeEnd - safeBegin);
      final result = curve.transform(adjustedT.clamp(0.0, 1.0));
      return result.clamp(0.0, 1.0);
    }
  }
}

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

  /// Bouncy curve for playful animations, now wrapped for safety.
  static final Curve playfulBounce = SafeCurve(Cubic(0.68, -0.55, 0.265, 1.55));

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
  static const Curve light = _SafeElasticOutCurve(0.7);

  /// Medium elastic effect.
  static const Curve medium = _SafeElasticOutCurve(0.5);

  /// Strong elastic effect.
  static const Curve strong = _SafeElasticOutCurve(0.3);

  /// Extra strong elastic effect.
  static const Curve extraStrong = _SafeElasticOutCurve(0.1);

  /// Custom elastic in curve.
  static const Curve elasticIn = _SafeElasticInCurve(0.7);

  /// Custom elastic out curve.
  static const Curve elasticOut = _SafeElasticOutCurve(0.7);

  /// Custom elastic in-out curve.
  static const Curve elasticInOut = _SafeElasticInOutCurve(0.7);
}

/// Safe elastic out curve that clamps values to [0, 1].
class _SafeElasticOutCurve extends Curve {
  final double period;

  const _SafeElasticOutCurve([this.period = 0.4]);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    if (t == 0.0 || t == 1.0) {
      return t;
    }
    const double s = 0.1591549431; // period / (2 * pi) * asin(1.0)
    final double result =
        math.pow(2.0, -10 * t) * math.sin((t - s) * (math.pi * 2.0) / period) +
            1.0;
    return result.clamp(0.0, 1.0);
  }
}

/// Safe elastic in curve that clamps values to [0, 1].
class _SafeElasticInCurve extends Curve {
  final double period;

  const _SafeElasticInCurve([this.period = 0.4]);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    if (t == 0.0 || t == 1.0) {
      return t;
    }
    const double s = 0.1591549431; // period / (2 * pi) * asin(1.0)
    final double result = -math.pow(2.0, 10 * (t - 1)) *
        math.sin(((t - 1) - s) * (math.pi * 2.0) / period);
    return result.clamp(0.0, 1.0);
  }
}

/// Safe elastic in-out curve that clamps values to [0, 1].
class _SafeElasticInOutCurve extends Curve {
  final double period;

  const _SafeElasticInOutCurve([this.period = 0.4]);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    if (t == 0.0 || t == 1.0) {
      return t;
    }
    const double s = 0.1591549431; // period / (2 * pi) * asin(1.0)
    t = 2.0 * t - 1.0;
    double result;
    if (t < 0.0) {
      result = -0.5 *
          math.pow(2.0, 10 * t) *
          math.sin((t - s) * (math.pi * 2.0) / period);
    } else {
      result = math.pow(2.0, -10 * t) *
              math.sin((t - s) * (math.pi * 2.0) / period) *
              0.5 +
          1.0;
    }
    return result.clamp(0.0, 1.0);
  }
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
    t = t.clamp(0.0, 1.0);

    double result;
    if (t < 0.2) {
      // Negative overshoot phase - but clamp to 0 minimum
      result = -overshoot * (0.2 - t) / 0.2;
    } else {
      // Normal progression with slight overshoot at the end
      final adjusted = (t - 0.2) / 0.8;
      result = Curves.easeOutBack.transform(adjusted.clamp(0.0, 1.0));
    }

    return result.clamp(0.0, 1.0);
  }
}

/// Custom curve for staggered animations.
class StaggerCurve extends Curve {
  final double staggerRatio;
  final Curve baseCurve;

  const StaggerCurve(this.staggerRatio, [this.baseCurve = Curves.easeOut]);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    final safeStaggerRatio = staggerRatio.clamp(0.0, 1.0);

    if (t < safeStaggerRatio) {
      return 0.0;
    }

    final adjustedT = (t - safeStaggerRatio) / (1.0 - safeStaggerRatio);
    final result = baseCurve.transform(adjustedT.clamp(0.0, 1.0));
    return result.clamp(0.0, 1.0);
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
    t = t.clamp(0.0, 1.0);
    final baseValue = baseCurve.transform(t);
    final wave = amplitude * math.sin(frequency * math.pi * t);
    final result = baseValue + wave;
    return result.clamp(0.0, 1.0);
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
    t = t.clamp(0.0, 1.0);
    final safeTransitionPoint = transitionPoint.clamp(0.0, 1.0);

    double result;
    if (t < safeTransitionPoint) {
      final adjustedT = safeTransitionPoint > 0 ? t / safeTransitionPoint : 0.0;
      result = first.transform(adjustedT.clamp(0.0, 1.0)) * safeTransitionPoint;
    } else {
      final adjustedT = (1.0 - safeTransitionPoint) > 0
          ? (t - safeTransitionPoint) / (1.0 - safeTransitionPoint)
          : 0.0;
      result = safeTransitionPoint +
          second.transform(adjustedT.clamp(0.0, 1.0)) *
              (1.0 - safeTransitionPoint);
    }

    return result.clamp(0.0, 1.0);
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
    t = t.clamp(0.0, 1.0);
    final safePauseStart = pauseStart.clamp(0.0, 1.0);
    final safePauseEnd = pauseEnd.clamp(safePauseStart, 1.0);

    double result;
    if (t < safePauseStart) {
      final adjustedT = safePauseStart > 0 ? t / safePauseStart : 0.0;
      result = curve.transform(adjustedT.clamp(0.0, 1.0)) * safePauseStart;
    } else if (t < safePauseEnd) {
      result = safePauseStart;
    } else {
      final adjustedT = (1.0 - safePauseEnd) > 0
          ? (t - safePauseEnd) / (1.0 - safePauseEnd)
          : 0.0;
      result = safePauseStart +
          curve.transform(adjustedT.clamp(0.0, 1.0)) * (1.0 - safePauseStart);
    }

    return result.clamp(0.0, 1.0);
  }
}

/// A curve that reverses another curve.
class _ReverseCurve extends Curve {
  final Curve curve;

  const _ReverseCurve(this.curve);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    final result = 1.0 - curve.transform(1.0 - t);
    return result.clamp(0.0, 1.0);
  }
}

/// A stepped animation curve.
class _SteppedCurve extends Curve {
  final int steps;

  const _SteppedCurve(this.steps);

  @override
  double transformInternal(double t) {
    t = t.clamp(0.0, 1.0);
    if (steps <= 0) return t;

    final result = (t * steps).floor() / steps;
    return result.clamp(0.0, 1.0);
  }
}
