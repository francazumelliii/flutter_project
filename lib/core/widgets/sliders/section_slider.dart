
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class SectionSlider<T> extends StatelessWidget {
  const SectionSlider({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.onTap,
  });

  final String title;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingMedium),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: Dimensions.paddingMedium),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onTap(item),
                child: itemBuilder(context, item),
              );
            },
          ),
        ),
      ],
    );
  }
}
