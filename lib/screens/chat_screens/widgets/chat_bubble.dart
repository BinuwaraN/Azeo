import 'package:azeo/models/message.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  final Message chatMessage;

  ChatBubble({@required this.chatMessage});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    User currentUser = userProvider.getUser;
    print(currentUser.uid);
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.senderId == currentUser.uid
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.senderId == currentUser.uid
                ? Theme.of(context).accentColor
                : Colors.grey),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            widget.chatMessage.message,
            style: TextStyle(color: darkModeOn ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
