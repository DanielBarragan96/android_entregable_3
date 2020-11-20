import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:entregable_2/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

class Users {
  final LatLng coord;
  final String firstname;
  final String lastname;

  Users(
    {
      @required this.coord,
      @required this.firstname,
      @required this.lastname
    }
  );
}

List<LatLng> _coords = [
  LatLng(20.659684585453792, -103.45644380897282),
  LatLng(20.58794293024975,  -103.41349761933088),
  LatLng(20.709674113035824, -103.38253621011972),
  LatLng(20.6232340206758,   -103.32710534334183),
  LatLng(20.703134533765034, -103.29913996160033)  
];

final List<Users> _usersList = [
  Users(
    coord: _coords[0],
    firstname: 'Juan',
    lastname: 'Perez',
  ),
  Users(
    coord: _coords[1],
    firstname: 'Juan',
    lastname: 'Colorado',
  ),
  Users(
    coord: _coords[2],
    firstname: 'Juan',
    lastname: 'Escutia',
  ),
  Users(
    coord: _coords[3],
    firstname: 'Juan',
    lastname: 'Lopez',
  ),  
  Users(
    coord: _coords[4],
    firstname: 'Juan',
    lastname: 'De la Barrera',
  ),         
];

Set<Marker> _mapMarkers = {
  Marker(
    markerId: MarkerId(_coords[0].toString()),
    position: _coords[0],
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: InfoWindow(
      title: _coords[0].toString(),
      //snippet: _getGeolocationAddress(Position(latitude: _coords[0].latitude, longitude: _coords[0].longitude)),
    ),
    onTap: () {},
  ),
  Marker(
    markerId: MarkerId(_coords[1].toString()),
    position: _coords[1],
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: InfoWindow(
      title: _coords[1].toString(),
      //snippet: _getGeolocationAddress(Position(latitude: _coords[0].latitude, longitude: _coords[0].longitude)),
    ),
    onTap: () {},
  ), 
   Marker(
    markerId: MarkerId(_coords[2].toString()),
    position: _coords[2],
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: InfoWindow(
      title: _coords[2].toString(),
      //snippet: _getGeolocationAddress(Position(latitude: _coords[0].latitude, longitude: _coords[0].longitude)),
    ),
    onTap: () {},
  ), 
   Marker(
    markerId: MarkerId(_coords[3].toString()),
    position: _coords[3],
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: InfoWindow(
      title: _coords[3].toString(),
      //snippet: _getGeolocationAddress(Position(latitude: _coords[0].latitude, longitude: _coords[0].longitude)),
    ),
    onTap: () {},
  ),
   Marker(
    markerId: MarkerId(_coords[4].toString()),
    position: _coords[4],
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    infoWindow: InfoWindow(
      title: _coords[4].toString(),
      //snippet: _getGeolocationAddress(Position(latitude: _coords[0].latitude, longitude: _coords[0].longitude)),
    ),
    onTap: () {},
  ),         
};

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
  Position _currentPosition;
  int _user_index = 0;
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
                    child: Icon(Icons.people),
                    onPressed: (){
                      _showUserCard(context,_usersList[_user_index]);
                    },
                  ),
                  SizedBox(height: 30),                  
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
    // add marker
    setState(() {
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(coord.toString()),
          position: coord,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: coord.toString(),
            //snippet: _markerAddress,
          ),
          consumeTapEvents: true,
          onTap: () async {

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

  void _showUserCard(BuildContext context, Users user) async {

    String address = await _getGeolocationAddress(
      Position(latitude: user.coord.latitude, longitude: user.coord.longitude),
    );

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            user.coord.latitude,
            user.coord.longitude,
          ),
          zoom: 15.0,
        ),
      ),
    );

    await showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
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
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 120),
                    child: Placeholder(
                      color: Colors.purple,
                      fallbackHeight: 128,
                      fallbackWidth: 32,
                    ),
                  ),                        
                  Text(
                    "${user.firstname} " + "${user.lastname}",
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
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        iconSize: 50,
                        icon: Icon(Icons.favorite,color:Colors.red),
                        onPressed: null
                      ),   
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        iconSize: 50,
                        icon: Icon(Icons.format_list_bulleted,color:Colors.purple),
                        onPressed: null
                      ),                         
                      SizedBox(
                        width: 20,
                      ),                                                                   
                      IconButton(
                        iconSize: 50,
                        icon: Icon(Icons.fast_forward,color:Colors.purple),
                        onPressed: (){
                          Navigator.of(context).pop();
                          setState((){                            
                            _user_index++;
                            if(_user_index == _usersList.length-1){
                              _user_index = 0;
                            }
                          });
                          _showUserCard(context,_usersList[_user_index]);
                        }
                      ),                   
                    ],
                  ),                        
                ],
              ),
            ),
          );
        }  
      ),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
    );    
  } 
}

