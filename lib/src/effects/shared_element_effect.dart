import 'package:flutter/material.dart';
import 'base_effect.dart';
import '../core/shifter_registry.dart';

/// A specialized effect for shared element transitions.
///
/// This effect creates smooth overlay animations between shared elements
/// identified by their shiftId. It handles complex animations including
/// resizing, position changes, and aspect ratio adjustments.
class SharedElementEffect extends RouteEffect {
  /// The flight duration for the shared element animation.
  final Duration flightDuration;

  /// The curve for the shared element flight path.
  final Curve flightCurve;

  /// Whether to enable morphing between different aspect ratios.
  final bool enableMorphing;

  /// The curve for morphing transformations.
  final Curve morphCurve;

  /// Custom flight path for the shared element.
  final Path? customFlightPath;

  /// Whether to use elevation during flight.
  final bool useElevation;

  /// The elevation value during flight.
  final double flightElevation;

  /// List of specific shiftIds to include in the shared element transition.
  /// If null, all available shared elements will be included.
  final List<String>? shiftIds;

  /// Creates a shared element effect.
  const SharedElementEffect({
    this.flightDuration = const Duration(milliseconds: 400),
    this.flightCurve = Curves.fastLinearToSlowEaseIn,
    this.enableMorphing = true,
    this.morphCurve = Curves.easeInOut,
    this.customFlightPath,
    this.useElevation = true,
    this.flightElevation = 8.0,
    this.shiftIds,
    super.duration,
    super.curve = Curves.linear,
    super.start,
    super.end,
  });

  @override
  Widget buildTransition(Animation<double> animation, Widget child) {
    return SharedElementOverlay(
      animation: animation,
      flightDuration: flightDuration,
      flightCurve: flightCurve,
      enableMorphing: enableMorphing,
      morphCurve: morphCurve,
      customFlightPath: customFlightPath,
      useElevation: useElevation,
      flightElevation: flightElevation,
      shiftIds: shiftIds,
      child: child,
    );
  }

