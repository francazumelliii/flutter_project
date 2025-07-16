import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';
import 'package:flutter_project/features/pages/playlists/playlist_details.dart';

class PlaylistPage extends StatelessWidget {
  final int playlistId;

  const PlaylistPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    return FutureBuilder(
      future: dataService.get('/playlist/$playlistId'),
      builder: (context, state) {
        if (state.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.hasError) {
          return Center(child: Text('Errore: ${state.error}'));
        }
        if (!state.hasData) {
          return const Center(child: Text('Nessun dato trovato'));
        }

        final data = state.data as Map<String, dynamic>;
        final collection = MediaCollection.fromJson(data, 'playlist');

        return CollectionContent(collection: collection);
      },
    );
  }
}