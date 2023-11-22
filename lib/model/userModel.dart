
class UserModel{
  String uid;
  String username;
  String gmail;

  UserModel({required this.uid,required this.username,required this.gmail});

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(uid: json["uid"], username: json["username"], gmail: json["gmail"]);
  }

  Map<String, dynamic> toJson() {
    final data = <String,dynamic>{};
    data['uid']= uid;
    data['username'] = username;
    data['gmail']= gmail;
    return data;
  }
}