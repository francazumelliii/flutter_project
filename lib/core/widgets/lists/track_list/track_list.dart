import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/audio_track.dart';
import 'package:flutter_project/core/widgets/lists/track_list/list_item.dart';
import 'package:provider/provider.dart';

import '../../../data/domain/controllers/audio_player_controller.dart';


class TrackList extends StatelessWidget {
  final List<AudioTrack> tracks;
  final void Function(int)? onTap;

  const TrackList({super.key, required this.tracks, this.onTap});

  @override
  Widget build(BuildContext context) {
    final audioCtrl = context.watch<AudioPlayerController>();
    final currentIndex = audioCtrl.currentIndex;

    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isSelected = index == currentIndex;

        return TrackListItem(
          index: index,
          track: track,
          isSelected: isSelected,
          onTap: () {
            if (onTap != null) onTap!(index);
          },
          onAlbumTap: () {

          },
        );
      },
    );
  }
}
