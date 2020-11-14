import 'package:entregable_2/chat/menu_chat_page.dart';
import 'package:entregable_2/chat/single_chat_page.dart';
import 'package:entregable_2/colors.dart';
import 'package:entregable_2/map/menu_map_page.dart';
import 'package:entregable_2/stats/menu_stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: BlocProvider(
        create: (context) {
          _bloc = HomeBloc();
          return _bloc;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is MenuStatsState) {
              return menuStatsPage(_bloc, context);
            }
            if (state is MenuMapState) {
              return menuMapPage(_bloc, context);
            }
            if (state is MenuChatState) {
              return menuChatPage(_bloc, context);
            }
            if (state is SingleChatState) {
              return singleChatPage(_bloc, context, state.userName);
            } else
              return Center();
          },
        ),
      ),
    );
  }
}
