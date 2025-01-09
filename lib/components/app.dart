import 'package:dock/components/triangle.dart';
import 'package:flutter/material.dart';

/// The `App` class in Dart represents a widget with an icon and name that can be scaled and displayed
/// with a tooltip.
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
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    Colors.primaries[icon.hashCode % Colors.primaries.length],
              ),
              child: SizedBox.square(
                dimension: 48,
                child: Center(
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
