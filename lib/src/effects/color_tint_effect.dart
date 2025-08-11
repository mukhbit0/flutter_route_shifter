import 'package:flutter/material.dart';
import 'base_effect.dart';

/// Creates color overlay transitions for modals and dialogs.
///
/// This effect animates a color overlay that fades in or out, essential for
/// modal dialogs or routes where you want to dim the underlying screen.
class ColorTintEffect extends RouteEffect {
  /// The starting color of the tint.
  final Color beginColor;

  /// The ending color of the tint.
  final Color endColor;

  /// The blend mode to use for the color overlay.
  final BlendMode blendMode;

  /// Whether to place the tint behind or in front of the child.
  final TintPosition position;

  const ColorTintEffect({
    this.beginColor = Colors.transparent,
    this.endColor = const Color(0x80000000), // Semi-transparent black
    this.blendMode = BlendMode.srcOver,
    this.position = TintPosition.behind,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) : super(duration: duration, curve: curve, start: start, end: end);

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    final colorAnimation = ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(animation);

    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, _) {
        final tintContainer = Container(
          color: colorAnimation.value,
          child: position == TintPosition.behind ? null : child,
        );

        if (position == TintPosition.behind) {
          return Stack(
            children: [
              tintContainer,
              child,
            ],
          );
        } else {
          return Stack(
            children: [
              child,
              Container(color: colorAnimation.value),
            ],
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
    return ColorTintEffect(
      beginColor: beginColor,
      endColor: endColor,
      blendMode: blendMode,
      position: position,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Creates a modal overlay effect with standard dark background.
  factory ColorTintEffect.modal({
    double opacity = 0.6,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return ColorTintEffect(
      beginColor: Colors.transparent,
      endColor: Colors.black.withValues(alpha: opacity),
      position: TintPosition.behind,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a highlight effect with colored overlay.
  factory ColorTintEffect.highlight({
    required Color color,
    double opacity = 0.3,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return ColorTintEffect(
      beginColor: Colors.transparent,
      endColor: color.withValues(alpha: opacity),
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }

  /// Creates a fade-to-color effect.
  factory ColorTintEffect.fadeToColor({
    required Color color,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return ColorTintEffect(
      beginColor: Colors.transparent,
      endColor: color,
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }
}

/// Position of the color tint relative to the child widget.
enum TintPosition {
  /// Tint appears behind the child (useful for backgrounds).
  behind,

  /// Tint appears in front of the child (useful for overlays).
  front,
}

/// Advanced color tint effect with gradient support.
class GradientTintEffect extends RouteEffect {
  /// The starting gradient.
  final Gradient? beginGradient;

  /// The ending gradient.
  final Gradient endGradient;

  /// The position of the tint.
  final TintPosition position;

  const GradientTintEffect({
    this.beginGradient,
    required this.endGradient,
    this.position = TintPosition.behind,
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
        Gradient currentGradient;

        if (beginGradient != null) {
          // Interpolate between gradients
          currentGradient =
              _interpolateGradients(beginGradient!, endGradient, progress);
        } else {
          // Use end gradient with animated opacity
          currentGradient = _applyOpacityToGradient(endGradient, progress);
        }

        final tintContainer = Container(
          decoration: BoxDecoration(gradient: currentGradient),
          child: position == TintPosition.behind ? null : child,
        );

        if (position == TintPosition.behind) {
          return Stack(
            children: [
              tintContainer,
              child,
            ],
          );
        } else {
          return Stack(
            children: [
              child,
              Container(decoration: BoxDecoration(gradient: currentGradient)),
            ],
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
    return GradientTintEffect(
      beginGradient: beginGradient,
      endGradient: endGradient,
      position: position,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  /// Interpolates between two gradients.
  Gradient _interpolateGradients(Gradient begin, Gradient end, double t) {
    if (begin is LinearGradient && end is LinearGradient) {
      return LinearGradient(
        begin: AlignmentGeometry.lerp(begin.begin, end.begin, t)!,
        end: AlignmentGeometry.lerp(begin.end, end.end, t)!,
        colors: _interpolateColors(begin.colors, end.colors, t),
        stops: _interpolateStops(begin.stops, end.stops, t),
      );
    } else if (begin is RadialGradient && end is RadialGradient) {
      return RadialGradient(
        center: AlignmentGeometry.lerp(begin.center, end.center, t)!,
        radius: begin.radius + (end.radius - begin.radius) * t,
        colors: _interpolateColors(begin.colors, end.colors, t),
        stops: _interpolateStops(begin.stops, end.stops, t),
      );
    }

    // Fallback: return end gradient with interpolated opacity
    return _applyOpacityToGradient(end, t);
  }

  /// Applies opacity to a gradient.
  Gradient _applyOpacityToGradient(Gradient gradient, double opacity) {
    final colors = gradient.colors
        .map((color) => color.withValues(alpha: color.a * opacity))
        .toList();

    if (gradient is LinearGradient) {
      return LinearGradient(
        begin: gradient.begin,
        end: gradient.end,
        colors: colors,
        stops: gradient.stops,
      );
    } else if (gradient is RadialGradient) {
      return RadialGradient(
        center: gradient.center,
        radius: gradient.radius,
        colors: colors,
        stops: gradient.stops,
      );
    }

    return LinearGradient(colors: colors);
  }

  /// Interpolates between two color lists.
  List<Color> _interpolateColors(List<Color> begin, List<Color> end, double t) {
    final maxLength = begin.length > end.length ? begin.length : end.length;
    final result = <Color>[];

    for (int i = 0; i < maxLength; i++) {
      final beginColor = i < begin.length ? begin[i] : begin.last;
      final endColor = i < end.length ? end[i] : end.last;
      result.add(Color.lerp(beginColor, endColor, t)!);
    }

    return result;
  }

  /// Interpolates between two stop lists.
  List<double>? _interpolateStops(
      List<double>? begin, List<double>? end, double t) {
    if (begin == null || end == null) return null;

    final maxLength = begin.length > end.length ? begin.length : end.length;
    final result = <double>[];

    for (int i = 0; i < maxLength; i++) {
      final beginStop = i < begin.length ? begin[i] : begin.last;
      final endStop = i < end.length ? end[i] : end.last;
      result.add(beginStop + (endStop - beginStop) * t);
    }

    return result;
  }
}

/// Extension methods for easy integration with RouteShifterBuilder
/// These would be implemented in the actual RouteShifterBuilder class
/*
extension ColorTintEffectExtensions on RouteShifterBuilder {
  RouteShifterBuilder tint({
    Color begin = Colors.transparent,
    Color end = const Color(0x80000000),
    BlendMode blendMode = BlendMode.srcOver,
    TintPosition position = TintPosition.behind,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) => addEffect(ColorTintEffect(
    beginColor: begin,
    endColor: end,
    blendMode: blendMode,
    position: position,
    duration: duration,
    curve: curve,
  ));

  RouteShifterBuilder modalOverlay({
    double opacity = 0.6,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) => addEffect(ColorTintEffect.modal(
    opacity: opacity,
    duration: duration,
    curve: curve,
  ));

  RouteShifterBuilder gradientTint({
    Gradient? beginGradient,
    required Gradient endGradient,
    TintPosition position = TintPosition.behind,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) => addEffect(GradientTintEffect(
    beginGradient: beginGradient,
    endGradient: endGradient,
    position: position,
    duration: duration,
    curve: curve,
  ));
}
*/
