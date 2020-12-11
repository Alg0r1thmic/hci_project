import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class VisualizationHeader extends StatelessWidget {
  final String text;
  const VisualizationHeader({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.PRIMARY_LIGHT),
        child: Center(
          child: Text(text,style: TextStyle(color: AppColors.WHITE,fontSize: 20 ),),
        ),
      ),
    );
  }
}
