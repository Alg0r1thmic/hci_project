
class FakeWaterDays {
  static final FakeWaterDays _instance = FakeWaterDays._internal();
  factory FakeWaterDays() {
    return _instance;
  }
  FakeWaterDays._internal() {}
  var statusDays = [true, true, true, false, false, false, false];
  var currentDayArray=[false,false,true,false,false,false,false];
  int currentDay = 2;
}
