import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/domain/controllers/audio_player_controller.dart';
import '../../utils/dimensions.dart';

class PlaybackButtons extends StatelessWidget {
  final AudioPlayerController controller;

  const PlaybackButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final player = controller.audioPlayer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: controller.previousTrack,
        ),
        SizedBox(width: Dimensions.spacingMedium),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data?.playing ?? false;
            return IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: isPlaying ? controller.pause : controller.resume,
            );
          },
        ),
        SizedBox(width: Dimensions.spacingMedium),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white),
          onPressed: controller.nextTrack,
        ),
      ],
    );
  }
}
