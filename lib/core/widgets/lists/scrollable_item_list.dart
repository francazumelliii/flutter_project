import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/widgets/lists/gradient_overlay_right.dart';

import '../items/item_tile.dart';

class ScrollableItemList extends StatelessWidget {
  final List<Map<String, String>> items;
  final int currentIndex;
  final void Function(int index)? onTap;
  final double horizontalPadding;

  const ScrollableItemList({
    required this.items,
    required this.currentIndex,
    this.onTap,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            final isSelected = index == currentIndex;

            return ItemTile(
              imageUrl: item['imageUrl']!,
              title: item['title']!,
              subtitle: item['subtitle']!,
              audioPreviewUrl: item['audioPreviewUrl'] ?? '',
              isSelected: isSelected,
              onTap: () => onTap?.call(index),
            );
          },
        ),
        const GradientOverlayRight(),
      ],
    );
  }
}


