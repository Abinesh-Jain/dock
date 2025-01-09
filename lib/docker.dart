import 'package:flutter/material.dart';

class Docker extends StatelessWidget {
  Docker({
    super.key,
    this.items = const [],
    required this.builder,
  }) : _items = ValueNotifier(List.from(items));

  final List<Map> items;

  final ValueNotifier<List<Map>> _items;

  final Widget Function(Map) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _items,
      builder: (context, value, child) => Container(
        alignment: Alignment.center,
        height: 48 + (8 * 2),
        // width: (value.length * (48 + 16)) + (4 * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black12,
        ),
        child: ReorderableListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          scrollDirection: Axis.horizontal,
          proxyDecorator: (child, index, animation) => child,
          itemBuilder: (context, index) => ReorderableDragStartListener(
            key: ValueKey(value[index]),
            index: index,
            child: builder(value[index]),
          ),
          itemCount: value.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex == newIndex) return;
            final item = value.removeAt(oldIndex);
            if (newIndex > oldIndex) newIndex--;
            value.insert(newIndex, item);
            _items.value = List.from(value);
          },
        ),
      ),
    );
  }
}
