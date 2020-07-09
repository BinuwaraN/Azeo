import 'package:flutter/material.dart';

class ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;

  const ChatListAppBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    Widget appBarButton() {
      return FlatButton(
        onPressed: () => onTap(),
        // padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        color: Theme.of(context).accentColor,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.black,
              size: 20,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "New",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      // color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Chats",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: darkModeOn ? Colors.white : Colors.black),
                  ),
                  appBarButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}
