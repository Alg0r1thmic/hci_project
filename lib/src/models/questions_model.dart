// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
    QuestionsModel({
        this.id,
        this.userId,
        this.questionOne,
        this.questionTwo,
        this.questionThree,
        this.questionFour,
        this.questionFive,
    });

    String id;
    String userId;
    String questionOne;
    String questionTwo;
    String questionThree;
    String questionFour;
    String questionFive;

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        id: json["id"],
        userId: json["userId"],
        questionOne: json["questionOne"],
        questionTwo: json["questionTwo"],
        questionThree: json["questionThree"],
        questionFour: json["questionFour"],
        questionFive: json["questionFive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "questionOne": questionOne,
        "questionTwo": questionTwo,
        "questionThree": questionThree,
        "questionFour": questionFour,
        "questionFive": questionFive,
    };
}
