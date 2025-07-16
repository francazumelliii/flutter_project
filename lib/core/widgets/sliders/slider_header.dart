import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class SliderHeader extends StatelessWidget {
  final String title;

  const SliderHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left:  Dimensions.paddingMedium,
        right:  Dimensions.paddingMedium,
        top: Dimensions.spacingSmall,
        bottom: Dimensions.spacingSmall / 1.5,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
