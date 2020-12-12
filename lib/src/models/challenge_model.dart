import 'dart:convert';

class ChallengeModel {
  ChallengeModel({
    this.amount,
    this.duration,
    this.enable,
    this.complete,
  });

  String amount;
  String duration;
  bool enable;
  bool complete;
}
