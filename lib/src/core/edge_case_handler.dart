import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Utility class for handling edge cases in shared element transitions.
///
/// This class provides methods to handle various challenging scenarios
/// such as different aspect ratios, resizing, clipping, and performance optimization.
class SharedElementEdgeCaseHandler {
  SharedElementEdgeCaseHandler._();

  /// Handles aspect ratio differences between source and target elements.
  ///
  /// This method calculates the optimal transformation to smoothly transition
  /// between elements with different aspect ratios.
  static AspectRatioTransition calculateAspectRatioTransition({
    required Rect sourceRect,
    required Rect targetRect,
    AspectRatioStrategy strategy = AspectRatioStrategy.scaleToFit,
  }) {
    final sourceAspectRatio = sourceRect.width / sourceRect.height;
    final targetAspectRatio = targetRect.width / targetRect.height;

    if ((sourceAspectRatio - targetAspectRatio).abs() < 0.01) {
      // Aspect ratios are essentially the same
      return AspectRatioTransition(
        needsHandling: false,
        sourceRect: sourceRect,
        targetRect: targetRect,
        intermediateRects: [],
        strategy: strategy,
      );
    }

    final intermediateRects = <Rect>[];

    switch (strategy) {
      case AspectRatioStrategy.scaleToFit:
        intermediateRects
            .addAll(_calculateScaleToFitTransition(sourceRect, targetRect));
        break;
      case AspectRatioStrategy.crop:
        intermediateRects
            .addAll(_calculateCropTransition(sourceRect, targetRect));
        break;
      case AspectRatioStrategy.letterbox:
        intermediateRects
            .addAll(_calculateLetterboxTransition(sourceRect, targetRect));
        break;
      case AspectRatioStrategy.morphGradual:
        intermediateRects
            .addAll(_calculateGradualMorphTransition(sourceRect, targetRect));
        break;
    }

    return AspectRatioTransition(
      needsHandling: true,
      sourceRect: sourceRect,
      targetRect: targetRect,
      intermediateRects: intermediateRects,
      strategy: strategy,
    );
  }

  /// Calculates scale-to-fit transition frames.
  static List<Rect> _calculateScaleToFitTransition(Rect source, Rect target) {
    final frames = <Rect>[];
    const frameCount = 8;

    for (int i = 1; i < frameCount; i++) {
      final t = i / frameCount;

      // Scale to maintain aspect ratio
      final sourceAspect = source.width / source.height;
      final targetAspect = target.width / target.height;

      Rect intermediateRect;

      if (sourceAspect > targetAspect) {
        // Source is wider, scale based on height
        final newHeight = source.height + (target.height - source.height) * t;
        final newWidth = newHeight * sourceAspect;
        final centerX =
            source.center.dx + (target.center.dx - source.center.dx) * t;
        final centerY =
            source.center.dy + (target.center.dy - source.center.dy) * t;

        intermediateRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: newWidth,
          height: newHeight,
        );
      } else {
        // Source is taller, scale based on width
        final newWidth = source.width + (target.width - source.width) * t;
        final newHeight = newWidth / sourceAspect;
        final centerX =
            source.center.dx + (target.center.dx - source.center.dx) * t;
        final centerY =
            source.center.dy + (target.center.dy - source.center.dy) * t;

        intermediateRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: newWidth,
          height: newHeight,
        );
      }

