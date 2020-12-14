
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
      decoration: BoxDecoration(
          color: AppColors.PRIMARY,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0)
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 200,
            child: Text(
              contentText,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            )
          ),
          InkWell(
            onTap: inputFunction,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.ORANGE,
                borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 10.0),
                        blurRadius: 5.0)
                  ]
              ),
              child: Icon(Icons.play_arrow_rounded, color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}
