import 'package:charts_flutter/flutter.dart' as charts;
import 'package:entregable_2/stats/stats_series.dart';
import 'package:flutter/material.dart';

class AlbumesChart extends StatelessWidget {
  final List<AlbumesSeries> data;

  AlbumesChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AlbumesSeries,String>> series = [
      charts.Series(
        id: "Albumes",
        data: data,
        domainFn: (AlbumesSeries series, _) => series.day,
        measureFn: (AlbumesSeries series, _) => series.albumes,
        colorFn: (AlbumesSeries series, _) => series.barColor,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("Albumes per day"),
            Expanded(
              child: charts.BarChart(series,animate:true),
            ),
          ],
        ),
      ),
    );
  }
}