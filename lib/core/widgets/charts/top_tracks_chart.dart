import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/domain/controllers/audio_player_controller.dart';

class TopTracksBarChart extends StatelessWidget {
  final List<AudioTrack> tracks;

  const TopTracksBarChart({required this.tracks, super.key});

  @override
  Widget build(BuildContext context) {
    final topTracks = tracks.take(5).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                int i = value.toInt();
                if (i >= 0 && i < topTracks.length) {
                  return Text(
                    topTracks[i].title,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return const SizedBox();
              },
              reservedSize: 50,
              interval: 1,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true),
        barGroups: topTracks.asMap().entries.map((entry) {
          final index = entry.key;
          final value = 10 - index.toDouble();
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: Colors.greenAccent,
                width: 16,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
