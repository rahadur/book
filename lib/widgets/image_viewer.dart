import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(imageUrl),
      placeholder: const AssetImage("assets/images/placeholder.png"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/placeholder.png',
            fit: BoxFit.fitWidth);
      },
      fit: BoxFit.fitWidth,
    );
  }
}
