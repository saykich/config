
class UserModel{
  String uid;
  String username;
  String gmail;
  Address? address;

  UserModel({required this.uid,required this.username,required this.gmail, this.address});

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(uid: json["uid"], username: json["username"], gmail: json["gmail"], address: Address.fromJson(json["address"]));
  }

  Map<String, dynamic> toJson() {
    final data = <String,dynamic>{};
    data["uid"]= uid;
    data["username"] = username;
    data["gmail"]= gmail;
    return data;
  }
}

class Address{
  String? street;
  String? city;

  Address({this.street, this.city});

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(street: json["street"], city: json["city"]);
  }

  Map<String, dynamic> toJson() {
    final data = <String,dynamic>{};
    data["street"] = street;
    data["city"] = city;
    return data;
  }

}