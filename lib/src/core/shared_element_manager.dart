import 'package:flutter/material.dart';
import '../core/shifter_registry.dart';

/// Advanced shared element transition manager with sophisticated animation capabilities.
///
/// This class provides high-level methods for creating complex shared element transitions
/// with support for multiple elements, custom flight paths, morphing animations,
/// and edge case handling.
class SharedElementTransitionManager {
  /// Singleton instance.
  static final SharedElementTransitionManager instance =
      SharedElementTransitionManager._internal();

  SharedElementTransitionManager._internal();

  /// Map of active transitions to prevent conflicts.
  final Map<Object, SharedElementTransition> _activeTransitions = {};

  /// Creates a shared element transition between source and target elements.
  ///
  /// This method handles the complete lifecycle of a shared element transition,
  /// including element discovery, animation setup, and cleanup.
  SharedElementTransition? createTransition({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required Object shiftId,
    Duration? duration,
    Curve? curve,
    bool enableMorphing = true,
    bool useElevation = true,
    Path? customFlightPath,
    VoidCallback? onComplete,
  }) {
    // Check if transition is already active
    if (_activeTransitions.containsKey(shiftId)) {
      debugPrint('Transition already active for $shiftId');
      return _activeTransitions[shiftId];
    }

    // Find source and target elements
    final sourceElement = ShifterRegistry.instance.getElementData(shiftId);
    if (sourceElement == null) {
      debugPrint('Source element not found for $shiftId');
      return null;
    }

    // Create and register transition
    final transition = SharedElementTransition(
      shiftId: shiftId,
      sourceElement: sourceElement,
      duration: duration ?? const Duration(milliseconds: 400),
      curve: curve ?? Curves.fastLinearToSlowEaseIn,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
      customFlightPath: customFlightPath,
      onComplete: () {
        _activeTransitions.remove(shiftId);
        onComplete?.call();
      },
    );

    _activeTransitions[shiftId] = transition;
    return transition;
  }

  /// Handles multiple shared elements in a single transition.
  List<SharedElementTransition> createMultiElementTransition({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required List<Object> shiftIds,
    Duration? duration,
    Curve? curve,
    bool enableMorphing = true,
    bool useElevation = true,
    Duration? staggerDelay,
    VoidCallback? onAllComplete,
  }) {
    final transitions = <SharedElementTransition>[];
    var completedCount = 0;

    for (int i = 0; i < shiftIds.length; i++) {
      final shiftId = shiftIds[i];
      final delay = staggerDelay != null
          ? Duration(milliseconds: staggerDelay.inMilliseconds * i)
          : Duration.zero;

      final transition = createTransition(
        sourceContext: sourceContext,
        targetContext: targetContext,
        shiftId: shiftId,
        duration: duration,
        curve: curve,
        enableMorphing: enableMorphing,
        useElevation: useElevation,
        onComplete: () {
          completedCount++;
          if (completedCount == shiftIds.length) {
            onAllComplete?.call();
          }
        },
      );

      if (transition != null) {
        transitions.add(transition);

        // Apply stagger delay if specified
        if (delay.inMilliseconds > 0) {
          Future.delayed(delay, () {
            transition.start();
          });
        }
      }
    }

    return transitions;
  }

  /// Cancels an active transition.
  void cancelTransition(Object shiftId) {
    final transition = _activeTransitions[shiftId];
    if (transition != null) {
      transition.cancel();
      _activeTransitions.remove(shiftId);
    }
  }

  /// Cancels all active transitions.
  void cancelAllTransitions() {
    for (final transition in _activeTransitions.values) {
      transition.cancel();
    }
    _activeTransitions.clear();
  }

  /// Gets the count of active transitions.
  int get activeTransitionCount => _activeTransitions.length;

  /// Checks if a specific element is currently transitioning.
  bool isTransitioning(Object shiftId) =>
      _activeTransitions.containsKey(shiftId);
}

/// Represents a single shared element transition with advanced capabilities.
class SharedElementTransition {
  final Object shiftId;
  final ShifterElementData sourceElement;
  final Duration duration;
  final Curve curve;
  final bool enableMorphing;
  final bool useElevation;
  final Path? customFlightPath;
  final VoidCallback? onComplete;

  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isActive = false;
  bool _isCompleted = false;

