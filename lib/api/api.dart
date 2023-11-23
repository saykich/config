import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/model/userModel.dart';

class API{
  var userCollection = FirebaseFirestore.instance.collection("users");

  createUser({required String username, required gmail, required Address address}) async{
    await userCollection.add({
      "username": username,
      "gmail": gmail,
      "address": {
        "street": address.street,
        "city": address.city
      }
    });
  }
}