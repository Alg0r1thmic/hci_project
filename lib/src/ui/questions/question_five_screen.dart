import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants/app_colors.dart';
import '../../core/routes/routes.dart';
import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

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
  double _currentSliderValue = 0;

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
          child: Image.asset("assets/images/fruit.png", height: 150,),
        ),
        Text(
          _currentSliderValue.round().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30
          ),
        ),


        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 30, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Cuantas ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'frutas ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'comes a la semana? ', style: TextStyle(fontWeight: FontWeight.normal)),
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
