import 'dart:convert';

WaterChallengeModel waterChallengeModelFromJson(String str) => WaterChallengeModel.fromJson(json.decode(str));

String waterChallengeModelToJson(WaterChallengeModel data) => json.encode(data.toJson());

class WaterChallengeModel {
    WaterChallengeModel({
        this.userId,
        this.weeks,
        this.waterChallenges,
        this.id
    });
    String id;
    String userId;
    int weeks;
    List<WaterChallenge> waterChallenges;

    factory WaterChallengeModel.fromJson(Map<String, dynamic> json) => WaterChallengeModel(
        userId: json["userId"],
        weeks: json["weeks"],
        id:json["id"],
        waterChallenges:(json["waterChallenges"]!=null)? List<WaterChallenge>.from(json["waterChallenges"].map((x) => WaterChallenge.fromJson(x))):null,
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "weeks": weeks,
        "id":id,
        "waterChallenges": List<dynamic>.from(waterChallenges.map((x) => x.toJson())),
    };
}

class WaterChallenge {
    WaterChallenge({
        this.completed=false,
        this.unlocked=false,
        this.amount,
        this.challengePerWeek,
    });

    bool completed;
    bool unlocked;
    int amount;
    List<ChallengePerWeek> challengePerWeek;

    factory WaterChallenge.fromJson(Map<String, dynamic> json) => WaterChallenge(
        completed: json["completed"],
        amount: json["amount"],
        unlocked: json["unlocked"],
        challengePerWeek: (json["challengePerWeek"]!=null)?List<ChallengePerWeek>.from(json["challengePerWeek"].map((x) => ChallengePerWeek.fromJson(x))):null,
    );

    Map<String, dynamic> toJson() => {
        "completed": completed,
        "amount": amount,
        "unlocked":unlocked,
        "challengePerWeek": List<dynamic>.from(challengePerWeek.map((x) => x.toJson())),
    };
}

class ChallengePerWeek {
    ChallengePerWeek({
        this.completed=false,
        this.currentDay=false,
    });

    bool completed;
    bool currentDay;

    factory ChallengePerWeek.fromJson(Map<String, dynamic> json) => ChallengePerWeek(
        completed: json["completed"],
        currentDay: json["currentDay"],
    );

    Map<String, dynamic> toJson() => {
        "completed": completed,
        "currentDay": currentDay,
    };
}
