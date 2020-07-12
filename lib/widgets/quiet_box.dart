import 'package:azeo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuietBox extends StatelessWidget {
  final String imagePath;
  final String text;

  const QuietBox({this.imagePath, this.text});

  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(imagePath, height: 250.0),
          SizedBox(
            height: 20.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: darkModeOn ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
