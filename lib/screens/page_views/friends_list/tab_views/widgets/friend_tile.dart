import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:azeo/widgets/shimmer_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatelessWidget {
  final Friend friend;
  final User currentUser;

  const FriendTile({this.friend, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();
    final FriendMethods _friendMethods = FriendMethods();

    return FutureBuilder(
        future: _authMethods.getUserDetailsById(friend.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TileView(
              user: snapshot.data,
              cancel: () =>
                  _friendMethods.removeFriend(currentUser.uid, friend.uid),
              accept: () =>
                  _friendMethods.acceptFriend(currentUser.uid, friend.uid),
              isSender: friend.isSender,
              isAccepted: friend.isAccepted,
            );
          }

          return ShimmerTile();
        });
  }
}

class TileView extends StatelessWidget {
  final User user;
  final Function cancel;
  final Function accept;
  final bool isSender;
  final bool isAccepted;

  const TileView(
      {this.user, this.cancel, this.accept, this.isSender, this.isAccepted});

  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePhoto),
                  maxRadius: 28,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                isSender || isAccepted
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(Icons.check), onPressed: () => accept()),
                IconButton(icon: Icon(Icons.close), onPressed: () => cancel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
