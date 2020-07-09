import 'package:flutter/material.dart';

class AddFriendDialog extends StatelessWidget {
  final Function onTap;
  final TextEditingController controller;

  const AddFriendDialog({this.onTap, this.controller});
  @override
  Widget build(context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 275.0,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Friend',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'You can add friends with their Username. It\'s cAsE sEnSitIve!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 2.0),
                  hintText: 'Enter a Username',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    onTap();
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
