import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class PlayIconButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const PlayIconButton({
    Key? key,
    required this.isPlaying,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
        color: Colors.greenAccent,
        size: Dimensions.iconSizeLarge,
      ),
      onPressed: onPressed,
      splashRadius: Dimensions.splashRadius,
    );
  }
}
