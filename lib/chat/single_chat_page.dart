import 'package:entregable_2/colors.dart';
import 'package:entregable_2/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatMessage {
  bool isMe;
  String msgIdentifier;
  String msg;
  DateTime time;

  ChatMessage(
    bool isMe,
    String msgIdentifier,
    String msg,
    DateTime time,
  ) {
    this.isMe = isMe;
    this.msgIdentifier = msgIdentifier;
    this.msg = msg;
    this.time = time;
  }
}

Widget _buildMessage(BuildContext context, ChatMessage message) {
  bool isMe = message.isMe;
  return Container(
    margin: isMe
        ? EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 80.0,
          )
        : EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            right: 80.0,
          ),
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    width: MediaQuery.of(context).size.width * 0.75,
    decoration: BoxDecoration(
      color: isMe ? kMainPurple : kDarkGray,
      borderRadius: isMe
          ? BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            )
          : BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
    ),
    child: Text(
      message.msg,
      style: TextStyle(color: kWhite),
    ),
  );
}

Widget singleChatPage(HomeBloc _bloc, BuildContext context, String userName) {
  List<ChatMessage> _messages = new List<ChatMessage>();
  for (int i = 0; i < 20; i++)
    _messages.add(ChatMessage((i % 2 == 0) ? true : false, "KJHBadskjHBASBasd",
        "Hola ${i + 1}", DateTime(2020, 10, 15)));

  return Scaffold(
    backgroundColor: kBlack,
    appBar: AppBar(
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.chevronLeft),
        onPressed: () {
          _bloc.add(MenuChatEvent());
        },
        iconSize: 20.0,
        color: kWhite,
      ),
      title: Text("$userName"),
    ),
    body: BlocProvider(
      create: (context) {
        return _bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        cubit: _bloc,
        builder: (context, state) {
          if (state is SingleChatState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildMessage(context, _messages[index]);
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
            IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: kWhite,
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {},
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: kWhite,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
