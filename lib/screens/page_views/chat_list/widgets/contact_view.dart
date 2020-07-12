import 'package:azeo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool darkModeOn =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://miro.medium.com/max/1000/0*kBHpKva09AsGj7RQ'),
                  maxRadius: 30,
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
                        Text(
                          'HackerMan',
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Test 213124',
                          style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black),
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
    );
  }
}

// class ViewLayout extends StatelessWidget {
//   final GestureTapCallback onTap;

//   ViewLayout({@required this.onTap});

//   Widget customTile() {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   CircleAvatar(
//                     //
//                     backgroundImage: NetworkImage(
//                         'https://i2.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'),
//                     maxRadius: 30,
//                   ),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   Expanded(
//                     child: Container(
//                       color: Colors.transparent,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           //
//                           Text('Text 1'),
//                           SizedBox(
//                             height: 6,
//                           ),
//                           //
//                           Text(
//                             'Text 2',
//                             style: TextStyle(
//                                 fontSize: 14, color: Colors.grey.shade500),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               'Time',
//               style: TextStyle(
//                 fontSize: 12,
//                 //color: widget.isMessageRead ? Colors.pink: Colors.grey.shade500),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         customTile(),
//       ],
//     );
//   }
// }
