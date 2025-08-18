import 'package:flutter/material.dart';
import '../core/route_shifter_builder.dart';
import '../utils/duration_extensions.dart';
import '../effects/creative/parallax_effect.dart';

/// Pre-built animation combinations for common use cases.
///
/// This library provides carefully crafted animation presets that follow
/// design best practices and are optimized for different scenarios.
class RouteShifterPresets {
  // ============================================================================
  // 🎯 GENERAL PURPOSE PRESETS
  // ============================================================================

  /// A subtle and professional fade-in animation.
  /// Perfect for most general navigation scenarios.
  static RouteShifterBuilder subtle() {
    return RouteShifterBuilder().fade(duration: 250.ms, curve: Curves.easeOut);
  }

  /// A smooth and elegant combination of fade and scale.
  /// Great for modal-style presentations.
  static RouteShifterBuilder elegant() {
    return RouteShifterBuilder()
        .fade(duration: 300.ms)
        .scale(beginScale: 0.95, curve: Curves.easeOutCubic);
  }

  /// A dynamic slide-in animation from the right.
  /// Ideal for forward navigation flows.
  static RouteShifterBuilder dynamic() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 275.ms)
        .fade(duration: 200.ms);
  }

  // ============================================================================
  // 🛍️ E-COMMERCE PRESETS
  // ============================================================================

  /// Product card to detail page transition.
  /// Smooth scale with subtle fade for product browsing.
  static RouteShifterBuilder productCard() {
    return RouteShifterBuilder()
        .fade(duration: 200.ms)
        .scale(beginScale: 0.8, curve: Curves.easeOutCubic);
  }

  /// Shopping cart overlay animation.
  /// Bottom slide with gentle bounce for cart interactions.
  static RouteShifterBuilder shoppingCart() {
    return RouteShifterBuilder()
        .slideFromBottom(duration: 350.ms, curve: Curves.easeOutBack);
  }

  /// Checkout flow progression.
  /// Professional slide transition for multi-step checkout.
  static RouteShifterBuilder checkoutFlow() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 300.ms)
        .fade(duration: 250.ms, curve: Curves.easeOut);
  }

  /// Product gallery view.
  /// Glass morphism effect for premium product galleries.
  static RouteShifterBuilder productGallery() {
    return RouteShifterBuilder()
        .glassMorph(endBlur: 15.0, duration: 400.ms)
        .fade(duration: 300.ms);
  }

  // ============================================================================
  // 📱 SOCIAL MEDIA PRESETS
  // ============================================================================

  /// Profile page transition.
  /// Elegant glass effect for user profiles.
  static RouteShifterBuilder socialProfile() {
    return RouteShifterBuilder()
        .glassMorph(endBlur: 20.0, duration: 500.ms)
        .parallax(direction: ParallaxDirection.vertical, backgroundSpeed: 0.3);
  }

  /// Story or post viewer.
  /// Quick fade-in for media consumption flows.
  static RouteShifterBuilder storyViewer() {
    return RouteShifterBuilder().fade(duration: 150.ms, curve: Curves.easeOut);
  }

  /// Comments or interaction modal.
  /// Bottom slide with backdrop blur.
  static RouteShifterBuilder socialModal() {
    return RouteShifterBuilder()
        .slideFromBottom(duration: 300.ms)
        .glassMorph(endBlur: 10.0, duration: 250.ms);
  }

  /// Feed navigation.
  /// Smooth horizontal slide for feed browsing.
  static RouteShifterBuilder feedNavigation() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 250.ms)
        .fade(duration: 200.ms);
  }

  // ============================================================================
  // 💼 BUSINESS/PRODUCTIVITY PRESETS
  // ============================================================================

  /// Document or file viewer.
  /// Professional fade transition for document apps.
  static RouteShifterBuilder documentViewer() {
    return RouteShifterBuilder()
        .fade(duration: 200.ms, curve: Curves.easeInOut);
  }

  /// Dashboard navigation.
  /// Subtle glass effect for business dashboards.
  static RouteShifterBuilder dashboard() {
    return RouteShifterBuilder()
        .glassMorph(endBlur: 8.0, duration: 300.ms)
        .fade(duration: 250.ms);
  }

  /// Settings or configuration pages.
  /// Clean slide transition for settings flows.
  static RouteShifterBuilder settings() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 300.ms, curve: Curves.easeOutCubic);
  }

  /// Report or analytics view.
  /// Scale animation for data-heavy screens.
  static RouteShifterBuilder analytics() {
    return RouteShifterBuilder()
        .scale(beginScale: 0.9, duration: 350.ms)
        .fade(duration: 300.ms);
  }

  // ============================================================================
  // 🎮 GAMING/ENTERTAINMENT PRESETS
  // ============================================================================

  /// Game level transition.
  /// Dramatic scale and rotation for gaming apps.
  static RouteShifterBuilder gameLevel() {
    return RouteShifterBuilder()
        .scale(beginScale: 0.7, duration: 500.ms)
        .rotation(beginTurns: -0.1, duration: 400.ms)
        .fade(duration: 300.ms);
  }

  /// Media player or video viewer.
  /// Cinematic fade for media consumption.
  static RouteShifterBuilder mediaPlayer() {
    return RouteShifterBuilder()
        .fade(duration: 400.ms, curve: Curves.easeInOutCubic);
  }

  /// Achievement or popup modal.
  /// Bouncy scale animation for achievements.
  static RouteShifterBuilder achievement() {
    return RouteShifterBuilder()
        .scale(beginScale: 0.3, duration: 600.ms, curve: Curves.elasticOut)
        .fade(duration: 300.ms);
  }

  // ============================================================================
  // 🎨 CREATIVE/ARTISTIC PRESETS
  // ============================================================================

  /// Art gallery or portfolio.
  /// Sophisticated clip path reveal for creative apps.
  static RouteShifterBuilder artGallery() {
    return RouteShifterBuilder()
        .circleReveal(duration: 600.ms)
        .fade(duration: 400.ms);
  }

  /// Photo editor or creative tool.
  /// Dynamic parallax for creative workflows.
  static RouteShifterBuilder photoEditor() {
    return RouteShifterBuilder()
        .parallax(
            direction: ParallaxDirection.horizontal,
            backgroundSpeed: 0.5,
            duration: 450.ms)
        .glassMorph(endBlur: 12.0, duration: 350.ms);
  }

  /// Creative portfolio showcase.
  /// Artistic rotation and scale combination.
  static RouteShifterBuilder portfolio() {
    return RouteShifterBuilder()
        .rotation(beginTurns: 0.05, duration: 500.ms)
        .scale(beginScale: 0.85, duration: 400.ms)
        .fade(duration: 350.ms);
  }

  // ============================================================================
  // 📚 EDUCATIONAL PRESETS
  // ============================================================================

  /// Course or lesson navigation.
  /// Clean and focused slide transition.
  static RouteShifterBuilder courseLesson() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 300.ms, curve: Curves.easeOutCubic);
  }

  /// Quiz or assessment flow.
  /// Engaging scale animation for interactive content.
  static RouteShifterBuilder quiz() {
    return RouteShifterBuilder()
        .scale(beginScale: 0.9, duration: 250.ms)
        .fade(duration: 200.ms);
  }

  /// Study material or textbook.
  /// Page-like slide transition for reading flows.
  static RouteShifterBuilder studyMaterial() {
    return RouteShifterBuilder()
        .slideFromRight(duration: 350.ms, curve: Curves.easeInOutCubic);
  }

  // ============================================================================
  // 🏥 HEALTHCARE PRESETS
  // ============================================================================

  /// Patient information or medical records.
  /// Professional and trustworthy fade transition.
  static RouteShifterBuilder medicalRecord() {
    return RouteShifterBuilder()
        .fade(duration: 250.ms, curve: Curves.easeInOut);
  }

  /// Appointment or consultation flow.
  /// Calm and reassuring slide transition.
  static RouteShifterBuilder appointment() {
    return RouteShifterBuilder()
        .slideFromBottom(duration: 400.ms, curve: Curves.easeOutCubic)
        .fade(duration: 300.ms);
  }

  // ============================================================================
  // 🚗 TRANSPORTATION PRESETS
  // ============================================================================

  /// Map or navigation view.
  /// Smooth glass effect for map-based apps.
  static RouteShifterBuilder mapNavigation() {
    return RouteShifterBuilder()
        .glassMorph(endBlur: 15.0, duration: 350.ms)
        .slideFromBottom(duration: 300.ms);
  }

  /// Ride booking or transportation flow.
  /// Quick and efficient slide transition.
  static RouteShifterBuilder rideBooking() {
    return RouteShifterBuilder()
        .slideFromBottom(duration: 300.ms)
        .fade(duration: 250.ms);
  }
}

