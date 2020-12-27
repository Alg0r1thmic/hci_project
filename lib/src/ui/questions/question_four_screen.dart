import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/exercise_question_model.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/services/exercise_question_service.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
//import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionFourScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionFourScreen({Key key, @required this.onGoToNextQuestion, @required this.onGoToBackQuestion}) : super(key: key);
  @override
  _QuestionFourScreenState createState() => _QuestionFourScreenState();
}

class _QuestionFourScreenState extends State<QuestionFourScreen> {

  ExerciseQuestionService _service;
  ExerciseQuestionModel _model;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() { 
    super.initState();
    _service=ExerciseQuestionService();
  }
  double _currentSliderValue = 2;
  void _saveData()async{
    _model=ExerciseQuestionModel(id: DateTime.now().toIso8601String(),userId: CurrentUserModel.instance.id,days: _currentSliderValue.toInt(),minuts:int.parse(_controller.text));
    await _service.createOne(_model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              PaginationText(total: 6, actual: 5),
              Expanded(child: SizedBox(child: _content(),)),
              _questionsChangeButton(),
            ],
          ),
        )
      )
    );
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.west,
        ),
        NextOrBackButton(
          inputFunction:(){
            this._saveData();
            widget.onGoToNextQuestion();
          
          } ,
          icon: Icons.east,
        )
      ],
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset("assets/images/ejer.png", height: 150,),
        ),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Cuantas ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'veces a la semana ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'realizas actividad fisica? ', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        SfSlider(
          min: 0.0,
          max: 7.0,
          value: _currentSliderValue,
          interval: 1,
          showLabels: true,
          onChanged: (dynamic value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Durante cuántos ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'minutos ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '?', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),


        _currentSliderValue != 0 ?
        NumberInputPrefabbed.roundedEdgeButtons(
          controller: _controller,
          autovalidate: true,
          min: 0,
          max: 40,
          incDecBgColor: Colors.blue,
          buttonArrangement: ButtonArrangement.incRightDecLeft,
        ): Container()

      ],
    );
  }
}
