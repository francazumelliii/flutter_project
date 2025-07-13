import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/domain/controllers/audio_player_controller.dart';


class TrackPlayPieChart extends StatelessWidget {
  final List<AudioTrack> tracks;
  final List<int> playCounts;

  const TrackPlayPieChart({required this.tracks, required this.playCounts, super.key});

  @override
  Widget build(BuildContext context) {
    final total = playCounts.fold<int>(0, (sum, val) => sum + val);
    if (total == 0) {
      return const Center(child: Text('Nessun dato disponibile', style: TextStyle(color: Colors.white)));
    }

    return PieChart(
      PieChartData(
        sections: tracks.asMap().entries.map((entry) {
          final index = entry.key;
          final percentage = (playCounts[index] / total) * 100;
          return PieChartSectionData(
            value: playCounts[index].toDouble(),
            color: Colors.primaries[index % Colors.primaries.length],
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }
}
