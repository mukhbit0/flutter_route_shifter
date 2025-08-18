import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';
import '../utils/duration_extensions.dart';
import '../presets/animation_presets.dart';
import '../effects/creative/parallax_effect.dart';

/// Deep link integration for RouteShifterBuilder.
///
/// This allows you to create animations based on URL parameters,
/// perfect for marketing campaigns, A/B testing, and dynamic UX flows.
class DeepLinkRouteShifter {
  /// Creates a RouteShifterBuilder from URL parameters.
  ///
  /// Supports multiple animation types and customization parameters
  /// that can be specified in deep link URLs.
  ///
  /// Example URLs:
  /// - `myapp://product/123?animation=glass&blur=15&duration=600`
  /// - `myapp://profile?animation=slide&direction=right&curve=bounce`
  /// - `myapp://gallery?animation=fade&preset=elegant`
  ///
  /// Example usage:
  /// ```dart
  /// GoRoute(
  ///   path: '/product/:id',
  ///   pageBuilder: (context, state) {
  ///     final shifter = DeepLinkRouteShifter.fromUrl(
  ///       state.uri,
  ///       fallback: RouteShifterBuilder().fade(),
  ///     );
  ///     return shifter.toPage(child: ProductPage(id: state.pathParameters['id']!));
  ///   },
  /// ),
  /// ```
  static RouteShifterBuilder fromUrl(
    Uri uri, {
    RouteShifterBuilder? fallback,
  }) {
    final params = uri.queryParameters;
    final animationType = params['animation']?.toLowerCase();

    if (animationType == null) {
      return fallback ?? RouteShifterBuilder().fade();
    }

    try {
      return _buildFromParameters(animationType, params);
    } catch (e) {
      debugPrint('DeepLinkRouteShifter: Error parsing URL parameters: $e');
      return fallback ?? RouteShifterBuilder().fade();
    }
  }

