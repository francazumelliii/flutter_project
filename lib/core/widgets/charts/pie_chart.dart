import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/domain/models/audio_track.dart';

class TrackPlayPieChart extends StatelessWidget {
  final List<AudioTrack> tracks;
  final List<int> playCounts;

  const TrackPlayPieChart({required this.tracks, required this.playCounts, super.key});

  @override
  Widget build(BuildContext context) {
    final total = playCounts.fold<int>(0, (sum, val) => sum + val);
    if (total == 0) {
      return const Center(
        child: Text('Nessun dato disponibile', style: TextStyle(color: Colors.white)),
      );
    }

    return PieChart(
      PieChartData(
        sections: List.generate(tracks.length, (index) {
          final percentage = (playCounts[index] / total) * 100;
          return PieChartSectionData(
            value: playCounts[index].toDouble(),
            color: Colors.primaries[index % Colors.primaries.length],
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 55,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }),
        sectionsSpace: 3,
        centerSpaceRadius: 30,
      ),
    );
  }
}
