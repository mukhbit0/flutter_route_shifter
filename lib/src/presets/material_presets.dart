import '../core/route_shifter_builder.dart';
import '../core/route_shifter.dart' show DismissDirection;
import '../utils/curves.dart';

/// Pre-built route transitions following Material Design guidelines.
///
/// This class provides static factory methods for common Material Design
/// transition patterns, making it easy to achieve consistent animations
/// throughout your application.
///
/// All presets follow Material Design motion principles:
/// - Standard easing curves
/// - Appropriate durations
/// - Proper layering and hierarchy
class MaterialPresets {
  MaterialPresets._();

  // Standard Material Design durations
  static const Duration _shortDuration = Duration(milliseconds: 200);
  static const Duration _mediumDuration = Duration(milliseconds: 300);
  static const Duration _longDuration = Duration(milliseconds: 400);

  /// Standard Material page transition (slide from right).
  ///
  /// This is the default transition used in Material Design for
  /// forward navigation between pages.
  static RouteShifterBuilder materialPageTransition() {
    return RouteShifterBuilder().slideFromRight(
      duration: _mediumDuration,
      curve: MaterialCurves.standardEasing,
    );
  }

  /// Material shared axis transition (X-axis).
  ///
  /// Used when elements move horizontally across the screen,
  /// such as in tabs or lateral navigation.
  static RouteShifterBuilder materialSharedAxisX() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
          start: 0.0,
          end: 0.3,
        )
        .slideFromRight(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
          start: 0.3,
          end: 1.0,
        );
  }

  /// Material shared axis transition (Y-axis).
  ///
  /// Used when elements move vertically, such as in
  /// bottom navigation or vertical paging.
  static RouteShifterBuilder materialSharedAxisY() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
          start: 0.0,
          end: 0.3,
        )
        .slideFromBottom(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
          start: 0.3,
          end: 1.0,
        );
  }

  /// Material shared axis transition (Z-axis).
  ///
  /// Used when elements move through depth layers,
  /// such as in dialogs or overlays.
  static RouteShifterBuilder materialSharedAxisZ() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
        )
        .scale(
          beginScale: 0.92,
          endScale: 1.0,
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
        );
  }

  /// Material fade through transition.
  ///
  /// Used when content changes while staying in the same
  /// context, such as in bottom navigation tabs.
  static RouteShifterBuilder materialFadeThrough() {
    return RouteShifterBuilder()
        .fade(
          duration: Duration(milliseconds: 210),
          curve: MaterialCurves.fadeInEasing,
          start: 0.0,
          end: 0.35,
        )
        .fade(
          beginOpacity: 0.0,
          endOpacity: 1.0,
          duration: Duration(milliseconds: 150),
          curve: MaterialCurves.fadeOutEasing,
          start: 0.35,
          end: 1.0,
        );
  }

  /// Material container transform.
  ///
  /// Used when a UI element expands to fill the screen
  /// or contracts from full screen, such as in FAB transitions.
  static RouteShifterBuilder materialContainerTransform() {
    return RouteShifterBuilder()
        .fade(
          duration: _longDuration,
          curve: MaterialCurves.standardEasing,
        )
        .scale(
          beginScale: 0.8,
          endScale: 1.0,
          duration: _longDuration,
          curve: MaterialCurves.emphasizedEasing,
        );
  }

  /// Material bottom sheet transition.
  ///
  /// Appropriate for bottom sheets and modal presentations.
  static RouteShifterBuilder materialBottomSheet() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _mediumDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        )
        .fade(
          beginOpacity: 0.0,
          endOpacity: 1.0,
          duration: Duration(milliseconds: 150),
          curve: MaterialCurves.fadeInEasing,
        );
  }

  /// Material dialog transition.
  ///
  /// Used for dialogs and pop-up content.
  static RouteShifterBuilder materialDialog() {
    return RouteShifterBuilder()
        .fade(
          duration: Duration(milliseconds: 150),
          curve: MaterialCurves.fadeInEasing,
        )
        .scale(
          beginScale: 0.8,
          endScale: 1.0,
          duration: _shortDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        );
  }

  /// Material drawer transition.
  ///
  /// Appropriate for navigation drawers.
  static RouteShifterBuilder materialDrawer() {
    return RouteShifterBuilder().slideFromLeft(
      duration: _mediumDuration,
      curve: MaterialCurves.emphasizedDecelerateEasing,
    );
  }

  /// Material snack bar transition.
  ///
  /// Used for snack bars and temporary notifications.
  static RouteShifterBuilder materialSnackBar() {
    return RouteShifterBuilder()
        .slideFromBottom(
          duration: _shortDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        )
        .fade(
          duration: Duration(milliseconds: 100),
          curve: MaterialCurves.fadeInEasing,
        );
  }

  /// Material search transition.
  ///
  /// Appropriate for search interface expansions.
  static RouteShifterBuilder materialSearch() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
        )
        .scale(
          beginScale: 0.95,
          endScale: 1.0,
          duration: _mediumDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        );
  }

  /// Material hero transition (for shared elements).
  ///
  /// Works with the Shifter widget for hero-like transitions.
  static RouteShifterBuilder materialHero() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.standardEasing,
        )
        .sharedElements(
          flightDuration: _mediumDuration,
          flightCurve: MaterialCurves.emphasizedEasing,
        );
  }

  /// Material staggered list transition.
  ///
  /// Creates a cascading animation effect for list items.
  static RouteShifterBuilder materialStaggeredList() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.fadeInEasing,
        )
        .stagger(
          interval: Duration(milliseconds: 50),
          duration: _longDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        );
  }

  /// Material card transition.
  ///
  /// Appropriate for card-based layouts and expansions.
  static RouteShifterBuilder materialCard() {
    return RouteShifterBuilder()
        .scale(
          beginScale: 0.9,
          endScale: 1.0,
          duration: _mediumDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        )
        .fade(
          duration: Duration(milliseconds: 200),
          curve: MaterialCurves.fadeInEasing,
        );
  }

  /// Material floating action button transition.
  ///
  /// Used for FAB animations and similar floating elements.
  static RouteShifterBuilder materialFab() {
    return RouteShifterBuilder()
        .scale(
          beginScale: 0.0,
          endScale: 1.0,
          duration: _mediumDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        )
        .rotation(
          beginTurns: -0.125, // 45 degrees
          endTurns: 0.0,
          duration: _mediumDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        );
  }

  /// Material page reverse transition (slide to right).
  ///
  /// Used when navigating backwards in the navigation stack.
  static RouteShifterBuilder materialPageReverse() {
    return RouteShifterBuilder().slideFromLeft(
      duration: _mediumDuration,
      curve: MaterialCurves.standardEasing,
    );
  }

  /// Material modal transition.
  ///
  /// Full-screen modal presentations with appropriate scaling.
  static RouteShifterBuilder materialModal() {
    return RouteShifterBuilder()
        .fade(
          duration: _mediumDuration,
          curve: MaterialCurves.fadeInEasing,
        )
        .scale(
          beginScale: 0.95,
          endScale: 1.0,
          duration: _longDuration,
          curve: MaterialCurves.emphasizedDecelerateEasing,
        )
        .interactiveDismiss(
          direction: DismissDirection.vertical,
        );
  }

  /// Gets a preset by name for dynamic usage.
  ///
  /// Useful when the transition type is determined at runtime.
  static RouteShifterBuilder? getPresetByName(String name) {
    switch (name.toLowerCase()) {
      case 'page':
      case 'material_page':
        return materialPageTransition();
      case 'shared_axis_x':
      case 'horizontal':
        return materialSharedAxisX();
      case 'shared_axis_y':
      case 'vertical':
        return materialSharedAxisY();
      case 'shared_axis_z':
      case 'depth':
        return materialSharedAxisZ();
      case 'fade_through':
        return materialFadeThrough();
      case 'container_transform':
        return materialContainerTransform();
      case 'bottom_sheet':
        return materialBottomSheet();
      case 'dialog':
        return materialDialog();
      case 'drawer':
        return materialDrawer();
      case 'search':
        return materialSearch();
      case 'hero':
        return materialHero();
      case 'staggered':
        return materialStaggeredList();
      case 'card':
        return materialCard();
      case 'fab':
        return materialFab();
      case 'modal':
        return materialModal();
      default:
        return null;
    }
  }

  /// Gets all available preset names.
  static List<String> get availablePresets => [
        'page',
        'shared_axis_x',
        'shared_axis_y',
        'shared_axis_z',
        'fade_through',
        'container_transform',
        'bottom_sheet',
        'dialog',
        'drawer',
        'search',
        'hero',
        'staggered',
        'card',
        'fab',
        'modal',
      ];
}
