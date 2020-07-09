import 'package:flutter/material.dart';

class FriendListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;

  const FriendListAppBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    Widget appBarButton() {
      return FlatButton(
        onPressed: () => onTap(),
        color: Theme.of(context).accentColor,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Row(
          children: <Widget>[
            Icon(Icons.add,
                size: 20, color: darkModeOn ? Colors.white : Colors.black),
            SizedBox(
              width: 2,
            ),
            Text(
              "Add",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: darkModeOn ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
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
                    "Friends",
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
