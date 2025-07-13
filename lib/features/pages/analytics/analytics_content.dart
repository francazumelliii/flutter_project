import 'package:flutter/material.dart';

import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/widgets/charts/line_chart.dart';
import '../../../core/widgets/charts/pie_chart.dart';
import '../../../core/widgets/charts/top_tracks_chart.dart';
import '../../../core/widgets/titles/section_title.dart';

class AnalyticsContent extends StatelessWidget {
  final List<AudioTrack> topTracks;
  final List<int> playCounts;

  const AnalyticsContent({required this.topTracks, required this.playCounts, super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(text: 'Top Tracks Bar Chart'),
          SizedBox(height: isMobile ? 200 : 150, child: TopTracksBarChart(tracks: topTracks)),
          const SizedBox(height: 32),

          SectionTitle(text: 'Track Play Count Line Chart'),
          SizedBox(height: isMobile ? 200 : 150, child: TrackPlayCountLineChart(tracks: topTracks, playCounts: playCounts)),
          const SizedBox(height: 32),

          SectionTitle(text: 'Track Play Pie Chart'),
          SizedBox(height: isMobile ? 220 : 180, child: TrackPlayPieChart(tracks: topTracks, playCounts: playCounts)),
        ],
      ),
    );
  }
}
