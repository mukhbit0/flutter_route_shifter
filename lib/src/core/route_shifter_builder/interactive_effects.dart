import 'package:flutter/material.dart';
import '../route_shifter.dart' as local_shifter;

/// Extension methods for interactive dismiss and shared elements on RouteShifterBuilder.
mixin InteractiveEffects {
  /// Enables interactive dismiss gestures.
  dynamic interactiveDismiss({
    local_shifter.DismissDirection direction =
        local_shifter.DismissDirection.horizontal,
  }) {
    final builder = this as dynamic;
    builder._interactiveDismissEnabled = true;
    builder._dismissDirection = direction;
    return this;
  }

  /// Enables interactive dismiss gestures (alias for interactiveDismiss).
  dynamic enableInteractiveDismiss({
    local_shifter.DismissDirection direction =
        local_shifter.DismissDirection.horizontal,
  }) {
    return interactiveDismiss(direction: direction);
  }

  /// Disables interactive dismiss gestures.
  dynamic disableInteractiveDismiss() {
    final builder = this as dynamic;
    builder._interactiveDismissEnabled = false;
    builder._dismissDirection = null;
    return this;
  }

  /// Enables shared elements between routes.
  dynamic sharedElements({
    Duration? flightDuration,
    Curve? flightCurve,
    bool enableMorphing = true,
    bool useElevation = false,
    Map<String, dynamic>? settings,
  }) {
    final builder = this as dynamic;
    builder._sharedElementSettings = {
      'flightDuration': flightDuration,
      'flightCurve': flightCurve,
      'enableMorphing': enableMorphing,
      'useElevation': useElevation,
      if (settings != null) ...settings,
    };
    return this;
  }

  /// Enables shared elements with bouncy animation.
  dynamic sharedElementsBouncy({
    Duration? flightDuration,
    bool enableMorphing = true,
    bool useElevation = true,
  }) {
    return sharedElements(
      flightDuration: flightDuration,
      flightCurve: Curves.bounceOut,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
    );
  }

  /// Enables shared elements with elastic animation.
  dynamic sharedElementsElastic({
    Duration? flightDuration,
    bool enableMorphing = true,
    bool useElevation = true,
  }) {
    return sharedElements(
      flightDuration: flightDuration,
      flightCurve: Curves.elasticOut,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
    );
  }

  /// Enables shared elements with curved flight path.
  dynamic sharedElementsWithCurvedPath({
    Duration? flightDuration,
    Curve? flightCurve,
    double curvature = 0.3,
    bool enableMorphing = true,
    bool useElevation = true,
  }) {
    return sharedElements(
      flightDuration: flightDuration,
      flightCurve: flightCurve,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
      settings: {'curvature': curvature},
    );
  }

  /// Enables shared elements with arc flight path.
  dynamic sharedElementsWithArc({
    Duration? flightDuration,
    Curve? flightCurve,
    double arcHeight = 100,
    bool enableMorphing = true,
    bool useElevation = true,
  }) {
    return sharedElements(
      flightDuration: flightDuration,
      flightCurve: flightCurve,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
      settings: {'arcHeight': arcHeight},
    );
  }
}
