import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/games/v1.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/mediaModel.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
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
        'isTyping':false,
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

  Future<QuerySnapshot> getChatItem(String groupId, [int limit = 20]) async {
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
          .limit(20)
          .orderBy('timeStamp', descending: true)
          .startAfterDocument(lastSnapshot)
          .get();

      /*  _messagesCollection
          .doc(groupChatId)
          .collection('CHATS')
          .startAfterDocument(lastSnapshot)
          .limit(20)
          .orderBy('timeStamp', descending: true)
          .get(); */
    } catch (error) {
      print(
          '****************** DB getSnapshotsAfter error **********************');
      print(error);
      throw error;
    }
  }

  void addNewMessage(String groupId, DateTime timeStamp, dynamic data) {
    try {
      _messagesCollection
          .doc(groupId)
          .collection(CHATS_COLLECTION)
          .doc(timeStamp.millisecondsSinceEpoch.toString())
          .set(data);
    } catch (error) {
      print('****************** DB addNewMessage error **********************');
      print(error);
      throw error;
    }
  }

  void updateContacts(String userId, dynamic contacts) {
    try {
      _usersCollection
          .doc(userId)
          .set({'contacts': contacts}, SetOptions(merge: true));
    } catch (error) {
      print(
          '****************** DB updateContacts error **********************');
      print(error);
      throw error;
    }
  }

  void addMediaUrl(String groupId, String url, Message mediaMsg) {
    try {
      _messagesCollection
          .doc(groupId)
          .collection(MEDIA_COLLECTION)
          .doc(mediaMsg.timeStamp)
          .set(MediaModel.fromMsgToMap(mediaMsg));
    } catch (error) {
      print('****************** DB addMediaUrl error **********************');
      print(error);
      throw error;
    }
  }

  Stream<QuerySnapshot> getSnapshotsWithLimit(String groupChatId,
      [int limit = 10]) {
    try {
      return _messagesCollection
          .doc(groupChatId)
          .collection(CHATS_COLLECTION)
          .limit(limit)
          .orderBy('timeStamp', descending: true)
          .snapshots();
    } catch (error) {
      print(
          '****************** DB getSnapshotsWithLimit error **********************');
      print(error);
      throw error;
    }
  }

  Stream<QuerySnapshot> getSnapshotsAfter(
      String groupChatId, DocumentSnapshot lastSnapshot) {
    try {
      return _messagesCollection
          .doc(groupChatId)
          .collection(CHATS_COLLECTION)
          .orderBy('timeStamp')
          .startAfterDocument(lastSnapshot)
          .snapshots();
      /* _messagesCollection
          .doc(groupChatId)
          .collection(CHATS_COLLECTION)
          .startAfterDocument(lastSnapshot)
          .orderBy('timeStamp')
          .snapshots(); */
    } catch (error) {
      print(
          '****************** DB getSnapshotsAfter error **********************');
      print(error);
      throw error;
    }
  }

  void updateMessageField(dynamic snapshot, String field, dynamic value) {
    try {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        // DocumentSnapshot freshDoc = await transaction.get(snapshot.reference);
        transaction.update(snapshot.reference, {'$field': value});
      });
    } catch (error) {
      print(
          '****************** DB updateMessageField error **********************');
      print(error);
      throw error;
    }
  }

  Future<DocumentSnapshot> addToPeerContacts(
      String peerId, String newContact) async {
    DocumentReference doc;
    DocumentSnapshot docSnapshot;

    try {
      doc = _usersCollection.doc(peerId);
      docSnapshot = await doc.get();

      var peerContacts = [];

      docSnapshot.data()['contacts'].forEach((elem) => peerContacts.add(elem));
      peerContacts.add(newContact);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        final freshDoc = await transaction.get(doc);
        transaction.update(freshDoc.reference, {'contacts': peerContacts});
      });

      // doc.setData({'contacts': peerContacts}, merge: true);
    } catch (error) {
      print(
          '****************** DB addToPeerContacts error **********************');
      print(error);
      throw error;
    }

    return docSnapshot;
  }

  void updateUserInfo(String userId, Map<String, dynamic> data) async {
    try {
      _usersCollection.doc(userId).set(data, SetOptions(merge: true));
    } catch (error) {
      print(
          '****************** DB updateUserInfo error **********************');
      print(error);
      throw error;
    }
  }
}
