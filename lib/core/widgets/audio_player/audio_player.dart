import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/domain/controllers/audio_player_controller.dart';
class CustomAudioPlayer extends StatelessWidget {
  final AudioPlayerController controller;

  const CustomAudioPlayer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final player = controller.audioPlayer;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<Duration>(
          stream: player.durationStream.map((d) => d ?? Duration.zero),
          builder: (context, durationSnapshot) {
            final duration = durationSnapshot.data ?? Duration.zero;
            return StreamBuilder<Duration>(
              stream: player.positionStream.map((p) => p ?? Duration.zero),
              builder: (context, positionSnapshot) {
                final position = positionSnapshot.data ?? Duration.zero;
                final progress = duration.inMilliseconds == 0
                    ? 0.0
                    : position.inMilliseconds / duration.inMilliseconds;

                return LinearProgressIndicator(
                  value: progress,
                  color: Colors.greenAccent,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  minHeight: 5,
                );
              },
            );
          },
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: controller.previousTrack,
              color: Colors.white,
            ),
            StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final playing = playerState?.playing ?? false;
                if (playing) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: controller.pause,
                    color: Colors.white,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: controller.resume,
                    color: Colors.white,
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: controller.nextTrack,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}


