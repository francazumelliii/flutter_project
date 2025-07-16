import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';
import 'cover_image.dart';
import 'info_section.dart';

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.subtitle,
    required this.onPlay,
  });

  final String coverUrl;
  final String title;
  final String subtitle;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingLarge),
      child: Row(
        children: [
          CoverImage(url: coverUrl),
          const SizedBox(width: Dimensions.paddingLarge),
          Expanded(child: InfoSection(title: title, subtitle: subtitle, onPlay: onPlay)),
        ],
      ),
    );
  }
}
