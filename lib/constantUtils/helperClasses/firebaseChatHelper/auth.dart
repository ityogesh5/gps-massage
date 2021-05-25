import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      UserCredential result = await _firebaseAuth
      .signInWithEmailAndPassword(
          email: email, password: password);
      _firebaseUser = result.user;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> signUp(String userName, String email,String password) async{
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firebaseUser = result.user;
      
    }
    catch(error)
    {
      print(error);
      return false;
    }
  }
}
