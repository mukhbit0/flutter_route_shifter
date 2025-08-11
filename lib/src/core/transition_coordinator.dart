import 'package:flutter/material.dart';
import 'shifter_registry.dart';
import 'shared_element_manager.dart';
import 'edge_case_handler.dart';

/// The central coordinator that orchestrates the shared element transition chain of command.
///
/// RESPONSIBILITIES:
/// 1. Receives transition requests from RouteShifter
/// 2. Delegates element discovery to ShifterRegistry
/// 3. Delegates transition planning to SharedElementManager
/// 4. Delegates animation execution to SharedElementEffect
/// 5. Enforces performance optimizations from EdgeCaseHandler
///
/// CHAIN OF COMMAND:
/// RouteShifter → TransitionCoordinator → SharedElementManager → SharedElementEffect
///                     ↓
///               ShifterRegistry (element discovery)
///                     ↓
///               EdgeCaseHandler (performance analysis)
class TransitionCoordinator {
  static final TransitionCoordinator _instance =
      TransitionCoordinator._internal();
  static TransitionCoordinator get instance => _instance;
  TransitionCoordinator._internal();

  final ShifterRegistry _registry = ShifterRegistry.instance;
  final SharedElementTransitionManager _manager =
      SharedElementTransitionManager.instance;

  /// Current active transitions for performance tracking
  final Set<String> _activeTransitions = <String>{};

  /// Performance optimization cache
  final Map<String, PerformanceOptimization> _optimizationCache = {};

  /// Initiates a shared element transition with full performance optimization.
  ///
  /// This is the single entry point for all shared element transitions.
  /// It coordinates the entire process while maintaining clear responsibilities.
  Future<List<SharedElementTransition>> coordinateTransition({
    required BuildContext fromContext,
    required BuildContext toContext,
    required String transitionId,
  }) async {
    // STEP 1: Performance Analysis (EdgeCaseHandler responsibility)
    final optimization = await _analyzePerformanceRequirements(
      fromContext: fromContext,
      toContext: toContext,
      transitionId: transitionId,
    );

    // STEP 2: Element Discovery (ShifterRegistry responsibility)
    final elementPairs = await _discoverSharedElementPairs(
      fromContext: fromContext,
      toContext: toContext,
    );

    if (elementPairs.isEmpty) {
      return [];
    }

    // STEP 3: Transition Planning (SharedElementManager responsibility)
    final transitions = await _planTransitions(
      elementPairs: elementPairs,
      optimization: optimization,
      transitionId: transitionId,
    );

    // STEP 4: Performance Application (Our responsibility)
    _applyPerformanceOptimizations(transitions, optimization);

    // STEP 5: Register active transition for monitoring
    _activeTransitions.add(transitionId);
    _optimizationCache[transitionId] = optimization;

    return transitions;
  }

  /// Completes a transition and cleans up resources.
  void completeTransition(String transitionId) {
    _activeTransitions.remove(transitionId);
    _optimizationCache.remove(transitionId);
    _registry.cleanupStaleReferences();
  }

  /// STEP 1: Analyze performance requirements using EdgeCaseHandler
  Future<PerformanceOptimization> _analyzePerformanceRequirements({
    required BuildContext fromContext,
    required BuildContext toContext,
    required String transitionId,
  }) async {
    // Get all potential shared elements for analysis
    final fromElements = _registry.getAllElementsInContext(fromContext);
    final toElements = _registry.getAllElementsInContext(toContext);

    if (fromElements.isEmpty || toElements.isEmpty) {
      return PerformanceOptimization.minimal();
    }

    // Analyze the most complex transition for optimization
    final pairs = _findElementPairs(fromElements, toElements);
    if (pairs.isEmpty) {
      return PerformanceOptimization.minimal();
    }

    // Use EdgeCaseHandler to determine optimization strategy
    final mostComplexPair = pairs.reduce(
        (a, b) => _calculateComplexity(a) > _calculateComplexity(b) ? a : b);

    // Use SharedElementEdgeCaseHandler static methods to determine optimization strategy
    return SharedElementEdgeCaseHandler.analyzePerformanceRequirements(
      sourceRect: mostComplexPair.from.rect,
      targetRect: mostComplexPair.to.rect,
      sourceWidget: mostComplexPair.from.child,
      targetWidget: mostComplexPair.to.child,
    );
  }

