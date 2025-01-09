import 'package:flutter/material.dart';

/// The `Triangle` class is a Flutter widget that displays a triangle shape using custom painting.
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

  /// The function `paint` draws a triangle on a canvas with a specified color and size.
  ///
  /// Args:
  ///   canvas (Canvas): The `canvas` parameter in the `paint` method represents the area where you will
  /// be drawing your custom graphics or shapes. It provides a drawing surface on which you can use
  /// various methods to create your desired visuals. In Flutter, the `Canvas` class is used for drawing
  /// custom graphics, and you
  ///   size (Size): The `size` parameter represents the size of the canvas on which you are drawing. It
  /// typically includes the width and height of the canvas, which can be used to position and size your
  /// drawings accordingly. In the provided code snippet, the `size` parameter is used to determine the
  /// dimensions of the triangle
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
