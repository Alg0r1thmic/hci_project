import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';

class QuestionOneScren extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  QuestionOneScren({Key key, @required this.onGoToNextQuestion,}) : super(key: key);
  @override
  _QuestionOneScrenState createState() => _QuestionOneScrenState();
}

class _QuestionOneScrenState extends State<QuestionOneScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Column(
          children: [
            Text('Page 1'),
            Expanded(child: SizedBox()),
            _questionsChangeButton(),
          ],
        ),
      )
    );
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToNextQuestion,
          icon: Icons.arrow_forward,
        )
      ],
    );
  }
  
}
