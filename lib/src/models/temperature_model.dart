import 'dart:convert';


TemperatureModel temperatureModelFromJson(String str) => TemperatureModel.fromJson(json.decode(str));

String temperatureModelToJson(TemperatureModel data) => json.encode(data.toJson());

class TemperatureModel {
    TemperatureModel({
        this.id,
        this.userId,
        this.temperature,
        this.time,
    });

    String id;
    String userId;
    double temperature;
    DateTime time;

    factory TemperatureModel.fromJson(Map<String, dynamic> json) => TemperatureModel(
        id: json["id"],
        userId: json["user_id"],
        temperature: json["temperature"].toDouble(),
        time: json["time"].toDate(),
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "temperature": temperature,
        "time": time,
    };
}

