import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

class AlbumPage extends StatelessWidget {
  final int albumId;

  const AlbumPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com').get('/album/$albumId'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data as Map<String, dynamic>;

        final collection = MediaCollection(
          id: albumId,
          title: data['title'] ?? '',
          subtitle: data['artist']['name'] ?? '',
          coverUrl: data['cover_xl'] ?? '',
          type: 'album',
        );

        return CollectionContent(collection: collection);
      },
    );
  }
}

class PlaylistPage extends StatelessWidget {
  final int playlistId;

  const PlaylistPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com').get('/playlist/$playlistId'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data as Map<String, dynamic>;

        final collection = MediaCollection(
          id: playlistId,
          title: data['title'] ?? '',
          subtitle: data['creator']['name'] ?? '',
          coverUrl: data['picture_xl'] ?? '',
          type: 'playlist',
        );

        return CollectionContent(collection: collection);
      },
    );
  }
}
