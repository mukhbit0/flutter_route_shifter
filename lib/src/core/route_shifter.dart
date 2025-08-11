import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../effects/base_effect.dart';
import '../effects/shared_element_effect.dart';

/// The main route class that handles animated transitions between pages.
///
/// This class extends PageRoute to provide custom transition animations
/// based on the effects configured through RouteShifterBuilder.
///
/// Supports:
/// - Multiple chained effects (fade, slide, scale, rotation, blur)
/// - Interactive dismiss gestures
/// - Shared element transitions
/// - Staggered animations
/// - Custom curves and durations
class RouteShifter<T> extends PageRoute<T> {
  /// The destination page widget.
  final Widget page;

  /// List of effects to apply during the transition.
  final List<RouteEffect> effects;

  /// Whether interactive dismiss gestures are enabled.
  final bool interactiveDismissEnabled;

  /// The direction for interactive dismiss gestures.
  final DismissDirection? dismissDirection;

  /// Settings for shared element transitions.
  final Map<String, dynamic>? sharedElementSettings;

  /// Animation controller for managing the transition.
  late final AnimationController _controller;

  /// Tracks if this route has been disposed.
  bool _disposed = false;

  /// Creates a new RouteShifter.
  RouteShifter({
    required this.page,
    this.effects = const [],
    super.settings,
    bool maintainState = true,
    super.fullscreenDialog = false,
    this.interactiveDismissEnabled = false,
    this.dismissDirection,
    this.sharedElementSettings,
  }) : _maintainState = maintainState;

  final bool _maintainState;

  @override
  bool get maintainState => _maintainState;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get barrierDismissible => false;

  @override
  Duration get transitionDuration {
    if (effects.isEmpty) return const Duration(milliseconds: 300);

    // Calculate the maximum duration among all effects
    Duration maxDuration = const Duration(milliseconds: 300);

    for (final effect in effects) {
      final effectDuration = effect.getEffectiveDuration(maxDuration);
      if (effectDuration > maxDuration) {
        maxDuration = effectDuration;
      }
    }

    return maxDuration;
  }

  @override
  Duration get reverseTransitionDuration => transitionDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    Widget child = page;

    // Wrap with interactive dismiss if enabled
    if (interactiveDismissEnabled && dismissDirection != null) {
      child = _wrapWithInteractiveDismiss(context, child, animation);
    }

    return child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // The animation controllers are managed by the PageRoute infrastructure
    // We use the provided animation objects directly

    Widget result = child;

    // Apply shared element transitions first using the new enhanced effect
    if (sharedElementSettings != null) {
      final sharedElementEffect = SharedElementEffect(
        flightDuration: sharedElementSettings?['flightDuration'] as Duration? ??
            const Duration(milliseconds: 400),
        flightCurve: sharedElementSettings?['flightCurve'] as Curve? ??
            Curves.fastLinearToSlowEaseIn,
        enableMorphing:
            sharedElementSettings?['enableMorphing'] as bool? ?? true,
        morphCurve:
            sharedElementSettings?['morphCurve'] as Curve? ?? Curves.easeInOut,
        useElevation: sharedElementSettings?['useElevation'] as bool? ?? true,
        flightElevation:
            sharedElementSettings?['flightElevation'] as double? ?? 8.0,
      );
      result = sharedElementEffect.build(animation, result);
    }

    // Apply all other effects in sequence
    for (final effect in effects) {
      result = effect.build(animation, result);
    }

    return result;
  }

  @override
  AnimationController createAnimationController() {
    final controller = super.createAnimationController();
    _controller = controller;
    return controller;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Wraps the child with interactive dismiss gesture handling.
  Widget _wrapWithInteractiveDismiss(
    BuildContext context,
    Widget child,
    Animation<double> animation,
  ) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onVerticalDragStart:
          dismissDirection == DismissDirection.vertical ? _onDragStart : null,
      onVerticalDragUpdate: dismissDirection == DismissDirection.vertical
          ? _onVerticalDragUpdate
          : null,
      onVerticalDragEnd:
          dismissDirection == DismissDirection.vertical ? _onDragEnd : null,
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }

  /// Handles the start of a drag gesture.
  void _onDragStart(DragStartDetails details) {
    if (_disposed || !_controller.isAnimating) return;

    // Provide haptic feedback
    HapticFeedback.lightImpact();
  }

  /// Handles horizontal drag updates for interactive dismiss.
  void _onDragUpdate(DragUpdateDetails details) {
    if (_disposed) return;

    final screenWidth = MediaQuery.of(navigator!.context).size.width;
    final delta = details.primaryDelta! / screenWidth;

    // Update the animation controller based on drag
    final newValue = (_controller.value - delta).clamp(0.0, 1.0);
    _controller.value = newValue;
  }

  /// Handles vertical drag updates for interactive dismiss.
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_disposed) return;

    final screenHeight = MediaQuery.of(navigator!.context).size.height;
    final delta = details.primaryDelta! / screenHeight;

    // Update the animation controller based on drag
    final newValue = (_controller.value - delta).clamp(0.0, 1.0);
    _controller.value = newValue;
  }

  /// Handles the end of a drag gesture.
  void _onDragEnd(DragEndDetails details) {
    if (_disposed) return;

    const double minFlingVelocity = 300.0;
    const double minDismissThreshold = 0.3;

    final velocity = dismissDirection == DismissDirection.horizontal
        ? details.velocity.pixelsPerSecond.dx
        : details.velocity.pixelsPerSecond.dy;

    // Determine if we should dismiss based on velocity or position
    final shouldDismiss = velocity.abs() > minFlingVelocity
        ? velocity > 0
        : _controller.value < minDismissThreshold;

    if (shouldDismiss) {
      // Dismiss the route
      _controller.fling(velocity: -1.0).then((_) {
        if (!_disposed && navigator?.canPop() == true) {
          navigator?.pop();
        }
      });
    } else {
      // Restore the route
      _controller.fling(velocity: 1.0);
    }
  }

  /// Gets the current animation value for external use.
  double get animationValue => _controller.value;

  /// Gets whether the route can be popped interactively.
  bool get canPop => navigator?.canPop() ?? false;

  @override
  bool get opaque => true;

  @override
  String toString() {
    return 'RouteShifter(page: $page, effects: ${effects.length}, '
        'interactiveDismiss: $interactiveDismissEnabled)';
  }
}

/// Represents the direction for dismissing a route interactively.
enum DismissDirection {
  horizontal,
  vertical,
  both,
}
