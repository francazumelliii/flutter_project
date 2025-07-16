import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/widgets/audio_player/audio_player.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/utils/dimensions.dart';

class TrackDetailPage extends StatelessWidget {
  final AudioTrack track;

  const TrackDetailPage({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioPlayerController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(track.title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingLarge),
        child: Column(
          children: [
            Image.network(
              track.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Dimensions.verticalMedium,
            Text(
              track.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Dimensions.verticalSmall,
            Text(
              track.subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            CustomAudioPlayer(controller: audioController),
          ],
        ),
      ),
    );
  }
}
