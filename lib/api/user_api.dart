
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAPI
{
  final CollectionReference userRef = FirebaseFirestore.instance.collection('user');
  Future<User?> signUp(String email, String password, DateTime dob, String note) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        await userRef.doc(userCredential.user!.uid).set({
          "email" : userCredential.user!.email,
          "uid" : userCredential.user!.uid,
          "dob": dob,
          "note": note
        });
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("signUp: FirebaseAuthException e.code = ${e.code}");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserModel?> getProfileUser(String? uid) async {
    try {
      DocumentSnapshot doc = await userRef.doc(uid).get();
      if (doc.exists) {
        UserModel myUser = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        return myUser;
      } else {
        return null;
      }
    } catch (e) {
      Logger.printLog("Error =>> ${e.toString()}");
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      print("email in user api : $email password : $password");
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email,password: password);
      print("login: success ${userCredential.user!.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("login: FirebaseAuthException e.code = ${e.code}");
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<bool> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }
    catch(e){
      return false;
    }

  }

}
class Logger {
  static printLog(msg) {
    debugPrint("Logger =>> ${msg.toString()}");
  }
}

