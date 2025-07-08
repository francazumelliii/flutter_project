import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/widgets/icons/play_icon.dart';

class TrackListItem extends StatelessWidget {
  final int index;
  final AudioTrack track;
  final bool isSelected;
  final VoidCallback onTap;

  const TrackListItem({
    Key? key,
    required this.index,
    required this.track,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.greenAccent : Colors.white;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: isSelected ? Colors.white.withOpacity(0.05) : Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                track.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track.subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            PlayIconButton(
              isPlaying: isSelected,
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
