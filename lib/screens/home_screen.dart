import 'package:azeo/screens/welcome_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();

    return Scaffold(
        body: Center(
      child: FlatButton(
        onPressed: () async {
          final bool isLoggedOut = await _authMethods.signOut();
          if (isLoggedOut) {
            
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
        },
        child: Text('Sign Out'),
      ),
    ));
  }
}
