import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import 'item_image.dart';
import 'item_info.dart';

class ItemTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String audioPreviewUrl;
  final VoidCallback? onTap;
  final bool isSelected;
  static const String soundGifPath = 'lib/assets/images/sound.gif';

  const ItemTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.audioPreviewUrl,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ItemImage(imageUrl: imageUrl),
                  if (isSelected)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          soundGifPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Dimensions.spacingSmall),
              ItemInfo(title: title, subtitle: subtitle),
            ],
          ),
        ),
      ),
    );
  }
}
