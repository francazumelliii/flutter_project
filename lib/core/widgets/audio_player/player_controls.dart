import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        IconButton(onPressed: onPrevious, icon: Icon(Icons.skip_previous, color: Colors.white)),
        IconButton(
          onPressed: onPlayPause,
          icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 48, color: Colors.white),
        ),
        IconButton(onPressed: onNext, icon: Icon(Icons.skip_next, color: Colors.white)),
      ],
    );
  }
}
