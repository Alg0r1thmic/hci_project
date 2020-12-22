import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SensorModel sensorModelFromJson(String str) => SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  SensorModel({this.id,this.description ,this.displayName,this.icon,this.index, this.sensorName, this.name, this.enabled, this.value, this.time, this.route});
  String id;
  String name;
  String displayName;
  String sensorName;
  String description;
  double value;
  String route;
  bool enabled = false;
  String icon;
  int index;
  Timestamp time;

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
    id: json["id"], 
    displayName: json["displayName"], 
    sensorName: json["sensorName"], 
    enabled: json["enabled"], 
    route: json["route"],
    icon: json["icon"],
    index: json["index"],
    description: json["description"]
  );
  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "sensorName": sensorName,
        "enabled": enabled,
        "index":index,
        "icon":icon,
        "description": description
      };
}
