import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../items/item_tile.dart';

class ItemSlider extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final int currentIndex; // aggiunto
  final void Function(int index)? onTap;

  const ItemSlider({
    super.key,
    required this.title,
    required this.items,
    this.currentIndex = -1, // default -1 (nessun selezionato)
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final bool isSelected = index == currentIndex; // evidenzia se è selezionato

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ItemTile(
                  imageUrl: item['imageUrl']!,
                  title: item['title']!,
                  subtitle: item['subtitle']!,
                  audioPreviewUrl: item['audioPreviewUrl'] ?? '',
                  onTap: () {
                    if (onTap != null) onTap!(index);
                  },
                  isSelected: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
