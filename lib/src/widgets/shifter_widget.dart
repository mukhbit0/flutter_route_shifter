import 'package:flutter/material.dart';

/// A widget that marks its child for shared element "hero" transitions.
///
/// This widget is a wrapper around Flutter's built-in [Hero] widget,
/// using the [shiftId] as the required [tag] to link animations
/// between two different routes.
///
/// Example:
/// ```dart
/// // In source page
/// Shifter(
///   shiftId: 'hero-image',
///   child: Image.asset('assets/image.png'),
/// )
///
/// // In destination page
/// Shifter(
///   shiftId: 'hero-image', // Same ID for shared element
///   child: Image.asset('assets/image.png'),
/// )
/// ```
class Shifter extends StatelessWidget {
  /// Unique identifier for this shared element.
  ///
  /// Elements with the same [shiftId] will be animated between during
  /// route transitions. This acts as the Hero tag and can be any object 
  /// (String, int, enum, etc.) but must implement proper equality comparison.
  final Object shiftId;

  /// The child widget to be shared between routes.
  final Widget child;

  /// Creates a shared element widget.
  ///
  /// The [shiftId] must be unique within the route and the same [shiftId]
  /// must exist in both the source and destination routes for the animation
  /// to work properly.
  const Shifter({
    super.key,
    required this.shiftId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: shiftId,
      child: child,
    );
  }
}

/// Extension methods for creating Shifter widgets with specific ID types.
extension ShifterExtensions on Shifter {
  /// Creates a Shifter with a string-based shiftId.
  static Shifter string({
    Key? key,
    required String shiftId,
    required Widget child,
  }) {
    return Shifter(
      key: key,
      shiftId: shiftId,
      child: child,
    );
  }

  /// Creates a Shifter with an enum-based shiftId.
  static Shifter enumId<T extends Enum>({
    Key? key,
    required T shiftId,
    required Widget child,
  }) {
    return Shifter(
      key: key,
      shiftId: shiftId,
      child: child,
    );
  }

  /// Creates a Shifter with an integer-based shiftId.
  static Shifter integer({
    Key? key,
    required int shiftId,
    required Widget child,
  }) {
    return Shifter(
      key: key,
      shiftId: shiftId,
      child: child,
    );
  }
}
