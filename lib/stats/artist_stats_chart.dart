import 'package:charts_flutter/flutter.dart' as charts;
import 'package:entregable_2/stats/stats_series.dart';
import 'package:flutter/material.dart';

class ArtistsChart extends StatelessWidget {
  final List<ArtistsSeries> data;

  ArtistsChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ArtistsSeries,String>> series = [
      charts.Series(
        id: "Artists",
        data: data,
        domainFn: (ArtistsSeries series, _) => series.day,
        measureFn: (ArtistsSeries series, _) => series.artists,
        colorFn: (ArtistsSeries series, _) => series.barColor,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("Artists per day"),
            Expanded(
              child: charts.BarChart(series,animate:true),
            ),
          ],
        ),
      ),
    );
  }
}