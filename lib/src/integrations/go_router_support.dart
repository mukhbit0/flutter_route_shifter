import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';

/// A route page that integrates RouteShifterBuilder with go_router.
///
/// This class provides seamless integration between route shifter animations
/// and the go_router package, allowing you to use all shifter effects
/// within a declarative routing setup.
///
/// Example usage:
/// ```dart
/// GoRoute(
///   path: '/details',
///   pageBuilder: (context, state) {
///     return RouteShifterBuilder()
///       .fade(duration: 400.ms)
///       .slideFromRight()
///       .toPage(child: DetailsPage());
///   },
/// ),
/// ```
class RouteShifterPage extends Page {
  /// The widget to display.
  final Widget child;

  /// The route shifter builder that defines the transition.
  final RouteShifterBuilder shifter;

  /// Creates a RouteShifterPage with the specified shifter and child.
  const RouteShifterPage({
    required this.child,
    required this.shifter,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    // Important: pass this Page as settings to satisfy Navigator's page-based API
    return shifter.toRoute(
      page: child,
      settings: this,
    );
  }
}

/// Extension to create RouteShifterPage instances.
extension RouteShifterPageExtension on RouteShifterBuilder {
  /// Creates a RouteShifterPage for go_router integration.
  ///
  /// This is the recommended way to integrate RouteShifterBuilder
  /// with go_router. The resulting page can be returned from
  /// GoRoute.pageBuilder.
  ///
  /// Example:
  /// ```dart
  /// GoRoute(
  ///   path: '/profile',
  ///   pageBuilder: (context, state) {
  ///     return RouteShifterBuilder()
  ///       .glass(blur: 20.0)
  ///       .parallax()
  ///       .toPage(child: ProfilePage());
  ///   },
  /// ),
  /// ```
  RouteShifterPage toPage({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return RouteShifterPage(
      shifter: this,
      child: child,
      key: key,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
    );
  }
}

/// A custom material page that works with go_router's pageBuilder.
///
/// This provides a more direct approach for go_router integration by
/// extending MaterialPageRoute and overriding the buildTransitions method.
class CustomRouteShifterPage extends MaterialPageRoute {
  /// The route shifter builder that defines the transition.
  final RouteShifterBuilder shifter;

  /// Creates a CustomRouteShifterPage with the specified shifter and child.
  CustomRouteShifterPage({
    required Widget child,
    required this.shifter,
    RouteSettings? settings,
  }) : super(
          builder: (_) => child,
          settings: settings,
        );

  @override
  Duration get transitionDuration {
    if (shifter.effects.isEmpty) {
      return const Duration(milliseconds: 300);
    }
    return shifter.effects
        .map((e) => e.getEffectiveDuration(const Duration(milliseconds: 300)))
        .reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create a temporary route to get the transition
    final route = shifter.toRoute(page: child);
    return route.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Extension to create CustomRouteShifterPage instances.
extension RouteShifterCustomPageExtension on RouteShifterBuilder {
  /// Creates a CustomRouteShifterPage for advanced go_router integration.
  ///
  /// Use this when you need more control over the page behavior or
  /// when working with complex go_router configurations that require
  /// a MaterialPageRoute-based approach.
  ///
  /// Example:
  /// ```dart
  /// GoRoute(
  ///   path: '/settings',
  ///   pageBuilder: (context, state) {
  ///     return RouteShifterBuilder()
  ///       .morphing(shape: MorphShape.rectangle)
  ///       .toCustomPage(child: SettingsPage());
  ///   },
  /// ),
  /// ```
  CustomRouteShifterPage toCustomPage({
    required Widget child,
    RouteSettings? settings,
  }) {
    return CustomRouteShifterPage(
      shifter: this,
      child: child,
      settings: settings,
    );
  }
}
