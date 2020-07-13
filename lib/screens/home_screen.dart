import 'package:azeo/enum/user_state.dart';
import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/page_views/gruop_list/gruop_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'page_views/chat_list/chat_list_screen.dart';
import 'page_views/friends_list/friends_list_screen.dart';
import 'page_views/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;

  final AuthMethods _authMethods = AuthMethods();

  UserProvider userProvider;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();

      if (userProvider.getUser != null && userProvider != null) {
        _authMethods.setUserState(
          userId: userProvider.getUser.uid,
          userState: UserState.Online,
        );
      }
    });

    pageController = PageController();

    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: <Widget>[
            ChatListScreen(),
            GruopScreen(),
            FriendsListScreen(),
            ProfileScreen(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: bottomNavBar());
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedItemColor: Colors.grey.shade400,
      currentIndex: _page,
      onTap: navigationTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text("Chats"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          title: Text("Groups"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_add),
          title: Text("Friends"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text("Profile"),
        ),
      ],
    );
  }
}
