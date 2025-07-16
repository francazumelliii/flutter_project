import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

class AlbumPage extends StatelessWidget {
  final int albumId;

  const AlbumPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    return FutureBuilder<dynamic>(
      future: dataService.get('/album/$albumId'),
      builder: (c, state) {
        if (state.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.hasError) {
          return Center(child: Text('Errore: ${state.error}'));
        }
        if (!state.hasData || state.data == null) {
          return const Center(child: Text('Nessun dato trovato'));
        }

        final data = state.data as Map<String, dynamic>;
        final collection = MediaCollection.fromJson(data, 'album');

        return CollectionContent(collection: collection);
      },
    );
  }
}
