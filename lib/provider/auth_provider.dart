import 'dart:io';
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



  setErrorMessage(var msg) {
    errorMessage = msg;
    notifyListeners();
  }
}