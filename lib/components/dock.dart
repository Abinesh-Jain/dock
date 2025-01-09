import 'package:flutter/material.dart';

/// Dock of the reorderable [items].
class Dock<T> extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });

  /// Initial [T] items to put in this [Dock].
  final List<T> items;

  /// Builder building the provided [T] item.
  final Widget Function(T) builder;

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

/// State of the [Dock] used to manipulate the [_items].
class _DockState<T> extends State<Dock<T>> {
  /// [T] items being manipulated.
  late final List<T> _items = widget.items.toList();

  /// This function updates the state by removing an item from a list at a specific index and inserting
  /// it at another index based on drag and drop details.
  ///
  /// Args:
  ///   details (DragTargetDetails): The `details` parameter in the `_onAcceptWithDetails` function is of
  /// type `DragTargetDetails`. This parameter contains information about the drag operation, such as the
  /// data being dragged and the position where it was dropped.
  ///   index (int): The `index` parameter in the `_onAcceptWithDetails` function represents the position
  /// where the dragged item should be inserted in the list of items.
  void _onAcceptWithDetails(DragTargetDetails details, int index) {
    setState(() {
      final draggedIndex = _items.indexOf(details.data);
      _items.removeAt(draggedIndex);
      _items.insert(index, details.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          return DragTarget(
            onAcceptWithDetails: (details) =>
                _onAcceptWithDetails(details, index),
            builder: (context, candidateData, rejectedData) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Draggable<Object>(
                  key: ValueKey(item),
                  data: item,
                  feedback: Opacity(
                    opacity: 0.75,
                    child: AnimatedScale(
                      scale: 1.2,
                      duration: Durations.medium4,
                      child: widget.builder(item),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: widget.builder(item),
                  ),
                  child: widget.builder(item),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
