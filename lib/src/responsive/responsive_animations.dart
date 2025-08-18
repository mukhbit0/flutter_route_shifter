import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';
import '../utils/duration_extensions.dart';

/// Extension that provides responsive animation support based on screen size.
///
/// This allows different animations on mobile, tablet, and desktop devices
/// for optimal user experience across all form factors.
extension ResponsiveRouteShifter on RouteShifterBuilder {
  /// Applies different animations based on screen size.
  ///
  /// Uses breakpoints to determine device type and applies appropriate
  /// animations for each form factor. Call this before push() to get
  /// context-aware responsive behavior.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .buildResponsive(
  ///     context,
  ///     mobile: (builder) => builder.slideFromBottom(),
  ///     tablet: (builder) => builder.fade().scale(),
  ///     desktop: (builder) => builder.glassMorph(),
  ///   )
  ///   .push(context);
  /// ```
  RouteShifterBuilder buildResponsive(
    BuildContext context, {
    required RouteShifterBuilder Function(RouteShifterBuilder) mobile,
    RouteShifterBuilder Function(RouteShifterBuilder)? tablet,
    RouteShifterBuilder Function(RouteShifterBuilder)? desktop,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenSize);

    switch (breakpoint) {
      case DeviceType.mobile:
        return mobile(this);
      case DeviceType.tablet:
        return (tablet ?? mobile)(this);
      case DeviceType.desktop:
        return (desktop ?? tablet ?? mobile)(this);
    }
  }

  /// Automatically adapts animations based on platform conventions.
  ///
  /// Uses platform-specific animation patterns:
  /// - Mobile: Slide transitions
  /// - Tablet: Scale and fade combinations
  /// - Desktop: Subtle fade and glass effects
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .adaptive(context)
  ///   .push(context);
  /// ```
  RouteShifterBuilder adaptive(BuildContext context) {
    return buildResponsive(
      context,
      mobile: (builder) => builder.slideFromRight(duration: 250.ms),
      tablet: (builder) => builder.fade(duration: 300.ms).scale(begin: 0.95),
      desktop: (builder) =>
          builder.fade(duration: 200.ms).glassMorph(endBlur: 10.0),
    );
  }

  /// Adapts animations based on orientation.
  ///
  /// Uses different animations for portrait and landscape orientations
  /// to optimize for the available screen space.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .orientationAdaptive(
  ///     context,
  ///     portrait: (builder) => builder.slideFromBottom(),
  ///     landscape: (builder) => builder.slideFromRight(),
  ///   )
  ///   .push(context);
  /// ```
  RouteShifterBuilder orientationAdaptive(
    BuildContext context, {
    required RouteShifterBuilder Function(RouteShifterBuilder) portrait,
    required RouteShifterBuilder Function(RouteShifterBuilder) landscape,
  }) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? portrait(this)
        : landscape(this);
  }
}

/// Device type enumeration for responsive breakpoints.
enum DeviceType { mobile, tablet, desktop }

/// Responsive breakpoints utility class.
class ResponsiveBreakpoints {
  /// Mobile breakpoint (up to 768px width)
  static const double mobileMaxWidth = 768.0;

  /// Tablet breakpoint (769px to 1024px width)
  static const double tabletMaxWidth = 1024.0;

  /// Desktop breakpoint (above 1024px width)
  // Desktop is anything above tabletMaxWidth

  /// Determines the device type based on screen size.
  static DeviceType getBreakpoint(Size screenSize) {
    if (screenSize.width <= mobileMaxWidth) {
      return DeviceType.mobile;
    } else if (screenSize.width <= tabletMaxWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Checks if the screen size is mobile.
  static bool isMobile(Size screenSize) =>
      getBreakpoint(screenSize) == DeviceType.mobile;

  /// Checks if the screen size is tablet.
  static bool isTablet(Size screenSize) =>
      getBreakpoint(screenSize) == DeviceType.tablet;

  /// Checks if the screen size is desktop.
  static bool isDesktop(Size screenSize) =>
      getBreakpoint(screenSize) == DeviceType.desktop;

  /// Gets responsive value based on device type.
  static T getResponsiveValue<T>({
    required Size screenSize,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (getBreakpoint(screenSize)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

/// Extension for easy responsive values.
extension ResponsiveExtension on BuildContext {
  /// Gets the current device type.
  DeviceType get deviceType =>
      ResponsiveBreakpoints.getBreakpoint(MediaQuery.of(this).size);

  /// Checks if current device is mobile.
  bool get isMobile => ResponsiveBreakpoints.isMobile(MediaQuery.of(this).size);

  /// Checks if current device is tablet.
  bool get isTablet => ResponsiveBreakpoints.isTablet(MediaQuery.of(this).size);

  /// Checks if current device is desktop.
  bool get isDesktop =>
      ResponsiveBreakpoints.isDesktop(MediaQuery.of(this).size);

  /// Gets responsive value based on current device type.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return ResponsiveBreakpoints.getResponsiveValue<T>(
      screenSize: MediaQuery.of(this).size,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
