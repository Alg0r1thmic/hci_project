import 'package:flutter/foundation.dart';

class ChallengeCompleProvider extends ChangeNotifier{
  bool _finishFirstChallenge=false;
  get firstChallenge=>_finishFirstChallenge;
  set firstChallenge(bool value){
    this._finishFirstChallenge=value;
    notifyListeners();
  }
}