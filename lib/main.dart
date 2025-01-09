import 'package:dock/background_image.dart';
import 'package:dock/dock.dart';
import 'package:dock/docker.dart';
import 'package:dock/triangle.dart';
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
        body: Stack(
          children: [
            const BackgroundImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Dock(
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
                  Docker(
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
                ],
              ),
            ),
          ],
        ),
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
