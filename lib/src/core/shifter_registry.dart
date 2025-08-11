import 'package:flutter/material.dart';
import 'dart:collection';

/// A simplified, robust registry for shared element transitions.
///
/// This registry uses a simple ID-based approach where elements with the same ID
/// automatically pair with each other across different pages. No complex context
/// matching or bidirectional logic - just straightforward element pairing.
class ShifterRegistry {
  /// Singleton instance of the registry.
  static final ShifterRegistry instance = ShifterRegistry._internal();

  /// Private constructor for singleton pattern.
  ShifterRegistry._internal();

  /// Maps shiftIds to lists of element instances (allowing multiple elements with same ID)
  final Map<Object, List<SimpleShifterElement>> _elementsByID = {};

  /// Tracks which elements are currently active in transitions.
  final Set<Object> _activeElements = <Object>{};

  /// Registers a shared element with the registry.
  void registerElement({
    required Object shiftId,
    required GlobalKey key,
    required BuildContext context,
    required Widget child,
  }) {
    // Create new element instance
    final element = SimpleShifterElement(
      shiftId: shiftId,
      key: key,
      context: context,
      child: child,
    );

    // Add to list of elements with this ID
    _elementsByID.putIfAbsent(shiftId, () => []).add(element);

    // Update position after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateElementPosition(element);
      _checkForPairs(shiftId);
    });
  }

  /// Unregisters a shared element from the registry.
  void unregisterElement(Object shiftId, BuildContext context) {
    final elements = _elementsByID[shiftId];
    if (elements != null) {
      // Remove the element with matching context
      elements.removeWhere((element) => element.context == context);

      // Clean up empty lists
      if (elements.isEmpty) {
        _elementsByID.remove(shiftId);
      }

      _activeElements.remove(shiftId);
    }
  }

  /// Updates the position of an element
  void _updateElementPosition(SimpleShifterElement element) {
    try {
      final renderBox =
          element.key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) {
        return;
      }

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final rect =
          Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

      element.rect = rect;
    } catch (e) {}
  }

  /// Checks for pairs and creates element data when both source and target are ready
  void _checkForPairs(Object shiftId) {
    final elements = _elementsByID[shiftId];
    if (elements == null || elements.length < 2) {
      return;
    }

    // Find elements that are ready (have valid rects)
    final readyElements =
        elements.where((e) => e.rect != null && e.context.mounted).toList();

    if (readyElements.length >= 2) {
      // Activate this shiftId for transitions
      _activeElements.add(shiftId);

      // Update each element with its pair info
      for (int i = 0; i < readyElements.length; i++) {
        final current = readyElements[i];
        // Find the "other" element (simple approach: use the next one, or first if we're at the end)
        final partner = readyElements[(i + 1) % readyElements.length];

        current.partnerRect = partner.rect;
      }
    } else {}
  }

  /// Gets element data for a specific shiftId
  ShifterElementData? getElementData(Object shiftId) {
    final elements = _elementsByID[shiftId];
    if (elements == null || elements.isEmpty) {
      return null;
    }

    // Find the first element that has both source and target rects
    for (final element in elements) {
      if (element.rect != null && element.partnerRect != null) {
        return ShifterElementData(
          shiftId: shiftId,
          child: element.child,
          sourceRect: element.rect!,
          targetRect: element.partnerRect,
          key: element.key,
          metadata: {},
        );
      }
    }

    // If no complete pair, return element with just source rect
    final firstReady = elements.firstWhere(
      (e) => e.rect != null,
      orElse: () => elements.first,
    );

    if (firstReady.rect != null) {
      return ShifterElementData(
        shiftId: shiftId,
        child: firstReady.child,
        sourceRect: firstReady.rect!,
        targetRect: null,
        key: firstReady.key,
        metadata: {},
      );
    }

    return null;
  }

  /// Gets all currently active shared elements
  Map<Object, ShifterElementData> getActiveElements() {
    final activeMap = <Object, ShifterElementData>{};

    for (final shiftId in _activeElements) {
      final data = getElementData(shiftId);
      if (data != null) {
        activeMap[shiftId] = data;
      } else {}
    }

    return activeMap;
  }

  /// Gets all registered elements
  Map<Object, ShifterElementData> getAllElements() {
    final allMap = <Object, ShifterElementData>{};

    for (final shiftId in _elementsByID.keys) {
      final data = getElementData(shiftId);
      if (data != null) {
        allMap[shiftId] = data;
      }
    }

    return allMap;
  }

  /// Marks an element as active for transition
  void activateElement(Object shiftId) {
    _activeElements.add(shiftId);
  }

  /// Marks an element as inactive after transition
  void deactivateElement(Object shiftId) {
    _activeElements.remove(shiftId);
  }

  /// Checks if an element is currently in a transition
  bool isElementInTransition(Object shiftId) {
    return _activeElements.contains(shiftId);
  }

  /// Performs cleanup of stale references
  void cleanup() {
    final staleIds = <Object>[];

    for (final entry in _elementsByID.entries) {
      final shiftId = entry.key;
      final elements = entry.value;

      // Remove elements with unmounted contexts
      elements.removeWhere((element) => !element.context.mounted);

      // Mark empty lists for removal
      if (elements.isEmpty) {
        staleIds.add(shiftId);
      }
    }

    // Remove empty lists
    for (final id in staleIds) {
      _elementsByID.remove(id);
      _activeElements.remove(id);
    }
  }

  /// Clears all registered elements
  void clear() {
    _elementsByID.clear();
    _activeElements.clear();
  }

  /// Gets the current number of registered elements
  int get elementCount {
    return _elementsByID.values.fold(0, (sum, list) => sum + list.length);
  }

  /// Gets the current number of active elements
  int get activeElementCount => _activeElements.length;

  /// Gets all registered element IDs
  UnmodifiableSetView<Object> get registeredIds =>
      UnmodifiableSetView(_elementsByID.keys.toSet());

  /// Gets all active element IDs
  UnmodifiableSetView<Object> get activeIds =>
      UnmodifiableSetView(_activeElements);

  /// Updates the position of an element in the registry (compatibility method)
  void updateElementPosition(Object shiftId, Rect rect, BuildContext context) {
    // Find the element with matching shiftId and context
    final elements = _elementsByID[shiftId];
    if (elements != null) {
      for (final element in elements) {
        if (element.context == context) {
          element.rect = rect;
          _checkForPairs(shiftId);
          break;
        }
      }
    }
  }

  /// Gets all elements in a specific context (compatibility method)
  List<ShifterElementData> getAllElementsInContext(BuildContext context) {
    final result = <ShifterElementData>[];

    for (final elements in _elementsByID.values) {
      for (final element in elements) {
        if (element.context == context && element.rect != null) {
          final data = ShifterElementData(
            shiftId: element.shiftId,
            child: element.child,
            sourceRect: element.rect!,
            targetRect: element.partnerRect,
            key: element.key,
            metadata: {},
          );
          data.setContext(context);
          result.add(data);
        }
      }
    }

    return result;
  }

  /// Cleans up stale references (compatibility method)
  void cleanupStaleReferences() {
    cleanup();
  }

  @override
  String toString() {
    return 'ShifterRegistry(elements: $elementCount, active: $activeElementCount, pairs: ${_elementsByID.length})';
  }
}

