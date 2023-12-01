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

  // var userCollection = FirebaseFirestore.instance.collection("user");
  // Future<User?> signUp(String email, String password, DateTime dob, String note) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     if(userCredential.user != null){
  //       await userCollection.doc(userCredential.user!.uid).set({
  //         "email" : userCredential.user!.email,
  //         "uid" : userCredential.user!.uid,
  //         "dob": dob,
  //         "note": note
  //       });
  //     }
  //     return userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     setErrorMessage("signUp: FirebaseAuthException e.code = ${e.code}");
  //     //print("signUp: FirebaseAuthException e.code = ${e.code}");
  //     if (e.code == 'weak-password') {
  //       setErrorMessage("The password provided is too weak.");
  //       //print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       setErrorMessage("The account already exists for that email.");
  //       //print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     //print(e);
  //     setErrorMessage(e);
  //   }
  //   return null;
  // }

  setErrorMessage(var msg) {
    errorMessage = msg;
    notifyListeners();
  }
}