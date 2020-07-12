import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:azeo/widgets/quiet_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/friend_tile.dart';

class AllTabView extends StatelessWidget {
  final FriendMethods _friendMethods = FriendMethods();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    User currentUser = userProvider.getUser;

    return Container(
      child: StreamBuilder(
        stream: _friendMethods.fetchFriends(currentUser.uid, true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var docList = snapshot.data.documents;

            if (docList.isEmpty) {
              return QuietBox(
                imagePath:
                    'https://pics.me.me/making-friends-in-real-life-making-friends-online-how-old-41516462.png',
                text: 'You don\'t have any friends. You don\'t have to though!',
              );
            }

            return ListView.builder(
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Friend _friend = Friend.fromMap(docList[index].data);

                  return FriendTile(
                    friend: _friend,
                    currentUser: currentUser,
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
