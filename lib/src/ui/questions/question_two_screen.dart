import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';


class QuestionTwoScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionTwoScreen({Key key, @required this.onGoToBackQuestion, @required this.onGoToNextQuestion}) : super(key: key);
  @override
  _QuestionTwoScreenState createState() => _QuestionTwoScreenState();
}

class _QuestionTwoScreenState extends State<QuestionTwoScreen> {

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Nunca", textAlign: TextAlign.center),
    //1: Text("1 vez cada 2 semanas", textAlign: TextAlign.center),
    1: Text("Quincenal", textAlign: TextAlign.center),
    2: Text("Semanal", textAlign: TextAlign.center),
    3: Text("Diario", textAlign: TextAlign.center),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              PaginationText(total: 6, actual: 3),
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
          child: Image.asset("assets/images/fastfood.png", height: 150,),
        ),


        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Con que frecuencia consumes ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'comida rapida?', style: TextStyle(fontWeight: FontWeight.bold)),
//              TextSpan(text: 'tomas al dia? ', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        CupertinoSlidingSegmentedControl(
          children: myTabs,
          groupValue: segmentedControlGroupValue,
          onValueChanged: (value) {
            setState(() {
              segmentedControlGroupValue = value;
            });
          }
        )
      ],
    );
  }
}
