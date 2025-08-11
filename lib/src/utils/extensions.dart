import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';
import '../core/route_shifter.dart';
import '../widgets/shifter_widget.dart';
import '../presets/material_presets.dart';
import '../presets/cupertino_presets.dart';

/// Extension methods for Duration to create more readable code.
extension DurationExtensions on int {
  /// Converts an integer to a Duration in milliseconds.
  Duration get milliseconds => Duration(milliseconds: this);

  /// Converts an integer to a Duration in seconds.
  Duration get seconds => Duration(seconds: this);

  /// Converts an integer to a Duration in minutes.
  Duration get minutes => Duration(minutes: this);

  /// Converts an integer to a Duration in hours.
  Duration get hours => Duration(hours: this);

  /// Shorthand for milliseconds.
  Duration get ms => milliseconds;

  /// Shorthand for seconds.
  Duration get s => seconds;
}

/// Extension methods for Navigator to make route transitions easier.
extension NavigatorExtensions on NavigatorState {
  /// Pushes a route with Material Design transition.
  Future<T?> pushMaterial<T extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
  }) {
    final builder = preset != null
        ? MaterialPresets.getPresetByName(preset) ??
            MaterialPresets.materialPageTransition()
        : MaterialPresets.materialPageTransition();

    final route = builder.toRoute<T>(page: page, settings: settings);
    return push(route);
  }

  /// Pushes a route with Cupertino (iOS) transition.
  Future<T?> pushCupertino<T extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
  }) {
    final builder = preset != null
        ? CupertinoPresets.getPresetByName(preset) ??
            CupertinoPresets.cupertinoPageTransition()
        : CupertinoPresets.cupertinoPageTransition();

    final route = builder.toRoute<T>(page: page, settings: settings);
    return push(route);
  }

  /// Pushes a route with custom RouteShifter transition.
  Future<T?> pushShifter<T extends Object?>(
    Widget page, {
    required RouteShifterBuilder builder,
    RouteSettings? settings,
  }) {
    final route = builder.toRoute<T>(page: page, settings: settings);
    return push(route);
  }

  /// Replaces the current route with Material Design transition.
  Future<T?> pushReplacementMaterial<T extends Object?, TO extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
    TO? result,
  }) {
    final builder = preset != null
        ? MaterialPresets.getPresetByName(preset) ??
            MaterialPresets.materialPageTransition()
        : MaterialPresets.materialPageTransition();

    final route = builder.toRoute<T>(page: page, settings: settings);
    return pushReplacement(route, result: result);
  }

  /// Replaces the current route with Cupertino transition.
  Future<T?> pushReplacementCupertino<T extends Object?, TO extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
    TO? result,
  }) {
    final builder = preset != null
        ? CupertinoPresets.getPresetByName(preset) ??
            CupertinoPresets.cupertinoPageTransition()
        : CupertinoPresets.cupertinoPageTransition();

    final route = builder.toRoute<T>(page: page, settings: settings);
    return pushReplacement(route, result: result);
  }
}

/// Extension methods for BuildContext to make navigation even easier.
extension BuildContextNavigationExtensions on BuildContext {
  /// Gets the navigator state.
  NavigatorState get navigator => Navigator.of(this);

  /// Pushes a route with Material Design transition.
  Future<T?> pushMaterial<T extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
  }) =>
      navigator.pushMaterial<T>(page, preset: preset, settings: settings);

  /// Pushes a route with Cupertino transition.
  Future<T?> pushCupertino<T extends Object?>(
    Widget page, {
    String? preset,
    RouteSettings? settings,
  }) =>
      navigator.pushCupertino<T>(page, preset: preset, settings: settings);

  /// Pushes a route with custom RouteShifter transition.
  Future<T?> pushShifter<T extends Object?>(
    Widget page, {
    required RouteShifterBuilder builder,
    RouteSettings? settings,
  }) =>
      navigator.pushShifter<T>(page, builder: builder, settings: settings);

  /// Pops the current route.
  void pop<T extends Object?>([T? result]) => navigator.pop<T>(result);

  /// Checks if the navigator can pop.
  bool get canPop => navigator.canPop();

  /// Pushes and removes all previous routes.
  Future<T?> pushAndRemoveUntilMaterial<T extends Object?>(
    Widget page,
    RoutePredicate predicate, {
    String? preset,
    RouteSettings? settings,
  }) {
    final builder = preset != null
        ? MaterialPresets.getPresetByName(preset) ??
            MaterialPresets.materialPageTransition()
        : MaterialPresets.materialPageTransition();

    final route = builder.toRoute<T>(page: page, settings: settings);
    return navigator.pushAndRemoveUntil(route, predicate);
  }
}

/// Extension methods for RouteShifterBuilder for additional convenience.
extension RouteShifterBuilderExtensions on RouteShifterBuilder {
  /// Adds multiple effects at once.
  RouteShifterBuilder addEffects(
      List<void Function(RouteShifterBuilder)> effects) {
    RouteShifterBuilder current = this;
    for (final effect in effects) {
      effect(current);
    }
    return current;
  }

