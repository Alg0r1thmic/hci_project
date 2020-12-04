import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/questions/question_one_screen.dart';
import 'package:health_body_checking/src/ui/questions/question_three_screen..dart';
import 'package:health_body_checking/src/ui/questions/question_two_screen.dart';
import 'package:health_body_checking/src/ui/questions/question_four_screen.dart';
import 'package:health_body_checking/src/ui/questions/question_five_screen.dart';

class QuestionIndex {
  QuestionIndex._();
  static const int QUESTION_ONE = 0;
  static const int QUESTION_TWO = 1;
  static const int QUESTION_THREE = 2;
  static const int QUESTION_FOUR = 3;
  static const int QUESTION_FIVE = 4;
  
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
        ),
        QuestionThreeScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_TWO);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_FOUR);
          },
        ),
        QuestionFourScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_THREE);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_FIVE);
          },
        ),
        QuestionFiveScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ONE);
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
