import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/album.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/core/widgets/albums/album_header.dart';
import 'package:flutter_project/core/widgets/lists/track_list.dart';
import 'package:provider/provider.dart';

class AlbumContent extends StatefulWidget {
  final Album album;

  const AlbumContent({Key? key, required this.album}) : super(key: key);

  @override
  State<AlbumContent> createState() => _AlbumContentState();
}

class _AlbumContentState extends State<AlbumContent> {
  List<AudioTrack> tracks = [];

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/album/${widget.album.id}/tracks');

    final loadedTracks = (response['data'] as List<dynamic>).map<AudioTrack>((track) {
      return AudioTrack(
        imageUrl: widget.album.coverUrl,
        title: track['title'] ?? '',
        subtitle: widget.album.artist,
        audioPreviewUrl: track['preview'] ?? '',
      );
    }).toList();

    setState(() => tracks = loadedTracks);

    context.read<AudioPlayerController>().setTracks(loadedTracks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, title: const Text('Album')),
      body: tracks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AlbumHeader(
              coverUrl: widget.album.coverUrl,
              title: widget.album.title,
              artist: widget.album.artist,
              onPlayAlbum: () {
                if (tracks.isNotEmpty) {
                  context.read<AudioPlayerController>().playTrack(0);
                }
              },
            ),
            TrackList(tracks: tracks),
          ],
        ),
      ),
    );
  }
}
