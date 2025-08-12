import 'package:flutter/material.dart';

/// Manages the registration of [SequencedItem] widgets for timed animations.
class SequencedItemRegistry {
  SequencedItemRegistry._();
  static final SequencedItemRegistry instance = SequencedItemRegistry._();

  final Map<Object, _SequencedItemData> _elements = {};

  void register({
    required Object id,
    required GlobalKey key,
    required BuildContext context,
    required Widget widget,
  }) {
    _elements[id] = _SequencedItemData(
      key: key,
      widget: widget,
    );
  }

  void unregister(Object id, BuildContext context) {
    _elements.remove(id);
  }

  _SequencedItemData? get(Object id) {
    final data = _elements[id];
    if (data == null) return null;

    final renderBox = data.key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.attached) {
      data.rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    }
    return data;
  }
}

class _SequencedItemData {
  final GlobalKey key;
  final Widget widget;
  Rect? rect;

  // The optional 'rect' parameter was removed as it was unused.
  _SequencedItemData({
    required this.key,
    required this.widget,
  });
}
