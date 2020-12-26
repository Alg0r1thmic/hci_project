import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
//import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class QuestionFourScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionFourScreen({Key key, @required this.onGoToNextQuestion, @required this.onGoToBackQuestion}) : super(key: key);
  @override
  _QuestionFourScreenState createState() => _QuestionFourScreenState();
}

class _QuestionFourScreenState extends State<QuestionFourScreen> {

  double _currentSliderValue = 2;

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
          inputFunction: widget.onGoToNextQuestion,
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
          controller: TextEditingController(),
          min: 0,
          max: 240,
          incDecBgColor: Colors.blue,
          buttonArrangement: ButtonArrangement.incRightDecLeft,

        ): Container()

      ],
    );
  }
}
