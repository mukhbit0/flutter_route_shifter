import 'package:flutter/material.dart';
import '../core/sequenced_item_registry.dart';
import '../effects/advanced/sequenced_effect.dart';

/// A widget that marks its child for a manually timed animation.
///
/// It registers itself with the [SequencedItemRegistry] using a unique [id].
/// The [SequencedEffect] then uses this ID to apply a specific animation delay.
class SequencedItem extends StatefulWidget {
  /// The unique identifier for this item.
  final Object id;

  /// The widget to be animated.
  final Widget child;

  const SequencedItem({
    super.key,
    required this.id,
    required this.child,
  });

  @override
  State<SequencedItem> createState() => _SequencedItemState();
}

class _SequencedItemState extends State<SequencedItem> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _register();
      }
    });
  }

  @override
  void dispose() {
    SequencedItemRegistry.instance.unregister(widget.id, context);
    super.dispose();
  }

  void _register() {
    SequencedItemRegistry.instance.register(
      id: widget.id,
      key: _key,
      context: context,
      widget: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = SequencedAnimationProvider.of(context);

    // If we're animating and this item is being animated, hide it
    final shouldHide = provider?.isAnimating == true &&
        provider!.animatingIds.contains(widget.id);

    return KeyedSubtree(
      key: _key,
      child: shouldHide
          ? Opacity(opacity: 0.0, child: widget.child)
          : widget.child,
    );
  }
}
