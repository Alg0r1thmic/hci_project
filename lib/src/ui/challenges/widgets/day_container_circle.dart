import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

class DayContainerCircle extends StatelessWidget {
  final bool fill;
  final String inputText;
  final bool isFirst;
  final bool currentDay;
  const DayContainerCircle({Key key, this.fill, this.inputText, this.isFirst = false, this.currentDay = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (isFirst == false) ? Center(
            child: Container(
                height: 10,
                width: 30,
                color: (fill) ? AppColors.PRIMARY : AppColors.PRIMARY_LIGHT,
            )
        ) : SizedBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (currentDay) ? SizedBox(height: 40) : SizedBox(),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: (fill) ? AppColors.PRIMARY : AppColors.PRIMARY_LIGHT,
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(color: AppColors.PRIMARY_DARK)
              ),
              child: Center(
                child: Text(
                  inputText,
                  style: TextStyle(color: AppColors.WHITE),
                ),
              ),
            ),
            _getindicator()
          ],
        ),
      ],
    );
  }

  Widget _getindicator() {
    return (currentDay) ? Column(
      children: [
        Icon(
          Icons.arrow_drop_up,
          color: AppColors.PRIMARY,
        ),
        Text(
          'Hoy',
          style: TextStyle(color: AppColors.WHITE, fontWeight: FontWeight.bold),
        )
      ],
    ): Container();
  }
}