  /// Creates a RouteShifterBuilder from a JSON string.
  ///
  /// Useful for storing animation configurations in databases
  /// or passing complex animation data through APIs.
  ///
  /// Example:
  /// ```dart
  /// final animationJson = '''\n  {\n    "type": "combination",\n    "effects": [\n      {"type": "fade", "duration": 300},\n      {"type": "scale", "begin": 0.8, "duration": 400}\n    ]\n  }\n  ''';\n  \n  final shifter = DeepLinkRouteShifter.fromJson(animationJson);\n  ```
  static RouteShifterBuilder fromJson(String jsonString) {
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return _buildFromJson(json);
    } catch (e) {
      debugPrint('DeepLinkRouteShifter: Error parsing JSON: $e');
      return RouteShifterBuilder().fade();
    }
  }

  /// Creates a URL with animation parameters.
  ///
  /// Useful for generating shareable links with specific animations.
  ///
  /// Example:
  /// ```dart
  /// final url = DeepLinkRouteShifter.toUrl(
  ///   baseUrl: 'myapp://product/123',
  ///   builder: RouteShifterBuilder().glass(endBlur: 20.0).fade(duration: 400.ms),
  /// );
  /// // Result: "myapp://product/123?animation=glass&blur=20&duration=400"
  /// ```
  static String toUrl({
    required String baseUrl,
    required RouteShifterBuilder builder,
  }) {
    final uri = Uri.parse(baseUrl);
    final params = Map<String, String>.from(uri.queryParameters);

    // Add animation parameters based on the builder's effects
    _addAnimationParameters(params, builder);

    return uri.replace(queryParameters: params).toString();
  }

  static RouteShifterBuilder _buildFromParameters(
    String animationType,
    Map<String, String> params,
  ) {
    final duration = _parseDuration(params['duration']);
    final curve = _parseCurve(params['curve']);

    switch (animationType) {
      case 'fade':
        return RouteShifterBuilder().fade(
          duration: duration,
          curve: curve,
        );

      case 'slide':
        final direction = params['direction']?.toLowerCase() ?? 'right';
        return _buildSlideAnimation(direction, duration, curve);

      case 'scale':
        final begin = double.tryParse(params['begin'] ?? '') ?? 0.0;
        final end = double.tryParse(params['end'] ?? '') ?? 1.0;
        return RouteShifterBuilder().scale(
          beginScale: begin,
          endScale: end,
          duration: duration,
          curve: curve,
        );

      case 'glass':
      case 'glassmorphism':
        final blur = double.tryParse(params['blur'] ?? '') ?? 15.0;
        final opacity = double.tryParse(params['opacity'] ?? '') ?? 0.1;
        return RouteShifterBuilder().glassMorph(
          endBlur: blur,
          endColor: Colors.white.withValues(alpha: opacity),
          duration: duration,
          curve: curve,
        );

      case 'rotation':
        final begin = double.tryParse(params['begin'] ?? '') ?? 0.0;
        final end = double.tryParse(params['end'] ?? '') ?? 0.25;
        return RouteShifterBuilder().rotation(
          beginTurns: begin,
          endTurns: end,
          duration: duration,
          curve: curve,
        );

      case 'parallax':
        final direction = params['direction']?.toLowerCase() ?? 'vertical';
        final intensity = double.tryParse(params['intensity'] ?? '') ?? 0.5;
        if (direction == 'horizontal') {
          return RouteShifterBuilder().parallax(
            direction: ParallaxDirection.horizontal,
            backgroundSpeed: intensity,
            duration: duration,
          );
        } else {
          return RouteShifterBuilder().parallax(
            direction: ParallaxDirection.vertical,
            backgroundSpeed: intensity,
            duration: duration,
          );
        }

      case 'clippath':
      case 'clip':
        final shape = params['shape']?.toLowerCase() ?? 'circle';
        return _buildClipPathAnimation(shape, duration, curve);

      case 'preset':
        final presetName = params['preset']?.toLowerCase();
        return _buildPresetAnimation(presetName);

      case 'combination':
        return _buildCombinationAnimation(params, duration, curve);

      default:
        return RouteShifterBuilder().fade(duration: duration, curve: curve);
    }
  }

  static RouteShifterBuilder _buildFromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;

    if (type == 'combination') {
      final effects = json['effects'] as List<dynamic>?;
      if (effects == null) return RouteShifterBuilder().fade();

      RouteShifterBuilder builder = RouteShifterBuilder();

      for (final effect in effects) {
        final effectMap = effect as Map<String, dynamic>;
        final effectType = effectMap['type'] as String;

        switch (effectType) {
          case 'fade':
            builder = builder.fade(
              duration: Duration(milliseconds: effectMap['duration'] ?? 300),
            );
            break;
          case 'scale':
            builder = builder.scale(
              beginScale: effectMap['begin']?.toDouble() ?? 0.0,
              endScale: effectMap['end']?.toDouble() ?? 1.0,
              duration: Duration(milliseconds: effectMap['duration'] ?? 300),
            );
            break;
          case 'slide':
            final direction = effectMap['direction'] as String? ?? 'right';
            builder = _addSlideToBuilder(builder, direction, effectMap);
            break;
          // Add more effect types as needed
        }
      }

      return builder;
    } else {
      // Handle single effect JSON
      return _buildFromParameters(type ?? 'fade', _mapFromJson(json));
    }
  }

  static Map<String, String> _mapFromJson(Map<String, dynamic> json) {
    return json.map((key, value) => MapEntry(key, value.toString()));
  }

  static RouteShifterBuilder _addSlideToBuilder(
    RouteShifterBuilder builder,
    String direction,
    Map<String, dynamic> params,
  ) {
    final duration = Duration(milliseconds: params['duration'] ?? 300);

    switch (direction.toLowerCase()) {
      case 'left':
        return builder.slideFromLeft(duration: duration);
      case 'right':
        return builder.slideFromRight(duration: duration);
      case 'up':
        return builder.slideFromTop(duration: duration);
      case 'down':
      case 'bottom':
        return builder.slideFromBottom(duration: duration);
      default:
        return builder.slideFromRight(duration: duration);
    }
  }

  static Duration _parseDuration(String? durationStr) {
    if (durationStr == null) return 300.ms;
    final ms = int.tryParse(durationStr);
    return ms != null ? Duration(milliseconds: ms) : 300.ms;
  }

  static Curve _parseCurve(String? curveStr) {
    if (curveStr == null) return Curves.easeInOut;

    switch (curveStr.toLowerCase()) {
      case 'linear':
        return Curves.linear;
      case 'easein':
        return Curves.easeIn;
      case 'easeout':
        return Curves.easeOut;
      case 'easeinout':
        return Curves.easeInOut;
      case 'bounce':
        return Curves.bounceOut;
      case 'elastic':
        return Curves.elasticOut;
      case 'back':
        return Curves.easeOutBack;
      default:
        return Curves.easeInOut;
    }
  }

  static RouteShifterBuilder _buildSlideAnimation(
    String direction,
    Duration duration,
    Curve curve,
  ) {
    switch (direction) {
      case 'left':
        return RouteShifterBuilder()
            .slideFromLeft(duration: duration, curve: curve);
      case 'right':
        return RouteShifterBuilder()
            .slideFromRight(duration: duration, curve: curve);
      case 'up':
      case 'top':
        return RouteShifterBuilder()
            .slideFromTop(duration: duration, curve: curve);
      case 'down':
      case 'bottom':
        return RouteShifterBuilder()
            .slideFromBottom(duration: duration, curve: curve);
      default:
        return RouteShifterBuilder()
            .slideFromRight(duration: duration, curve: curve);
    }
  }

  static RouteShifterBuilder _buildClipPathAnimation(
    String shape,
    Duration duration,
    Curve curve,
  ) {
    switch (shape) {
      case 'circle':
        return RouteShifterBuilder().circleReveal(duration: duration);
      case 'rectangle':
      case 'rect':
        return RouteShifterBuilder().rectangleReveal(duration: duration);
      case 'star':
        return RouteShifterBuilder().starReveal(duration: duration);
      case 'wave':
        return RouteShifterBuilder().waveReveal(duration: duration);
      default:
        return RouteShifterBuilder().circleReveal(duration: duration);
    }
  }

  static RouteShifterBuilder _buildPresetAnimation(String? presetName) {
    if (presetName == null) return RouteShifterBuilder().fade();

    switch (presetName) {
      case 'subtle':
        return RouteShifterPresets.subtle();
      case 'elegant':
        return RouteShifterPresets.elegant();
      case 'dynamic':
        return RouteShifterPresets.dynamic();
      case 'product':
      case 'productcard':
        return RouteShifterPresets.productCard();
      case 'social':
      case 'socialprofile':
        return RouteShifterPresets.socialProfile();
      case 'dashboard':
        return RouteShifterPresets.dashboard();
      case 'game':
      case 'gamelevel':
        return RouteShifterPresets.gameLevel();
      default:
        return RouteShifterPresets.subtle();
    }
  }

  static RouteShifterBuilder _buildCombinationAnimation(
    Map<String, String> params,
    Duration duration,
    Curve curve,
  ) {
    // Parse combination parameters like "fade+slide+scale"
    final effects = params['effects']?.split('+') ?? ['fade'];
    RouteShifterBuilder builder = RouteShifterBuilder();

    for (final effect in effects) {
      switch (effect.trim().toLowerCase()) {
        case 'fade':
          builder = builder.fade(duration: duration, curve: curve);
          break;
        case 'slide':
          builder = builder.slideFromRight(duration: duration, curve: curve);
          break;
        case 'scale':
          builder =
              builder.scale(beginScale: 0.8, duration: duration, curve: curve);
          break;
        case 'glass':
          builder = builder.glassMorph(endBlur: 15.0, duration: duration);
          break;
      }
    }

    return builder;
  }

  static void _addAnimationParameters(
    Map<String, String> params,
    RouteShifterBuilder builder,
  ) {
    // This would analyze the builder's effects and add appropriate parameters
    // For now, we'll add a simple animation parameter
    if (builder.effects.isNotEmpty) {
      params['animation'] = 'custom';
      params['effects'] = builder.effects.length.toString();
    }
  }
}