  /// STEP 2: Discover shared element pairs using ShifterRegistry
  Future<List<_ElementPair>> _discoverSharedElementPairs({
    required BuildContext fromContext,
    required BuildContext toContext,
  }) async {
    final fromElements = _registry.getAllElementsInContext(fromContext);
    final toElements = _registry.getAllElementsInContext(toContext);

    return _findElementPairs(fromElements, toElements);
  }

  /// STEP 3: Plan transitions using SharedElementManager
  Future<List<SharedElementTransition>> _planTransitions({
    required List<_ElementPair> elementPairs,
    required PerformanceOptimization optimization,
    required String transitionId,
  }) async {
    final transitions = <SharedElementTransition>[];

    for (final pair in elementPairs) {
      final transition = _manager.createTransition(
        sourceContext: pair.from.context!,
        targetContext: pair.to.context!,
        shiftId: pair.from.shiftId,
        duration: optimization.recommendedDuration,
        curve: optimization.recommendedCurve,
        enableMorphing: !optimization.shouldSimplifyGeometry,
        useElevation: !optimization.shouldRasterize,
      );

      if (transition != null) {
        transitions.add(transition);
      }
    }

    return transitions;
  }

  /// STEP 4: Apply performance optimizations to transitions
  void _applyPerformanceOptimizations(
    List<SharedElementTransition> transitions,
    PerformanceOptimization optimization,
  ) {
    for (final transition in transitions) {
      // Apply rasterization if recommended
      if (optimization.shouldRasterize) {
        _enableRasterization(transition);
      }

      // Apply geometry simplification if recommended
      if (optimization.shouldSimplifyGeometry) {
        _enableGeometrySimplification(transition);
      }

      // Apply reduced frame rate if recommended
      if (optimization.recommendedFrameRate < 60) {
        _limitFrameRate(transition, optimization.recommendedFrameRate);
      }

      // Apply clipping strategy
      _applyClippingStrategy(transition, optimization.clippingStrategy);
    }
  }

  /// Enables rasterization by wrapping elements in RepaintBoundary
  void _enableRasterization(SharedElementTransition transition) {
    // Mark transition for rasterization - will be applied during build
    transition.metadata['useRasterization'] = true;
    transition.metadata['repaintBoundary'] = true;
  }

  /// Enables geometry simplification by creating simplified placeholders
  void _enableGeometrySimplification(SharedElementTransition transition) {
    // Create simplified placeholder widgets from source element
    final sourceSimplified =
        _createSimplifiedWidget(transition.sourceElement.child);

    transition.metadata['simplifiedSource'] = sourceSimplified;
    transition.metadata['useSimplification'] = true;
  }

  /// Limits frame rate for performance-critical transitions
  void _limitFrameRate(SharedElementTransition transition, int frameRate) {
    final duration = transition.duration;
    final optimizedDuration = Duration(
      milliseconds: (duration.inMilliseconds * (60 / frameRate)).round(),
    );

    transition.metadata['optimizedDuration'] = optimizedDuration;
    transition.metadata['targetFrameRate'] = frameRate;
  }

