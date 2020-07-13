import 'package:azeo/models/friend.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/page_views/chat_list/widgets/chat_list_search.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/chat_list_app_bar.dart';
import 'widgets/chat_list_friend_tile.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatListAppBar(onTap: () => {}),
      body: Column(
        children: <Widget>[
          ChatListSearch(),
          Expanded(child: ChatListContainer()),
        ],
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final FriendMethods _friendMethods = FriendMethods();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder(
          stream: _friendMethods.fetchFriends(
              currentUserId: userProvider.getUser?.uid, isAccepted: true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return Center(child: Text('Empty'));
              }

              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Friend contact = Friend.fromMap(docList[index].data);

                  return ChatListView(contact);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
