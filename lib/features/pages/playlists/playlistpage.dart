import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';
import 'package:flutter_project/features/pages/playlists/playlist_details.dart';

class PlaylistListPage extends StatefulWidget {
  const PlaylistListPage({super.key});

  @override
  State<PlaylistListPage> createState() => _PlaylistListPageState();
}

class _PlaylistListPageState extends State<PlaylistListPage> {
  List<MediaCollection> playlists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
  }

  Future<void> _loadPlaylists() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/chart/0/playlists');

    final loadedPlaylists = (response['data'] as List<dynamic>).map<MediaCollection>((playlist) {
      return MediaCollection(
        id: playlist['id'],
        title: playlist['title'] ?? '',
        subtitle: playlist['creator']?['name'] ?? '',
        coverUrl: playlist['picture_xl'] ?? '',
        type: 'playlist',
      );
    }).toList();

    setState(() {
      playlists = loadedPlaylists;
      isLoading = false;
    });
  }

  void _openPlaylist(MediaCollection playlist) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlaylistDetailsPage(playlistId: playlist.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Top Playlists'), backgroundColor: Colors.transparent),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(playlist.coverUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            title: Text(playlist.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(playlist.subtitle, style: const TextStyle(color: Colors.grey)),
            onTap: () => _openPlaylist(playlist),
          );
        },
      ),
    );
  }
}
