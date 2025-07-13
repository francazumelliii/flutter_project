import 'package:flutter/material.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/services/data_service.dart';
import 'analytics_content.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late final DataService _dataService;
  late Future<List<AudioTrack>> _futureTracks;

  @override
  void initState() {
    super.initState();
    _dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    _futureTracks = fetchTopTracks();
  }

  Future<List<AudioTrack>> fetchTopTracks() async {
    try {
      final response = await _dataService.get('/chart/0/tracks');
      final List<dynamic> tracksJson = response['data'] ?? [];

      return tracksJson
          .map((json) => AudioTrack.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Errore caricamento tracce: $e');
    }
  }

  // Deezer non fornisce i playCounts, quindi generiamo dati finti
  List<int> generateFakePlayCounts(int length) {
    return List.generate(length, (index) => (index + 1) * 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<AudioTrack>>(
        future: _futureTracks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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

          final tracks = snapshot.data ?? [];
          if (tracks.isEmpty) {
            return const Center(
              child: Text(
                'Nessuna traccia disponibile',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final playCounts = generateFakePlayCounts(tracks.length);

          return AnalyticsContent(topTracks: tracks, playCounts: playCounts);
        },
      ),
    );
  }
}
