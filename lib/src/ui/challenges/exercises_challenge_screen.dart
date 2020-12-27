import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/exercise_challenge_model.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/services/exercise_callenge_service.dart';
import 'package:health_body_checking/src/utils/hex_color.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExercisesChallengeScreen extends StatefulWidget {
  final ExerciseChallengeModel exerciseChallengeModel;
  final int index;
  ExercisesChallengeScreen(
      {Key key, @required this.exerciseChallengeModel, @required this.index})
      : super(key: key);

  @override
  _ExercisesChallengeScreenState createState() =>
      _ExercisesChallengeScreenState();
}

class _ExercisesChallengeScreenState extends State<ExercisesChallengeScreen> {
  ExerciseChallengeService _service;
  Timer _currentTimer;
  double minuts;
  double seconds = 00;
  Color color = AppColors.GREY;
  String text='😄 tu puedes!!!';
  @override
  void initState() {
    _service = ExerciseChallengeService();
    super.initState();
    minuts = widget.exerciseChallengeModel.challenges[widget.index].minuts
        .toDouble();
  }

  final CircularSliderAppearance appearance03 = CircularSliderAppearance(
      customWidths: CustomSliderWidths(
          trackWidth: 22, progressBarWidth: 20, shadowWidth: 50),
      customColors: CustomSliderColors(
          trackColors: [HexColor('#FFF8CB'), HexColor('#B9FFFF')],
          progressBarColors: [HexColor('#FFC84B'), HexColor('#00BFD5')],
          shadowColor: HexColor('#5FC7B0'),
          dynamicGradient: true,
          shadowMaxOpacity: 0.05),
      infoProperties: InfoProperties(
        bottomLabelStyle: TextStyle(
            color: HexColor('#002D43'),
            fontSize: 20,
            fontWeight: FontWeight.w700),
        bottomLabelText: '😄 Tu puedes',
        mainLabelStyle: TextStyle(
            color: Color.fromRGBO(97, 169, 210, 1),
            fontSize: 30.0,
            fontWeight: FontWeight.w200),
      ),
      counterClockwise: true,
      size: 250.0,
      startAngle: 270,
      angleRange: 340);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reto actual'),
      ),
      body: Column(
        children: [
          _infoCard(),
          _startChallengeCard(),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        children: [
          Center(
            child: Text(
              'Informacion sobre el reto actual',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: Text('Cantidad de dias'),
            leading: Icon(
              Icons.calendar_today,
              color: AppColors.PRIMARY,
            ),
            trailing: Text(widget
                .exerciseChallengeModel.challenges[widget.index].days
                .toString()),
          ),
          ListTile(
            title: Text('Cantidad de minutos'),
            leading: Icon(
              Icons.schedule,
              color: AppColors.PRIMARY,
            ),
            trailing: Text(widget
                .exerciseChallengeModel.challenges[widget.index].minuts
                .toString()),
          ),
          ListTile(
            title: Text('Cantidad de dias completadas'),
            leading: Icon(
              Icons.event_available,
              color: AppColors.PRIMARY,
            ),
            trailing: Text(widget
                .exerciseChallengeModel.challenges[widget.index].currentDay
                .toString()),
          )
        ],
      ),
    );
  }

  Widget _startChallengeCard() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        children: [
          SleekCircularSlider(
            onChangeStart: (double value) {},
            onChangeEnd: (double value) {},
            appearance: appearance03,
            min: 0,
            max: widget.exerciseChallengeModel.challenges[widget.index].minuts
                .toDouble(),
            initialValue:
                (widget.exerciseChallengeModel.challenges[widget.index].minuts -
                        minuts)
                    .toDouble(),
            innerWidget: (double value) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 150,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${minuts.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            'm',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${seconds.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            's',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(text)
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () {
                  color = AppColors.PRIMARY;
                  _currentTimer = Timer.periodic(
                      Duration(seconds: 1), (Timer t) => _getTime());
                },
                color: color,
                child: Text('Iniciar'),
              ),
              CupertinoButton(
                onPressed: () {
                  color = AppColors.GREY;
                  _currentTimer.cancel();
                  this.minuts = widget
                      .exerciseChallengeModel.challenges[widget.index].minuts
                      .toDouble();
                  this.seconds = 0;
                },
                color: HexColor('#9B9B9B'),
                child: Text('Resetear'),
              )
            ],
          )
        ],
      ),
    );
  }

  _getTime() {
    if (seconds == 0 && minuts > 0) {
      minuts--;
      seconds = 60;
    }
    else if(minuts>=0 && seconds>0){
      seconds--;
    }
    else{
      _currentTimer.cancel();
      _saveData();
    }
    setState(() {});

  }
  void _saveData()async{
    setState(() {
      text='🏆 Lo lograste!!';
    });
    if(widget.exerciseChallengeModel.challenges[widget.index].currentDay+1==widget.exerciseChallengeModel.challenges[widget.index].days){
      widget.exerciseChallengeModel.challenges[widget.index].currentDay++;
      widget.exerciseChallengeModel.challenges[widget.index].completed=true;
    }else{
      widget.exerciseChallengeModel.challenges[widget.index].currentDay++;
    }
    await this._service.createOne(widget.exerciseChallengeModel);

    _currentTimer = Timer(Duration(seconds: 2), () => _natigateToHome());
  }
  void _natigateToHome() {
    _currentTimer?.cancel();
    Navigator.pop(context);
  }
}
