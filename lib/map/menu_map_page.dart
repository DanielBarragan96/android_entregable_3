import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:entregable_2/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

GoogleMapController mapController;

final LatLng _center = const LatLng(20.608160, -103.414496);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

Widget menuMapPage(HomeBloc _bloc, BuildContext context) {
  return Scaffold(
    backgroundColor: kBlack,
    drawer: DrawerWidget(),
    appBar: AppBar(
      title: Text("Map"),
    ),
    body: BlocProvider(
      create: (context) {
        return _bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        cubit: _bloc,
        builder: (context, state) {
          if (state is MenuMapState) {
            return Stack(
              children: <Widget>[
                //SizedBox(height: 20),
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      backgroundColor: kLightPurple,
                      onPressed: () {
                        Share.share(
                          //"$_currentPosition",
                          "My Location",
                          subject: "Aqui me encuentro",
                        );
                      },
                      child: Icon(Icons.share),
                    ),
                  ),
                ),
              ],
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
                onPressed: () {
                  _bloc.add(MenuStatsEvent());
                },
                iconSize: 25.0,
                color: kLightGray,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                onPressed: () {},
                iconSize: 25.0,
                color: kWhite,
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
