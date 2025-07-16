import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

import '../../../core/utils/dimensions.dart';

class ArtistPage extends StatefulWidget {
  final int artistId;

  const ArtistPage({super.key, required this.artistId});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  List<MediaCollection> albums = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAlbums();
  }

  void loadAlbums() async {
    final dataService = DataService();
    final response = await dataService.get('/artist/${widget.artistId}/albums');

    if (response['data'] != null) {
      final list = response['data'] as List<dynamic>;

      final loaded = list.map((album) {
        return MediaCollection(
          id: album['id'],
          title: album['title'] ?? '',
          subtitle: album['artist']?['name'] ?? '',
          coverUrl: album['cover_xl'] ?? '',
          type: 'album',
        );
      }).toList();

      setState(() {
        albums = loaded;
        loading = false;
      });
    } else {
      setState(() {
        albums = [];
        loading = false;
      });
    }
  }

  void openAlbum(MediaCollection album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CollectionContent(collection: album),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Albums'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: EdgeInsets.all(Dimensions.paddingLarge),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];

          return ListTile(
            onTap: () => openAlbum(album),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                album.coverUrl,
                width: Dimensions.coverImageWidth,
                height: Dimensions.coverImageHeight,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(album.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(album.subtitle, style: const TextStyle(color: Colors.white70)),
          );
        },
      ),
    );
  }
}
