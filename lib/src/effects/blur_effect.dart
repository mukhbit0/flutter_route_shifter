import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'base_effect.dart';

/// A blur transition effect that animates blur from one sigma to another.
///
/// This effect creates smooth blur animations, commonly used for focus
/// transitions, modal overlays, and modern UI effects.
///
/// Example:
/// ```dart
/// RouteShifterBuilder()
///   .blur(beginSigma: 10.0, endSigma: 0.0)
///   .fade()
///   .toRoute(page: NextPage())
/// ```
class BlurEffect extends RouteEffect {
  /// The starting blur radius (sigma).
  final double beginSigma;

  /// The ending blur radius (sigma).
  final double endSigma;

  /// The tile mode for the blur effect.
  final TileMode tileMode;

  /// Creates a blur effect.
  ///
  /// [beginSigma] is the starting blur amount (higher = more blurred)
  /// [endSigma] is the ending blur amount (0.0 = no blur)
  /// [tileMode] determines how the blur handles edges
  const BlurEffect({
    this.beginSigma = 10.0,
    this.endSigma = 0.0,
    this.tileMode = TileMode.clamp,
    super.duration,
    super.curve = Curves.easeInOut,
    super.start,
    super.end,
  })  : assert(beginSigma >= 0.0, 'beginSigma must be non-negative'),
        assert(endSigma >= 0.0, 'endSigma must be non-negative');

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final sigmaTween = Tween<double>(begin: beginSigma, end: endSigma);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final currentSigma = sigmaTween.evaluate(animation);

        // Don't apply blur filter if sigma is 0 or very small
        if (currentSigma < 0.01) {
          return child;
        }

        // Web performance optimization: Use lower quality blur on web
        final effectiveSigma = kIsWeb ? currentSigma * 0.7 : currentSigma;

        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: effectiveSigma,
              sigmaY: effectiveSigma,
              tileMode: tileMode,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  BlurEffect copyWith({
    double? beginSigma,
    double? endSigma,
    TileMode? tileMode,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return BlurEffect(
      beginSigma: beginSigma ?? this.beginSigma,
      endSigma: endSigma ?? this.endSigma,
      tileMode: tileMode ?? this.tileMode,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a blur-in effect (from clear to blurred).
  factory BlurEffect.blurIn({
    double targetSigma = 10.0,
    TileMode? tileMode,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return BlurEffect(
      beginSigma: 0.0,
      endSigma: targetSigma,
      tileMode: tileMode ?? TileMode.clamp,
      duration: duration,
      curve: curve ?? Curves.easeIn,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a blur-out effect (from blurred to clear).
  factory BlurEffect.blurOut({
    double sourceSigma = 10.0,
    TileMode? tileMode,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    return BlurEffect(
      beginSigma: sourceSigma,
      endSigma: 0.0,
      tileMode: tileMode ?? TileMode.clamp,
      duration: duration,
      curve: curve ?? Curves.easeOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  /// Creates a focus effect that blurs then unblurs.
  factory BlurEffect.focus({
    double peakSigma = 5.0,
    TileMode? tileMode,
    Duration? duration,
    double? start,
    double? end,
  }) {
    return BlurEffect(
      beginSigma: 0.0,
      endSigma: 0.0,
      tileMode: tileMode ?? TileMode.clamp,
      duration: duration ?? const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      start: start ?? 0.0,
      end: end ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is BlurEffect &&
          beginSigma == other.beginSigma &&
          endSigma == other.endSigma &&
          tileMode == other.tileMode;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, beginSigma, endSigma, tileMode);

  @override
  String toString() => 'BlurEffect(begin: $beginSigma, end: $endSigma, '
      'tileMode: $tileMode, duration: $duration, curve: $curve)';
}
