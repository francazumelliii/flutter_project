import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/domain/models/audio_track.dart';

class TrackPlayCountLineChart extends StatelessWidget {
  final List<AudioTrack> tracks;
  final List<int> playCounts;

  const TrackPlayCountLineChart({
    required this.tracks,
    required this.playCounts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final maxPlayCount = playCounts.isEmpty
        ? 10
        : playCounts.reduce((a, b) => a > b ? a : b).toDouble();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxPlayCount + 5,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 50,
              getTitlesWidget: (double value, TitleMeta meta) {
                int i = value.toInt();
                if (i < 0 || i >= tracks.length) return const SizedBox.shrink();

                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    tracks[i].title,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: playCounts
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                .toList(),
            isCurved: true,
            color: Colors.greenAccent,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.greenAccent.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
