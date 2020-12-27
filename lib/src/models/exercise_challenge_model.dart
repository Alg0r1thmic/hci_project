// To parse this JSON data, do
//
//     final exerciseChallengeModel = exerciseChallengeModelFromJson(jsonString);

import 'dart:convert';

ExerciseChallengeModel exerciseChallengeModelFromJson(String str) => ExerciseChallengeModel.fromJson(json.decode(str));

String exerciseChallengeModelToJson(ExerciseChallengeModel data) => json.encode(data.toJson());

class ExerciseChallengeModel {
    ExerciseChallengeModel({
        this.id,
        this.userId,
        this.minDays=1,
        this.maxDays=7,
        this.currentDays=0,
        this.minMinuts=10,
        this.maxMinuts=40,
        this.currentMinuts=0,
        this.challenges,
        this.completedDays=false,
        this.completedMinuts=false
    });

    String id;
    String userId;
    int minDays;
    int maxDays;
    int currentDays;
    int minMinuts;
    int maxMinuts;
    int currentMinuts;
    bool completedDays;
    bool completedMinuts;
    List<Challenge> challenges;

    factory ExerciseChallengeModel.fromJson(Map<String, dynamic> json) => ExerciseChallengeModel(
        id: json["id"],
        userId: json["userId"],
        minDays: json["minDays"],
        maxDays: json["maxDays"],
        currentDays: json["currentDays"],
        minMinuts: json["minMinuts"],
        maxMinuts: json["maxMinuts"],
        currentMinuts: json["currentMinuts"],
        completedDays: json["completedDays"],
        completedMinuts:json["completedMinuts"] ,
        challenges:(json["challenges"]!=null)?List<Challenge>.from(json["challenges"].map((x) => Challenge.fromJson(x))):null
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "minDays": minDays,
        "maxDays": maxDays,
        "currentDays": currentDays,
        "minMinuts": minMinuts,
        "maxMinuts": maxMinuts,
        "currentMinuts": currentMinuts,
        "completedDays": completedDays,
        "completedMinuts":completedMinuts ,
        "challenges": List<dynamic>.from(challenges.map((x) => x.toJson())),
    };
}

class Challenge {
    Challenge({
        this.days,
        this.minuts,
        this.completed=false,
        this.currentDay=0,
    });

    int days;
    int minuts;
    bool completed;
    int currentDay;

    factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        days: json["days"],
        minuts: json["minuts"],
        completed: json["completed"],
        currentDay: json["currentDay"],
    );

    Map<String, dynamic> toJson() => {
        "days": days,
        "minuts": minuts,
        "completed": completed,
        "currentDay": currentDay,
    };
}
