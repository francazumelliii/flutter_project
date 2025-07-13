import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

class AlbumPage extends StatelessWidget {
  final int albumId;

  const AlbumPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com').get('/album/$albumId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Nessun dato trovato'));
        }

        final data = snapshot.data as Map<String, dynamic>;
        final collection = MediaCollection.fromJson(data, 'album');

        return CollectionContent(collection: collection);
      },
    );
  }
}
