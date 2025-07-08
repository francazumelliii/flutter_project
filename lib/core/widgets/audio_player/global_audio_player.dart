import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/widgets/audio_player/audio_player.dart';

class GlobalAudioPlayer extends StatelessWidget {
  const GlobalAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();
    final currentTrack = audioController.currentTrack;

    if (currentTrack == null) return const SizedBox.shrink();

    return CustomAudioPlayer(
      audioUrl: currentTrack.audioPreviewUrl,
      onNext: audioController.nextTrack,
      onPrevious: audioController.previousTrack,
    );
  }
}
