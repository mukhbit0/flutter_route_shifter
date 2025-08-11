import 'package:flutter/material.dart' hide DismissDirection;
import '../core/route_shifter_builder.dart';
import '../core/route_shifter.dart' show DismissDirection;

/// Pre-built route transitions following Cupertino (iOS) design guidelines.
///
/// This class provides static factory methods for common iOS-style
/// transition patterns, including the signature sliding animations
/// and modal presentations typical of iOS applications.
class CupertinoPresets {
  CupertinoPresets._();

  // Standard iOS durations
  static const Duration _quickDuration = Duration(milliseconds: 250);
  static const Duration _standardDuration = Duration(milliseconds: 350);

  /// Standard iOS page transition (slide from right with shadow).
  ///
  /// This is the default iOS navigation transition used in UINavigationController.
  static RouteShifterBuilder cupertinoPageTransition() {
    return RouteShifterBuilder()
        .slideFromRight(
          duration: _standardDuration,
          curve: Curves.fastEaseInToSlowEaseOut,
        )
        .interactiveDismiss(
          direction: DismissDirection.horizontal,
        );
  }

  /// iOS modal presentation (slide up from bottom).
  ///
  /// Used for modal view controllers that slide up from the bottom.
  static RouteShifterBuilder cupertinoModalPresentation() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .scale(
          beginScale: 1.0,
          endScale: 0.95,
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .interactiveDismiss(
          direction: DismissDirection.vertical,
        );
  }

  /// iOS fullscreen modal (fade with slight scale).
  ///
  /// Used for fullscreen modal presentations.
  static RouteShifterBuilder cupertinoFullScreenModal() {
    return RouteShifterBuilder()
        .fade(
          duration: _quickDuration,
          curve: Curves.easeInOut,
        )
        .scale(
          beginScale: 1.1,
          endScale: 1.0,
          duration: _quickDuration,
          curve: Curves.easeOut,
        );
  }

  /// iOS alert dialog transition.
  ///
  /// Bouncy scale animation typical of iOS alerts.
  static RouteShifterBuilder cupertinoAlert() {
    return RouteShifterBuilder()
        .fade(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        )
        .scale(
          beginScale: 1.3,
          endScale: 1.0,
          duration: _standardDuration,
          curve: Curves.elasticOut,
        );
  }

