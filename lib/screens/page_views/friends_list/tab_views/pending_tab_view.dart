import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:azeo/widgets/quiet_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/friend_tile.dart';

class PendingTabView extends StatelessWidget {
  final FriendMethods _friendMethods = FriendMethods();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User currentUser = userProvider.getUser;

    return Container(
      child: StreamBuilder(
        stream: _friendMethods.fetchFriends(currentUser.uid, false),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var docList = snapshot.data.documents;

            if (docList.isEmpty) {
              return SingleChildScrollView(
                child: QuietBox(
                  imagePath:
                      'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1a9a4862-df68-40bf-8628-7cb3dfe0103c/dd6kejv-3cd2eb4e-7d3d-47c9-8e98-fba229216e88.png/v1/fill/w_400,h_400,strp/wumpus_by_inklessrambles_dd6kejv-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD00MDAiLCJwYXRoIjoiXC9mXC8xYTlhNDg2Mi1kZjY4LTQwYmYtODYyOC03Y2IzZGZlMDEwM2NcL2RkNmtlanYtM2NkMmViNGUtN2QzZC00N2M5LThlOTgtZmJhMjI5MjE2ZTg4LnBuZyIsIndpZHRoIjoiPD00MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.Is5Ov-0rWzw6sbopQQZ0IKDjv3YFJIqLPW7BOyrj2Vo',
                  text:
                      'There are no pending friend requests. Here\'s Wumpus for now',
                ),
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
