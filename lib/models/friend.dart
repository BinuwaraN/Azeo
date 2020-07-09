import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  String uid;
  bool isSender;
  bool isAccepted;
  Timestamp addedOn;

  Friend({
    this.uid,
    this.addedOn,
    this.isSender,
    this.isAccepted,
  });

  Map toMap(Friend friend) {
    var data = Map<String, dynamic>();
    data['friend_id'] = friend.uid;
    data['isSender'] = friend.isSender;
    data['isAccepted'] = friend.isAccepted;
    data['added_on'] = friend.addedOn;
    return data;
  }

  Friend.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['friend_id'];
    this.isSender = mapData['isSender'];
    this.isAccepted = mapData['isAccepted'];
    this.addedOn = mapData["added_on"];
  }
}
