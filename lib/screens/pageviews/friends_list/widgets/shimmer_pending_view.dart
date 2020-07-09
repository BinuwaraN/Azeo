import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPendingFriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark ? true : false;

    return Shimmer.fromColors(
      baseColor: darkModeOn ? Colors.grey[900] : Colors.grey[800],
      highlightColor: darkModeOn ? Colors.grey[800] : Colors.grey[900],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 240.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
