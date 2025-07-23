
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/domain/models/audio_track.dart';

class RadioTrackList extends StatelessWidget {
  final List<AudioTrack> tracks;
  final int currentIndex;
  final void Function(int) onTrackSelected;

  const RadioTrackList({
    super.key,
    required this.tracks,
    required this.currentIndex,
    required this.onTrackSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isPlaying = currentIndex == index;
        return ListTile(
          leading: track.imageUrl.isNotEmpty
              ? Image.network(track.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
              : const SizedBox(width: 50, height: 50),
          title: Text(track.title, style: TextStyle(color: isPlaying ? Colors.green : Colors.white)),
          subtitle: Text(track.subtitle, style: const TextStyle(color: Colors.grey)),
          trailing: isPlaying
              ? const Icon(Icons.equalizer, color: Colors.green)
              : const Icon(Icons.play_arrow, color: Colors.white),
          onTap: () => onTrackSelected(index),
        );
      },
    );
  }
}
