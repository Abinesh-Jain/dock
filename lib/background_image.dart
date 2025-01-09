import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Image.network(
        'https://picsum.photos/${constraints.maxWidth.toInt()}/${constraints.maxHeight.toInt()}',
        errorBuilder: (context, error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
