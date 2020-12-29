import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/exercise_challenge_model.dart';
import 'package:health_body_checking/src/models/exercise_question_model.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/models/water_challenge_model.dart';
import 'package:health_body_checking/src/services/exercise_callenge_service.dart';
import 'package:health_body_checking/src/services/exercise_question_service.dart';
import 'package:health_body_checking/src/services/user_service.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants/app_colors.dart';
import '../../core/routes/routes.dart';
import '../../models/user_model.dart';
import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionFiveScreen extends StatefulWidget {
  final VoidCallback onGoToBackQuestion;
  QuestionFiveScreen({
    Key key,
    @required this.onGoToBackQuestion,
  }) : super(key: key);
  @override
  _QuestionFiveScreenState createState() => _QuestionFiveScreenState();
}

class _QuestionFiveScreenState extends State<QuestionFiveScreen> {
  double _currentSliderValue = 0;
  ExerciseChallengeService _service;
  ExerciseQuestionService _exerciseQuestionService;
  ExerciseChallengeModel _exerciseChallengeModel;
  ExerciseQuestionModel _exerciseQuestionModel;

  UserService _userService;
  @override
  void initState() {
    super.initState();
    _userService=UserService();
    _service = ExerciseChallengeService();
    _exerciseQuestionService = ExerciseQuestionService();
  }

  void _createExerciseChallenges() async {
    this
        ._exerciseQuestionService
        .findByUserId(userId: CurrentUserModel.instance.id)
        .listen((event) async {
      this._exerciseQuestionModel = event[0];
      _generateList(this._exerciseQuestionModel);
    });
    this._userService.setUser(CurrentUserModel.instance);
  }

  _generateList(ExerciseQuestionModel model) async {
    int daysLen = 7 - _exerciseQuestionModel.days;
    int minutsLen = (40 -
            ((_exerciseQuestionModel.minuts >= 10)
                ? _exerciseQuestionModel.minuts -
                    _exerciseQuestionModel.minuts % 5
                : 10)) ~/
        5;
    List<Challenge> _list = [];
    for (var i = 0; i < daysLen; i++) {
      _list.add(Challenge(
          days: _exerciseQuestionModel.days + i + 1,
          minuts: (_exerciseQuestionModel.minuts >= 10)
              ? ((_exerciseQuestionModel.minuts -
                      _exerciseQuestionModel.minuts % 5) +
                  5)
              : 10));
    }
    int initialMinuts = _exerciseQuestionModel.minuts >= 10
        ? _exerciseQuestionModel.minuts - _exerciseQuestionModel.minuts % 5 + 5
        : 10;
    int max = (initialMinuts == 10) ? minutsLen : minutsLen - 1;
    for (var i = 0; i < max; i++) {
      _list.add(Challenge(days: 7, minuts: initialMinuts + 5 * (i + 1)));
    }
    _exerciseChallengeModel = ExerciseChallengeModel(
        id: DateTime.now().toIso8601String(),
        currentDays: _exerciseQuestionModel.days+1,
        currentMinuts:initialMinuts,
        challenges: _list, userId: CurrentUserModel.instance.id);
    this._service.createOne(_exerciseChallengeModel);
  }

  void _generateWaterChallenge(){
    List<WaterChallenge> _list;
    List<ChallengePerWeek> _listWeek;

    for (var i = 0; i < 7; i++) {
      _listWeek.add(ChallengePerWeek());
    }
    for (var i = CurrentUserModel.instance.glassOfWaterPerDay+1; i <= 8; i++) {
      _list.add(WaterChallenge(challengePerWeek: _listWeek,amount:i ));
    }
    print(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          PaginationText(total: 6, actual: 6),
          Expanded(
              child: SizedBox(
            child: _content(),
          )),
          _questionsChangeButton(),
        ],
      ),
    )));
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.west,
        ),
        _goToHomeButton(),
      ],
    );
  }

  Widget _goToHomeButton() {
    return InkWell(
      onTap: () {
        this._createExerciseChallenges();
        this._generateWaterChallenge();
        //CurrentUserModel.instance.custionsCompleted=true;
        //Navigator.of(context).pushReplacementNamed(Routes.home);
      },
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
            color: AppColors.SECONDARY,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            'FINALIZAR',
            style: TextStyle(color: AppColors.WHITE),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset(
            "assets/images/fruit.png",
            height: 150,
          ),
        ),
        Text(
          _currentSliderValue.round().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 30, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: '¿Cuantas ',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(
                  text: 'frutas ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'comes a la semana? ',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SfSlider(
          min: 0.0,
          max: 8.0,
          value: _currentSliderValue,
          interval: 1,
          showLabels: true,
          onChanged: (dynamic value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        )
      ],
    );
  }
}
