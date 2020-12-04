import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class StartChallengeContainer extends StatelessWidget {
  final String amountText;
  final String durationText;
  final VoidCallback inputFunction;
  const StartChallengeContainer({Key key, @required this.amountText, @required this.durationText, this.inputFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: 60, bottom: 40),
      padding: EdgeInsets.all(20),
      width: 350,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.PRIMARY,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/no-image.jpg',
            width: 100,
            height: 100,
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Empieza un nuevo reto',
            style: TextStyle(color: AppColors.WHITE, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          _timeInfoContainer(),
          SizedBox(
            height: 40,
          ),
          _startButton()
        ],
      ),
    );
  }

  Widget _timeInfoContainer() {
    return Container(
      padding: EdgeInsets.only(left: 40),
      width: 250,
      height: 80,
      decoration: BoxDecoration(color: AppColors.WHITE.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Duracion: $durationText',style: TextStyle(color: AppColors.WHITE),),
          SizedBox(
            height: 10,
          ),
          Text('Cantidad: $amountText',style: TextStyle(color: AppColors.WHITE),)
        ],
      ),
    );
  }

  Widget _startButton() {
    return InkWell(
      onTap: inputFunction,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.SECONDARY,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(child: Text('EMPEZAR',style: TextStyle(color: AppColors.WHITE),)),
      ),
    
    );
  }
}
