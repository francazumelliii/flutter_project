import 'package:flutter/material.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/services/data_service.dart';
import 'analytics_content.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<List<AudioTrack>> futureTracks;

  @override
  void initState() {
    super.initState();
    futureTracks = fetchTracks();
  }

  Future<List<AudioTrack>> fetchTracks() async {
    final dataService = DataService();

    try {
      final response = await dataService.get('/chart/0/tracks');
      final list = response['data'] ?? [];

      return list.map<AudioTrack>((e) => AudioTrack.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Errore caricamento: $e');
    }
  }

  List<int> fakePlayCounts(int count) {
    return List.generate(count, (i) => (i + 1) * 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<AudioTrack>>(
        future: futureTracks,
        builder: (context, state) {
          if (state.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(
              child: Text('Errore: ${state.error}', style: const TextStyle(color: Colors.white)),
            );
          }

          final tracks = state.data ?? [];

          if (tracks.isEmpty) {
            return const Center(child: Text('Nessuna traccia disponibile', style: TextStyle(color: Colors.white)));
          }

          final counts = fakePlayCounts(tracks.length);

          return AnalyticsContent(topTracks: tracks, playCounts: counts);
        },
      ),
    );
  }
}
