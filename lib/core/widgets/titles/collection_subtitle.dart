import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionSubtitle extends StatelessWidget {
  const CollectionSubtitle({super.key, required this.subtitle});
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: const TextStyle(color: Colors.grey, fontSize: 18),
    );
  }
}