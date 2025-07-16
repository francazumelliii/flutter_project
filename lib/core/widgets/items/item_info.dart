import 'package:flutter/material.dart';
import 'package:flutter_project/core/utils/text_styles.dart';
import 'package:flutter_project/core/utils/text_styles.dart';

class ItemInfo extends StatelessWidget {
  final String title;
  final String subtitle;

  const ItemInfo({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.itemTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          subtitle,
          style: TextStyles.itemSubtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
