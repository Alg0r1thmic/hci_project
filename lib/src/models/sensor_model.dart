import 'dart:convert';

SensorModel sensorModelFromJson(String str) => SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
    SensorModel({
        this.id,
        this.name,
        this.type,
        this.enable,
    });

    String id;
    String name;
    String type;
    bool enable;

    factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        enable: json["enable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "enable": enable,
    };
}