  /// iOS action sheet transition.
  ///
  /// Slides up from bottom with slight bounce.
  static RouteShifterBuilder cupertinoActionSheet() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _standardDuration,
          curve: Curves.easeOutBack,
        )
        .fade(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  /// iOS tab bar transition.
  ///
  /// Subtle fade for tab switching.
  static RouteShifterBuilder cupertinoTabTransition() {
    return RouteShifterBuilder().fade(
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  /// iOS search transition.
  ///
  /// Slides down from the top with blur effect.
  static RouteShifterBuilder cupertinoSearch() {
    return RouteShifterBuilder()
        .slideFromTop(
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .blur(
          beginSigma: 0.0,
          endSigma: 5.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        )
        .fade(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  /// iOS segmented control transition.
  ///
  /// Quick fade for segmented control changes.
  static RouteShifterBuilder cupertinoSegmentedTransition() {
    return RouteShifterBuilder().fade(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  /// iOS picker transition.
  ///
  /// Slides up from bottom, similar to modal but faster.
  static RouteShifterBuilder cupertinoPicker() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _quickDuration,
          curve: Curves.easeInOut,
        )
        .fade(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
  }

  /// iOS context menu transition.
  ///
  /// Scale with blur background effect.
  static RouteShifterBuilder cupertinoContextMenu() {
    return RouteShifterBuilder()
        .scale(
          beginScale: 0.9,
          endScale: 1.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
        )
        .fade(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        )
        .blur(
          beginSigma: 0.0,
          endSigma: 10.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  /// iOS navigation push (with parallax effect).
  ///
  /// Simulates the iOS navigation stack with background movement.
  static RouteShifterBuilder cupertinoNavigationPush() {
    return RouteShifterBuilder()
        .slideFromRight(
          duration: _standardDuration,
          curve: Curves.fastEaseInToSlowEaseOut,
        )
        .fade(
          beginOpacity: 0.0,
          endOpacity: 1.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          start: 0.0,
          end: 0.3,
        )
        .interactiveDismiss(
          direction: DismissDirection.horizontal,
        );
  }

  /// iOS navigation pop (reverse slide).
  ///
  /// Used when popping from the navigation stack.
  static RouteShifterBuilder cupertinoNavigationPop() {
    return RouteShifterBuilder().slideFromLeft(
      duration: _standardDuration,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  /// iOS page sheet (iOS 13+ style modal).
  ///
  /// Modern iOS modal with rounded corners and drag dismiss.
  static RouteShifterBuilder cupertinoPageSheet() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .scale(
          beginScale: 1.0,
          endScale: 0.98,
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .fade(
          beginOpacity: 0.0,
          endOpacity: 1.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        )
        .interactiveDismiss(
          direction: DismissDirection.vertical,
        );
  }

  /// iOS notification transition.
  ///
  /// Slides down from top for notifications.
  static RouteShifterBuilder cupertinoNotification() {
    return RouteShifterBuilder()
        .slideFromTop(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
        )
        .fade(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
  }

  /// iOS control center transition.
  ///
  /// Slides up with blur effect, similar to iOS Control Center.
  static RouteShifterBuilder cupertinoControlCenter() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .blur(
          beginSigma: 0.0,
          endSigma: 20.0,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        )
        .scale(
          beginScale: 0.95,
          endScale: 1.0,
          duration: _standardDuration,
          curve: Curves.easeOut,
        )
        .interactiveDismiss(
          direction: DismissDirection.vertical,
        );
  }

  /// iOS photo viewer transition.
  ///
  /// Scale and fade for photo gallery-style presentations.
  static RouteShifterBuilder cupertinoPhotoViewer() {
    return RouteShifterBuilder()
        .scale(
          beginScale: 0.8,
          endScale: 1.0,
          duration: _standardDuration,
          curve: Curves.easeInOut,
        )
        .fade(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        )
        .blur(
          beginSigma: 0.0,
          endSigma: 15.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
  }

  /// Gets a Cupertino preset by name.
  ///
  /// Useful for dynamic preset selection.
  static RouteShifterBuilder? getPresetByName(String name) {
    switch (name.toLowerCase()) {
      case 'page':
      case 'cupertino_page':
        return cupertinoPageTransition();
      case 'modal':
      case 'modal_presentation':
        return cupertinoModalPresentation();
      case 'fullscreen_modal':
        return cupertinoFullScreenModal();
      case 'alert':
        return cupertinoAlert();
      case 'action_sheet':
        return cupertinoActionSheet();
      case 'tab':
      case 'tab_transition':
        return cupertinoTabTransition();
      case 'search':
        return cupertinoSearch();
      case 'segmented':
        return cupertinoSegmentedTransition();
      case 'picker':
        return cupertinoPicker();
      case 'context_menu':
        return cupertinoContextMenu();
      case 'navigation_push':
        return cupertinoNavigationPush();
      case 'navigation_pop':
        return cupertinoNavigationPop();
      case 'page_sheet':
        return cupertinoPageSheet();
      case 'notification':
        return cupertinoNotification();
      case 'control_center':
        return cupertinoControlCenter();
      case 'photo_viewer':
        return cupertinoPhotoViewer();
      default:
        return null;
    }
  }

  /// Gets all available Cupertino preset names.
  static List<String> get availablePresets => [
        'page',
        'modal',
        'fullscreen_modal',
        'alert',
        'action_sheet',
        'tab_transition',
        'search',
        'segmented',
        'picker',
        'context_menu',
        'navigation_push',
        'navigation_pop',
        'page_sheet',
        'notification',
        'control_center',
        'photo_viewer',
      ];
}
