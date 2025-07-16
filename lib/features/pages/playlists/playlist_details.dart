import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

class PlaylistDetailsPage extends StatelessWidget {
  final int playlistId;

  const PlaylistDetailsPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    return FutureBuilder(
      future: dataService.get('/playlist/$playlistId'),
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
