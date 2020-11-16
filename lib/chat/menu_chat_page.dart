import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:entregable_2/home/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget menuChatPage(HomeBloc _bloc, BuildContext context) {
  List<Map<String, dynamic>> _data = [];
  //   {
  //     "picture": "https://randomuser.me/api/portraits/men/0.jpg",
  //     "name": "Juan Perez",
  //   },
  //   {
  //     "picture": "https://randomuser.me/api/portraits/men/1.jpg",
  //     "name": "Juan Perez 2",
  //   },
  //   {
  //     "picture": "https://randomuser.me/api/portraits/men/2.jpg",
  //     "name": "Juan Perez 3",
  //   },
  //   {
  //     "picture": "https://randomuser.me/api/portraits/men/3.jpg",
  //     "name": "Juan Perez 4",
  //   },
  // ];

  User _user = FirebaseAuth.instance.currentUser;
  DatabaseReference _firebaseDatabase = FirebaseDatabase.instance
      .reference()
      .child("profiles/${_user.uid}/chats/");

  _firebaseDatabase.once().then((dataSnapShot) {
    Map chats = dataSnapShot.value;
    chats.forEach((key, value) {
      // print(key);
      _data.add({"picture": "", "name": "${key.toString()}"});
    });
  });

  return Scaffold(
    backgroundColor: kBlack,
    drawer: DrawerWidget(),
    appBar: AppBar(
      title: Text("Chat"),
    ),
    body: BlocProvider(
      create: (context) {
        return _bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        cubit: _bloc,
        builder: (context, state) {
          if (state is MenuChatState) {
            return Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: kLightPurple,
                    ),
                    itemCount: _data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _bloc.add(
                              SingleChatEvent(userName: _data[index]["name"]));
                        },
                        child: ListTile(
                          leading: Image.network(_data[index]["picture"]),
                          title: Text(
                            "${_data[index]["name"]}",
                            style: TextStyle(color: kWhite),
                          ),
                        ),
                      );
                    },
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
                onPressed: () {},
                iconSize: 25.0,
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
