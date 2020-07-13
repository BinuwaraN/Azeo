import 'package:azeo/models/message.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/screens/chat_screens/widgets/chat_app_bar.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/chat_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> chatMessage = [
    Message(message: "Test123", senderId: 'cwYOMLobWJMP5hhCGo7CVmzqTgJ2'),
    Message(
        message: 'test test test test',
        senderId: '5gYrbZI3QWhUb50ixg8m7fHul383'),
    Message(message: "hiiiiiiii", senderId: 'cwYOMLobWJMP5hhCGo7CVmzqTgJ2'),
    Message(message: "shut up", senderId: '5gYrbZI3QWhUb50ixg8m7fHul383'),
    Message(message: "12345678", senderId: 'cwYOMLobWJMP5hhCGo7CVmzqTgJ2'),
  ];

  TextEditingController textFieldController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();

  ScrollController _listScrollController = ScrollController();

  final ChatMethods _chatMethods = ChatMethods();
  final AuthMethods _authMethods = AuthMethods();

  User sender;

  String _currentUserId;
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      _currentUserId = user.uid;

      setState(() {
        sender = User(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoUrl,
        );
      });
    });
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  void showModal() {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        builder: (context) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  height: 4,
                  width: 50,
                  color: Colors.grey.shade200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ListView(children: <Widget>[
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 20,
                      ),
                    ),
                    title: Text('Media'),
                  ),
                ]),
              )
            ],
          );
        });
  }

  sendMessage() {
    var text = textFieldController.text;

    Message _message = Message(
      receiverId: widget.receiver.uid,
      senderId: sender.uid,
      message: text,
      timestamp: Timestamp.now(),
      type: 'text',
    );

    setState(() {
      isWriting = false;
    });

    textFieldController.text = "";

    _chatMethods.addMessageToDb(_message, sender, widget.receiver);
  }

  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Scaffold(
      appBar: ChatAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMessage.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatBubble(
                chatMessage: chatMessage[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              color: darkModeOn ? Colors.black : Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30, bottom: 50),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
