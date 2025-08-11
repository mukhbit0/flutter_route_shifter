import 'package:flutter/material.dart';
import '../effects/base_effect.dart';
import '../effects/fade_effect.dart';
import '../effects/slide_effect.dart';
import '../effects/scale_effect.dart';
import '../effects/blur_effect.dart';
import '../effects/rotation_effect.dart';
import '../effects/stagger_effect.dart';
import '../effects/clip_path_effect.dart';
import '../effects/color_tint_effect.dart';
import '../effects/shear_effect.dart';
import '../effects/parallax_effect.dart';
import '../effects/follow_path_effect.dart';
import 'route_shifter.dart' as local_shifter;

/// A builder class that provides a chainable API for creating animated route transitions.
///
/// This class implements the builder pattern, allowing you to chain different
/// effects together to create complex route animations.
///
/// Example:
/// ```dart
/// final route = RouteShifterBuilder()
///   .fade()
///   .slide(direction: SlideDirection.fromRight)
///   .scale(begin: 0.8)
///   .toRoute(page: NextPage());
/// ```
class RouteShifterBuilder {
  final List<RouteEffect> _effects = [];
  bool _interactiveDismissEnabled = false;
  local_shifter.DismissDirection? _dismissDirection;
  Map<String, dynamic>? _sharedElementSettings;

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

  /// Creates a new builder with the given effects.
  RouteShifterBuilder({
    List<RouteEffect> effects = const [],
    bool interactiveDismissEnabled = false,
    local_shifter.DismissDirection? dismissDirection,
    Map<String, dynamic>? sharedElementSettings,
  }) {
    _effects.addAll(effects);
    _interactiveDismissEnabled = interactiveDismissEnabled;
    _dismissDirection = dismissDirection;
    _sharedElementSettings = sharedElementSettings;
  }

  /// Adds a fade effect to the transition.
  RouteShifterBuilder fade({
    double begin = 0.0,
    double end = 1.0,
    double? beginOpacity,
    double? endOpacity,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double animationEnd = 1.0,
  }) {
    _effects.add(FadeEffect(
      beginOpacity: beginOpacity ?? begin,
      endOpacity: endOpacity ?? end,
      duration: duration,
      curve: curve,
      start: start,
      end: animationEnd,
    ));
    return this;
  }

