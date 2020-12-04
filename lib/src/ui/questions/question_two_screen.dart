import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';

class QuestionTwoScreen extends StatefulWidget {
  final VoidCallback onGoToNextQuestion;
  final VoidCallback onGoToBackQuestion;
  QuestionTwoScreen({Key key, @required this.onGoToNextQuestion, @required this.onGoToBackQuestion}) : super(key: key);
  @override
  _QuestionTwoScreenState createState() => _QuestionTwoScreenState();
}

class _QuestionTwoScreenState extends State<QuestionTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Column(
          children: [
            Text('Page 2'),
            Expanded(child: SizedBox()),
            _questionsChangeButton(),
          ],
        ),
      )
    );
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.arrow_back,
        ),
        NextOrBackButton(
          inputFunction: widget.onGoToNextQuestion,
          icon: Icons.arrow_forward,
        )
      ],
    );
  }
  
}
