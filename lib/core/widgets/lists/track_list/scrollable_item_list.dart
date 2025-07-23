import 'package:flutter/material.dart';
import '../../items/item_tile.dart';
import '../../../utils/dimensions.dart';

class ScrollableItemList extends StatelessWidget {
  const ScrollableItemList({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.horizontalPadding = Dimensions.paddingMedium,
  });

  final List<Map<String, String>> items;
  final int currentIndex;
  final void Function(int)? onTap;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == items.length - 1 ? 0 : Dimensions.spacingSmall,
            ),
            child: ItemTile(
              imageUrl: item['imageUrl'] ?? '',
              title: item['title'] ?? '',
              subtitle: item['subtitle'] ?? '',
              isSelected: index == currentIndex,
              audioPreviewUrl: item['audioPreviewUrl'] ?? '',
              onTap: () => onTap?.call(index),
            ),
          );
        },
      ),
    );
  }
}
