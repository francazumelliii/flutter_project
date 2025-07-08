import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/albums/albumpage.dart';
import 'package:flutter_project/features/pages/playlists/playlistpage.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/domain/models/album.dart';
import '../../../core/data/domain/models/media_collection.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/widgets/audio_player/audio_player.dart';
import 'home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Album> albums = [];
  List<MediaCollection> playlists = [];
  List<AudioTrack> homeTracks = [];

  @override
  void initState() {
    super.initState();
    _loadTracks();
    _loadAlbums();
    _loadPlaylists();
  }

  Future<void> _loadTracks() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/chart/0/tracks');

    final tracks = (response['data'] as List<dynamic>).map<AudioTrack>((track) {
      return AudioTrack(
        imageUrl: 'https://e-cdns-images.dzcdn.net/images/cover/${track['album']['md5_image']}/250x250-000000-80-0-0.jpg',
        title: track['title'] ?? '',
        subtitle: track['artist']['name'] ?? '',
        audioPreviewUrl: track['preview'] ?? '',
      );
    }).toList();

    homeTracks = tracks;
    context.read<AudioPlayerController>().setTracks(tracks);
  }

  Future<void> _loadAlbums() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/chart/0/albums');

    final topAlbums = (response['data'] as List<dynamic>).map<Album>((albumJson) {
      return Album(
        id: albumJson['id'],
        title: albumJson['title'] ?? '',
        artist: albumJson['artist']?['name'] ?? '',
        coverUrl: albumJson['cover_xl'] ?? '',
      );
    }).toList();

    setState(() {
      albums = topAlbums;
    });
  }

  Future<void> _loadPlaylists() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/chart/0/playlists');

    final topPlaylists = (response['data'] as List<dynamic>).map<MediaCollection>((playlistJson) {
      return MediaCollection(
        id: playlistJson['id'],
        title: playlistJson['title'] ?? '',
        subtitle: playlistJson['creator']?['name'] ?? '',
        coverUrl: playlistJson['picture_xl'] ?? '',
        type: 'playlist',
      );
    }).toList();

    setState(() {
      playlists = topPlaylists;
    });
  }

  void _goToAlbum(BuildContext context, int albumId) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AlbumPage(albumId: albumId)),
    ).then((_) {
      context.read<AudioPlayerController>().setTracks(homeTracks);
    });
  }

  void _goToPlaylist(BuildContext context, int playlistId) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlaylistPage(playlistId: playlistId)),
    ).then((_) {
      context.read<AudioPlayerController>().setTracks(homeTracks);
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();

    if (audioController.tracks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: HomeContent(
              tracks: audioController.tracks
                  .map((t) => {
                'imageUrl': t.imageUrl,
                'title': t.title,
                'subtitle': t.subtitle,
                'audioPreviewUrl': t.audioPreviewUrl,
              })
                  .toList(),
              albums: albums
                  .map((album) => {
                'imageUrl': album.coverUrl,
                'title': album.title,
                'subtitle': album.artist,
                'albumId': album.id.toString(),
              })
                  .toList(),
              playlists: playlists
                  .map((playlist) => {
                'imageUrl': playlist.coverUrl,
                'title': playlist.title,
                'subtitle': playlist.subtitle,
                'playlistId': playlist.id.toString(),
              })
                  .toList(),
              currentIndex: audioController.currentIndex,
              onTrackSelected: audioController.playTrack,
              onAlbumTap: (albumId) => _goToAlbum(context, albumId),
              onPlaylistTap: (playlistId) => _goToPlaylist(context, playlistId),
            ),
          ),
          if (audioController.currentTrack != null)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomAudioPlayer(
                audioUrl: audioController.currentTrack!.audioPreviewUrl,
                onNext: audioController.nextTrack,
                onPrevious: audioController.previousTrack,
              ),
            ),
        ],
      ),
    );
  }
}
