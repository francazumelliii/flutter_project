import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/domain/controllers/audio_player_controller.dart';
import '../../utils/dimensions.dart';
import 'track_info.dart';
import 'playback_buttons.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key, required this.controller});

  final AudioPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final currentTrack = controller.currentTrack;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TrackInfo(
              track: currentTrack,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          PlaybackButtons(controller: controller),
        ],
      ),
    );
  }
}
