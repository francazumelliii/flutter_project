import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderHeader extends StatelessWidget {
  final String title;
  final double padding;

  const SliderHeader({
    required this.title,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 12, padding, 8),
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
