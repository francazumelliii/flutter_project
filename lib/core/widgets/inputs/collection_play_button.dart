import 'package:flutter/material.dart';

class CollectionPlayButton extends StatelessWidget {
  final VoidCallback onPlay;

  const CollectionPlayButton({super.key, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPlay,
      icon: const Icon(Icons.play_arrow),
      label: const Text('Play'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
