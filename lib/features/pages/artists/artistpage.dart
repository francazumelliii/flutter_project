import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';

class ArtistPage extends StatefulWidget {
  final int artistId;

  const ArtistPage({super.key, required this.artistId});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  List<MediaCollection> albums = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArtistAlbums();
  }

  Future<void> _loadArtistAlbums() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/artist/${widget.artistId}/albums');

    final loadedAlbums = (response['data'] as List<dynamic>).map<MediaCollection>((album) {
      return MediaCollection(
        id: album['id'],
        title: album['title'] ?? '',
        subtitle: album['artist']?['name'] ?? '',
        coverUrl: album['cover_xl'] ?? '',
        type: 'album',
      );
    }).toList();

    setState(() {
      albums = loadedAlbums;
      isLoading = false;
    });
  }

  void _openAlbum(MediaCollection album) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CollectionContent(collection: album),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Albums'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return ListTile(
            onTap: () => _openAlbum(album),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(album.coverUrl, width: 50, height: 50, fit: BoxFit.cover),
            ),
            title: Text(album.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(album.subtitle, style: const TextStyle(color: Colors.white70)),
          );
        },
      ),
    );
  }
}
