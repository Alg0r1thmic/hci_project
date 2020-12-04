import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/ui/questions/widgets/next_or_back_button.dart';

class QuestionThreeScreen extends StatefulWidget {
  final VoidCallback onGoToBackQuestion;
  QuestionThreeScreen({
    Key key,
    @required this.onGoToBackQuestion,
  }) : super(key: key);
  @override
  _QuestionThreeScreenState createState() => _QuestionThreeScreenState();
}

class _QuestionThreeScreenState extends State<QuestionThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Text('Page 3'),
          Expanded(child: SizedBox()),
          _questionsChangeButton(),
        ],
      ),
    ));
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.arrow_forward,
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
}
