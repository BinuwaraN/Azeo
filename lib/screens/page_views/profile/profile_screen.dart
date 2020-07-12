import 'package:azeo/providers/theme_provider.dart';
import 'package:azeo/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () async {
            final bool isLoggedOut = await AuthMethods().signOut();

            if (isLoggedOut) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false);
            }
          },
          child: Text('Log Out'),
        ),
        Switch(
            value: darkModeOn,
            onChanged: (boolVal) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(boolVal);
            })
      ],
    );
  }
}
