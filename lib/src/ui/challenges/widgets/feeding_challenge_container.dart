
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class FeedingChallengeContainer extends StatelessWidget {
  final String contentText;
  final String imagePath;
  final VoidCallback inputFunction;
  const FeedingChallengeContainer({Key key, this.contentText, this.imagePath, this.inputFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(color: AppColors.WHITE, borderRadius: BorderRadius.circular(10), 
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: Text(contentText,style: TextStyle(fontSize: 22),textAlign: TextAlign.center,)),
          Expanded(child: SizedBox()),
          Column(
            children: [
              SizedBox(height: 10,),
              Image.asset(imagePath,width: 100,height: 100,),
              SizedBox(height: 10,),
              InkWell(
                onTap: inputFunction,
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.SECONDARY
                  ),
                  child: Center(
                    child: Text('VER RETOS',style: TextStyle(color: AppColors.WHITE),),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