  /// Adds a slide effect to the transition.
  RouteShifterBuilder slide({
    Offset? offsetBegin,
    Offset? offsetEnd,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(SlideEffect(
      begin: offsetBegin ?? const Offset(1.0, 0.0),
      offsetEnd: offsetEnd ?? Offset.zero,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a slide from right effect.
  RouteShifterBuilder slideFromRight({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return slide(
      offsetBegin: const Offset(1.0, 0.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    );
  }

  /// Adds a slide from left effect.
  RouteShifterBuilder slideFromLeft({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return slide(
      offsetBegin: const Offset(-1.0, 0.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    );
  }

  /// Adds a slide from top effect.
  RouteShifterBuilder slideFromTop({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return slide(
      offsetBegin: const Offset(0.0, -1.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    );
  }

  /// Adds a slide from bottom effect.
  RouteShifterBuilder slideFromBottom({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return slide(
      offsetBegin: const Offset(0.0, 1.0),
      offsetEnd: Offset.zero,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    );
  }

  /// Adds a scale effect to the transition.
  RouteShifterBuilder scale({
    double begin = 0.0,
    double end = 1.0,
    double? beginScale,
    double? endScale,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double animationEnd = 1.0,
  }) {
    _effects.add(ScaleEffect(
      beginScale: beginScale ?? begin,
      endScale: endScale ?? end,
      duration: duration,
      curve: curve,
      start: start,
      end: animationEnd,
    ));
    return this;
  }

  /// Adds a scale up effect.
  RouteShifterBuilder scaleUp({
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return scale(
      begin: 0.0,
      end: 1.0,
      duration: duration,
      curve: curve,
      start: start,
      animationEnd: end,
    );
  }

  /// Adds a blur effect to the transition.
  RouteShifterBuilder blur({
    double begin = 0.0,
    double end = 5.0,
    double? beginSigma,
    double? endSigma,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double animationEnd = 1.0,
  }) {
    _effects.add(BlurEffect(
      beginSigma: beginSigma ?? begin,
      endSigma: endSigma ?? end,
      duration: duration,
      curve: curve,
      start: start,
      end: animationEnd,
    ));
    return this;
  }

  /// Adds a rotation effect to the transition.
  RouteShifterBuilder rotation({
    double begin = 0.0,
    double end = 1.0,
    double? beginTurns,
    double? endTurns,
    double? turns,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double animationEnd = 1.0,
  }) {
    _effects.add(RotationEffect(
      beginTurns: beginTurns ?? begin,
      endTurns: endTurns ?? end,
      duration: duration,
      curve: curve,
      start: start,
      end: animationEnd,
    ));
    return this;
  }

  /// Adds a clockwise rotation effect.
  RouteShifterBuilder rotateClockwise({
    double turns = 1.0,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    return rotation(
      begin: 0.0,
      end: turns,
      duration: duration,
      curve: curve,
      start: start,
      animationEnd: end,
    );
  }

  /// Adds a stagger effect to the transition.
  RouteShifterBuilder stagger({
    Duration? interval,
    bool Function(Widget)? selector,
    RouteEffect? baseEffect,
    int maxStaggeredChildren = 20,
    bool reverse = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    _effects.add(StaggerEffect(
      interval: interval ?? const Duration(milliseconds: 100),
      selector: selector,
      baseEffect: baseEffect,
      maxStaggeredChildren: maxStaggeredChildren,
      reverse: reverse,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  // ============================================================================
  // CREATIVE EFFECTS
  // ============================================================================

  /// Adds a clip path effect for dramatic reveals.
  RouteShifterBuilder clipPath({
    ClipPathType type = ClipPathType.circle,
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(ClipPathEffect(
      type: type,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a circle reveal clip path effect.
  RouteShifterBuilder circleReveal({
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.circle,
      direction: ClipDirection.center,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a rectangle reveal clip path effect.
  RouteShifterBuilder rectangleReveal({
    ClipDirection direction = ClipDirection.center,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.rectangle,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a star reveal clip path effect.
  RouteShifterBuilder starReveal({
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.star,
      direction: ClipDirection.center,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a wave reveal clip path effect.
  RouteShifterBuilder waveReveal({
    ClipDirection direction = ClipDirection.left,
    bool reversed = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return clipPath(
      type: ClipPathType.wave,
      direction: direction,
      reversed: reversed,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a color tint effect for overlays and modals.
  RouteShifterBuilder colorTint({
    required Color beginColor,
    required Color endColor,
    BlendMode blendMode = BlendMode.srcOver,
    TintPosition position = TintPosition.front,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(ColorTintEffect(
      beginColor: beginColor,
      endColor: endColor,
      blendMode: blendMode,
      position: position,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a modal color tint effect (black overlay).
  RouteShifterBuilder modal({
    double opacity = 0.5,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: Colors.black.withValues(alpha: opacity),
      position: TintPosition.behind,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a highlight color tint effect.
  RouteShifterBuilder highlight({
    required Color color,
    double opacity = 0.7,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: color.withValues(alpha: opacity),
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a fade to color effect.
  RouteShifterBuilder fadeToColor({
    required Color color,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return colorTint(
      beginColor: Colors.transparent,
      endColor: color,
      position: TintPosition.front,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a gradient tint effect.
  RouteShifterBuilder gradientTint({
    Gradient? beginGradient,
    required Gradient endGradient,
    TintPosition position = TintPosition.front,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(GradientTintEffect(
      beginGradient: beginGradient,
      endGradient: endGradient,
      position: position,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a shear effect for stylistic skewing.
  RouteShifterBuilder shear({
    Offset beginShear = const Offset(0.5, 0.0),
    Offset endShear = Offset.zero,
    Alignment origin = Alignment.center,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(ShearEffect(
      beginShear: beginShear,
      endShear: endShear,
      origin: origin,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a horizontal shear effect.
  RouteShifterBuilder horizontalShear({
    double shear = 0.3,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(shear, 0.0),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a vertical shear effect.
  RouteShifterBuilder verticalShear({
    double shear = 0.3,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(0.0, shear),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a diagonal shear effect.
  RouteShifterBuilder diagonalShear({
    double shear = 0.2,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    return this.shear(
      beginShear: Offset(shear, shear),
      endShear: Offset.zero,
      duration: duration,
      curve: curve,
    );
  }

  /// Adds a parallax effect for creating depth.
  RouteShifterBuilder parallax({
    double backgroundSpeed = 0.3,
    ParallaxDirection direction = ParallaxDirection.horizontal,
    bool blurBackground = false,
    double blurSigma = 2.0,
    bool scaleBackground = false,
    double backgroundScale = 0.95,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(ParallaxEffect(
      backgroundSpeed: backgroundSpeed,
      direction: direction,
      blurBackground: blurBackground,
      blurSigma: blurSigma,
      scaleBackground: scaleBackground,
      backgroundScale: backgroundScale,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a horizontal parallax effect.
  RouteShifterBuilder horizontalParallax({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Adds a vertical parallax effect.
  RouteShifterBuilder verticalParallax({
    double speed = 0.3,
    bool blur = false,
    bool scale = false,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.vertical,
      blurBackground: blur,
      scaleBackground: scale,
      duration: duration,
    );
  }

  /// Adds a depth parallax effect with blur and scale.
  RouteShifterBuilder depthParallax({
    double speed = 0.2,
    double blurSigma = 3.0,
    double scale = 0.9,
    Duration? duration,
  }) {
    return parallax(
      backgroundSpeed: speed,
      direction: ParallaxDirection.horizontal,
      blurBackground: true,
      blurSigma: blurSigma,
      scaleBackground: true,
      backgroundScale: scale,
      duration: duration,
    );
  }

  /// Adds a multi-layer parallax effect.
  RouteShifterBuilder multiLayerParallax({
    List<double> layerSpeeds = const [0.1, 0.3, 0.6, 1.0],
    ParallaxDirection direction = ParallaxDirection.horizontal,
    bool useLayeredBlur = true,
    bool useLayeredScale = true,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    _effects.add(MultiLayerParallaxEffect(
      layerSpeeds: layerSpeeds,
      direction: direction,
      useLayeredBlur: useLayeredBlur,
      useLayeredScale: useLayeredScale,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a follow path effect for non-linear motion.
  RouteShifterBuilder followPath({
    required Path path,
    bool rotateAlongPath = false,
    double rotationOffset = 0.0,
    Offset pathOrigin = Offset.zero,
    bool usePreciseMetrics = true,
    Duration? duration,
    Curve curve = Curves.easeInOut,
    double start = 0.0,
    double end = 1.0,
  }) {
    _effects.add(FollowPathEffect(
      path: path,
      rotateAlongPath: rotateAlongPath,
      rotationOffset: rotationOffset,
      pathOrigin: pathOrigin,
      usePreciseMetrics: usePreciseMetrics,
      duration: duration,
      curve: curve,
      start: start,
      end: end,
    ));
    return this;
  }

  /// Adds a circular path effect.
  RouteShifterBuilder circularPath({
    required double radius,
    double startAngle = 0.0,
    double sweepAngle = 6.283185307179586, // 2 * pi
    Offset center = Offset.zero,
    bool clockwise = true,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.circular(
      radius: radius,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      center: center,
      clockwise: clockwise,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a wave path effect.
  RouteShifterBuilder wavePath({
    required double width,
    required double height,
    double amplitude = 50.0,
    double frequency = 2.0,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.wave(
      width: width,
      height: height,
      amplitude: amplitude,
      frequency: frequency,
      startPoint: startPoint,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a spiral path effect.
  RouteShifterBuilder spiralPath({
    required double maxRadius,
    double turns = 3.0,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.spiral(
      maxRadius: maxRadius,
      turns: turns,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds an S-curve path effect.
  RouteShifterBuilder sCurvePath({
    required double width,
    required double height,
    Offset startPoint = Offset.zero,
    bool rotateAlongPath = false,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.sCurve(
      width: width,
      height: height,
      startPoint: startPoint,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a heart-shaped path effect.
  RouteShifterBuilder heartPath({
    required double size,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.heart(
      size: size,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a figure-8 path effect.
  RouteShifterBuilder figure8Path({
    required double width,
    required double height,
    Offset center = Offset.zero,
    bool rotateAlongPath = true,
    Duration? duration,
  }) {
    _effects.add(FollowPathEffect.figure8(
      width: width,
      height: height,
      center: center,
      rotateAlongPath: rotateAlongPath,
      duration: duration,
    ));
    return this;
  }

  /// Adds a multi-segment path effect.
  RouteShifterBuilder multiSegmentPath({
    required List<PathSegment> segments,
    bool rotateAlongPath = false,
    SegmentTransition segmentTransition = SegmentTransition.smooth,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    _effects.add(MultiSegmentPathEffect(
      segments: segments,
      rotateAlongPath: rotateAlongPath,
      segmentTransition: segmentTransition,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  /// Adds a particle trail path effect.
  RouteShifterBuilder particleTrailPath({
    required Path path,
    int particleCount = 5,
    double trailFadeDuration = 0.3,
    bool rotateParticles = false,
    Duration? duration,
    Curve curve = Curves.easeInOut,
  }) {
    _effects.add(ParticleTrailPathEffect(
      path: path,
      particleCount: particleCount,
      trailFadeDuration: trailFadeDuration,
      rotateParticles: rotateParticles,
      duration: duration,
      curve: curve,
    ));
    return this;
  }

  // ============================================================================
  // INTERACTIVE DISMISS & SHARED ELEMENTS
  // ============================================================================

  /// Enables interactive dismiss gestures.
  RouteShifterBuilder interactiveDismiss({
    local_shifter.DismissDirection direction =
        local_shifter.DismissDirection.horizontal,
  }) {
    _interactiveDismissEnabled = true;
    _dismissDirection = direction;
    return this;
  }

  /// Enables interactive dismiss gestures (alias for interactiveDismiss).
  RouteShifterBuilder enableInteractiveDismiss({
    local_shifter.DismissDirection direction =
        local_shifter.DismissDirection.horizontal,
  }) {
    return interactiveDismiss(direction: direction);
  }

  /// Disables interactive dismiss gestures.
  RouteShifterBuilder disableInteractiveDismiss() {
    _interactiveDismissEnabled = false;
    _dismissDirection = null;
    return this;
  }

  /// Sets shared element settings.
  RouteShifterBuilder withSharedElementSettings(Map<String, dynamic> settings) {
    _sharedElementSettings = settings;
    return this;
  }

  /// Enables shared elements with advanced configuration.
  RouteShifterBuilder sharedElements({
    Duration? flightDuration,
    Curve? flightCurve,
    Map<String, dynamic>? settings,
    bool enableMorphing = true,
    Curve? morphCurve,
    bool useElevation = true,
    double? flightElevation,
    Path? customFlightPath,
  }) {
    final sharedSettings = <String, dynamic>{
      'enabled': true,
      if (flightDuration != null) 'flightDuration': flightDuration,
      if (flightCurve != null) 'flightCurve': flightCurve,
      'enableMorphing': enableMorphing,
      if (morphCurve != null) 'morphCurve': morphCurve,
      'useElevation': useElevation,
      if (flightElevation != null) 'flightElevation': flightElevation,
      if (customFlightPath != null) 'customFlightPath': customFlightPath,
      ...?settings,
    };
    _sharedElementSettings = sharedSettings;
    return this;
  }

  /// Enables shared elements with curved flight path.
  RouteShifterBuilder sharedElementsWithCurvedPath({
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
  RouteShifterBuilder sharedElementsWithArc({
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

  /// Gets the list of effects.
  List<RouteEffect> get effects => List.unmodifiable(_effects);

  /// Gets whether interactive dismiss is enabled.
  bool get isInteractiveDismissEnabled => _interactiveDismissEnabled;

  /// Gets the dismiss direction.
  local_shifter.DismissDirection? get dismissDirection => _dismissDirection;

  /// Gets the shared element settings.
  Map<String, dynamic>? get sharedElementSettings => _sharedElementSettings;
}
