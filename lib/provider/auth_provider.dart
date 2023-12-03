import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/api/user_api.dart';
import 'package:config/model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
  bool isLoading = false;
  String errorMessage = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel? myUser;

  onChangeLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future getUser(String uid) async {
    try {
      myUser = await UserAPI().getProfileUser(uid);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      //print("email in user api : $email password : $password");
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email,password: password);
      setErrorMessage("login: successful");
      //print("login: success ${userCredential.user!.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      //print("login: FirebaseAuthException e.code = ${e.code}");
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
        setErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
        setErrorMessage("Incorrect password.");
      }
      setErrorMessage("Error: ${e.code}");
    }
    return null;
  }
  setErrorMessage(var msg) {
    errorMessage = msg;
    notifyListeners();
  }
}