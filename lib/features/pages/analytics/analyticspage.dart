import 'package:flutter/material.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/models/media_collection.dart';
import '../../../core/data/services/data_service.dart';
import 'analytics_content.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<Map<String, dynamic>> futureAnalytics;

  @override
  void initState() {
    super.initState();
    futureAnalytics = fetchAnalyticsData();
  }

  /// Recupero dati da Deezer (Top Tracce, Album e Playlist)
  Future<Map<String, dynamic>> fetchAnalyticsData() async {
    final dataService = DataService();

    try {
      // Top Tracks
      final trackResponse = await dataService.get('/chart/0/tracks');
      final trackList = (trackResponse['data'] ?? [])
          .map<AudioTrack>((e) => AudioTrack.fromJson(e))
          .toList();

      // Top Albums
      final albumResponse = await dataService.get('/chart/0/albums');
      final albumList = (albumResponse['data'] ?? [])
          .map<MediaCollection>((e) => MediaCollection.fromJson(e, type: 'album'))
          .toList();

      // Top Playlists
      final playlistResponse = await dataService.get('/chart/0/playlists');
      final playlistList = (playlistResponse['data'] ?? [])
          .map<MediaCollection>((e) => MediaCollection.fromJson(e, type: 'playlist'))
          .toList();

      // PlayCounts fake (per i grafici)
      final trackPlayCounts = List.generate(trackList.length, (i) => (i + 1) * 12);
      final albumPlayCounts = List.generate(albumList.length, (i) => (i + 1) * 8);
      final playlistPlayCounts = List.generate(playlistList.length, (i) => (i + 1) * 10);

      return {
        'tracks': trackList,
        'albums': albumList,
        'playlists': playlistList,
        'trackCounts': trackPlayCounts,
        'albumCounts': albumPlayCounts,
        'playlistCounts': playlistPlayCounts,
      };
    } catch (e) {
      throw Exception('Errore caricamento dati Analytics: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureAnalytics,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Errore: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final data = snapshot.data!;
          final tracks = data['tracks'] as List<AudioTrack>;
          final albums = data['albums'] as List<MediaCollection>;
          final playlists = data['playlists'] as List<MediaCollection>;
          final trackCounts = data['trackCounts'] as List<int>;
          final albumCounts = data['albumCounts'] as List<int>;
          final playlistCounts = data['playlistCounts'] as List<int>;

          return AnalyticsContent(
            topTracks: tracks,
            playCounts: trackCounts,
            topAlbums: albums,
            albumCounts: albumCounts,
            topPlaylists: playlists,
            playlistCounts: playlistCounts,
          );
        },
      ),
    );
  }
}
