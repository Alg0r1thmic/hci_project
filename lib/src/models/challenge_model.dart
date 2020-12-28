import '../constants/fake_water_days.dart';

class ChallengeModel {
  ChallengeModel({
    this.amount,
    this.duration,
    this.enable,
    this.progress,
    this.days
  });

  String amount;
  String duration;
  bool enable;
  bool progress;
  FakeWaterDays days;

  bool isComplete() {
    for(int i = 0; i < days.statusDays?.length; i++) {
      if(!days.statusDays[i]) return false;
    }
    return true;
  }

  double percent() {
    var value = ((days.currentDay + 1) / 7);
    print(value);
    return value;
  }
}

ChallengeModel currentChallenge;

List<ChallengeModel> fruitChallenges = [
  ChallengeModel(
      amount: "1 fruta diaria",
      duration: "1 semana",
      enable: true,
      progress: false,
      days: FakeWaterDays()
  ),
  ChallengeModel(
      amount: "2 frutas diarias",
      duration:"1 semana",
      enable: false,
      progress: false,
      days: FakeWaterDays()
  ),
  ChallengeModel(
      amount: "3 frutas diarias",
      duration: "1 semana",
      enable: false,
      progress: false,
      days: FakeWaterDays()
  ),
];


List<ChallengeModel> challenges = [
  ChallengeModel(
      amount: "1 vaso diario",
      duration: "1 semana",
      enable: true,
      progress: false,
      days: FakeWaterDays()
  ),
  ChallengeModel(
      amount: "2 vasos diarios",
      duration:"1 semana",
      enable: false,
      progress: false,
      days: FakeWaterDays()
  ),
  ChallengeModel(
      amount: "3 vasos diarios",
      duration: "1 semana",
      enable: false,
      progress: false,
      days: FakeWaterDays()
  ),
];
