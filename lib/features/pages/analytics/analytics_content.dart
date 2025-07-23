import 'package:flutter/material.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/models/media_collection.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/charts/top_tracks_chart.dart';
import '../../../core/widgets/charts/line_chart.dart';
import '../../../core/widgets/charts/pie_chart.dart';
import '../../../core/widgets/titles/section_title.dart';

class AnalyticsContent extends StatelessWidget {
  final List<AudioTrack> topTracks;
  final List<int> playCounts;
  final List<MediaCollection> topAlbums;
  final List<int> albumCounts;
  final List<MediaCollection> topPlaylists;
  final List<int> playlistCounts;

  const AnalyticsContent({
    super.key,
    required this.topTracks,
    required this.playCounts,
    required this.topAlbums,
    required this.albumCounts,
    required this.topPlaylists,
    required this.playlistCounts,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionTitle(text: 'Top Tracks'),
            SizedBox(height: 200, child: TopTracksBarChart(tracks: topTracks)),
            Dimensions.verticalExtraLarge,

            SectionTitle(text: 'Top Albums'),
            SizedBox(height: 200, child: TrackPlayCountLineChart(
              tracks: topTracks,
              playCounts: albumCounts,
            )),
            Dimensions.verticalExtraLarge,

            SectionTitle(text: 'Top Playlists'),
            SizedBox(height: 220, child: TrackPlayPieChart(
              tracks: topTracks,
              playCounts: playlistCounts,
            )),
          ],
        ),
      ),
    );
  }
}
