import 'package:flutter/material.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Stack(
        children: <Widget>[],
      ),
    );
  }
}
