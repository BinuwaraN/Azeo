import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/chat_screens/chat_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/chat_methods.dart';
import 'package:azeo/widgets/shimmer_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'last_message_container.dart';

class ChatListView extends StatelessWidget {
  final Friend friend;
  final AuthMethods _authMethods = AuthMethods();

  ChatListView(this.friend);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authMethods.getUserDetailsById(friend.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ChatListTile(
            friend: user,
          );
        }
        return Center(
          child: ShimmerTile(),
        );
      },
    );
  }
}

class ChatListTile extends StatelessWidget {
  final User friend;
  final ChatMethods _chatMethods = ChatMethods();

  ChatListTile({
    @required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    receiver: friend,
                  ))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(friend.profilePhoto),
                    maxRadius: 30,
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
                            friend.name,
                            style: TextStyle(
                                color: darkModeOn ? Colors.white : Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          LastMessageContainer(
                            stream: _chatMethods.fetchLastMessageBetween(
                                senderId: userProvider.getUser.uid,
                                receiverId: friend.uid),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
