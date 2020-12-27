// To parse this JSON data, do
//
//     final exerciseQuestionModel = exerciseQuestionModelFromJson(jsonString);

import 'dart:convert';

ExerciseQuestionModel exerciseQuestionModelFromJson(String str) => ExerciseQuestionModel.fromJson(json.decode(str));

String exerciseQuestionModelToJson(ExerciseQuestionModel data) => json.encode(data.toJson());

class ExerciseQuestionModel {
    ExerciseQuestionModel({
        this.id,
        this.minuts,
        this.days,
        this.userId,
    });

    String id;
    int minuts;
    int days;
    String userId;

    factory ExerciseQuestionModel.fromJson(Map<String, dynamic> json) => ExerciseQuestionModel(
        id: json["id"],
        minuts: json["minuts"],
        days: json["days"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "minuts": minuts,
        "days": days,
        "userId": userId,
    };
}
