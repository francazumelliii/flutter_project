import 'package:flutter/material.dart';
import 'package:flutter_project/core/widgets/inputs/play_all_button.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/audio_player/audio_player.dart';
import '../../../core/widgets/headers/artist_header/artist_image_header.dart';
import '../../../core/widgets/lists/track_list/radio_track_list.dart';

class ArtistRadioContent extends StatelessWidget {
  const ArtistRadioContent({
    super.key,
    required this.artistName,
    required this.artistImageUrl,
    required this.tracks,
    required this.onTrackSelected,
    required this.onPlayAll,
  });

  final String artistName;
  final String artistImageUrl;
  final List<AudioTrack> tracks;
  final void Function(int) onTrackSelected;
  final VoidCallback onPlayAll;

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();
    final isPlaying = audioController.isPlaying;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Radio $artistName')),
      body: Column(
        children: [
          ArtistImageHeader(artistName: artistName, artistImageUrl: artistImageUrl),

          const SizedBox(height: Dimensions.paddingLarge),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge),
            child: PlayAllButton(
              isPlaying: audioController.isPlaying,
              onPlay: () {
                if (tracks.isNotEmpty) {
                  audioController.playTrack(0);
                }
              },
              onPause: () {
                audioController.pause();
              },
            ),
          ),

          const SizedBox(height: Dimensions.paddingLarge),

          Expanded(
            child: RadioTrackList(
              tracks: tracks,
              currentIndex: audioController.currentIndex,
              onTrackSelected: onTrackSelected,
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