  @override
  SharedElementEffect copyWith({
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
    return SharedElementEffect(
      flightDuration: flightDuration ?? this.flightDuration,
      flightCurve: flightCurve ?? this.flightCurve,
      enableMorphing: enableMorphing ?? this.enableMorphing,
      morphCurve: morphCurve ?? this.morphCurve,
      customFlightPath: customFlightPath ?? this.customFlightPath,
      useElevation: useElevation ?? this.useElevation,
      flightElevation: flightElevation ?? this.flightElevation,
      shiftIds: shiftIds ?? this.shiftIds,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is SharedElementEffect &&
          flightDuration == other.flightDuration &&
          flightCurve == other.flightCurve &&
          enableMorphing == other.enableMorphing &&
          morphCurve == other.morphCurve &&
          customFlightPath == other.customFlightPath &&
          useElevation == other.useElevation &&
          flightElevation == other.flightElevation &&
          shiftIds == other.shiftIds;

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        flightDuration,
        flightCurve,
        enableMorphing,
        morphCurve,
        customFlightPath,
        useElevation,
        flightElevation,
        shiftIds,
      );

  @override
  String toString() => 'SharedElementEffect('
      'flightDuration: $flightDuration, '
      'flightCurve: $flightCurve, '
      'enableMorphing: $enableMorphing, '
      'duration: $duration)';
}

/// Widget that renders the shared element overlay with advanced animations.
class SharedElementOverlay extends StatefulWidget {
  final Animation<double> animation;
  final Duration flightDuration;
  final Curve flightCurve;
  final bool enableMorphing;
  final Curve morphCurve;
  final Path? customFlightPath;
  final bool useElevation;
  final double flightElevation;
  final List<String>? shiftIds;
  final Widget child;

  const SharedElementOverlay({
    Key? key,
    required this.animation,
    required this.flightDuration,
    required this.flightCurve,
    required this.enableMorphing,
    required this.morphCurve,
    this.customFlightPath,
    required this.useElevation,
    required this.flightElevation,
    this.shiftIds,
    required this.child,
  }) : super(key: key);

  @override
  State<SharedElementOverlay> createState() => _SharedElementOverlayState();
}

class _SharedElementOverlayState extends State<SharedElementOverlay>
    with TickerProviderStateMixin {
  late AnimationController _overlayController;
  late Map<Object, SharedElementFlightData> _flightData;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      duration: widget.flightDuration,
      vsync: this,
    );
    _flightData = {};
    _setupSharedElements();
    
    // Listen for animation completion to deactivate elements
    _overlayController.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        _cleanupSharedElements();
      }
    });
    
    _overlayController.forward();
  }

  @override
  void dispose() {
    _cleanupSharedElements();
    _overlayController.dispose();
    super.dispose();
  }

  void _setupSharedElements() {
    
    // First, activate all registered elements that have both source and target positions
    final allElements = ShifterRegistry.instance.getAllElements();
    
    for (final entry in allElements.entries) {
      final shiftId = entry.key;
      final elementData = entry.value;
      
      // Filter by shiftIds if provided
      if (widget.shiftIds != null && !widget.shiftIds!.contains(shiftId.toString())) {
        continue;
      }
      
      // Activate elements that have both source and target positions
      if (elementData.sourceRect != Rect.zero && elementData.targetRect != null) {
        ShifterRegistry.instance.activateElement(shiftId);
      } else {
      }
    }
    
    // Now get the active elements for transition
    final sharedElements = ShifterRegistry.instance.getActiveElements();

    for (final entry in sharedElements.entries) {
      final shiftId = entry.key;
      final elementData = entry.value;

      _flightData[shiftId] = SharedElementFlightData(
        elementData: elementData,
        positionTween: _createPositionTween(elementData),
        sizeTween: _createSizeTween(elementData),
        morphTween:
            widget.enableMorphing ? _createMorphTween(elementData) : null,
        elevationTween: widget.useElevation ? _createElevationTween() : null,
      );
    }
    
  }

  void _cleanupSharedElements() {
    
    // Deactivate all elements that were activated for this transition
    for (final shiftId in _flightData.keys) {
      ShifterRegistry.instance.deactivateElement(shiftId);
    }
    
  }

  RectTween _createPositionTween(ShifterElementData elementData) {
    return RectTween(
      begin: elementData.sourceRect,
      end: elementData.targetRect ?? elementData.sourceRect,
    );
  }

  Tween<Size> _createSizeTween(ShifterElementData elementData) {
    final sourceSize = elementData.sourceRect.size;
    final targetSize = elementData.targetRect?.size ?? sourceSize;
    return Tween<Size>(begin: sourceSize, end: targetSize);
  }

  Matrix4Tween? _createMorphTween(ShifterElementData elementData) {
    final sourceRect = elementData.sourceRect;
    final targetRect = elementData.targetRect ?? sourceRect;

    if (sourceRect.size == targetRect.size) return null;

    final scaleX = targetRect.width / sourceRect.width;
    final scaleY = targetRect.height / sourceRect.height;

    return Matrix4Tween(
      begin: Matrix4.identity(),
      end: Matrix4.diagonal3Values(scaleX, scaleY, 1.0),
    );
  }

  Tween<double>? _createElevationTween() {
    return Tween<double>(begin: 0.0, end: widget.flightElevation);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, _) {
        final sharedElements = ShifterRegistry.instance.getActiveElements();

        if (sharedElements.isEmpty) {
          return widget.child;
        }

        return Stack(
          children: [
            // Main content with shared elements hidden
            _buildMainContentWithHiddenElements(),

            // Shared element overlays
            ..._buildSharedElementOverlays(),
          ],
        );
      },
    );
  }

  Widget _buildMainContentWithHiddenElements() {
    return SharedElementHider(
      animation: widget.animation,
      hiddenElements: _flightData.keys,
      child: widget.child,
    );
  }

  List<Widget> _buildSharedElementOverlays() {
    return _flightData.entries.map((entry) {
      final shiftId = entry.key;
      final flightData = entry.value;

      return _buildSingleSharedElementOverlay(shiftId, flightData);
    }).toList();
  }

  Widget _buildSingleSharedElementOverlay(
    Object shiftId,
    SharedElementFlightData flightData,
  ) {
    final flightAnimation = CurvedAnimation(
      parent: _overlayController,
      curve: widget.flightCurve,
    );

    final morphAnimation = widget.enableMorphing
        ? CurvedAnimation(
            parent: _overlayController,
            curve: widget.morphCurve,
          )
        : null;

    return AnimatedBuilder(
      animation: Listenable.merge(
          [flightAnimation, if (morphAnimation != null) morphAnimation]),
      builder: (context, _) {
        final rect = flightData.positionTween.evaluate(flightAnimation)!;
        final elevation =
            flightData.elevationTween?.evaluate(flightAnimation) ?? 0.0;

        Widget overlayChild = flightData.elementData.child;

        // Apply morphing transformation if enabled
        if (widget.enableMorphing &&
            flightData.morphTween != null &&
            morphAnimation != null) {
          final transform = flightData.morphTween!.evaluate(morphAnimation);
          overlayChild = Transform(
            transform: transform,
            alignment: Alignment.center,
            child: overlayChild,
          );
        }

        // Add elevation effect if enabled
        if (widget.useElevation && elevation > 0) {
          overlayChild = Material(
            elevation: elevation,
            color: Colors.transparent,
            child: overlayChild,
          );
        }

        // Handle custom flight path
        if (widget.customFlightPath != null) {
          final pathMetric = widget.customFlightPath!.computeMetrics().first;
          final distance = pathMetric.length * flightAnimation.value;
          final tangent = pathMetric.getTangentForOffset(distance);

          if (tangent != null) {
            return Positioned(
              left: tangent.position.dx - rect.width / 2,
              top: tangent.position.dy - rect.height / 2,
              width: rect.width,
              height: rect.height,
              child: overlayChild,
            );
          }
        }

        return Positioned(
          left: rect.left,
          top: rect.top,
          width: rect.width,
          height: rect.height,
          child: ClipRect(
            child: OverflowBox(
              minWidth: 0,
              minHeight: 0,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: overlayChild,
            ),
          ),
        );
      },
    );
  }
}

