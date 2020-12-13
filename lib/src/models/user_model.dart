// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:health_body_checking/src/models/sernsor_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.uid,
        this.email,
        this.displayName,
        this.phoneNumber,
        this.name,
        this.lastName,
        this.userName,
        this.photoUrl,
        this.age,
        this.country,
        this.weight,
        this.height,
        this.sensors,
    });

    String uid;
    String email;
    String displayName;
    String phoneNumber;
    String name;
    String lastName;
    String userName;
    String photoUrl;
    int age;
    String country;
    double weight;
    double height;
    List<SensorModel> sensors;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        lastName: json["lastName"],
        userName: json["userName"],
        photoUrl: json["photoUrl"],
        age: json["age"],
        country: json["country"],
        weight: json["weight"].toDouble(),
        height: json["height"].toDouble(),
        sensors: List<SensorModel>.from(json["sensors"].map((x) => SensorModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        "name": name,
        "lastName": lastName,
        "userName": userName,
        "photoUrl": photoUrl,
        "age": age,
        "country": country,
        "weight": weight,
        "height": height,
        "sensors": List<dynamic>.from(sensors.map((x) => x.toJson())),
    };
}