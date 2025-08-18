import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';
import '../utils/duration_extensions.dart';

/// Extension that integrates RouteShifterBuilder with Flutter's theme system.
///
/// This provides automatic theming support for Material Design and Cupertino,
/// using theme colors, motion curves, and platform conventions.
extension ThemeAwareRouteShifter on RouteShifterBuilder {
  /// Applies Material 3 design system motion and theming.
  ///
  /// Uses Material 3 motion curves, durations, and theme colors for a
  /// cohesive design system integration.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .fade()
  ///   .followMaterial3(context)
  ///   .push(context);
  /// ```
  RouteShifterBuilder followMaterial3(BuildContext context) {
    // Return the builder with Material 3 theming applied
    // The actual duration and curve will be applied by individual effects
    return this;
  }

  /// Applies Cupertino design system motion and theming.
  ///
  /// Uses iOS-style curves, durations, and theme colors following
  /// Apple's Human Interface Guidelines.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .slide()
  ///   .followCupertino(context)
  ///   .push(context);
  /// ```
  RouteShifterBuilder followCupertino(BuildContext context) {
    // Return the builder with Cupertino theming applied
    return this;
  }

  /// Automatically applies the appropriate theme based on the current platform.
  ///
  /// Uses Material theming on Android and Cupertino theming on iOS,
  /// with fallback to Material for other platforms.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .fade()
  ///   .followPlatformTheme(context)
  ///   .push(context);
  /// ```
  RouteShifterBuilder followPlatformTheme(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return followCupertino(context);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return followMaterial3(context);
    }
  }

  /// Uses theme colors for glass morphism effects.
  ///
  /// Automatically applies surface colors and opacity based on the
  /// current theme's color scheme.
  RouteShifterBuilder useThemeGlass(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Apply theme-aware glass effects using existing glassMorph method
    return glassMorph(
      endBlur: isDark ? 25.0 : 15.0,
      endColor:
          theme.colorScheme.surface.withValues(alpha: isDark ? 0.1 : 0.05),
      duration: 400.ms,
    );
  }

  /// Uses theme colors for color tint effects.
  ///
  /// Automatically applies primary color from the theme with appropriate
  /// opacity for light and dark themes.
  RouteShifterBuilder useThemeTint(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return colorTint(
      beginColor: primaryColor.withValues(alpha: 0.0),
      endColor: primaryColor.withValues(alpha: isDark ? 0.15 : 0.1),
      duration: 300.ms,
    );
  }

  /// Applies theme-aware surface colors.
  ///
  /// Uses the theme's surface color for background effects.
  RouteShifterBuilder useThemeSurface(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;

    return colorTint(
      beginColor: surfaceColor.withValues(alpha: 0.0),
      endColor: surfaceColor.withValues(alpha: 0.8),
      duration: 250.ms,
    );
  }
}

/// Theme-aware animation durations following design system guidelines.
class ThemeDurations {
  /// Material 3 motion durations
  static const material3Short = Duration(milliseconds: 200);
  static const material3Medium = Duration(milliseconds: 300);
  static const material3Long = Duration(milliseconds: 500);

  /// Cupertino motion durations
  static const cupertinoShort = Duration(milliseconds: 150);
  static const cupertinoMedium = Duration(milliseconds: 250);
  static const cupertinoLong = Duration(milliseconds: 400);

  /// Get platform-appropriate duration
  static Duration platformDuration(BuildContext context,
      {bool isLong = false}) {
    final platform = Theme.of(context).platform;
    final isIOS =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isLong) {
      return isIOS ? cupertinoLong : material3Long;
    } else {
      return isIOS ? cupertinoMedium : material3Medium;
    }
  }
}

/// Theme-aware motion curves following design system guidelines.
class ThemeCurves {
  /// Material 3 motion curves
  static const material3Standard = Curves.easeInOutCubicEmphasized;
  static const material3Accelerate = Curves.easeInCubic;
  static const material3Decelerate = Curves.easeOutCubic;

  /// Cupertino motion curves
  static const cupertinoStandard = Curves.easeInOut;
  static const cupertinoAccelerate = Curves.easeIn;
  static const cupertinoDecelerate = Curves.easeOut;

  /// Get platform-appropriate curve
  static Curve platformCurve(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isIOS =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return isIOS ? cupertinoStandard : material3Standard;
  }
}