/// Widget that hides shared elements in the main content during transitions.
class SharedElementHider extends StatelessWidget {
  final Animation<double> animation;
  final Iterable<Object> hiddenElements;
  final Widget child;

  const SharedElementHider({
    Key? key,
    required this.animation,
    required this.hiddenElements,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a complete implementation, this would traverse the widget tree
    // and find Shifter widgets with matching shiftIds, then hide them
    // during the transition by wrapping them with Opacity(opacity: 0.0)

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // For now, we'll use a simple approach that relies on the
        // Shifter widgets themselves to hide during active transitions
        return child;
      },
    );
  }
}

/// Data structure for managing shared element flight animations.
class SharedElementFlightData {
  final ShifterElementData elementData;
  final RectTween positionTween;
  final Tween<Size> sizeTween;
  final Matrix4Tween? morphTween;
  final Tween<double>? elevationTween;

  SharedElementFlightData({
    required this.elementData,
    required this.positionTween,
    required this.sizeTween,
    this.morphTween,
    this.elevationTween,
  });
}

/// Extension methods for creating curved flight paths.
extension SharedElementPaths on Path {
  /// Creates a curved flight path between two points.
  static Path createCurvedFlight(Offset start, Offset end,
      {double curvature = 0.3}) {
    final path = Path();
    path.moveTo(start.dx, start.dy);

    final controlPoint = Offset(
      start.dx + (end.dx - start.dx) * 0.5,
      start.dy +
          (end.dy - start.dy) * 0.5 -
          (end.dy - start.dy).abs() * curvature,
    );

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      end.dx,
      end.dy,
    );

    return path;
  }

  /// Creates an arc flight path.
  static Path createArcFlight(Offset start, Offset end, {double height = 100}) {
    final path = Path();
    path.moveTo(start.dx, start.dy);

    final midX = start.dx + (end.dx - start.dx) * 0.5;
    final midY = start.dy + (end.dy - start.dy) * 0.5 - height;

    path.quadraticBezierTo(midX, midY, end.dx, end.dy);
    return path;
  }
}
