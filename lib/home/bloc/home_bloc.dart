import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:entregable_2/login/bloc/login_bloc.dart';
import 'package:entregable_2/login/login_page.dart';
import 'package:entregable_2/models/artist.dart';
import 'package:entregable_2/models/track.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginBloc loginBloc;
  http.Client _inner = http.Client();
  String SPOTIFY_API_KEY =
      "BQCvudIzR_njq2Fo6Bj_6DmCdMY06duNtk2ioNVAKN6eNPGpNC50-JNbAWHLqZja127kgVpUNZJ5c1itKvVgaBM-XZEDyp3Wc1LT_468f2mQsbbDmWr1ZGnR9Piuhf16umf5OHf9zj3B4v7RWXdupv1pLVZE1WXlehD594Ov1yP92uf_HW-c5g";

  HomeBloc({@required this.loginBloc}) : super(MenuStatsState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ScanPicture) {
      File img = await _chooseImage();
      if (img == null)
        yield Error();
      else {
        String data = "";
        // if (event.barcodeScan)
        //   data = await _barcodeScan(img);
        yield Results(result: data, chosenImage: img);
      }
    } else if (event is MenuStatsEvent) {
      yield MenuStatsState();
    } else if (event is MenuMapEvent) {
      yield MenuMapState();
    } else if (event is MenuChatEvent) {
      yield MenuChatState();
    } else if (event is SingleChatEvent) {
      yield SingleChatState(userName: event.userName);
    } else if (event is LoadSpotifyStatsEvent) {
      // get artists stats
      var responseArtist = await getSpotifyArtistStats();
      // decode json response
      Map<String, dynamic> dataArtist = jsonDecode(responseArtist.body);

      // create top artists list
      List<Artist> topArtists = List();
      for (var artist in dataArtist["items"])
        topArtists.add(Artist(
          artistName: "${artist["name"]}",
        ));
      print(topArtists.toString());

      // get tracks stats
      var responseTrack = await getSpotifyTrackStats();
      // decode json response
      Map<String, dynamic> dataTrack = jsonDecode(responseTrack.body);

      // create top tracks list
      List<Track> topTracks = List();
      for (var track in dataTrack["items"]) {
        topTracks.add(Track(
          trackName: "${track["name"]}",
          artistName: "${track["artists"][0]["name"]}",
          albumName: "${track["album"]["name"]}",
        ));
      }
      print(topTracks.toString());
    }
  }

  // Future<String> _barcodeScan(File imageFile) async {
  //   var visionImage = FirebaseVisionImage.fromFile(imageFile);
  //   var barcode = FirebaseVision.instance.barcodeDetector();
  //   List<Barcode> codes = await barcode.detectInImage(visionImage);

  //   String data = "";
  //   for (var item in codes) {
  //     var code = item.rawValue;
  //     var type = item.valueType;
  //     var boundBox = item.boundingBox;
  //     var corners = item.cornerPoints;
  //     var url = item.url;

  //     data += '''
  //     > Codigo $code\n
  //     > Formato: $type\n
  //     > URL titulo: ${url == null ? "No disponible" : url.title}\n
  //     > URL: ${url == null ? "No disponible" : url}\n
  //     > Area de cod: $boundBox\n
  //     > Esquinas: $corners\n
  //     -----------------\n
  //     ''';
  //   }
  //   return data;
  // }

  Future<File> _chooseImage() async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chooseImage.path);
  }

  Widget logout() {
    this.loginBloc.add(LogoutWithGoogleEvent());
    return LoginPage();
  }

  Future<http.Response> getSpotifyArtistStats() async {
    String url = "https://api.spotify.com/v1/me/top/artists";

    return http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $SPOTIFY_API_KEY',
    });
  }

  Future<http.Response> getSpotifyTrackStats() async {
    String url = "https://api.spotify.com/v1/me/top/tracks";

    return http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $SPOTIFY_API_KEY',
    });
  }
}
