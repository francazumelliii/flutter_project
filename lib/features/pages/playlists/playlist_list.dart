
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/playlists/playlist_details.dart';

import '../../../core/data/domain/models/media_collection.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/utils/dimensions.dart';

class PlaylistListPage extends StatefulWidget {
  const PlaylistListPage({super.key});

  @override
  State<PlaylistListPage> createState() => _PlaylistListPageState();
}

class _PlaylistListPageState extends State<PlaylistListPage> {
  List<MediaCollection> playlists = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    final service = DataService();
    try {
      final response = await service.get('/chart/0/playlists');
      final list = response['data'] as List<dynamic>;
      final loaded = list.map((json) => MediaCollection.fromJson(json, 'playlist')).toList();

      setState(() {
        playlists = loaded;
        loading = false;
      });
    } catch (_) {
      setState(() => loading = false);
    }
  }

  void openPlaylist(MediaCollection playlist) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaylistDetailsPage(playlistId: playlist.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Top Playlists'),
        backgroundColor: Colors.transparent,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(Dimensions.paddingLarge),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
              child: Image.network(
                playlist.coverUrl,
                width: Dimensions.coverImageWidth,
                height: Dimensions.coverImageHeight,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(playlist.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(playlist.subtitle, style: const TextStyle(color: Colors.grey)),
            onTap: () => openPlaylist(playlist),
          );
        },
      ),
    );
  }
}