/// Extension methods for easy preset access.
extension RouteShifterPresetExtension on RouteShifterBuilder {
  /// Apply a preset configuration to the current builder.
  ///
  /// This allows you to combine presets with custom effects.
  ///
  /// Example:
  /// ```dart
  /// RouteShifterBuilder()
  ///   .applyPreset(RouteShifterPresets.elegant())
  ///   .colorTint(beginColor: Colors.blue, endColor: Colors.transparent)
  ///   .push(context);
  /// ```
  RouteShifterBuilder applyPreset(RouteShifterBuilder preset) {
    // Copy all effects from the preset to this builder
    effects.addAll(preset.effects);
    return this;
  }
}

/// Utility class for getting context-aware presets.
class AdaptivePresets {
  /// Get platform-appropriate preset.
  ///
  /// Automatically selects iOS or Material design patterns
  /// based on the current platform.
  static RouteShifterBuilder platformDefault(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return RouteShifterBuilder()
            .slideFromRight(duration: 250.ms, curve: Curves.easeInOut);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return RouteShifterBuilder()
            .fade(duration: 300.ms, curve: Curves.easeInOutCubicEmphasized);
    }
  }

  /// Get theme-aware preset.
  ///
  /// Adjusts animation intensity based on light/dark theme.
  static RouteShifterBuilder themeAware(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return RouteShifterBuilder()
          .glassMorph(endBlur: 20.0, duration: 400.ms)
          .fade(duration: 300.ms);
    } else {
      return RouteShifterBuilder()
          .fade(duration: 250.ms)
          .scale(beginScale: 0.95, duration: 300.ms);
    }
  }
}
