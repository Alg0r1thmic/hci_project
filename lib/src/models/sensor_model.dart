import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SensorModel sensorModelFromJson(String str) => SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  SensorModel({this.id, this.name, this.type, this.enabled, this.value, this.time,this.route});
  String id;
  String name;
  String type;
  double value;
  String route;
  bool enabled=false;
  Timestamp time;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        enabled: json["enabled"],
        route:json["route"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "enabled": enabled,
      };
}
