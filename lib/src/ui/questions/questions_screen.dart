import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/question_one_screen.dart';
import 'package:health_body_checking/src/ui/questions/question_two_screen.dart';

class QuestionIndex {
  QuestionIndex._();
  static const int QUESTION_ONE = 0;
  static const int QUESTION_TWO = 1;
  static const int QUESTION_THREE = 2;
}

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({Key key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  void _switchForm(int page) {
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        QuestionOneScren(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ONE);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_TWO);
          },
        ),
        QuestionTwoScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ONE);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_THREE);
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
