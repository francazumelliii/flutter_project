import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_project/core/data/domain/models/chart_data.dart';

import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../data/domain/models/audio_track.dart';

class BarChartWidget extends StatelessWidget {
  final List<AudioTrack> tracks;
  const BarChartWidget({required this.tracks, super.key});

  @override
  Widget build(BuildContext context) {
    final data = tracks.map((track) => ChartData(track.title, track.albumId)).toList();

    final series = [
      charts.Series<ChartData, String>(
        id: 'Popularity',
        domainFn: (data, _) => data.title,
        measureFn: (data, _) => data.value,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        data: data,
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: true,
      domainAxis: const charts.OrdinalAxisSpec(renderSpec: charts.SmallTickRendererSpec(
        labelStyle: charts.TextStyleSpec(fontSize: 10, color: charts.MaterialPalette.white),
      )),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(color: charts.MaterialPalette.white),
        ),
      ),
    );
  }
}

