import 'package:flutter/material.dart';
import 'package:flutter_project/core/widgets/lists/list_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';


class TrackList extends StatelessWidget {
  final List<AudioTrack> tracks;

  const TrackList({Key? key, required this.tracks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();
    final currentIndex = audioController.currentIndex;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: tracks.length,
      separatorBuilder: (_, __) => const Divider(color: Colors.grey, height: 1),
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isSelected = index == currentIndex;

        return TrackListItem(
          index: index,
          track: track,
          isSelected: isSelected,
          onTap: () {
            context.read<AudioPlayerController>().playTrack(index);
          },
        );
      },
    );
  }
}
