
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
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(color: AppColors.WHITE, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0), BoxShadow(color: Colors.black12, offset: Offset(0.0, -10.0), blurRadius: 10.0)]),
      child: Row(
        children: [
          Text(contentText),
          Column(
            children: [
              Image.asset(imagePath,width: 100,height: 100,),
              InkWell(
                onTap: inputFunction,
                child: Container(
                  width: 140,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.SECONDARY
                  ),
                  child: Center(
                    child: Text('VER RETOS'),
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
