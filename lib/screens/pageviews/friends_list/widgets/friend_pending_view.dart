import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/screens/pageviews/friends_list/widgets/shimmer_pending_view.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:flutter/material.dart';

class FriendPendingView extends StatelessWidget {
  final Friend friend;
  final User currentUser;

  const FriendPendingView({this.friend, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();
    final FriendMethods _friendMethods = FriendMethods();

    return FutureBuilder(
        future: _authMethods.getUserDetailsById(friend.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FriendPendingTile(
              user: snapshot.data,
              cancel: () =>
                  _friendMethods.removeFriend(currentUser.uid, friend.uid),
              accept: () =>
                  _friendMethods.acceptFriend(currentUser.uid, friend.uid),
              isSender: friend.isSender,
            );
          }

          return ShimmerPendingFriend();
        });
  }
}

class FriendPendingTile extends StatelessWidget {
  final User user;
  final Function cancel;
  final Function accept;
  final bool isSender;

  const FriendPendingTile({this.user, this.cancel, this.accept, this.isSender});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark ? true : false;

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
                isSender
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
