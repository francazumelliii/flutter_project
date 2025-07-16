import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/home/home_content.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/models/album.dart';
import '../../../core/data/domain/models/media_collection.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/audio_player/audio_player.dart';
import '../albums/albumpage.dart';
import '../playlists/playlistpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AudioTrack> tracks = [];
  List<Album> albums = [];
  List<MediaCollection> playlists = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final dataService = DataService();

    final tracksData = await dataService.get('/chart/0/tracks');
    final albumsData = await dataService.get('/chart/0/albums');
    final playlistsData = await dataService.get('/chart/0/playlists');

    final loadedTracks = (tracksData['data'] as List).map((t) {
      return AudioTrack(
        title: t['title'] ?? '',
        subtitle: t['artist']?['name'] ?? '',
        imageUrl: 'https://e-cdns-images.dzcdn.net/images/cover/${t['album']?['md5_image']}/250x250-000000-80-0-0.jpg',
        audioPreviewUrl: t['preview'] ?? '',
        albumId: t['album']?['id'] ?? 0,
      );
    }).toList();

    final loadedAlbums = (albumsData['data'] as List).map((a) {
      return Album(
        id: a['id'],
        title: a['title'] ?? '',
        artist: a['artist']?['name'] ?? '',
        coverUrl: a['cover_xl'] ?? '',
      );
    }).toList();

    final loadedPlaylists = (playlistsData['data'] as List).map((p) {
      return MediaCollection(
        id: p['id'],
        title: p['title'] ?? '',
        subtitle: p['creator']?['name'] ?? '',
        coverUrl: p['picture_xl'] ?? '',
        type: 'playlist',
      );
    }).toList();

    setState(() {
      tracks = loadedTracks;
      albums = loadedAlbums;
      playlists = loadedPlaylists;
      loading = false;
    });

    // Set playlist for audio player
    context.read<AudioPlayerController>().setPlaylist(loadedTracks);
  }

  void onTrackSelected(int index) {
    context.read<AudioPlayerController>().playTrack(index);
  }

  void onAlbumTap(int albumId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AlbumPage(albumId: albumId)),
    );
  }

  void onPlaylistTap(int playlistId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaylistPage(playlistId: playlistId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();

    if (loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: HomeContent(
              tracks: tracks.map((t) => {
                'imageUrl': t.imageUrl,
                'title': t.title,
                'subtitle': t.subtitle,
                'audioPreviewUrl': t.audioPreviewUrl,
                'albumId': t.albumId.toString(),
              }).toList(),
              albums: albums.map((a) => {
                'imageUrl': a.coverUrl,
                'title': a.title,
                'subtitle': a.artist,
                'albumId': a.id.toString(),
              }).toList(),
              playlists: playlists.map((p) => {
                'imageUrl': p.coverUrl,
                'title': p.title,
                'subtitle': p.subtitle,
                'playlistId': p.id.toString(),
              }).toList(),
              currentIndex: audioController.currentIndex,
              onTrackSelected: onTrackSelected,
              onAlbumTap: onAlbumTap,
              onPlaylistTap: onPlaylistTap,
            ),
          ),
          if (audioController.currentTrack != null)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
              child: CustomAudioPlayer(controller: audioController),
            ),
        ],
      ),
    );
  }
}