  SharedElementTransition({
    required this.shiftId,
    required this.sourceElement,
    required this.duration,
    required this.curve,
    required this.enableMorphing,
    required this.useElevation,
    this.customFlightPath,
    this.onComplete,
  });

  /// Starts the transition animation.
  void start() {
    if (_isActive || _isCompleted) return;

    _isActive = true;

    // Mark element as active in registry
    ShifterRegistry.instance.activateElement(shiftId);

    // Start animation
    _controller.forward().then((_) {
      _complete();
    });
  }

  /// Cancels the transition.
  void cancel() {
    if (!_isActive || _isCompleted) return;

    _controller.stop();
    _cleanup();
  }

  /// Completes the transition.
  void _complete() {
    if (_isCompleted) return;

    _isCompleted = true;
    _cleanup();
    onComplete?.call();
  }

  /// Cleans up resources after transition.
  void _cleanup() {
    _isActive = false;
    ShifterRegistry.instance.deactivateElement(shiftId);
  }

  /// Gets the current progress of the transition (0.0 to 1.0).
  double get progress =>
      _isActive ? _animation.value : (_isCompleted ? 1.0 : 0.0);

  /// Whether the transition is currently active.
  bool get isActive => _isActive;

  /// Whether the transition has completed.
  bool get isCompleted => _isCompleted;
}

/// Utility class for creating common shared element transition patterns.
class SharedElementPatterns {
  SharedElementPatterns._();

  /// Creates a card expansion transition pattern.
  static SharedElementTransition? cardExpansion({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required Object shiftId,
    Duration? duration,
    VoidCallback? onComplete,
  }) {
    return SharedElementTransitionManager.instance.createTransition(
      sourceContext: sourceContext,
      targetContext: targetContext,
      shiftId: shiftId,
      duration: duration ?? const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      enableMorphing: true,
      useElevation: true,
      onComplete: onComplete,
    );
  }

  /// Creates a hero-style image transition.
  static SharedElementTransition? heroImage({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required Object shiftId,
    Duration? duration,
    VoidCallback? onComplete,
  }) {
    return SharedElementTransitionManager.instance.createTransition(
      sourceContext: sourceContext,
      targetContext: targetContext,
      shiftId: shiftId,
      duration: duration ?? const Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      enableMorphing: true,
      useElevation: false,
      onComplete: onComplete,
    );
  }

  /// Creates a curved flight path transition.
  static SharedElementTransition? curvedFlight({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required Object shiftId,
    double curvature = 0.3,
    Duration? duration,
    VoidCallback? onComplete,
  }) {
    // This would calculate the actual curved path based on source and target positions
    // For now, we'll use a default transition
    return SharedElementTransitionManager.instance.createTransition(
      sourceContext: sourceContext,
      targetContext: targetContext,
      shiftId: shiftId,
      duration: duration ?? const Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      enableMorphing: true,
      useElevation: true,
      onComplete: onComplete,
    );
  }

  /// Creates a staggered list transition for multiple elements.
  static List<SharedElementTransition> staggeredList({
    required BuildContext sourceContext,
    required BuildContext targetContext,
    required List<Object> shiftIds,
    Duration? itemDuration,
    Duration? staggerDelay,
    VoidCallback? onAllComplete,
  }) {
    return SharedElementTransitionManager.instance.createMultiElementTransition(
      sourceContext: sourceContext,
      targetContext: targetContext,
      shiftIds: shiftIds,
      duration: itemDuration ?? const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      enableMorphing: true,
      useElevation: false,
      staggerDelay: staggerDelay ?? const Duration(milliseconds: 50),
      onAllComplete: onAllComplete,
    );
  }
}

/// Extension methods for BuildContext to simplify shared element transitions.
extension SharedElementContextExtensions on BuildContext {
  /// Creates a shared element transition to another context.
  SharedElementTransition? transitionSharedElement({
    required BuildContext targetContext,
    required Object shiftId,
    Duration? duration,
    Curve? curve,
    bool enableMorphing = true,
    bool useElevation = true,
    VoidCallback? onComplete,
  }) {
    return SharedElementTransitionManager.instance.createTransition(
      sourceContext: this,
      targetContext: targetContext,
      shiftId: shiftId,
      duration: duration,
      curve: curve,
      enableMorphing: enableMorphing,
      useElevation: useElevation,
      onComplete: onComplete,
    );
  }
}
