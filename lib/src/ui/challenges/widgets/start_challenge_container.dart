import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class StartChallengeContainer extends StatelessWidget {
  final String amountText;
  final String durationText;
  final VoidCallback inputFunction;
  final String imagePath;
  final bool complete;
  final bool enable;
  const StartChallengeContainer({Key key, this.enable = true, @required this.amountText, @required this.durationText, this.inputFunction, this.imagePath, this.complete=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,  bottom: 40, right: 20),
      padding: EdgeInsets.all(20),
      width: 320,
      height: 300,
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            enable ? 'assets/images/unlock.png': 'assets/images/padlock.png',
            width: 80,
            height: 80,
            color: (complete==false)?AppColors.LIME:AppColors.WHITE,
          )),
          SizedBox(
            height: 20,
          ),
          (complete==false)? Text(
            'Empieza un nuevo reto',
            style: TextStyle(color: AppColors.WHITE, fontSize: 24),
          ):Text(
            'Terminaste este reto',
            style: TextStyle(color: AppColors.WHITE, fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          _timeInfoContainer(),
          SizedBox(
            height: 40,
          ),
          (complete==false)?_startButton():SizedBox()
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
          Text(
            'Duracion: $durationText',
            style: TextStyle(color: AppColors.WHITE),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Cantidad: $amountText',
            style: TextStyle(color: AppColors.WHITE),
          )
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
        decoration: BoxDecoration(color: AppColors.SECONDARY, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          'EMPEZAR',
          style: TextStyle(color: AppColors.WHITE),
        )),
      ),
    );
  }

  Color _getColor() {
    if (enable){
      if (complete) return AppColors.PRIMARY_DARK;
      else return AppColors.PRIMARY;
    } else return AppColors.CASCADE;
  }
}