  /// Creates a route and immediately pushes it.
  Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
  }) {
    final route = toRoute<T>(page: page, settings: settings);
    return Navigator.of(context).push(route);
  }

  /// Creates a route and pushes it as a replacement.
  Future<T?> pushReplacementTo<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    TO? result,
  }) {
    final route = toRoute<T>(page: page, settings: settings);
    return Navigator.of(context).pushReplacement(route, result: result);
  }

  /// Quick method to add common effect combinations.
  RouteShifterBuilder slideAndFade({
    Offset? slideBegin,
    Duration? duration,
    Curve? curve,
  }) {
    return slideFromRight(
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    ).fade(
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    );
  }

  /// Quick method for scale and fade combination.
  RouteShifterBuilder scaleAndFade({
    double? beginScale,
    Duration? duration,
    Curve? curve,
  }) {
    return scale(
      beginScale: beginScale ?? 0.8,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    ).fade(
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    );
  }

  /// Quick method for rotation and fade combination.
  RouteShifterBuilder rotateAndFade({
    double? beginTurns,
    double? endTurns,
    Duration? duration,
    Curve? curve,
  }) {
    return rotation(
      beginTurns: beginTurns ?? -0.25,
      endTurns: endTurns ?? 0.0,
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    ).fade(
      duration: duration,
      curve: curve ?? Curves.easeInOut,
    );
  }

  /// Applies a preset by name.
  RouteShifterBuilder applyPreset(String presetName,
      {bool isCupertino = false}) {
    final preset = isCupertino
        ? CupertinoPresets.getPresetByName(presetName)
        : MaterialPresets.getPresetByName(presetName);

    if (preset != null) {
      return preset;
    }

    // Return current builder if preset not found
    return this;
  }
}

/// Extension methods for common Flutter widgets to enable easier shared element usage.
extension WidgetShifterExtensions on Widget {
  /// Wraps this widget with a Shifter for shared element transitions.
  Widget asShifter({
    required Object shiftId,
    Map<String, dynamic> metadata = const {},
    bool enabled = true,
  }) {
    return Shifter(
      shiftId: shiftId,
      enabled: enabled,
      metadata: metadata,
      child: this,
    );
  }

  /// Creates a string-based shifter.
  Widget asStringShifter(
    String shiftId, {
    Map<String, dynamic> metadata = const {},
    bool enabled = true,
  }) {
    return asShifter(
      shiftId: shiftId,
      metadata: metadata,
      enabled: enabled,
    );
  }

  /// Creates an enum-based shifter.
  Widget asEnumShifter<T extends Enum>(
    T shiftId, {
    Map<String, dynamic> metadata = const {},
    bool enabled = true,
  }) {
    return asShifter(
      shiftId: shiftId,
      metadata: metadata,
      enabled: enabled,
    );
  }
}

/// Extension methods for Route for additional information.
extension RouteExtensions<T> on Route<T> {
  /// Checks if this is a RouteShifter.
  bool get isRouteShifter => this is RouteShifter;

  /// Gets this route as RouteShifter if possible.
  RouteShifter<T>? get asRouteShifter =>
      this is RouteShifter<T> ? this as RouteShifter<T> : null;
}

/// Extension methods for Animation to make working with intervals easier.
extension AnimationExtensions on Animation<double> {
  /// Creates an interval animation from this animation.
  Animation<double> interval(double begin, double end, {Curve? curve}) {
    return CurvedAnimation(
      parent: this,
      curve: Interval(begin, end, curve: curve ?? Curves.linear),
    );
  }

  /// Creates a delayed animation.
  Animation<double> delayed(double delay, {Curve? curve}) {
    final start = delay.clamp(0.0, 0.8);
    return interval(start, 1.0, curve: curve);
  }

  /// Creates a tween from this animation.
  Animation<T> tween<T>(T begin, T end) {
    return Tween<T>(begin: begin, end: end).animate(this);
  }
}

/// Utility class for creating common route configurations.
class RouteShifterUtils {
  RouteShifterUtils._();

  /// Creates a quick fade transition.
  static RouteShifterBuilder quickFade([Duration? duration]) {
    return RouteShifterBuilder().fade(
      duration: duration ?? 200.milliseconds,
      curve: Curves.easeInOut,
    );
  }

  /// Creates a quick slide transition.
  static RouteShifterBuilder quickSlide([Offset? beginOffset, Duration? duration]) {
    return RouteShifterBuilder().slide(
      beginOffset: beginOffset ?? const Offset(1.0, 0.0),
      duration: duration ?? 250.milliseconds,
      curve: Curves.easeInOut,
    );
  }

  /// Creates a quick scale transition.
  static RouteShifterBuilder quickScale(
      [double? beginScale, Duration? duration]) {
    return RouteShifterBuilder().scale(
      beginScale: beginScale ?? 0.8,
      duration: duration ?? 200.milliseconds,
      curve: Curves.easeOut,
    );
  }

  /// Creates a platform-appropriate transition.
  static RouteShifterBuilder platformTransition(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoPresets.cupertinoPageTransition();
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return MaterialPresets.materialPageTransition();
    }
  }

  /// Creates a transition based on current theme.
  static RouteShifterBuilder themeBasedTransition(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platformTransition(platform);
  }
}