      frames.add(intermediateRect);
    }

    return frames;
  }

  /// Calculates crop transition frames.
  static List<Rect> _calculateCropTransition(Rect source, Rect target) {
    final frames = <Rect>[];
    const frameCount = 8;

    for (int i = 1; i < frameCount; i++) {
      final t = i / frameCount;

      // Interpolate position and size directly (cropping effect)
      final left = source.left + (target.left - source.left) * t;
      final top = source.top + (target.top - source.top) * t;
      final width = source.width + (target.width - source.width) * t;
      final height = source.height + (target.height - source.height) * t;

      frames.add(Rect.fromLTWH(left, top, width, height));
    }

    return frames;
  }

  /// Calculates letterbox transition frames.
  static List<Rect> _calculateLetterboxTransition(Rect source, Rect target) {
    final frames = <Rect>[];
    const frameCount = 8;

    final sourceAspect = source.width / source.height;
    final targetAspect = target.width / target.height;

    for (int i = 1; i < frameCount; i++) {
      final t = i / frameCount;

      // Create letterbox effect by maintaining one dimension
      Rect intermediateRect;

      if (sourceAspect > targetAspect) {
        // Add top/bottom letterbox
        final newWidth = source.width + (target.width - source.width) * t;
        final newHeight = newWidth / sourceAspect;
        final centerX =
            source.center.dx + (target.center.dx - source.center.dx) * t;
        final centerY =
            source.center.dy + (target.center.dy - source.center.dy) * t;

        intermediateRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: newWidth,
          height: newHeight,
        );
      } else {
        // Add left/right letterbox
        final newHeight = source.height + (target.height - source.height) * t;
        final newWidth = newHeight * sourceAspect;
        final centerX =
            source.center.dx + (target.center.dx - source.center.dx) * t;
        final centerY =
            source.center.dy + (target.center.dy - source.center.dy) * t;

        intermediateRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: newWidth,
          height: newHeight,
        );
      }

      frames.add(intermediateRect);
    }

    return frames;
  }

  /// Calculates gradual morph transition frames.
  static List<Rect> _calculateGradualMorphTransition(Rect source, Rect target) {
    final frames = <Rect>[];
    const frameCount = 12; // More frames for smoother morphing

    for (int i = 1; i < frameCount; i++) {
      final t = i / frameCount;

      // Use easing curve for smoother morphing
      final easedT = Curves.easeInOutCubic.transform(t);

      final left = source.left + (target.left - source.left) * easedT;
      final top = source.top + (target.top - source.top) * easedT;
      final width = source.width + (target.width - source.width) * easedT;
      final height = source.height + (target.height - source.height) * easedT;

      frames.add(Rect.fromLTWH(left, top, width, height));
    }

    return frames;
  }

  /// Handles clipping and overflow scenarios.
  static ClippingStrategy calculateClippingStrategy({
    required Rect elementRect,
    required Rect containerRect,
    required Rect targetRect,
  }) {
    final isSourceClipped = !containerRect.overlaps(elementRect) ||
        !containerRect.contains(elementRect.topLeft) ||
        !containerRect.contains(elementRect.bottomRight);
    final isTargetClipped = !containerRect.overlaps(targetRect) ||
        !containerRect.contains(targetRect.topLeft) ||
        !containerRect.contains(targetRect.bottomRight);

    if (!isSourceClipped && !isTargetClipped) {
      return ClippingStrategy.none;
    }

    if (isSourceClipped && isTargetClipped) {
      return ClippingStrategy.both;
    }

    return isSourceClipped ? ClippingStrategy.source : ClippingStrategy.target;
  }

  /// Optimizes performance for large or complex transitions.
  static PerformanceOptimization calculatePerformanceOptimization({
    required Size elementSize,
    required int elementComplexity,
    required Duration transitionDuration,
  }) {
    final area = elementSize.width * elementSize.height;
    final complexity =
        elementComplexity; // Number of child widgets, animations, etc.

    var optimizationLevel = OptimizationLevel.none;
    var useRasterization = false;
    var reducedFrameRate = false;
    var simplifiedGeometry = false;

    // Large elements
    if (area > 500000) {
      // 500k square pixels
      optimizationLevel = OptimizationLevel.high;
      useRasterization = true;
    } else if (area > 100000) {
      // 100k square pixels
      optimizationLevel = OptimizationLevel.medium;
      useRasterization = true;
    }

    // Complex elements
    if (complexity > 50) {
      optimizationLevel = OptimizationLevel.high;
      simplifiedGeometry = true;
    } else if (complexity > 20) {
      optimizationLevel = OptimizationLevel.medium;
    }

    // Long duration transitions
    if (transitionDuration.inMilliseconds > 1000) {
      reducedFrameRate = true;
    }

    return PerformanceOptimization(
      level: optimizationLevel,
      useRasterization: useRasterization,
      useReducedFrameRate: reducedFrameRate,
      useSimplifiedGeometry: simplifiedGeometry,
      recommendedFrameRate: reducedFrameRate ? 30 : 60,
      aspectRatioTransition: calculateAspectRatioTransition(
        sourceRect: Rect.fromLTWH(0, 0, elementSize.width, elementSize.height),
        targetRect: Rect.fromLTWH(0, 0, elementSize.width, elementSize.height),
      ),
    );
  }

  /// Analyzes performance requirements for a specific transition.
  /// This is a convenience method for the TransitionCoordinator.
  static PerformanceOptimization analyzePerformanceRequirements({
    required Rect sourceRect,
    required Rect targetRect,
    required Widget sourceWidget,
    required Widget targetWidget,
  }) {
    // Calculate element size (use the larger of the two rects)
    final sourceSize = sourceRect.size;
    final targetSize = targetRect.size;
    final maxSize = Size(
      math.max(sourceSize.width, targetSize.width),
      math.max(sourceSize.height, targetSize.height),
    );

    // Estimate complexity based on widget type
    int complexity = _estimateWidgetComplexity(sourceWidget) +
        _estimateWidgetComplexity(targetWidget);

    // Estimate duration based on rect differences
    final distance = (targetRect.center - sourceRect.center).distance;
    final sizeChange = (targetSize.width * targetSize.height) /
        (sourceSize.width * sourceSize.height);
    final duration = Duration(
      milliseconds:
          (300 + (distance / 2) + (sizeChange * 100)).clamp(200, 1000).round(),
    );

    return calculatePerformanceOptimization(
      elementSize: maxSize,
      elementComplexity: complexity,
      transitionDuration: duration,
    );
  }

  /// Estimates widget complexity for performance analysis
  static int _estimateWidgetComplexity(Widget widget) {
    if (widget is Image) return 15;
    if (widget is ListView || widget is GridView) return 25;
    if (widget is Column || widget is Row) return 10;
    if (widget is Stack) return 20;
    if (widget is Container) return 5;
    if (widget is Text) return 3;
    return 8; // Default complexity
  }

  /// Handles screen orientation changes during transitions.
  static OrientationTransition handleOrientationChange({
    required Rect sourceRect,
    required Rect targetRect,
    required Size oldScreenSize,
    required Size newScreenSize,
  }) {
    final scaleX = newScreenSize.width / oldScreenSize.width;
    final scaleY = newScreenSize.height / oldScreenSize.height;

    final adjustedSourceRect = Rect.fromLTWH(
      sourceRect.left * scaleX,
      sourceRect.top * scaleY,
      sourceRect.width * scaleX,
      sourceRect.height * scaleY,
    );

    final adjustedTargetRect = Rect.fromLTWH(
      targetRect.left * scaleX,
      targetRect.top * scaleY,
      targetRect.width * scaleX,
      targetRect.height * scaleY,
    );

    return OrientationTransition(
      originalSource: sourceRect,
      originalTarget: targetRect,
      adjustedSource: adjustedSourceRect,
      adjustedTarget: adjustedTargetRect,
      needsRecalculation: true,
    );
  }

  /// Validates transition feasibility and provides fallback options.
  static TransitionValidation validateTransition({
    required Rect sourceRect,
    required Rect targetRect,
    required Duration duration,
    required Size screenSize,
  }) {
    final warnings = <String>[];
    final errors = <String>[];
    var isValid = true;
    var recommendedFallback = FallbackStrategy.none;

    // Check if rectangles are valid
    if (sourceRect.isEmpty || targetRect.isEmpty) {
      errors.add('Source or target rectangle is empty');
      isValid = false;
      recommendedFallback = FallbackStrategy.fadeOnly;
    }

    // Check if rectangles are on screen
    final screenRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    if (!screenRect.overlaps(sourceRect) || !screenRect.overlaps(targetRect)) {
      warnings.add('Elements are partially or completely off-screen');
      recommendedFallback = FallbackStrategy.slideOnly;
    }

    // Check distance
    final distance = (targetRect.center - sourceRect.center).distance;
    if (distance > screenSize.longestSide * 2) {
      warnings.add('Transition distance is very large');
      recommendedFallback = FallbackStrategy.teleport;
    }

    // Check size difference
    final sizeDifference =
        (targetRect.size.longestSide / sourceRect.size.longestSide);
    if (sizeDifference > 10 || sizeDifference < 0.1) {
      warnings.add('Extreme size difference detected');
      recommendedFallback = FallbackStrategy.scaleLimit;
    }

    // Check duration
    if (duration.inMilliseconds > 2000) {
      warnings.add('Very long transition duration');
    } else if (duration.inMilliseconds < 100) {
      warnings.add('Very short transition duration');
    }

    return TransitionValidation(
      isValid: isValid,
      warnings: warnings,
      errors: errors,
      recommendedFallback: recommendedFallback,
    );
  }
}

