import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _firebaseUser;

  bool get isAuth {
    return _firebaseUser != null;
  }

  User get getUser {
    return _firebaseUser;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: "password");
      _firebaseUser = result.user;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<String> signUp(String userName, String email, String password,
      String imgUrl, int isTherapist, int serverID) async {
    try {
      final db = DB();
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _firebaseUser = result.user;
      db.addNewUser(
          _firebaseUser.uid, imgUrl, userName, email, serverID, isTherapist);
      _firebaseUser.updateProfile(photoURL: imgUrl, displayName: userName);
      return _firebaseUser.uid;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void signOut() async {
    _firebaseAuth.signOut();
  }
}
