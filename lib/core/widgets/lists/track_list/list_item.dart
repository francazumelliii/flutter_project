import 'package:flutter/material.dart';
import '../../../data/domain/models/audio_track.dart';
import '../../inputs/row_play_button.dart';
import 'album_cover.dart';
import 'track_index.dart';
import 'track_info.dart';

class TrackListItem extends StatelessWidget {
  const TrackListItem({
    super.key,
    required this.index,
    required this.track,
    required this.isSelected,
    required this.onTap,
    required this.onAlbumTap,
  });

  final int index;
  final AudioTrack track;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onAlbumTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.green : Colors.white;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: isSelected ? Colors.white.withOpacity(0.05) : Colors.transparent,
        child: Row(
          children: [
            TrackIndex(index: index, color: color),
            const SizedBox(width: 12),
            AlbumCover(imageUrl: track.imageUrl, onTap: onAlbumTap),
            const SizedBox(width: 12),
            Expanded(
              child: TrackInfo(title: track.title, subtitle: track.subtitle, color: color),
            ),
            RowPlayButton(isPlaying: isSelected, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
