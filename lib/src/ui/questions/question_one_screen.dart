import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class QuestionOneScren extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  QuestionOneScren({Key key, @required this.onGoToNextQuestion,}) : super(key: key);
  @override
  _QuestionOneScrenState createState() => _QuestionOneScrenState();
}

class _QuestionOneScrenState extends State<QuestionOneScren> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              PaginationText(total: 5, actual: 1),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
          child: Image.asset("assets/images/glass.png", height: 150,),
        ),

        Text(
          _currentSliderValue.round().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),


        RichText(
          text:
            TextSpan(style: TextStyle(fontSize: 30, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '¿Cuantos ', style: TextStyle(fontWeight: FontWeight.normal)),
                TextSpan(text: 'vasos de agua ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'tomas al dia? ', style: TextStyle(fontWeight: FontWeight.normal)),
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