/// Strategy for handling aspect ratio differences.
enum AspectRatioStrategy {
  scaleToFit,
  crop,
  letterbox,
  morphGradual,
}

/// Strategy for handling clipping scenarios.
enum ClippingStrategy {
  none,
  source,
  target,
  both,
  hard, // Hard clipping without transitions
  fade, // Fade clipping with opacity transitions
  scale, // Scale clipping with size transitions
}

/// Performance optimization level.
enum OptimizationLevel {
  none,
  low,
  medium,
  high,
}

/// Fallback strategy when transitions are not feasible.
enum FallbackStrategy {
  none,
  fadeOnly,
  slideOnly,
  teleport,
  scaleLimit,
}

/// Data class for aspect ratio transition information.
class AspectRatioTransition {
  final bool needsHandling;
  final Rect sourceRect;
  final Rect targetRect;
  final List<Rect> intermediateRects;
  final AspectRatioStrategy strategy;

  const AspectRatioTransition({
    required this.needsHandling,
    required this.sourceRect,
    required this.targetRect,
    required this.intermediateRects,
    required this.strategy,
  });
}

/// Data class for performance optimization recommendations.
class PerformanceOptimization {
  final OptimizationLevel level;
  final bool useRasterization;
  final bool useReducedFrameRate;
  final bool useSimplifiedGeometry;
  final int recommendedFrameRate;
  final Duration recommendedDuration;
  final Curve recommendedCurve;
  final ClippingStrategy clippingStrategy;
  final AspectRatioTransition aspectRatioTransition;

