import 'package:flutter/material.dart';

class AlbumCover extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;
  final double size;

  const AlbumCover({
    super.key,
    required this.imageUrl,
    required this.onTap,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      // placeholder
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          color: Colors.grey,
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey,
            child: const Icon(Icons.broken_image, color: Colors.white),
          );
        },
      ),
    );
  }
}
