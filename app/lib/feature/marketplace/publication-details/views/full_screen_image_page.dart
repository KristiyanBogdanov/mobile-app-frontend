import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final ImageProvider imageProvider;

  const FullScreenImagePage({
    required this.imageProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        imageProvider: imageProvider,
      ),
    );
  }
}
