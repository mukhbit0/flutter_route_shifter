import 'package:flutter/material.dart';
import '../core/shifter_registry.dart';

/// A widget that marks its child for shared element transitions.
///
/// This widget registers itself with the ShifterRegistry using a unique
/// [shiftId] and enables smooth transitions between pages when the same
/// [shiftId] exists in both the source and destination routes.
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
class Shifter extends StatefulWidget {
  /// Unique identifier for this shared element.
  ///
  /// Elements with the same [shiftId] will be animated between during
  /// route transitions. This can be any object (String, int, enum, etc.)
  /// but must implement proper equality comparison.
  final Object shiftId;

  /// The child widget to be shared between routes.
  final Widget child;

  /// Optional metadata for the shared element.
  ///
  /// This can be used to store additional information about the element
  /// that might be needed during the transition animation.
  final Map<String, dynamic> metadata;

  /// Whether this element should participate in shared element transitions.
  ///
  /// When false, this widget behaves like a normal container and won't
  /// register itself for transitions.
  final bool enabled;

  /// Custom key for this widget.
  ///
  /// If not provided, a unique key will be generated automatically.
  final Key? customKey;

  /// Creates a shared element widget.
  const Shifter({
    Key? key,
    required this.shiftId,
    required this.child,
    this.metadata = const {},
    this.enabled = true,
    this.customKey,
  }) : super(key: key);

  @override
  State<Shifter> createState() => _ShifterState();
}

class _ShifterState extends State<Shifter> with TickerProviderStateMixin {
  /// Global key for tracking this widget's position and size.
  late final GlobalKey _globalKey;

  /// Whether this element is currently registered.
  bool _isRegistered = false;

  /// Whether this element is currently active in a transition.
  bool _isActive = false;

  @override
  void initState() {
    super.initState();

    // Create a unique global key for this element
    _globalKey = widget.customKey != null && widget.customKey is GlobalKey
        ? widget.customKey as GlobalKey
        : GlobalKey(debugLabel: 'Shifter-${widget.shiftId}');

    // Register with the registry if enabled
    if (widget.enabled) {
      _registerElement();
    }
  }

