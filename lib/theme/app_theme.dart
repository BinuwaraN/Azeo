import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xff0081a7),
    accentColor: Color(0xff5dd9c1)
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff0081a7),
    accentColor: Color(0xff5dd9c1),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold)
    )
  );
}
