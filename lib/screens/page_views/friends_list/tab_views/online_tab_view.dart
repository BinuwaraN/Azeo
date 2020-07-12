import 'package:azeo/widgets/quiet_box.dart';
import 'package:flutter/material.dart';

class OnlineTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuietBox(
      imagePath:
          'https://www.womansworld.com/wp-content/uploads/2018/05/sad-cat-luhu.jpg?w=715',
      text: 'No one\'s around to play with me :(',
    );
  }
}
