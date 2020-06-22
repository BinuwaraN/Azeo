import 'package:azeo/screens/home_screen.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        alignment: Alignment.center,
        child: isLoginPressed
            ? Center(
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/svg/login.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    _signInButton(),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
      ),
    );
  }

  void performLogin() async {
    setState(() {
      isLoginPressed = true;
    });
    FirebaseUser user = await _authMethods.signIn();
    if (user != null) {
      print('Performing Login');
      authenticateUser(user);
    } else {
      print('There was an error');
    }
  }

  void authenticateUser(FirebaseUser user) async {
    bool isNewUser = await _authMethods.authenticateUser(user);

    if (isNewUser) {
      // _authMethods.addDataToDb(user).then((value) async {
      //   await Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) {
      //     return HomeScreen();
      //   }), (Route<dynamic> route) => false);

      //   setState(() {
      //     isLoginPressed = false;
      //   });
      // });

      await _authMethods.addDataToDb(user);

      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (Route<dynamic> route) => false);

      setState(() {
        isLoginPressed = false;
      });
    } else {
      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (Route<dynamic> route) => false);

      setState(() {
        isLoginPressed = false;
      });
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () => performLogin(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
