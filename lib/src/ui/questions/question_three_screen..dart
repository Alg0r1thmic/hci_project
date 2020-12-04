import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';

class QuestionThreeScreen extends StatefulWidget {
  final VoidCallback onGoToBackQuestion;
  final VoidCallback onGoToNextQuestion;
  QuestionThreeScreen({
    Key key,
    @required this.onGoToBackQuestion,
    @required this.onGoToNextQuestion
  }) : super(key: key);
  @override
  _QuestionThreeScreenState createState() => _QuestionThreeScreenState();
}

class _QuestionThreeScreenState extends State<QuestionThreeScreen> {
  double _currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                PaginationText(total: 5, actual: 3),
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
          child: Image.asset("assets/images/tea.png"),
        ),
        Text(
          "¿Con cuántas cucharitas de azúcar endulzas tu taza?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 8,
          divisions: 7,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        )
      ],
    );
  }

}
