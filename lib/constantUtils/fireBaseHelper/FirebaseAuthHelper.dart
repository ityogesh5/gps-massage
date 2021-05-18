import 'package:firebase_auth/firebase_auth.dart';

import 'Model/HealingMatchUser.dart';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User firebaseUser;

  HealingMatchUser _userFromFirebaseUser(User user) {
    print('User Provider data details : ${user.providerData}');
    return user != null ? HealingMatchUser(uid: user.uid) : null;
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        firebaseUser = user;
        var userEmail = user.email;
        print('Firebase User Email : $userEmail && UID : ${user.uid}');
      } else {
        return;
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final User user = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          var signInUID = value.user.uid;
          firebaseUser = value.user;
          print('Sign in firebase UID : $signInUID');
        }
      }).catchError((onError) {
        print('Sign in Firebase error : ${onError.toString()}');
      });
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      print('Firebase logged out UID !! :${_firebaseAuth.currentUser.uid}');
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
