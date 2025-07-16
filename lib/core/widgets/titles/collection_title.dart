import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionTitle extends StatelessWidget {
  const CollectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}