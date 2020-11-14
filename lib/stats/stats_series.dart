import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SongsSeries {
  final String day;
  final int songs;
  final charts.Color barColor;

  SongsSeries(
    {
      @required this.day,
      @required this.songs,
      @required this.barColor  
    }
  );
}

class ArtistsSeries {
  final String day;
  final int artists;
  final charts.Color barColor;

  ArtistsSeries(
    {
      @required this.day,
      @required this.artists,
      @required this.barColor  
    }
  );
}

class AlbumesSeries {
  final String day;
  final int albumes;
  final charts.Color barColor;

  AlbumesSeries(
    {
      @required this.day,
      @required this.albumes,
      @required this.barColor  
    }
  );
}