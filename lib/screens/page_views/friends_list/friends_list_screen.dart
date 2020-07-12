import 'package:azeo/models/user.dart';
import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab_views/all_tab_view.dart';
import 'tab_views/online_tab_view.dart';
import 'tab_views/pending_tab_view.dart';
import 'widgets/add_friend_dialog.dart';
import 'widgets/friend_list_app_bar.dart';

class FriendsListScreen extends StatefulWidget {
  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen>
    with TickerProviderStateMixin {
  final FriendMethods _friendMethods = FriendMethods();
  final AuthMethods _authMethods = AuthMethods();

  TextEditingController _addFriendController;
  TabController _tabController;

  List<String> litems = [];
  List<Tab> tabList = List();

  bool isAddFriendPressed = false;

  @override
  void initState() {
    super.initState();
    tabList.add(_tab('Online'));
    tabList.add(_tab('All'));
    tabList.add(_tab('Pending'));
    tabList.add(_tab('Blocked'));

    _tabController = TabController(length: tabList.length, vsync: this);
    _addFriendController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FriendListAppBar(
        onTap: () => showDialog(
          context: context,
          builder: (context) => AddFriendDialog(
            onTap: () {
              setState(() {
                isAddFriendPressed = true;
              });
              addFriend(_addFriendController.text);
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _addFriendController.clear());
            },
            controller: _addFriendController,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: tabList,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OnlineTabView(),
                AllTabView(),
                PendingTabView(),
                blocked()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget online() {
    return Center(child: Text('Online'));
  }

  Widget blocked() {
    return Center(child: Text('Blocked'));
  }

  void addFriend(String friendName) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    FirebaseUser currentUser = await _authMethods.getCurrentUser();
    List<User> userList = await _authMethods.fetchAllUsers(currentUser);

    User user = userList.firstWhere((User user) => user.username == friendName,
        orElse: () => null);

    setState(() {
      isAddFriendPressed = false;
    });

    if (friendName != userProvider.getUser.username) {
      if (user != null) {
        DocumentSnapshot friendDoc = await _friendMethods.getFriendFromUserDb(
            userProvider.getUser.uid, user.uid);

        if (friendDoc.exists) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('User is alredy in your friend list')));
        } else {
          await _friendMethods.addFriendToDb(userProvider.getUser, user);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('User is added to contacts!')));
        }
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('User does not exist')));
      }
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Your already friend with you <3')));
    }
  }

  Widget _tab(String text) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: darkModeOn ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
