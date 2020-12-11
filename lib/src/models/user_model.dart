import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.uid,
        this.email,
        this.displayName,
        this.phoneNumber,
        this.photoUrl,
    });

    String uid;
    String email;
    String displayName;
    String phoneNumber;
    String photoUrl;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "photoUrl": photoUrl,
    };
}