  /// Applies clipping strategy for overflow scenarios
  void _applyClippingStrategy(
    SharedElementTransition transition,
    ClippingStrategy strategy,
  ) {
    transition.metadata['clippingStrategy'] = strategy;

    switch (strategy) {
      case ClippingStrategy.hard:
        transition.metadata['useHardClip'] = true;
        break;
      case ClippingStrategy.fade:
        transition.metadata['useFadeClip'] = true;
        break;
      case ClippingStrategy.scale:
        transition.metadata['useScaleClip'] = true;
        break;
      case ClippingStrategy.none:
        transition.metadata['allowOverflow'] = true;
        break;
      case ClippingStrategy.source:
        transition.metadata['clipSource'] = true;
        break;
      case ClippingStrategy.target:
        transition.metadata['clipTarget'] = true;
        break;
      case ClippingStrategy.both:
        transition.metadata['clipSource'] = true;
        transition.metadata['clipTarget'] = true;
        break;
    }
  }

  /// Creates a simplified widget for performance optimization
  Widget _createSimplifiedWidget(Widget original) {
    return Builder(
      builder: (context) {
        // For images, use a colored container
        if (original is Image) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }

        // For complex widgets, use a simple colored rectangle
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  /// Creates optimized settings based on performance analysis
  // Removed as it's not used in the current implementation

  /// Finds matching element pairs between contexts
  List<_ElementPair> _findElementPairs(
    List<ShifterElementData> fromElements,
    List<ShifterElementData> toElements,
  ) {
    final pairs = <_ElementPair>[];

    for (final fromElement in fromElements) {
      for (final toElement in toElements) {
        if (fromElement.shiftId == toElement.shiftId) {
          pairs.add(_ElementPair(from: fromElement, to: toElement));
        }
      }
    }

    return pairs;
  }

  /// Calculates transition complexity for optimization analysis
  double _calculateComplexity(_ElementPair pair) {
    final sourceRect = pair.from.rect;
    final targetRect = pair.to.rect;

    // Complexity factors:
    // 1. Size difference
    final sizeDifference = (targetRect.width * targetRect.height) /
        (sourceRect.width * sourceRect.height);

    // 2. Distance
    final distance = (targetRect.center - sourceRect.center).distance;

    // 3. Aspect ratio change
    final sourceRatio = sourceRect.width / sourceRect.height;
    final targetRatio = targetRect.width / targetRect.height;
    final aspectDifference = (sourceRatio - targetRatio).abs();

    return sizeDifference + (distance / 100) + (aspectDifference * 10);
  }

  /// Gets current performance metrics for debugging
  Map<String, dynamic> getPerformanceMetrics() {
    return {
      'activeTransitions': _activeTransitions.length,
      'cachedOptimizations': _optimizationCache.length,
      'registeredElements': _registry.elementCount,
      'optimizations': _optimizationCache.values
          .map((opt) => {
                'shouldRasterize': opt.shouldRasterize,
                'shouldSimplify': opt.shouldSimplifyGeometry,
                'frameRate': opt.recommendedFrameRate,
              })
          .toList(),
    };
  }
}

/// Internal class for pairing source and target elements
class _ElementPair {
  final ShifterElementData from;
  final ShifterElementData to;

  _ElementPair({required this.from, required this.to});
}

/// Performance optimization extensions for SharedElementTransition
extension SharedElementTransitionOptimization on SharedElementTransition {
  /// Static metadata storage for performance optimizations
  static final Map<Object, Map<String, dynamic>> _metadataStorage = {};

  /// Metadata storage for performance optimizations
  Map<String, dynamic> get metadata {
    _metadataStorage[shiftId] ??= <String, dynamic>{};
    return _metadataStorage[shiftId]!;
  }

  /// Checks if rasterization is enabled
  bool get useRasterization => metadata['useRasterization'] == true;

  /// Checks if geometry simplification is enabled
  bool get useSimplification => metadata['useSimplification'] == true;

  /// Gets the optimized duration if available
  Duration get optimizedDuration => metadata['optimizedDuration'] ?? duration;

  /// Gets the clipping strategy
  ClippingStrategy get clippingStrategy =>
      metadata['clippingStrategy'] ?? ClippingStrategy.none;

  /// Cleans up metadata when transition completes
  void cleanupMetadata() {
    _metadataStorage.remove(shiftId);
  }
}
