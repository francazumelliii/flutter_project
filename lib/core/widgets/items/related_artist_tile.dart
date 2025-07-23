
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/domain/models/artist.dart';

class RelatedArtistTile extends StatelessWidget {
  const RelatedArtistTile({super.key, required this.artist});
  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          artist.pictureUrl.isNotEmpty
              ? ClipOval(
            child: Image.network(
              artist.pictureUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )
              : CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[800],
          ),
          const SizedBox(height: 8),
          Text(
            artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            '${artist.nbFans} fan',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
