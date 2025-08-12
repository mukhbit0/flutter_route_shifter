import 'package:flutter/widgets.dart';
import '../core/route_shifter_builder.dart';

/// Widget extensions for route shifting animations
/// 
/// Provides a modern widget API for route transitions:
/// ```dart
/// NextPage().routeShift().fade().slide().push(context);
/// ```
extension WidgetRouteShiftExtensions on Widget {
  /// Creates a RouteShifterBuilder for this widget
  /// 
  /// Example:
  /// ```dart
  /// MyPage().routeShift()
  ///   .fade(duration: 300.ms)
  ///   .slide(begin: Offset(1.0, 0.0))
  ///   .push(context);
  /// ```
  RouteShifterBuilder routeShift() {
    return RouteShifterBuilder()..setPage(this);
  }
}
