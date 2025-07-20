import 'package:flutter/material.dart';
import 'package:flutter_project/core/widgets/audio_player/player_controls.dart';
import 'package:flutter_project/core/widgets/audio_player/progress_bar.dart';
import '../../data/domain/controllers/audio_player_controller.dart';
import '../../utils/dimensions.dart';

class CustomAudioPlayer extends StatelessWidget {
  const CustomAudioPlayer({super.key, required this.controller});

  final AudioPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final player = controller.audioPlayer;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProgressBar(player: player),
        Dimensions.verticalSmall,
        PlayerControls(controller: controller),
      ],
    );
  }
}
