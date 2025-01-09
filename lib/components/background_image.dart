import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override

  ///  A `LayoutBuilder` widget is being returned, which contains an `Image.network` widget. The
  /// `Image.network` widget loads an image from the URL 'https://picsum.photos/' with dimensions based
  /// on the maximum width and height constraints provided by the `LayoutBuilder`. If there is an error
  /// loading the image, a `SizedBox` widget is returned.
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Image.network(
        'https://picsum.photos/${constraints.maxWidth.toInt()}/${constraints.maxHeight.toInt()}',
        errorBuilder: (context, error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
