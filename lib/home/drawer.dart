import 'package:entregable_2/auth/user_auth_provider.dart';
import 'package:entregable_2/colors.dart';
import 'package:entregable_2/login/bloc/login_bloc.dart';
import 'package:entregable_2/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final LoginBloc loginBloc;

  DrawerWidget({Key key, this.loginBloc}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User _user;

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: (_user.photoURL != "" && _user.photoURL != null)
                        ? Image.network(
                            _user.photoURL,
                            alignment: Alignment.center,
                            fit: BoxFit.scaleDown,
                            height: 80,
                          )
                        : CircleAvatar(
                            backgroundColor: kMainPurple,
                            minRadius: 40,
                            maxRadius: 80,
                          ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${_user.displayName ?? ""}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("${_user.email}"),
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text("Ajustes"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      if (widget.loginBloc != null) {
                        widget.loginBloc.add(LogoutWithGoogleEvent());
                        return LoginPage();
                      }
                    },
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
                        onPressed: () {
                          widget.loginBloc.add(LogoutWithGoogleEvent());
                        },
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
