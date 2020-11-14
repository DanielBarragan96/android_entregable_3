import 'package:entregable_2/colors.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PROFILE_TITLE"),
        ),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: CircleAvatar(
                      backgroundColor: kMainPurple,
                      minRadius: 40,
                      maxRadius: 80,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "PROFILE_NAME",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("PROFILE_EMAIL"),
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text("PROFILE_SETTINGS"),
                    leading: Icon(Icons.settings),
                    onTap: () {},
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Log out"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
