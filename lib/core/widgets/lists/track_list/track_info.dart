import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackInfo extends StatelessWidget {
  const TrackInfo({super.key, required this.title, required this.subtitle, required this.color});

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey[400], fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}