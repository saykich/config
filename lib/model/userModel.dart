
class UserModel{
  String uid;
  String email;
  DateTime dob;
  String note;

  UserModel({required this.uid,required this.email,required this.dob,required this.note});

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(uid: json["uid"], email: json["email"], dob: json["dob"], note: json["note"]);
  }

  Map<String, dynamic> toJson() {
    final data = <String,dynamic>{};
    data["uid"]= uid;
    data["email"]= email;
    data["dob"]= dob;
    data["note"]= note;
    return data;
  }
}