  const PerformanceOptimization({
    required this.level,
    required this.useRasterization,
    required this.useReducedFrameRate,
    required this.useSimplifiedGeometry,
    required this.recommendedFrameRate,
    this.recommendedDuration = const Duration(milliseconds: 300),
    this.recommendedCurve = Curves.easeInOut,
    this.clippingStrategy = ClippingStrategy.none,
    required this.aspectRatioTransition,
  });

  /// Creates a minimal optimization for simple transitions
  factory PerformanceOptimization.minimal() {
    return PerformanceOptimization(
      level: OptimizationLevel.none,
      useRasterization: false,
      useReducedFrameRate: false,
      useSimplifiedGeometry: false,
      recommendedFrameRate: 60,
      recommendedDuration: const Duration(milliseconds: 300),
      recommendedCurve: Curves.easeInOut,
      clippingStrategy: ClippingStrategy.none,
      aspectRatioTransition: AspectRatioTransition(
        needsHandling: false,
        sourceRect: Rect.zero,
        targetRect: Rect.zero,
        intermediateRects: [],
        strategy: AspectRatioStrategy.scaleToFit,
      ),
    );
  }

  /// Convenience getters for compatibility
  bool get shouldRasterize => useRasterization;
  bool get shouldSimplifyGeometry => useSimplifiedGeometry;
}

/// Data class for orientation change handling.
class OrientationTransition {
  final Rect originalSource;
  final Rect originalTarget;
  final Rect adjustedSource;
  final Rect adjustedTarget;
  final bool needsRecalculation;

  const OrientationTransition({
    required this.originalSource,
    required this.originalTarget,
    required this.adjustedSource,
    required this.adjustedTarget,
    required this.needsRecalculation,
  });
}

/// Data class for transition validation results.
class TransitionValidation {
  final bool isValid;
  final List<String> warnings;
  final List<String> errors;
  final FallbackStrategy recommendedFallback;

  const TransitionValidation({
    required this.isValid,
    required this.warnings,
    required this.errors,
    required this.recommendedFallback,
  });
}