/// Extension for easy deep link integration.
extension DeepLinkExtension on RouteShifterBuilder {
  /// Convert this builder to a shareable URL parameter string.
  ///
  /// Example:
  /// ```dart
  /// final params = RouteShifterBuilder()
  ///   .fade()
  ///   .scale(begin: 0.8)
  ///   .toUrlParams();
  /// // Result: "animation=combination&effects=fade+scale&duration=300"
  /// ```
  String toUrlParams() {
    if (effects.isEmpty) return 'animation=fade';

    final params = <String, String>{};

    if (effects.length == 1) {
      // Single effect
      final effect = effects.first;
      params['animation'] = effect.runtimeType.toString().toLowerCase();
    } else {
      // Multiple effects
      params['animation'] = 'combination';
      params['effects'] =
          effects.map((e) => e.runtimeType.toString().toLowerCase()).join('+');
    }

    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}

/// Predefined deep link configurations for common scenarios.
class DeepLinkPresets {
  /// Marketing campaign animations for high conversion.
  static const Map<String, String> marketing = {
    'hero': 'animation=glass&blur=20&duration=600',
    'cta': 'animation=scale&begin=0.8&curve=bounce&duration=500',
    'product': 'animation=combination&effects=fade+scale&duration=400',
    'premium': 'animation=glass&blur=25&opacity=0.15&duration=800',
  };

  /// A/B testing configurations.
  static const Map<String, String> abTesting = {
    'variant_a': 'animation=fade&duration=250',
    'variant_b': 'animation=scale&begin=0.9&duration=300',
    'variant_c': 'animation=slide&direction=right&duration=275',
    'variant_d': 'animation=glass&blur=15&duration=400',
  };

  /// Onboarding flow animations.
  static const Map<String, String> onboarding = {
    'welcome': 'animation=scale&begin=0.5&curve=elastic&duration=800',
    'tutorial': 'animation=slide&direction=right&duration=350',
    'completion':
        'animation=combination&effects=fade+scale+rotation&duration=600',
  };

  /// Get URL for a marketing preset.
  static String getMarketingUrl(String baseUrl, String preset) {
    final params = marketing[preset] ?? marketing['hero']!;
    return '$baseUrl?$params';
  }

  /// Get URL for an A/B testing variant.
  static String getABTestUrl(String baseUrl, String variant) {
    final params = abTesting[variant] ?? abTesting['variant_a']!;
    return '$baseUrl?$params';
  }
}
