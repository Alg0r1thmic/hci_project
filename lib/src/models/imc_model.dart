import 'dart:convert';

import 'package:health_body_checking/src/models/base_model.dart';

ImcModel imcModelFromJson(String str) => ImcModel.fromJson(json.decode(str));

String imcModelToJson(ImcModel data) => json.encode(data.toJson());

class ImcModel implements BaseModel{
    ImcModel({
        this.id,
        this.userIdSensorName,
        this.value,
        this.time,
    });

    String id;
    String userIdSensorName;
    double value;
    DateTime time;

    factory ImcModel.fromJson(Map<String, dynamic> json) => ImcModel(
        id: json["id"],
        userIdSensorName: json["userIdSensorName"],
        value: json["value"].toDouble(),
        time: json["time"].toDate(),
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "userIdSensorName": userIdSensorName,
        "value":value,
        "time": time,
    };
}
