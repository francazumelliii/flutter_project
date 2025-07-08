import 'package:flutter/material.dart';
import 'package:flutter_project/core/widgets/buttons/play_button.dart';

class CollectionHeader extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String subtitle;
  final VoidCallback onPlayCollection;

  const CollectionHeader({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.subtitle,
    required this.onPlayCollection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              coverUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
              progress == null ? child : const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                PlayButton(onPressed: onPlayCollection),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
