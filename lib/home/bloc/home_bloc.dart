import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(MenuStatsState());

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
        // else
        //   data = await _imgLabeling(img);
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
}
