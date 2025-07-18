import 'package:flutter/material.dart';
import 'package:flutter_project/core/utils/dimensions.dart';

class ItemImage extends StatelessWidget {
  final String imageUrl;

  const ItemImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.network(
        imageUrl,
        width: Dimensions.coverImageWidth,
        height: Dimensions.coverImageHeight,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, color: Colors.white),
      ),
    );
  }
}
