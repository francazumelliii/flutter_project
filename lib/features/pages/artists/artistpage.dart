import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/radio/radio_page.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/artist.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/models/album.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/audio_player/audio_player.dart';
import '../albums/albumpage.dart';
import 'artist_content.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key, required this.artistId});

  final int artistId;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  bool loading = true;
  Artist? artist;
  List<AudioTrack> topTracks = [];
  List<Album> albums = [];
  List<Artist> relatedArtists = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dataService = DataService();

    try {
      final artistData = await dataService.get('/artist/${widget.artistId}');
      final topData = await dataService.get(
        '/artist/${widget.artistId}/top?limit=50',
      );
      final albumsData = await dataService.get(
        '/artist/${widget.artistId}/albums',
      );
      final relatedData = await dataService.get(
        '/artist/${widget.artistId}/related',
      );

      // ARTIST
      final loadedArtist = Artist(
        id: artistData['id'],
        name: artistData['name'] ?? '',
        pictureUrl: artistData['picture_xl'] ?? artistData['picture_big'] ?? '',
        nbFans: (artistData['nb_fan'] ?? 0) is int
            ? artistData['nb_fan']
            : int.tryParse('${artistData['nb_fan']}') ?? 0,
        nbAlbum: (artistData['nb_album'] ?? 0) is int
            ? artistData['nb_album']
            : int.tryParse('${artistData['nb_album']}') ?? 0,
      );

      // TOP TRACKS
      final loadedTopTracks = (topData['data'] as List).map((t) {
        final md5 = t['album']?['md5_image'];
        final cover = (md5 != null)
            ? 'https://e-cdns-images.dzcdn.net/images/cover/$md5/250x250-000000-80-0-0.jpg'
            : (t['album']?['cover_xl'] ?? '');
        return AudioTrack(
          title: t['title'] ?? '',
          subtitle: t['artist']?['name'] ?? '',
          imageUrl: cover ?? '',
          audioPreviewUrl: t['preview'] ?? '',
          albumId: t['album']?['id'] ?? 0,
          artistId: t['artist']?['id'] ?? 0,
        );
      }).toList();

      // ALBUMS
      final loadedAlbums = (albumsData['data'] as List).map((a) {
        return Album(
          id: a['id'],
          title: a['title'] ?? '',
          artist: a['artist']?['name'] ?? loadedArtist.name,
          coverUrl: a['cover_xl'] ?? a['cover_big'] ?? '',
        );
      }).toList();

      // RELATED ARTISTS
      final loadedRelated = (relatedData['data'] as List).map((ra) {
        return Artist(
          id: ra['id'],
          name: ra['name'] ?? '',
          pictureUrl: ra['picture_xl'] ?? ra['picture_big'] ?? '',
          nbFans: (ra['nb_fan'] ?? 0) is int
              ? ra['nb_fan']
              : int.tryParse('${ra['nb_fan']}') ?? 0,
          nbAlbum: (ra['nb_album'] ?? 0) is int
              ? ra['nb_album']
              : int.tryParse('${ra['nb_album']}') ?? 0,
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        artist = loadedArtist;
        topTracks = loadedTopTracks;
        albums = loadedAlbums;
        relatedArtists = loadedRelated;
        loading = false;
      });

      context.read<AudioPlayerController>().setPlaylist(loadedTopTracks);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
      debugPrint('Errore caricamento artista: $e');
    }
  }

  void _onPlayAll() {
    final audio = context.read<AudioPlayerController>();
    if (topTracks.isEmpty) return;
    audio.playTrack(0);
  }

  void _onAlbumTap(int albumId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AlbumPage(albumId: albumId)),
    );
  }

  void _onRelatedArtistTap(int artistId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArtistPage(artistId: artistId)),
    );
  }

  void _onCreateRadio() {
    if (artist == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArtistRadioPage(
          artistId: artist!.id,
          artistName: artist!.name,
          artistImageUrl: artist!.pictureUrl,
        ),
      ),
    );
  }

  void _onTrackSelected(int index) {
    context.read<AudioPlayerController>().playTrack(index);
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();

    if (loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Artista')),
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (artist == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Artista')),
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'Artista non trovato',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(artist!.name)),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ArtistContent(
              artist: artist!,
              topTracks: topTracks,
              albums: albums,
              relatedArtists: relatedArtists,
              currentIndex: audioController.currentIndex,
              onPlayAll: _onPlayAll,
              onAlbumTap: _onAlbumTap,
              onRelatedArtistTap: _onRelatedArtistTap,
              onCreateRadio: _onCreateRadio,
            ),
          ),
          if (audioController.currentTrack != null)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSmall,
              ),
              child: CustomAudioPlayer(controller: audioController),
            ),
        ],
      ),
    );
  }
}
