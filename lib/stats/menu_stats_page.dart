import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:entregable_2/home/drawer.dart';
import 'package:entregable_2/stats/albumes_stats_chart.dart';
import 'package:entregable_2/stats/artist_stats_chart.dart';
import 'package:entregable_2/stats/song_stats_chart.dart';
import 'package:entregable_2/stats/stats_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final List<SongsSeries> songs_data = [
  SongsSeries(
      day: "Mon",
      songs: 60,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Tue",
      songs: 50,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Wed",
      songs: 40,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Thu",
      songs: 50,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Fri",
      songs: 70,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Sut",
      songs: 80,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  SongsSeries(
      day: "Sun",
      songs: 30,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
];

final List<ArtistsSeries> artists_data = [
  ArtistsSeries(
      day: "Mon",
      artists: 30,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Tue",
      artists: 25,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Wed",
      artists: 20,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Thu",
      artists: 25,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Fri",
      artists: 35,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Sut",
      artists: 40,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  ArtistsSeries(
      day: "Sun",
      artists: 15,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
];

final List<AlbumesSeries> albumes_data = [
  AlbumesSeries(
      day: "Mon",
      albumes: 45,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Tue",
      albumes: 30,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Wed",
      albumes: 30,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Thu",
      albumes: 30,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Fri",
      albumes: 45,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Sut",
      albumes: 60,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
  AlbumesSeries(
      day: "Sun",
      albumes: 20,
      barColor: charts.ColorUtil.fromDartColor(kLightestPurple)),
];

enum StatsType { SONGS, ARTISTS, ALBUMES }
StatsType stats_type = StatsType.SONGS;

Widget _getChart(StatsType type) {
  var chart;

  if (type == StatsType.SONGS) {
    chart = SongsChart(data: songs_data);
  } else if (type == StatsType.ARTISTS) {
    chart = ArtistsChart(data: artists_data);
  } else {
    chart = AlbumesChart(data: albumes_data);
  }

  return chart;
}

Widget menuStatsPage(HomeBloc _bloc, BuildContext context) {
  return Scaffold(
    backgroundColor: kBlack,
    drawer: DrawerWidget(),
    appBar: AppBar(
      title: Text("Stats"),
    ),
    body: BlocProvider(
      create: (context) {
        return _bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        cubit: _bloc,
        builder: (context, state) {
          if (state is MenuStatsState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        child: _getChart(stats_type),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(width: 10),
                      ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: RaisedButton(
                          textColor: kWhite,
                          color: kLightestPurple,
                          child: Text(
                            'SONGS\nPER\nDAY',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            stats_type = StatsType.SONGS;
                          },
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: RaisedButton(
                          textColor: kWhite,
                          color: kLightestPurple,
                          child: Text(
                            'ARTISTS\nPER\nDAY',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            stats_type = StatsType.ARTISTS;
                          },
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: RaisedButton(
                          textColor: kWhite,
                          color: kLightestPurple,
                          child: Text(
                            'ALBUMES\nPER\nDAY',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            stats_type = StatsType.ALBUMES;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            );
          } else
            return Center();
        },
      ),
    ),
    bottomNavigationBar: SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      child: Container(
        color: kMainPurple,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.spotify),
                onPressed: () {},
                iconSize: 25.0,
                color: kWhite,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                onPressed: () {
                  _bloc.add(MenuMapEvent());
                },
                iconSize: 25.0,
                color: kLightGray,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.users),
                onPressed: () {
                  _bloc.add(MenuChatEvent());
                },
                iconSize: 25.0,
                color: kLightGray,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
