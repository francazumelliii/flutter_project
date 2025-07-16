import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/domain/controllers/audio_player_controller.dart';
import '../../utils/dimensions.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key, required this.controller});

  final AudioPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final player = controller.audioPlayer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: controller.previousTrack,
        ),
        SizedBox(width: Dimensions.spacingMedium),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data?.playing ?? false;
            return IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: isPlaying ? controller.pause : controller.resume,
            );
          },
        ),
        SizedBox(width: Dimensions.spacingMedium),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: controller.nextTrack,
        ),
      ],
    );
  }
}
