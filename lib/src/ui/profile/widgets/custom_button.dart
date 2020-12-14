import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback inputFunction;
  final String text;
  final bool filled;
  const CustomButton({Key key,@required this.inputFunction,@required this.text,this.filled=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: inputFunction,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: (filled)?AppColors.SECONDARY:AppColors.PRIMARY_DARK),
          borderRadius: BorderRadius.circular(10),
          color:(filled)?AppColors.SECONDARY:AppColors.WHITE
        ),
        child: Center(
          child: Text(text,style: TextStyle(color: (filled)?AppColors.WHITE:AppColors.PRIMARY_DARK),),
        ),
      ),
    );
  }
}
