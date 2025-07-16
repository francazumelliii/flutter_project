import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium, vertical: Dimensions.paddingVerticalLarge),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
