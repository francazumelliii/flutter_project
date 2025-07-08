import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/widgets/audio_player/audio_player.dart';
import 'package:provider/provider.dart';

class TrackDetailPage extends StatelessWidget {
  final AudioTrack track;

  const TrackDetailPage({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioPlayerController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(track.title),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.network(track.imageUrl, width: 200, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(track.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(track.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(height: 20),
          CustomAudioPlayer(
            audioUrl: track.audioPreviewUrl,
            onNext: () {},
            onPrevious: () {},
          ),
        ],
      ),
    );
  }
}
