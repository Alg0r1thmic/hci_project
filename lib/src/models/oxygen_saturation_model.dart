import 'dart:convert';


import 'base_model.dart';


OxygenSaturationModel oxygenSaturationModelFromJson(String str) => OxygenSaturationModel.fromJson(json.decode(str));

String oxygenSaturationModelToJson(OxygenSaturationModel data) => json.encode(data.toJson());

class OxygenSaturationModel implements BaseModel {
    OxygenSaturationModel({
        this.id,
        this.userId,
        this.value,
        this.time,
    });
    String id;
    String userId;
    double value;
    DateTime time;

    factory OxygenSaturationModel.fromJson(Map<String, dynamic> json) => OxygenSaturationModel(
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
