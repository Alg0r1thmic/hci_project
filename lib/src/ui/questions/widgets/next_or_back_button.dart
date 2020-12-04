import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class NextOrBackButton extends StatelessWidget {
  final VoidCallback inputFunction;
  final IconData icon;
  const NextOrBackButton({Key key, this.inputFunction,@required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: inputFunction,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: AppColors.SECONDARY),
        child: Center(child: Icon(this.icon, color: Colors.white,),),
      ),
    );
  }
}
