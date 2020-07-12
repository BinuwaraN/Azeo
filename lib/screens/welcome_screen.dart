import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height,
      width: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome To Azeo',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/chat.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            _welcomeButton(size, context),
          ],
        ),
      ),
    ));
  }

  Widget _welcomeButton(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          ),
          child: Text(
            'START',
          ),
        ),
      ),
    );
  }
}
