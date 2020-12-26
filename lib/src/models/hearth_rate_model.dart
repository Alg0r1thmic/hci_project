import 'dart:convert';
import 'base_model.dart';
HearthRateModel hearthRateModelFromJson(String str) => HearthRateModel.fromJson(json.decode(str));

String hearthRateModelToJson(HearthRateModel data) => json.encode(data.toJson());

class HearthRateModel implements BaseModel{
    HearthRateModel({
        this.id,
        this.userIdSensorName,
        this.value,
        this.time,
    });

    String id;
    String userIdSensorName;
    double value;
    DateTime time;

    factory HearthRateModel.fromJson(Map<String, dynamic> json) => HearthRateModel(
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
