import 'package:flutter/material.dart';
import '../lists/scrollable_item_list.dart';
import '../titles/section_title.dart';

class ItemSlider extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final int currentIndex;
  final void Function(int index)? onTap;

  const ItemSlider({
    super.key,
    required this.title,
    required this.items,
    this.currentIndex = -1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          SectionTitle(
            text: title,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
          ),
        SizedBox(
          height: 200,
          child: ScrollableItemList(
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
            horizontalPadding: horizontalPadding,
          ),
        ),
      ],
    );
  }
}
