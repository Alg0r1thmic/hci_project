import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';
import 'package:health_body_checking/src/ui/questions/widgets/pagination.dart';

class QuestionFiveScreen extends StatefulWidget {
  final VoidCallback onGoToBackQuestion;
  QuestionFiveScreen({
    Key key,
    @required this.onGoToBackQuestion,
  }) : super(key: key);
  @override
  _QuestionFiveScreenState createState() => _QuestionFiveScreenState();
}

class _QuestionFiveScreenState extends State<QuestionFiveScreen> {
  double _currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              PaginationText(total: 5, actual: 5),
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
        _goToHomeButton(),
      ],
    );
  }

  Widget _goToHomeButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.SECONDARY,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text('FINALIZAR',style: TextStyle(color: AppColors.WHITE),),),
      ),
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset("assets/images/fruit.png"),
        ),
        Text(
          "¿Cuántos días a la semana consumes fruta?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 7,
          divisions: 6,
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