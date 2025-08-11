import 'package:flutter/material.dart';
import '../effects/base_effect.dart';
import '../effects/slide_effect.dart';
import '../effects/fade_effect.dart';
import 'route_shifter.dart' as local_shifter;

// Import all effect mixins
import 'route_shifter_builder/fade_effects.dart';
import 'route_shifter_builder/slide_effects.dart';
import 'route_shifter_builder/scale_effects.dart';
import 'route_shifter_builder/advanced_effects.dart';
import 'route_shifter_builder/clip_path_effects.dart';
import 'route_shifter_builder/color_tint_effects.dart';
import 'route_shifter_builder/shear_effects.dart';
import 'route_shifter_builder/parallax_effects.dart';
import 'route_shifter_builder/follow_path_effects.dart';
import 'route_shifter_builder/interactive_effects.dart';
import 'route_shifter_builder/creative_effects.dart';

/// A modular builder class that provides a chainable API for creating animated route transitions.
///
/// This class implements the builder pattern using mixins for better modularity,
/// allowing you to chain different effects together to create complex route animations.
///
/// Example:
/// ```dart
/// final route = RouteShifterBuilder()
///   .fade()
///   .slideFromRight()
///   .scale(begin: 0.8)
///   .toRoute(page: NextPage());
/// ```
class RouteShifterBuilder
    with
        FadeEffects,
        SlideEffects,
        ScaleEffects,
        AdvancedEffects,
        ClipPathEffects,
        ColorTintEffects,
        ShearEffects,
        ParallaxEffects,
        FollowPathEffects,
        CreativeEffects,
        InteractiveEffects {
  final List<RouteEffect> _effects = [];
  bool _interactiveDismissEnabled = false;
  local_shifter.DismissDirection? _dismissDirection;
  Map<String, dynamic>? _sharedElementSettings;

  /// Access to the effects list for mixins
  List<RouteEffect> get effects => _effects;

  /// Creates a route with the configured effects.
  local_shifter.RouteShifter<T> toRoute<T>({
    required Widget page,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return local_shifter.RouteShifter<T>(
      page: page,
      effects: List.unmodifiable(_effects),
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      interactiveDismissEnabled: _interactiveDismissEnabled,
      dismissDirection: _dismissDirection,
      sharedElementSettings: _sharedElementSettings,
    );
  }

  /// Creates a copy of this builder with the same configuration.
  RouteShifterBuilder copy() {
    final copy = RouteShifterBuilder();
    copy._effects.addAll(_effects);
    copy._interactiveDismissEnabled = _interactiveDismissEnabled;
    copy._dismissDirection = _dismissDirection;
    copy._sharedElementSettings = _sharedElementSettings;
    return copy;
  }

  /// Resets all effects and configurations.
  RouteShifterBuilder reset() {
    _effects.clear();
    _interactiveDismissEnabled = false;
    _dismissDirection = null;
    _sharedElementSettings = null;
    return this;
  }

  /// Adds a custom effect to the route transition.
  RouteShifterBuilder addEffect(RouteEffect effect) {
    _effects.add(effect);
    return this;
  }

  /// Enables interactive dismiss for the route.
  RouteShifterBuilder enableInteractiveDismiss({
    local_shifter.DismissDirection? direction,
  }) {
    _interactiveDismissEnabled = true;
    _dismissDirection = direction;
    return this;
  }

  /// Configures shared element transitions.
  RouteShifterBuilder configureSharedElements({
    required Map<String, dynamic> settings,
  }) {
    _sharedElementSettings = settings;
    return this;
  }

  // Material Design Presets
  RouteShifterBuilder materialSlideUp() {
    return addEffect(SlideEffect(
      begin: const Offset(0, 1),
      offsetEnd: Offset.zero,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ));
  }

  RouteShifterBuilder materialFadeThrough() {
    return addEffect(FadeEffect(
      beginOpacity: 0.0,
      endOpacity: 1.0,
      duration: const Duration(milliseconds: 210),
      curve: Curves.easeIn,
    ));
  }

  // Cupertino Presets
  RouteShifterBuilder cupertinoSlide() {
    return addEffect(SlideEffect(
      begin: const Offset(1, 0),
      offsetEnd: Offset.zero,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
  }

  RouteShifterBuilder cupertinoModal() {
    return addEffect(SlideEffect(
      begin: const Offset(0, 1),
      offsetEnd: Offset.zero,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    ));
  }
}
