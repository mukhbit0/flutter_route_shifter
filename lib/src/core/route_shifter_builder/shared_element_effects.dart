import 'package:flutter/material.dart';
import '../../effects/shared_element_effect.dart';
import '../../effects/base_effect.dart';

/// Mixin providing shared element transition methods for RouteShifterBuilder.
mixin SharedElementEffects {
  /// Access to the effects list (provided by RouteShifterBuilder)
  List<RouteEffect> get effects;

  /// Creates a shared element transition effect.
  ///
  /// This effect creates smooth transitions between shared elements
  /// identified by their shiftId across different pages.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .sharedElement(
  ///     flightDuration: Duration(milliseconds: 600),
  ///     enableMorphing: true,
  ///   )
  ///   .toRoute(page: NextPage())
  /// ```
  dynamic sharedElement({
    Duration? flightDuration,
    Curve? flightCurve,
    bool? enableMorphing,
    Curve? morphCurve,
    Path? customFlightPath,
    bool? useElevation,
    double? flightElevation,
    List<String>? shiftIds,
    Duration? duration,
    Curve? curve,
    double? start,
    double? end,
  }) {
    effects.add(SharedElementEffect(
      flightDuration: flightDuration ?? const Duration(milliseconds: 400),
      flightCurve: flightCurve ?? Curves.fastLinearToSlowEaseIn,
      enableMorphing: enableMorphing ?? true,
      morphCurve: morphCurve ?? Curves.easeInOut,
      customFlightPath: customFlightPath,
      useElevation: useElevation ?? true,
      flightElevation: flightElevation ?? 8.0,
      shiftIds: shiftIds,
      duration: duration,
      curve: curve ?? Curves.linear,
      start: start ?? 0.0,
      end: end ?? 1.0,
    ));
    return this;
  }

  /// Creates a shared element transition with curved flight path.
  dynamic sharedElementCurved({
    Path? customPath,
    Duration? flightDuration,
    Curve? flightCurve,
    bool? enableMorphing,
    bool? useElevation,
    double? flightElevation,
    List<String>? shiftIds,
  }) {
    return sharedElement(
      customFlightPath: customPath,
      flightDuration: flightDuration ?? const Duration(milliseconds: 500),
      flightCurve: flightCurve ?? Curves.easeInOutCubic,
      enableMorphing: enableMorphing ?? true,
      useElevation: useElevation ?? true,
      flightElevation: flightElevation ?? 12.0,
      shiftIds: shiftIds,
    );
  }

  /// Creates a shared element transition with morphing disabled.
  dynamic sharedElementSimple({
    Duration? flightDuration,
    Curve? flightCurve,
    bool? useElevation,
    double? flightElevation,
    List<String>? shiftIds,
  }) {
    return sharedElement(
      flightDuration: flightDuration ?? const Duration(milliseconds: 300),
      flightCurve: flightCurve ?? Curves.easeOut,
      enableMorphing: false,
      useElevation: useElevation ?? false,
      flightElevation: flightElevation ?? 0.0,
      shiftIds: shiftIds,
    );
  }

  /// Creates a shared element transition with high elevation flight.
  dynamic sharedElementElevated({
    Duration? flightDuration,
    Curve? flightCurve,
    bool? enableMorphing,
    double? flightElevation,
    List<String>? shiftIds,
  }) {
    return sharedElement(
      flightDuration: flightDuration ?? const Duration(milliseconds: 450),
      flightCurve: flightCurve ?? Curves.fastLinearToSlowEaseIn,
      enableMorphing: enableMorphing ?? true,
      useElevation: true,
      flightElevation: flightElevation ?? 16.0,
      shiftIds: shiftIds,
    );
  }
}