  @override
  void didUpdateWidget(Shifter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle shiftId changes
    if (oldWidget.shiftId != widget.shiftId) {
      _unregisterElement(oldWidget.shiftId);
      if (widget.enabled) {
        _registerElement();
      }
    }

    // Handle enabled state changes
    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _registerElement();
      } else {
        _unregisterElement(widget.shiftId);
      }
    }

    // Update element data if already registered
    if (_isRegistered && widget.enabled) {
      _updateElementData();
    }
  }

  @override
  void dispose() {
    if (_isRegistered) {
      _unregisterElement(widget.shiftId);
    }
    super.dispose();
  }

  /// Registers this element with the ShifterRegistry.
  void _registerElement() {
    if (_isRegistered || !widget.enabled) return;

    try {
      ShifterRegistry.instance.registerElement(
        shiftId: widget.shiftId,
        key: _globalKey,
        context: context,
        child: widget.child,
      );
      _isRegistered = true;

      // Schedule an update after the frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isRegistered) {
          _updateElementData();
        }
      });
    } catch (e) {
      debugPrint('Failed to register shared element ${widget.shiftId}: $e');
    }
  }

  /// Unregisters this element from the ShifterRegistry.
  void _unregisterElement(Object shiftId) {
    if (!_isRegistered) return;

    try {
      ShifterRegistry.instance.unregisterElement(shiftId);
      _isRegistered = false;
      _isActive = false;
    } catch (e) {
      debugPrint('Failed to unregister shared element $shiftId: $e');
    }
  }

  /// Updates the element data in the registry.
  void _updateElementData() {
    if (!_isRegistered || !mounted) return;

    // The registry will handle the position calculation
    // This is just a notification that the element might have changed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _isRegistered) {
        try {
          ShifterRegistry.instance.registerElement(
            shiftId: widget.shiftId,
            key: _globalKey,
            context: context,
            child: widget.child,
          );
        } catch (e) {
          debugPrint('Failed to update element data for ${widget.shiftId}: $e');
        }
      }
    });
  }

  /// Activates this element for transition.
  @override
  void activate() {
    super.activate();

    if (!_isRegistered) return;

    _isActive = true;
    ShifterRegistry.instance.activateElement(widget.shiftId);

    if (mounted) {
      setState(() {});
    }
  }

  /// Deactivates this element after transition.
  @override
  void deactivate() {
    if (!_isRegistered) return;

    _isActive = false;
    ShifterRegistry.instance.deactivateElement(widget.shiftId);

    if (mounted) {
      setState(() {});
    }

    super.deactivate();
  }

  /// Gets the current rect of this element.
  Rect? getCurrentRect() {
    try {
      final renderBox =
          _globalKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) return null;

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      return Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    } catch (e) {
      debugPrint('Failed to get current rect for ${widget.shiftId}: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    // Wrap with the tracking key if enabled
    if (widget.enabled) {
      child = SizedBox(
        key: _globalKey,
        child: child,
      );

      // Hide the element during active transitions
      if (_isActive) {
        child = Opacity(
          opacity: 0.0,
          child: child,
        );
      }
    }

    // Add debug information in debug mode
    assert(() {
      if (widget.enabled && _isRegistered) {
        child = _DebugShifterWrapper(
          shiftId: widget.shiftId,
          isActive: _isActive,
          child: child,
        );
      }
      return true;
    }());

    return child;
  }

  /// Gets the current shift ID.
  Object get shiftId => widget.shiftId;

  /// Gets whether this element is currently registered.
  bool get isRegistered => _isRegistered;

  /// Gets whether this element is currently active.
  bool get isActive => _isActive;

  /// Gets the global key for this element.
  GlobalKey get globalKey => _globalKey;
}

/// Debug wrapper that shows information about shared elements in debug mode.
class _DebugShifterWrapper extends StatelessWidget {
  final Object shiftId;
  final bool isActive;
  final Widget child;

  const _DebugShifterWrapper({
    required this.shiftId,
    required this.isActive,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (isActive)
          Positioned(
            top: -20,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                'SHIFTING: $shiftId',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Extension methods for the Shifter widget.
extension ShifterExtensions on Shifter {
  /// Creates a Shifter with a string-based shiftId.
  static Shifter string({
    Key? key,
    required String shiftId,
    required Widget child,
    Map<String, dynamic> metadata = const {},
    bool enabled = true,
  }) {
    return Shifter(
      key: key,
      shiftId: shiftId,
      child: child,
      metadata: metadata,
      enabled: enabled,
    );
  }

  /// Creates a Shifter with an enum-based shiftId.
  static Shifter enumId<T extends Enum>({
    Key? key,
    required T shiftId,
    required Widget child,
    Map<String, dynamic> metadata = const {},
    bool enabled = true,
  }) {
    return Shifter(
      key: key,
      shiftId: shiftId,
      child: child,
      metadata: metadata,
      enabled: enabled,
    );
  }
}

/// Utility functions for working with Shifter widgets.
class ShifterUtils {
  ShifterUtils._();

  /// Finds all Shifter widgets in a widget tree.
  static List<Shifter> findShiftersInTree(BuildContext context) {
    final shifters = <Shifter>[];

    void visitor(Element element) {
      if (element.widget is Shifter) {
        shifters.add(element.widget as Shifter);
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    return shifters;
  }

  /// Gets the Shifter widget with the given shiftId if it exists in the tree.
  static Shifter? findShifterById(BuildContext context, Object shiftId) {
    Shifter? found;

    void visitor(Element element) {
      if (found != null) return;

      if (element.widget is Shifter) {
        final shifter = element.widget as Shifter;
        if (shifter.shiftId == shiftId) {
          found = shifter;
          return;
        }
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    return found;
  }
}
