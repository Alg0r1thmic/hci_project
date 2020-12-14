import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/challenge_model.dart';
import 'package:health_body_checking/src/ui/challenges/widgets/day_container_circle.dart';

enum States {
  ENABLE,
  DISABLE,
  PROGRESS,
  COMPLETE
}

class ChallengeContainer extends StatefulWidget {
  States _actualState;

  final int index;
  ChallengeContainer({Key key, @required this.index}) : super(key: key){
    bool complete = challenges[index].isComplete();
    print(complete);
    if(challenges[index].enable && !challenges[index].progress && !complete) {
      _actualState = States.ENABLE;
    } else if (!challenges[index].enable && !complete) {
      _actualState = States.DISABLE;
    } else if (challenges[index].progress && !complete) {
      _actualState = States.PROGRESS;
    } else if (complete && !challenges[index].progress){
      _actualState = States.COMPLETE;
    }
  }

  @override
  ChallengeContainerState createState() => ChallengeContainerState();
}

class ChallengeContainerState extends State<ChallengeContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.all(20),
      width: 320,
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _getViewFromState(),
    );
  }

  void updateState(States state) {
    setState(() {
     widget._actualState = state;
    });
  }

  Widget _getViewFromState() {
    if (widget._actualState == States.ENABLE) return enableBody();
    else if (widget._actualState == States.DISABLE) return disableBody();
    else if (widget._actualState == States.PROGRESS) return progressBody();
    else return completeBody();
  }

  Widget enableBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
              'assets/images/unlock.png',
              width: 80,
              height: 80,
              color: AppColors.WHITE,
            )),
        Text(
          'Empieza un nuevo reto',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.WHITE, fontSize: 18),
        ),
        _timeInfoContainer(),
        _startButton()
      ],
    );
  }

  Widget disableBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
              'assets/images/padlock.png',
              width: 80,
              height: 80,
              color: AppColors.WHITE,
            )),
        Text(
          'Parece que todavia no puedes iniciar este reto',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.WHITE, fontSize: 18),
        ),
        _timeInfoContainer()
      ],
    );
  }

  Widget progressBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (challenges[widget.index].isComplete()) ? Image.asset(
          'assets/images/trophy_color.png',
          width: 80,
          height: 80,
        ) : Image.asset(
          'assets/images/trophy.png',
          width: 60,
          height: 60,
          color: Colors.white,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DayContainerCircle(
                isFirst: true,
                fill: challenges[widget.index].days.statusDays[0],
                inputText: 'Dia 1',
                currentDay: challenges[widget.index].days.currentDayArray[0],
              ),
              DayContainerCircle(
                  fill: challenges[widget.index].days.statusDays[1],
                  inputText: 'Dia 2',
                  currentDay: challenges[widget.index].days.currentDayArray[1]
              ),
              DayContainerCircle(
                  fill: challenges[widget.index].days.statusDays[2],
                  inputText: 'Dia 3',
                  currentDay: challenges[widget.index].days.currentDayArray[2]
              ),
              DayContainerCircle(
                  fill: challenges[widget.index].days.statusDays[3],
                  inputText: 'Dia 4',
                  currentDay: challenges[widget.index].days.currentDayArray[3]
              ),
              DayContainerCircle(
                fill: challenges[widget.index].days.statusDays[4],
                inputText: 'Dia 5',
                currentDay: challenges[widget.index].days.currentDayArray[4],
              ),
              DayContainerCircle(
                  fill: challenges[widget.index].days.statusDays[5],
                  inputText: 'Dia 6',
                  currentDay: challenges[widget.index].days.currentDayArray[5]
              ),
              DayContainerCircle(
                  fill: challenges[widget.index].days.statusDays[6],
                  inputText: 'Dia 7',
                  currentDay: challenges[widget.index].days.currentDayArray[6]
              ),
            ],
          ),
        ),
        Text(
          getText(),
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.WHITE, fontSize: 16),
        ),
        _madeButton()
      ],
    );
  }

  Widget completeBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
              'assets/images/trophy_color.png',
              width: 80,
              height: 80,
              color: AppColors.ORANGE,
            )),
        Text(
          '¡Terminaste este reto!',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.WHITE, fontSize: 18),
        ),
        _timeInfoContainer()
      ],
    );
  }

  Widget _timeInfoContainer() {
    return Container(
      padding: EdgeInsets.only(left: 40),
      width: 250,
      height: 80,
      decoration: BoxDecoration(color: AppColors.WHITE.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Duracion:    ' + challenges[widget.index].duration,
            style: TextStyle(color: AppColors.WHITE),
          ),
          Text(
            'Cantidad:   ' + challenges[widget.index].amount,
            style: TextStyle(color: AppColors.WHITE),
          )
        ],
      ),
    );
  }

  Widget _startButton() {
    return InkWell(
      onTap: () {
        challenges[widget.index].progress = true;
        updateState(States.PROGRESS);
      },
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(color: AppColors.SECONDARY, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          'EMPEZAR',
          style: TextStyle(color: AppColors.WHITE),
        )),
      ),
    );
  }

  Color _getColor() {
    if (widget._actualState == States.COMPLETE) {
      return AppColors.PRIMARY_DARK;
    } else if (widget._actualState == States.DISABLE) {
      return AppColors.CASCADE;
    } else if (widget._actualState == States.ENABLE) {
      return AppColors.PRIMARY;
    } else return AppColors.PRIMARY_DARK;
  }

  String getText() {
    return (!challenges[widget.index].isComplete()) ? '¿Lograste terminar el reto hoy?' : '¡Lo lograste!';
  }

  Widget _madeButton() {
    return InkWell(
      onTap: () {
        if (challenges[widget.index].days.currentDay < 7) {
          setState(() {
            if (challenges[widget.index].days.currentDay == 6) {
              challenges[widget.index].progress = false;
              if (challenges.length != widget.index)  challenges[widget.index + 1].enable = true;
              updateState(States.COMPLETE);
            }
            int current = challenges[widget.index].days.currentDay;
            challenges[widget.index].days.currentDayArray[current] = false;
            challenges[widget.index].days.statusDays[current] = true;
            challenges[widget.index].days.currentDay++;
            challenges[widget.index].days.currentDayArray[current+1] = true;
          });
        }
      },
      child: (!challenges[widget.index].isComplete()) ? Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.SECONDARY,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
            child: Text(
              'Si, lo logre',
              style: TextStyle(color: AppColors.WHITE, fontSize: 16),
            )
        ),
      ): SizedBox(),
    );
  }

}
