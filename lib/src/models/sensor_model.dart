import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SensorModel temperatureModelFromJson(String str) => SensorModel.fromJson(json.decode(str));

String temperatureModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  SensorModel({
    this.id,
    this.userId,
    this.value,
    this.time,
  });

  int id;
  String userId;
  double value;
  Timestamp time;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
    id: json["id"],
    userId: json["user_id"],
    value: json["value"].toDouble(),
    time: json["time"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "value": value,
    "time": time,
  };
}
