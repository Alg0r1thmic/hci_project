import 'dart:convert';

import 'sensor_model.dart';

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

CurrentUserModel currentUserModelFromJson(String str) => CurrentUserModel.fromJson(json.decode(str));

String currentUserModelToJson(CurrentUserModel data) => json.encode(data.toJson());

class CurrentUserModel {
  static CurrentUserModel _instance = CurrentUserModel._internal();
  static get instance => _instance;
  CurrentUserModel._internal();
  String id;
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
  bool custionsCompleted;
  String firebaseKey;
  int glassOfWaterPerDay;
  List<SensorModel> sensors;
  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    _instance.id = json["id"];
    _instance.email = json["email"];
    _instance.displayName = json["displayName"];
    _instance.phoneNumber = json["phoneNumber"];
    _instance.name = json["name"];
    _instance.lastName = json["lastName"];
    _instance.userName = json["userName"];
    _instance.photoUrl = json["photoUrl"];
    _instance.age = json["age"];
    _instance.country = json["country"];
    _instance.weight = (json["weight"]!=null)?json["weight"].toDouble():null;
    _instance.height = (json["height"]!=null)?json["height"].toDouble():null;
    _instance.firebaseKey=json["firebaseKey"];
    _instance.custionsCompleted= json["custionsCompleted"];
    _instance.sensors =(json["sensors"]!=null)?List<SensorModel>.from(json["sensors"].map((x) => SensorModel.fromJson(x))):null;
    _instance.glassOfWaterPerDay=json["  int glassOfWaterPerDay"];
    return _instance;
  }
  factory CurrentUserModel({
    String id,
    String email,
    String displayName,
    String phoneNumber,
    String name,
    String lastName,
    String userName,
    String photoUrl,
    int age,
    String country,
    double weight,
    double height,
    bool cuestionsCompleted=false,
    String firebaseKey,
    List<SensorModel> sensors,
    int glassOfWaterPerDay
  }) {
    _instance.id = id;
    _instance.email = email;
    _instance.displayName = displayName;
    _instance.phoneNumber = phoneNumber;
    _instance.name = name;
    _instance.lastName = lastName;
    _instance.userName = userName;
    _instance.photoUrl = photoUrl;
    _instance.age = age;
    _instance.country = country;
    _instance.weight = weight;
    _instance.height = height;
    _instance.sensors = sensors;
    _instance.custionsCompleted=cuestionsCompleted;
    _instance.firebaseKey=firebaseKey;
    _instance.glassOfWaterPerDay=glassOfWaterPerDay;
    return _instance;
  }
  Map<String, dynamic> toJson() => {
        "id": id,
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
        "custionsCompleted":custionsCompleted,
        "firebaseKey":firebaseKey,
        "glassOfWaterPerDay":glassOfWaterPerDay,
        "sensors": (sensors!=null)?List<dynamic>.from(sensors.map((x) => x.toJson())):null,
      };
  
}
