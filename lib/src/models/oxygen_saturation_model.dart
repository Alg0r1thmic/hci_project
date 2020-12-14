import 'dart:convert';


OxygenSaturationModel oxygenSaturationModelFromJson(String str) => OxygenSaturationModel.fromJson(json.decode(str));

String oxygenSaturationModelToJson(OxygenSaturationModel data) => json.encode(data.toJson());

class OxygenSaturationModel {
    OxygenSaturationModel({
        this.id,
        this.userId,
        this.saturation,
        this.time,
    });

    int id;
    String userId;
    double saturation;
    DateTime time;

    factory OxygenSaturationModel.fromJson(Map<String, dynamic> json) => OxygenSaturationModel(
        id: json["id"],
        userId: json["user_id"],
        saturation: json["saturation"].toDouble(),
        time: json["time"].toDate(),
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "saturation": saturation,
        "time": time,
    };
}
