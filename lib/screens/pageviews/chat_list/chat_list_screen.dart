import 'package:azeo/screens/pageviews/chat_list/widgets/chat_list_search.dart';
import 'package:azeo/screens/pageviews/chat_list/widgets/contact_view.dart';
import 'package:flutter/material.dart';

import 'widgets/chat_list_app_bar.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool isAddFriendPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatListAppBar(onTap: () => {}),
        body: isAddFriendPressed
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ChatListSearch(),
                    SizedBox(height: 12.0),
                    ChatListContainer(),
                  ],
                ),
              ));
  }
}

class ChatListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ContactView(),
        ContactView(),
        ContactView(),
        ContactView(),
      ],
    );
  }
}
