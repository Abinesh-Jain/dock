import 'package:flutter/material.dart';

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// [Widget] building the [MaterialApp].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: const [
              {'icon': Icons.person, 'name': 'Person'},
              {'icon': Icons.message, 'name': 'Message'},
              {'icon': Icons.call, 'name': 'Call'},
              {'icon': Icons.camera, 'name': 'Camera'},
              {'icon': Icons.photo, 'name': 'Photo'},
            ],
            builder: (e) {
              final iconData = e['icon'] as IconData;
              final iconName = e['name'] as String;
              return App(
                icon: iconData,
                name: iconName,
              );
            },
          ),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onAcceptWithDetails: (details) {
              setState(() {
                final draggedIndex = _items.indexOf(details.data as T);
                _items.removeAt(draggedIndex);
                _items.insert(index, details.data as T);
              });
            },
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

class App extends StatelessWidget {
  App({
    super.key,
    this.icon,
    this.name,
    double scale = 1,
    this.maxScale = 1.2,
  }) : scale = ValueNotifier(scale);

  final IconData? icon;
  final String? name;
  final ValueNotifier<double> scale;
  final double maxScale;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: const BoxDecoration(color: Colors.transparent),
      verticalOffset: -75,
      richMessage: WidgetSpan(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                '$name',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Triangle(),
          ],
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: scale,
        builder: (context, value, child) => MouseRegion(
          onEnter: (event) => scale.value = maxScale,
          onExit: (event) => scale.value = 1,
          child: AnimatedScale(
            scale: value,
            duration: Durations.short4,
            child: Container(
              constraints: const BoxConstraints(minWidth: 48),
              height: 48,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    Colors.primaries[icon.hashCode % Colors.primaries.length],
              ),
              child: Center(
                child: Icon(icon, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Triangle extends StatelessWidget {
  const Triangle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(10, 10),
      painter: TrianglePainter(),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
