import 'package:azeo/providers/user_provider.dart';
import 'package:azeo/screens/pageviews/chat_list/chat_list_screen.dart';
import 'package:azeo/screens/pageviews/friends_list/friends_list_screen.dart';
import 'package:azeo/screens/welcome_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;

  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.refreshUser();

    pageController = PageController();
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
          Container(child: ChatListScreen()),
          Center(
            child: Text(
              'Gruops',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FriendsListScreen(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    final bool isLoggedOut = await AuthMethods().signOut();

                    if (isLoggedOut) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Text('Log Out'),
                ),
              ],
            ),
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
