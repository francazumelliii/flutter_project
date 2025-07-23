import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayAllButton extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final bool isPlaying;

  const PlayAllButton({
    super.key,
    required this.onPlay,
    required this.onPause,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPlaying ? Colors.green : Colors.white24,
      ),
      onPressed: isPlaying ? onPause : onPlay,
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
      label: Text(isPlaying ? 'Pause' : 'Play All', style: const TextStyle(color: Colors.white)),
    );
  }
}
