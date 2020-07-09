import 'package:azeo/constants/strings.dart';
import 'package:azeo/models/friend.dart';
import 'package:azeo/models/message.dart';
import 'package:azeo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMethods {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference _messageCollection =
      _firestore.collection(MESSAGES_COLLECTION);

  final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToFriends(senderId: message.senderId, receiverId: message.receiverId);

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getFriendsDocument({String of, String forFriend}) =>
      _userCollection
          .document(of)
          .collection(FRIENDS_COLLECTION)
          .document(forFriend);

  addToFriends({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSender(senderId, receiverId, currentTime);
    await addToReceiver(senderId, receiverId, currentTime);
  }

  Future<void> addToSender(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getFriendsDocument(of: senderId, forFriend: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      Friend receiver = Friend(
        uid: receiverId,
        addedOn: currentTime,
      );

      var receiverMap = receiver.toMap(receiver);

      await getFriendsDocument(of: senderId, forFriend: receiverId)
          .setData(receiverMap);
    }
  }

  Future<void> addToReceiver(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getFriendsDocument(of: receiverId, forFriend: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Friend sender = Friend(
        uid: senderId,
        addedOn: currentTime,
      );

      var senderMap = sender.toMap(sender);

      await getFriendsDocument(of: receiverId, forFriend: senderId)
          .setData(senderMap);
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Stream<QuerySnapshot> fetchFriends({String userId}) => _userCollection
      .document(userId)
      .collection(FRIENDS_COLLECTION)
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _messageCollection
          .document(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
