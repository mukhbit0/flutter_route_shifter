import 'package:flutter/material.dart';
import '../../effects/color_tint_effect.dart';

/// Extension methods for color tint effects on RouteShifterBuilder.
mixin ColorTintEffects {
  List<dynamic> get _effects;

  /// Adds a color tint effect for overlays and modals.
  dynamic colorTint({
    required Color beginColor,
    required Color endColor,
    BlendMode blendMode = BlendMode.srcOver,
    TintPosition position = TintPosition.front,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0,
    double end = 1,
  }) {
    _effects.add(ColorTintEffect(
      beginColor: beginColor,
      endColor: endColor,
      blendMode: blendMode,
      position: position,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a modal color tint effect (black overlay).
  dynamic modal({
    double opacity = 0.5,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: Colors.black.withValues(alpha: opacity),
      position: TintPosition.behind,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a highlight color tint effect.
  dynamic highlight({
    required Color color,
    double opacity = 0.7,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: color.withValues(alpha: opacity),
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a fade to color effect.
  dynamic fadeToColor({
    required Color color,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: color,
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a gradient tint effect.
  dynamic gradientTint({
    Gradient? beginGradient,
    required Gradient endGradient,
    TintPosition position = TintPosition.front,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    final effectsField = (this as dynamic)._effects as List;
    effectsField.add(GradientTintEffect(
      beginGradient: beginGradient,
      endGradient: endGradient,
      position: position,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a shimmer effect using gradient tint.
  dynamic shimmer({
    Color baseColor = Colors.grey,
    Color highlightColor = Colors.white,
    Duration? duration,
  }) {
    return gradientTint(
      beginGradient: LinearGradient(
        colors: [baseColor, baseColor],
      ),
      endGradient: LinearGradient(
        colors: [baseColor, highlightColor, baseColor],
        stops: const [0.0, 0.5, 1.0],
      ),
      duration: duration,
      curve: Curves.easeInOut,
    );
  }
}
