import 'package:flutter/material.dart';
import '../lists/track_list/scrollable_item_list.dart';
import '../titles/section_title.dart';
import '../../utils/dimensions.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          SectionTitle(
            text: title,
          ),
        SizedBox(
          height: 200,
          child: ScrollableItemList(
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
            horizontalPadding: Dimensions.paddingMedium,
          ),
        ),
      ],
    );
  }
}
