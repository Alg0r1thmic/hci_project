import 'dart:convert';

import 'base_model.dart';


TemperatureModel temperatureModelFromJson(String str) => TemperatureModel.fromJson(json.decode(str));

String temperatureModelToJson(TemperatureModel data) => json.encode(data.toJson());

class TemperatureModel implements BaseModel {
    TemperatureModel({
        this.id,
        this.userId,
        this.value,
        this.time,
    });

    String id;
    String userId;
    double value;
    DateTime time;

    factory TemperatureModel.fromJson(Map<String, dynamic> json) => TemperatureModel(
        id: json["id"],
        userId: json["user_id"],
        value: json["value"].toDouble(),
        time: json["time"].toDate(),
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "value": value,
        "time": time,
    };
}

