import 'package:flutter/material.dart';
import 'dart:collection';

/// A singleton registry that manages shared elements across route transitions.
///
/// This registry tracks the position, size, and widget data for shared elements
/// identified by their shiftId. It enables smooth transitions between pages
/// by coordinating the animation of common elements.
///
/// The registry automatically cleans up stale references and provides methods
/// for managing the lifecycle of shared elements.
class ShifterRegistry {
  /// Singleton instance of the registry.
  static final ShifterRegistry instance = ShifterRegistry._internal();

  /// Private constructor for singleton pattern.
  ShifterRegistry._internal();

  /// Maps shiftIds to their element data.
  final Map<Object, ShifterElementData> _elements = {};

  /// Maps shiftIds to their global keys for position tracking.
  final Map<Object, GlobalKey> _keys = {};

  /// Tracks which elements are currently active in transitions.
  final Set<Object> _activeElements = <Object>{};

  /// Weak references to contexts for cleanup.
  final Map<Object, BuildContext> _contexts = {};

  /// Registers a shared element with the registry.
  ///
  /// [shiftId] unique identifier for the shared element.
  /// [key] GlobalKey for tracking the widget's position.
  /// [context] BuildContext of the widget.
  /// [child] the widget to be shared.
  void registerElement({
    required Object shiftId,
    required GlobalKey key,
    required BuildContext context,
    required Widget child,
  }) {
    _keys[shiftId] = key;
    _contexts[shiftId] = context;

    // Calculate the current position and size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateElementData(shiftId, child);
    });
  }

  /// Unregisters a shared element from the registry.
  ///
  /// [shiftId] the identifier of the element to remove.
  void unregisterElement(Object shiftId) {
    _elements.remove(shiftId);
    _keys.remove(shiftId);
    _contexts.remove(shiftId);
    _activeElements.remove(shiftId);
  }

  /// Updates the data for a registered element.
  void _updateElementData(Object shiftId, Widget child) {
    final key = _keys[shiftId];
    final context = _contexts[shiftId];

    if (key?.currentContext == null || context == null) return;

    try {
      final renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) return;

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final rect =
          Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

      // Find matching elements for target rect calculation
      Rect? targetRect;
      final matchingElements =
          _findMatchingElementsInOtherContexts(shiftId, context);
      if (matchingElements.isNotEmpty) {
        // Use the first matching element as the target
        final targetElement = matchingElements.first;
        final targetKey = _keys[targetElement];
        if (targetKey?.currentContext != null) {
          final targetRenderBox =
              targetKey!.currentContext!.findRenderObject() as RenderBox?;
          if (targetRenderBox != null && targetRenderBox.attached) {
            final targetSize = targetRenderBox.size;
            final targetPosition = targetRenderBox.localToGlobal(Offset.zero);
            targetRect = Rect.fromLTWH(targetPosition.dx, targetPosition.dy,
                targetSize.width, targetSize.height);
          }
        }
      }

      _elements[shiftId] = ShifterElementData(
        shiftId: shiftId,
        child: child,
        sourceRect: rect,
        targetRect: targetRect,
        key: key,
        metadata: _getElementMetadata(shiftId),
      );

      // Set the context on the element data
      _elements[shiftId]?.setContext(_contexts[shiftId]!);
    } catch (e) {
      // Handle cases where the render object is not available
      debugPrint('Failed to update element data for $shiftId: $e');
    }
  }

  /// Finds matching elements in other contexts for transition pairing.
  List<Object> _findMatchingElementsInOtherContexts(
      Object shiftId, BuildContext currentContext) {
    final matches = <Object>[];

    for (final entry in _contexts.entries) {
      final otherShiftId = entry.key;
      final otherContext = entry.value;

      // Skip self and check if shiftIds match
      if (otherShiftId == shiftId && otherContext != currentContext) {
        matches.add(otherShiftId);
      }
    }

    return matches;
  }

  /// Gets metadata for an element.
  Map<String, dynamic> _getElementMetadata(Object shiftId) {
    // This could be extended to store additional information about elements
    return {
      'shiftId': shiftId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'registered': true,
    };
  }

  /// Gets the data for a specific shared element.
  ///
  /// Returns null if the element is not found or not ready.
  ShifterElementData? getElementData(Object shiftId) {
    return _elements[shiftId];
  }

  /// Gets all currently active shared elements.
  ///
  /// Returns a map of shiftId to element data for all active elements.
  Map<Object, ShifterElementData> getActiveElements() {
    final activeMap = <Object, ShifterElementData>{};

    for (final shiftId in _activeElements) {
      final data = _elements[shiftId];
      if (data != null) {
        activeMap[shiftId] = data;
      }
    }

    return activeMap;
  }

  /// Marks an element as active for transition.
  ///
  /// [shiftId] the identifier of the element to activate.
  void activateElement(Object shiftId) {
    _activeElements.add(shiftId);
  }

  /// Marks an element as inactive after transition.
  ///
  /// [shiftId] the identifier of the element to deactivate.
  void deactivateElement(Object shiftId) {
    _activeElements.remove(shiftId);
  }

  /// Checks if an element is currently in a transition.
  ///
  /// [shiftId] the identifier of the element to check.
  /// Returns true if the element is currently being animated.
  bool isElementInTransition(Object shiftId) {
    return _activeElements.contains(shiftId);
  }

  /// Finds matching shared elements between source and target contexts.
  ///
  /// This method is used during route transitions to identify which elements
  /// should be animated between pages.
  List<Object> findMatchingElements(
      BuildContext sourceContext, BuildContext targetContext) {
    final matches = <Object>[];

    // Find elements that exist in both contexts
    for (final shiftId in _elements.keys) {
      final context = _contexts[shiftId];
      if (context != null) {
        // Check if this element is relevant to the transition
        final isInSource = _isContextAncestor(sourceContext, context);
        final isInTarget = _isContextAncestor(targetContext, context);

        if (isInSource || isInTarget) {
          matches.add(shiftId);
        }
      }
    }

    return matches;
  }

  /// Checks if one context is an ancestor of another.
  bool _isContextAncestor(BuildContext ancestor, BuildContext descendant) {
    BuildContext? current = descendant;

    while (current != null) {
      if (identical(current, ancestor)) {
        return true;
      }
      // Use visitAncestorElements to safely traverse the tree
      BuildContext? parent;
      current.visitAncestorElements((element) {
        parent = element;
        return false; // Stop after finding the immediate parent
      });
      current = parent;
    }

    return false;
  }

  /// Updates the target rect for a shared element during transition.
  ///
  /// This is called when the target position is calculated.
  void setTargetRect(Object shiftId, Rect targetRect) {
    final data = _elements[shiftId];
    if (data != null) {
      _elements[shiftId] = data.copyWith(targetRect: targetRect);
    }
  }

  /// Performs cleanup of stale references.
  ///
  /// Should be called periodically to prevent memory leaks.
  void cleanup() {
    final staleIds = <Object>[];

    for (final entry in _contexts.entries) {
      final context = entry.value;
      if (!context.mounted) {
        staleIds.add(entry.key);
      }
    }

    for (final id in staleIds) {
      unregisterElement(id);
    }
  }

  /// Gets the current number of registered elements.
  int get elementCount => _elements.length;

  /// Gets the current number of active elements.
  int get activeElementCount => _activeElements.length;

  /// Clears all registered elements.
  ///
  /// Useful for testing or when resetting the application state.
  void clear() {
    _elements.clear();
    _keys.clear();
    _contexts.clear();
    _activeElements.clear();
  }

  /// Gets all registered element IDs.
  UnmodifiableSetView<Object> get registeredIds =>
      UnmodifiableSetView(_elements.keys.toSet());

  /// Gets all active element IDs.
  UnmodifiableSetView<Object> get activeIds =>
      UnmodifiableSetView(_activeElements);

  @override
  String toString() {
    return 'ShifterRegistry(elements: $elementCount, active: $activeElementCount)';
  }
}