/// Simple element wrapper that holds basic information
class SimpleShifterElement {
  final Object shiftId;
  final GlobalKey key;
  final BuildContext context;
  final Widget child;

  Rect? rect;
  Rect? partnerRect;

  SimpleShifterElement({
    required this.shiftId,
    required this.key,
    required this.context,
    required this.child,
  });
}

/// Data class that holds information about a shared element.
class ShifterElementData {
  final Object shiftId;
  final Widget child;
  final Rect sourceRect;
  final Rect? targetRect;
  final GlobalKey key;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;

  ShifterElementData({
    required this.shiftId,
    required this.child,
    required this.sourceRect,
    this.targetRect,
    required this.key,
    this.metadata = const {},
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

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

  Rect get effectiveTargetRect => targetRect ?? sourceRect;

  double get animationDistance {
    final target = effectiveTargetRect;
    final sourceCenter = sourceRect.center;
    final targetCenter = target.center;
    return (targetCenter - sourceCenter).distance;
  }

  double get scaleRatio {
    final target = effectiveTargetRect;
    if (sourceRect.isEmpty || target.isEmpty) return 1.0;
    final sourceArea = sourceRect.width * sourceRect.height;
    final targetArea = target.width * target.height;
    return (targetArea / sourceArea).clamp(0.1, 10.0);
  }

  bool get needsPositionAnimation {
    if (targetRect == null) return false;
    const threshold = 1.0;
    return (sourceRect.center - targetRect!.center).distance > threshold;
  }

  bool get needsSizeAnimation {
    if (targetRect == null) return false;
    const threshold = 1.0;
    final sourceSize = sourceRect.size;
    final targetSize = targetRect!.size;
    return (sourceSize.width - targetSize.width).abs() > threshold ||
        (sourceSize.height - targetSize.height).abs() > threshold;
  }

  T? getMetadata<T>(String key) {
    final value = metadata[key];
    return value is T ? value : null;
  }

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

  Rect get rect => sourceRect;
  BuildContext? get context => _context;
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }
}
