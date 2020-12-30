import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/exercise_challenge_model.dart';
import 'package:health_body_checking/src/services/exercise_callenge_service.dart';
import 'package:health_body_checking/src/utils/hex_color.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../constants/app_colors.dart';

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
  String text = 'Tu puedes!! 💪😀';
  double _currentSeconds = 0;
  bool showMessage = false;
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
        bottomLabelText: 'Tu puedes!! 💪😀',
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
        backgroundColor: Color.fromRGBO(226, 226, 226, 1),
        appBar: AppBar(
            title: Text(
              'Reto actual',
              style: TextStyle(color: AppColors.BLACK),
            ),
            backgroundColor: AppColors.WHITE,
            leading: MaterialButton(
              onPressed: () {
                if (_currentSeconds > 0) {
                  _showMessageDialog(
                      title: 'salir',
                      content:
                          'Recuerda que aun no has terminado el reto y tu progreso se perdera');
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Icon(Icons.arrow_back, color: AppColors.BLACK),
            )),
        body: Stack(
          children: [
            Column(
              children: [
                _infoCard(),
                _startChallengeCard(),
              ],
            ),
            (showMessage) ? _showMessage() : SizedBox(),
          ],
        ));
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
            appearance: appearance03,
            min: 0,
            max: 60 *
                widget.exerciseChallengeModel.challenges[widget.index].minuts
                    .toDouble(),
            initialValue: _currentSeconds,
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
                      Text('Quedan'),
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
                  this._currentSeconds = 0;
                  setState(() {});
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
    } else if (minuts >= 0 && seconds > 0) {
      seconds--;
      _currentSeconds++;
    } else {
      _currentTimer.cancel();
      _saveData();
    }

    setState(() {});
  }

  void _saveData() async {
    setState(() {
      text = '🏆 Lo lograste!!';
    });
    if (widget.exerciseChallengeModel.challenges[widget.index].currentDay + 1 ==
        widget.exerciseChallengeModel.challenges[widget.index].days) {
      widget.exerciseChallengeModel.challenges[widget.index].currentDay++;
      widget.exerciseChallengeModel.challenges[widget.index].completed = true;
    } else {
      widget.exerciseChallengeModel.challenges[widget.index].currentDay++;
    }
    await this._service.createOne(widget.exerciseChallengeModel);
    _natigateToHome();
  }

  void _goBack() {
    _currentTimer?.cancel();
    Navigator.of(context).pop();
  }

  void _showMessageDialog({String title, String content, int index}) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Estas seguro que quieres salir?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: new Text(content),
          actions: <Widget>[
            FlatButton(
              color: AppColors.ELECTROMACNETIC,
              child: Row(
                children: [
                  Icon(
                    Icons.check_box,
                    color: AppColors.PRIMARY,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "SI",
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _goBack();
              },
            ),
            SizedBox(
              width: 10,
            ),
            FlatButton(
              color: AppColors.ELECTROMACNETIC,
              child: Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: AppColors.ORANGE,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "NO",
                  ),
                ],
              ),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showMessage() {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(color: AppColors.BLACK.withOpacity(0.5)),
      child: Column(
        children: [
          Container(padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.PRIMARY,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text('Felicidades !! , Lo lograste',style:TextStyle(color: AppColors.WHITE,fontSize: 18),))),
          Expanded(
              child: FlareActor("assets/animation/trophy.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Untitled")),
          InkWell(
            onTap: (){
              FlutterRingtonePlayer.stop();
              _navigateToBack();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(color: AppColors.PRIMARY,
              borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text('✖ Salir',style: TextStyle(color: AppColors.WHITE,fontWeight: FontWeight.bold,fontSize: 18),)),
            ),
          ),
          
        ],
      ),
    );
  }

  void _natigateToHome() {
    _currentTimer?.cancel();
    FlutterRingtonePlayer.playAlarm();
    showMessage=true;
    setState(() {
      
    });
    //avigator.pop(context);
  }

  void _navigateToBack() {
    Navigator.of(context).pop();
  }

  void _showValidateMessage(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.yellow,
                  size: 30,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              children: [],
            ),
            actions: [
              FlatButton(
                color: AppColors.ELECTROMACNETIC,
                child: Row(
                  children: [
                    Icon(
                      Icons.check_box,
                      color: AppColors.PRIMARY,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Salir",
                    ),
                  ],
                ),
                onPressed: () {
                  FlutterRingtonePlayer.stop();
                  Navigator.of(context).pop();
                  _navigateToBack();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _currentTimer?.cancel();
    super.dispose();
  }
}
