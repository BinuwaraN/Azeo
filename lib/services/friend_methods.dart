import 'package:azeo/constants/strings.dart';
import 'package:azeo/models/friend.dart';
import 'package:azeo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendMethods {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  Future<void> addFriendToDb(User sender, User receiver) async {
    addToFriends(senderId: sender.uid, receiverId: receiver.uid);
  }

  DocumentReference getFriendsDocument({String of, String forFriend}) =>
      _userCollection
          .document(of)
          .collection(FRIENDS_COLLECTION)
          .document(forFriend);

  addToFriends({
    String senderId,
    String receiverId,
    bool isAccepted,
    bool isSender,
  }) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderFriends(
        senderId, receiverId, currentTime, isAccepted, isSender);
    await addToReceiverFriends(
        senderId, receiverId, currentTime, isAccepted, isSender);
  }

  Future<void> addToSenderFriends(
    String senderId,
    String receiverId,
    currentTime,
    bool isAccepted,
    bool isSender,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getFriendsDocument(of: senderId, forFriend: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      Friend receiver = Friend(
        uid: receiverId,
        isAccepted: false,
        isSender: true,
        addedOn: currentTime,
      );

      var receiverMap = receiver.toMap(receiver);

      await getFriendsDocument(of: senderId, forFriend: receiverId)
          .setData(receiverMap);
    }
  }

  Future<void> addToReceiverFriends(
    String senderId,
    String receiverId,
    currentTime,
    bool isAccepted,
    bool isSender,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getFriendsDocument(of: receiverId, forFriend: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Friend sender = Friend(
        uid: senderId,
        addedOn: currentTime,
        isAccepted: false,
        isSender: false,
      );

      var senderMap = sender.toMap(sender);

      await getFriendsDocument(of: receiverId, forFriend: senderId)
          .setData(senderMap);
    }
  }

  Future<void> acceptFriend(String currentUserId, String friendId) async {
    DocumentReference userFriendDocument = _userCollection
        .document(currentUserId)
        .collection(FRIENDS_COLLECTION)
        .document(friendId);

    DocumentReference friendUserDocument = _userCollection
        .document(friendId)
        .collection(FRIENDS_COLLECTION)
        .document(currentUserId);

    try {
      await friendUserDocument.updateData({'isAccepted': true});
      await userFriendDocument.updateData({'isAccepted': true});
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeFriend(String currentUserId, String friendId) async {
    DocumentReference userFriendDocument = _userCollection
        .document(currentUserId)
        .collection(FRIENDS_COLLECTION)
        .document(friendId);

    DocumentReference friendUserDocument = _userCollection
        .document(friendId)
        .collection(FRIENDS_COLLECTION)
        .document(currentUserId);

    try {
      await friendUserDocument.delete();
      await userFriendDocument.delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> fetchFriends(
      String currentUserId, bool isAccepted) {
    Stream<QuerySnapshot> _friends = _userCollection
        .document(currentUserId)
        .collection(FRIENDS_COLLECTION)
        .where(
          'isAccepted',
          isEqualTo: isAccepted,
        )
        .snapshots();

    return _friends;
  }

  getFriendFromUserDb(String currentUserId, String friendId) => _userCollection
      .document(currentUserId)
      .collection(FRIENDS_COLLECTION)
      .document(friendId)
      .get();
}
