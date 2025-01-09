import 'package:dock/components/app.dart';
import 'package:dock/components/background_image.dart';
import 'package:dock/components/dock.dart';
import 'package:dock/components/docker.dart';
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
