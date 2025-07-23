
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/domain/models/album.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({super.key, required this.album});
  final Album album;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          album.coverUrl.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              album.coverUrl,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            width: 140,
            height: 140,
            color: Colors.grey[800],
          ),
          const SizedBox(height: 8),
          Text(
            album.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            album.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
