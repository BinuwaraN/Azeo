import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/pageviews/friends_list/widgets/friend_list_app_bar.dart';
import 'package:azeo/screens/pageviews/friends_list/widgets/friend_pending_view.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:azeo/services/friend_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/add_friend_dialog.dart';

class FriendsListScreen extends StatefulWidget {
  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> litems = [];
  final FriendMethods _friendMethods = FriendMethods();
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController _addFriendController;
  List<Tab> tabList = List();

  bool isAddFriendPressed = false;
  bool darkModeOn;

  @override
  void initState() {
    super.initState();
    tabList.add(Tab(
      text: 'Online',
    ));
    tabList.add(Tab(
      text: 'All',
    ));
    tabList.add(Tab(
      text: 'Pending',
    ));
    tabList.add(Tab(
      text: 'Blocked',
    ));
    _tabController = TabController(length: tabList.length, vsync: this);
    _addFriendController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    darkModeOn = brightness == Brightness.dark ? true : false;

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
              children: [online(), all(), pending(), blocked()],
            ),
          ),
        ],
      ),
    );
  }

  Widget online() {
    return Center(child: Text('Online'));
  }

  Widget all() {
    return Center(child: Text('All'));
  }

  Widget pending() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    User currentUser = userProvider.getUser;

    return Container(
      child: StreamBuilder(
        stream: _friendMethods.getAllPendingUsers(currentUser.uid, true),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var docList = snapshot.data.documents;

            if (docList.isEmpty) {
              return Center(child: Text('Empty'));
            }

            return ListView.builder(
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Friend _friend = Friend.fromMap(docList[index].data);

                  return FriendPendingView(
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
        print(user.name);
        DocumentSnapshot friendDoc = await _friendMethods.getFriendFromUserDb(
            userProvider.getUser.uid, user.uid);

        if (friendDoc.exists) {
          print(friendDoc.documentID);
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
}
