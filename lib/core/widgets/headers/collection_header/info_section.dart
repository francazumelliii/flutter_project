import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/widgets/titles/collection_subtitle.dart';
import 'package:flutter_project/core/widgets/titles/collection_title.dart';

import '../../inputs/collection_play_button.dart';


class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPlay,
  });

  final String title;
  final String subtitle;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CollectionTitle(title: title),
        const SizedBox(height: 8),
        CollectionSubtitle(subtitle: subtitle),
        const SizedBox(height: 16),
        CollectionPlayButton(onPlay: onPlay),
      ],
    );
  }
}

