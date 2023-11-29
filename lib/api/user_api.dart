
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/model/userModel.dart';
import 'package:flutter/material.dart';

class UserAPI
{
  final CollectionReference userRef = FirebaseFirestore.instance.collection('users');

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

}
class Logger {
  static printLog(msg) {
    debugPrint("Logger =>> ${msg.toString()}");
  }
}

