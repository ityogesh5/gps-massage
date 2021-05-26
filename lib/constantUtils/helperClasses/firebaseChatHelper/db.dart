import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/games/v1.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class DB {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('USERS');
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('MESSAGES');

  //create New User
  void addNewUser(String userId, String imageUrl, String username, String email,
      int id, int isTherapist) {
    try {
      _usersCollection.doc(userId).set({
        'id': userId,
        'imageUrl': imageUrl,
        'username': username,
        'email': email,
        'serverId': id,
        'isTherapist': isTherapist,
        'contacts': [],
      });
    } catch (error) {
      print('****************** DB addNewUser error **********************');
      print(error);
      throw error;
    }
  }

  Future<UserDetail> getContactsofUser(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _usersCollection.doc(userId).get();
      print(documentSnapshot.data());
      UserDetail userDetail = UserDetail.fromJson(documentSnapshot.data());
      print(userDetail);
      return userDetail;
    } catch (error) {
      print('****************** DB addNewUser error **********************');
      print(error);
      throw error;
    }
  }

  Future<List<UserDetail>> getUserDetilsOfContacts(
      List<String> contacts) async {
    List<UserDetail> userDetail = List<UserDetail>();
    try {
      QuerySnapshot querySnapShot =
          await _usersCollection.where("id", whereIn: contacts).get();
      print(querySnapShot.docs);
      for (var documentSnapShot in querySnapShot.docs) {
        userDetail.add(UserDetail.fromJson(documentSnapShot.data()));
      }
      print(userDetail);
      return userDetail;
    } catch (error) {
      print(
          '****************** DB getUSerDetails error **********************');
      print(error);
      throw error;
    }
  }

  Future<QuerySnapshot> getChatItem(String groupId, [int limit = 10]) async {
    try {
      QuerySnapshot querySnapShot = await _messagesCollection
          .doc(groupId)
          .collection('CHATS')
          .orderBy('timeStamp', descending: true)
          .limit(limit)
          .get();
      print(querySnapShot.docs);
      return querySnapShot;
    } catch (error) {
      print('****************** DB getChatItems error **********************');
      print(error);
      throw error;
    }
  }

  Future<QuerySnapshot> getNewChats(
      String groupChatId, DocumentSnapshot lastSnapshot,
      [int limit = 20]) {
    try {
      return _messagesCollection
          .doc(groupChatId)
          .collection('CHATS')
          .startAfterDocument(lastSnapshot)
          .limit(20)
          .orderBy('timeStamp', descending: true)
          .get();
    } catch (error) {
      print(
          '****************** DB getSnapshotsAfter error **********************');
      print(error);
      throw error;
    }
  }
}
