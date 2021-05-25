import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/games/v1.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class DB {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('USERS');

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
      QuerySnapshot querySnapshot =
          await _usersCollection.where("id", whereIn: contacts).get();
      print(querySnapshot.docs);
      for (var documentSnapShot in querySnapshot.docs) {
        userDetail.add(UserDetail.fromJson(documentSnapShot.data()));
      }
      print(userDetail);
      return userDetail;
    } catch (error) {
      print('****************** DB addNewUser error **********************');
      print(error);
      throw error;
    }
  }

  void updateContacts(String userID, String contactUserID) async {}
}
