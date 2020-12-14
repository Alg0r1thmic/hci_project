
class FakeWaterDays {
  static final FakeWaterDays _instance = FakeWaterDays._internal();
  factory FakeWaterDays() {
    return _instance;
  }
  FakeWaterDays._internal() {}
  var statusDays = [false, false, false, false, false, false, false];
  var currentDayArray=[true,false,false,false,false,false,false, false];
  int currentDay = 0;
}