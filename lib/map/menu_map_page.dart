import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:entregable_2/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

class MapPage extends StatefulWidget {
  final HomeBloc bloc;
  final BuildContext context;

  MapPage({
    Key key,
    @required this.bloc,
    @required this.context
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _mapController;
  Set<Marker> _mapMarkers = Set();
  Marker _currentPositionMarker;
  Position _currentPosition;
  final LatLng _center = const LatLng(20.608160, -103.414496);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Stack(
        children: <Widget>[
          //SizedBox(height: 20),
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _mapMarkers,
            onLongPress: _setMarker,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: kLightPurple,
                    child: Icon(Icons.location_pin),
                    onPressed: (){
                      _getCurrentPosition(context);
                    },
                  ),
                  SizedBox(height: 30),
                  FloatingActionButton(
                    backgroundColor: kLightPurple,
                    child: Icon(Icons.share),
                    onPressed: () {
                      Share.share(
                        "$_currentPosition",
                        subject: "Aqui me encuentro",
                      );
                    },
                  ),                  
                ],
              ),
            ),
          ),          
        ],
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
                    widget.bloc.add(MenuStatsEvent());
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
                    widget.bloc.add(MenuChatEvent());
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

  Future<void> _getCurrentPosition(BuildContext context) async {
    // get current position
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    // get address
    String _currentAddress = await _getGeolocationAddress(_currentPosition);

    LatLng coord = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    // add marker
    _mapMarkers.add(
      Marker(
        markerId: MarkerId(_currentPosition.toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        position: LatLng(
          _currentPosition.latitude,
          _currentPosition.longitude,
        ),
        infoWindow: InfoWindow(
          title: _currentPosition.toString(),
          snippet: _currentAddress,
        ),
        consumeTapEvents: true,
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setModalState) =>
                  _bottomSheet(context,setModalState,coord,_currentAddress),
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          );
        },        
      ),
    );

    // move camera
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _setMarker(LatLng coord) async {
    // get address
    String _markerAddress = await _getGeolocationAddress(
      Position(latitude: coord.latitude, longitude: coord.longitude),
    );
    // add marker
    setState(() {
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(coord.toString()),
          position: coord,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: coord.toString(),
            snippet: _markerAddress,
          ),
          consumeTapEvents: true,
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setModalState) =>
                    _bottomSheet(context,setModalState,coord,_markerAddress),
              ),
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
            );
          },
        ),
      );
      //polygonLatLngs.add(coord);
    });
  }

  Future<String> _getGeolocationAddress(Position position) async {
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      return "${place.thoroughfare}, ${place.locality}";
    }
    return "No address availabe";
  }

  Widget _bottomSheet(BuildContext context,StateSetter setModalState,LatLng coord,String address) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 70),
              child: Placeholder(
                color: Colors.purple,
                fallbackHeight: 256,
                //fallbackWidth: 32,
              ),
            ),                        
            Text(
              "Nombre Apellido",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),            
            SizedBox(
              height: 10,
            ),                        
            Text(
              address,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              coord.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              )
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.fast_rewind,color:Colors.purple),
                  onPressed: null
                ),                   
                SizedBox(
                  width: 40,
                ),                  
                IconButton(
                  iconSize: 100,
                  icon: Icon(Icons.favorite,color:Colors.red),
                  onPressed: null
                ),              
              ],
            ),                        
          ],
        ),
      ),
    );
  } 
}

