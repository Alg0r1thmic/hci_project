import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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

class Values {
  Values({this.time, this.value});
  double value;
  DateTime time;
}

class Sensor {
  Sensor({this.id, this.name, this.enabled, this.values, this.icon});
  int id;
  String name;
  bool enabled=false;
  IconData icon;
  List<Values> values;
}

List<Sensor> sensors =  [
  Sensor(id: 1, name: "Indice de masa corporal", enabled: true, values: <Values>[], icon: IconData(0xf496, fontFamily: "Health", fontPackage: null)),
  Sensor(id: 2, name: "Latidos por minuto", enabled: true, values: <Values>[], icon: IconData(0xf21e, fontFamily: "Health", fontPackage: null)),
  Sensor(id: 3, name: "Temperatura", enabled: true, values: <Values>[], icon: IconData(0xf2c9, fontFamily: "Health", fontPackage: null)),
  Sensor(id: 4, name: "Saturacion de oxigeno", enabled: true, values: <Values>[], icon: IconData(0xf604, fontFamily: 'Lungs', fontPackage: null)),
];

