
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/domain/models/artist.dart';
import '../../../utils/dimensions.dart';

class ArtistHeader extends StatelessWidget {
  const ArtistHeader({
    super.key,
    required this.artist,
    required this.onPlayAll,
    required this.onCreateRadio,
  });

  final Artist artist;
  final VoidCallback onPlayAll;
  final VoidCallback onCreateRadio;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(Dimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (artist.pictureUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                artist.pictureUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: Dimensions.paddingMedium),
          Text(
            artist.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _subtitleText(),
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: Dimensions.paddingMedium),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onPlayAll,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play All'),
              ),
              const SizedBox(width: Dimensions.paddingMedium),
              ElevatedButton.icon(
                onPressed: onCreateRadio,
                icon: const Icon(Icons.radio),
                label: const Text('Crea Radio'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _subtitleText() {
    final fans = artist.nbFans;
    final albums = artist.nbAlbum;
    if (fans == 0 && albums == 0) return '';
    if (fans > 0 && albums > 0) return '$fans fan • $albums album';
    if (fans > 0) return '$fans fan';
    return '$albums album';
  }
}
