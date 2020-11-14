import 'package:charts_flutter/flutter.dart' as charts;
import 'package:entregable_2/stats/stats_series.dart';
import 'package:flutter/material.dart';

class SongsChart extends StatelessWidget {
  final List<SongsSeries> data;

  SongsChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SongsSeries,String>> series = [
      charts.Series(
        id: "Songs",
        data: data,
        domainFn: (SongsSeries series, _) => series.day,
        measureFn: (SongsSeries series, _) => series.songs,
        colorFn: (SongsSeries series, _) => series.barColor,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("Songs per day"),
            Expanded(
              child: charts.BarChart(series,animate:true),
            ),
          ],
        ),
      ),
    );
  }
}