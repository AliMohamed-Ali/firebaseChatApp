import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService();
  User? _user;
  User get user => _user!;
  Future<bool> login(String email, String password) async {
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