/// Data class that holds information about a shared element.
///
/// This class contains all the necessary information for animating a shared
/// element between different positions during route transitions.
class ShifterElementData {
  /// Unique identifier for this shared element.
  final Object shiftId;

  /// The widget that will be animated.
  final Widget child;

  /// The source rectangle (starting position/size).
  final Rect sourceRect;

  /// The target rectangle (ending position/size).
  /// If null, the element will animate from source to source (no movement).
  final Rect? targetRect;

  /// GlobalKey for tracking the widget's render object.
  final GlobalKey key;

  /// Additional metadata for the element.
  final Map<String, dynamic> metadata;

  /// Timestamp when this data was created.
  final DateTime createdAt;

  /// Creates a new shared element data instance.
  ShifterElementData({
    required this.shiftId,
    required this.child,
    required this.sourceRect,
    this.targetRect,
    required this.key,
    this.metadata = const {},
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Creates a copy of this element data with modified fields.
  ShifterElementData copyWith({
    Object? shiftId,
    Widget? child,
    Rect? sourceRect,
    Rect? targetRect,
    GlobalKey? key,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
  }) {
    return ShifterElementData(
      shiftId: shiftId ?? this.shiftId,
      child: child ?? this.child,
      sourceRect: sourceRect ?? this.sourceRect,
      targetRect: targetRect ?? this.targetRect,
      key: key ?? this.key,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Gets the effective target rectangle.
  ///
  /// Returns [targetRect] if available, otherwise returns [sourceRect].
  Rect get effectiveTargetRect => targetRect ?? sourceRect;

  /// Gets the distance between source and target rectangles.
  double get animationDistance {
    final target = effectiveTargetRect;
    final sourceCenter = sourceRect.center;
    final targetCenter = target.center;

    return (targetCenter - sourceCenter).distance;
  }

  /// Gets the scale factor between source and target rectangles.
  double get scaleRatio {
    final target = effectiveTargetRect;
    if (sourceRect.isEmpty || target.isEmpty) return 1.0;

    final sourceArea = sourceRect.width * sourceRect.height;
    final targetArea = target.width * target.height;

    return (targetArea / sourceArea).clamp(0.1, 10.0);
  }

  /// Checks if this element needs position animation.
  bool get needsPositionAnimation {
    if (targetRect == null) return false;

    const threshold = 1.0; // pixels
    return (sourceRect.center - targetRect!.center).distance > threshold;
  }

  /// Checks if this element needs size animation.
  bool get needsSizeAnimation {
    if (targetRect == null) return false;

    const threshold = 1.0; // pixels
    final sourceSize = sourceRect.size;
    final targetSize = targetRect!.size;
    return (sourceSize.width - targetSize.width).abs() > threshold ||
        (sourceSize.height - targetSize.height).abs() > threshold;
  }

  /// Gets metadata value by key with type casting.
  T? getMetadata<T>(String key) {
    final value = metadata[key];
    return value is T ? value : null;
  }

  /// Sets a metadata value and returns a new instance.
  ShifterElementData setMetadata(String key, dynamic value) {
    final newMetadata = Map<String, dynamic>.from(metadata);
    newMetadata[key] = value;
    return copyWith(metadata: newMetadata);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShifterElementData &&
          runtimeType == other.runtimeType &&
          shiftId == other.shiftId &&
          sourceRect == other.sourceRect &&
          targetRect == other.targetRect &&
          key == other.key;

  @override
  int get hashCode => Object.hash(shiftId, sourceRect, targetRect, key);

  @override
  String toString() {
    return 'ShifterElementData('
        'shiftId: $shiftId, '
        'source: $sourceRect, '
        'target: $targetRect, '
        'needsAnimation: ${needsPositionAnimation || needsSizeAnimation}'
        ')';
  }

  /// Gets the current rect (uses sourceRect as the primary rect)
  Rect get rect => sourceRect;

  /// Gets the context if available
  BuildContext? get context => _context;
  BuildContext? _context;

  /// Sets the context for this element
  void setContext(BuildContext context) {
    _context = context;
  }
}

// Add extension methods to ShifterRegistry for TransitionCoordinator
extension ShifterRegistryCoordination on ShifterRegistry {
  /// Gets all elements in a specific context
  List<ShifterElementData> getAllElementsInContext(BuildContext context) {
    final result = <ShifterElementData>[];

    for (final element in _elements.values) {
      if (element.context == context) {
        result.add(element);
      }
    }

    return result;
  }

  /// Gets the total number of registered elements
  int get elementCount => _elements.length;

  /// Cleans up stale references
  void cleanupStaleReferences() {
    final keysToRemove = <Object>[];

    for (final entry in _contexts.entries) {
      final context = entry.value;
      // Check if context is still mounted
      try {
        if (!context.mounted) {
          keysToRemove.add(entry.key);
        }
      } catch (e) {
        // Context is invalid, remove it
        keysToRemove.add(entry.key);
      }
    }

    for (final key in keysToRemove) {
      _elements.remove(key);
      _keys.remove(key);
      _contexts.remove(key);
      _activeElements.remove(key);
    }
  }
}
