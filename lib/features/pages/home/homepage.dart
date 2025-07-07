import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/widgets/audio_player/audio_player.dart';
import 'home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadTracks();
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

    // Passa le tracce al controller
    final audioController = context.read<AudioPlayerController>();
    audioController.setTracks(tracks);
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
              currentIndex: audioController.currentIndex,
              onTrackSelected: audioController.playTrack,
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
