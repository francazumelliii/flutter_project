import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/audio_track.dart';

class TrackInfo extends StatelessWidget {
  final AudioTrack? track;
  final int maxLines;
  final TextOverflow overflow;

  const TrackInfo({
    super.key,
    required this.track,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      track?.title ?? 'Nessun brano',
      maxLines: maxLines,
      overflow: overflow,
      style: const TextStyle(color: Colors.white),
    );

  }
}
