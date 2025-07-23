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
                final i = value.toInt();
                if (i < 0 || i >= tracks.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    tracks[i].title,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: maxPlayCount / 4,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: playCounts
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.green],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.greenAccent.withOpacity(0.3), Colors.green.withOpacity(0.05)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
