import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowPlayButton extends StatelessWidget {
  const RowPlayButton({super.key, required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      color: Colors.white,
      onPressed: onTap,
    );
  }
}