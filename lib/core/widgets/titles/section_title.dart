import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const SectionTitle({
    super.key,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
