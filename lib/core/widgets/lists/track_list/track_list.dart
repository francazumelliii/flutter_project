import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/domain/controllers/audio_player_controller.dart';
import '../../../data/domain/models/audio_track.dart';

class TrackList extends StatelessWidget {
  final List<AudioTrack> tracks;

  const TrackList({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      return const Center(child: Text('Nessuna traccia disponibile', style: TextStyle(color: Colors.white)));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isPlaying = context.watch<AudioPlayerController>().currentIndex == index;

        return ListTile(
          leading: track.imageUrl.isNotEmpty
              ? Image.network(track.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
              : const SizedBox(width: 50, height: 50),
          title: Text(track.title, style: TextStyle(color: isPlaying ? Colors.green : Colors.white)),
          subtitle: Text(track.subtitle, style: const TextStyle(color: Colors.grey)),
          trailing: isPlaying ? const Icon(Icons.equalizer, color: Colors.green) : const Icon(Icons.play_arrow, color: Colors.white),
          onTap: () {
            context.read<AudioPlayerController>().playTrack(index);
          },
        );
      },
    );
  }
}
