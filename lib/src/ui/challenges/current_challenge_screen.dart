import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/fake_water_days.dart';
import '../../core/routes/routes.dart';

class CurrentChallengeScreen extends StatefulWidget {
  CurrentChallengeScreen({Key key}) : super(key: key);

  @override
  _CurrentChallengeScreenState createState() => _CurrentChallengeScreenState();
}

class _CurrentChallengeScreenState extends State<CurrentChallengeScreen> {
  Timer timer;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(milliseconds: 500), () => _moveToCenter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Reto actual',
            style: TextStyle(color: AppColors.BLACK),
          ),
          backgroundColor: AppColors.WHITE,
          elevation: 0.6,
          leading: MaterialButton(onPressed: () {
            Navigator.of(context).pop();

          },
          child: Icon(Icons.arrow_back,color: AppColors.BLACK,),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (FakeWaterDays().currentDay == 6)
                ? Image.asset(
                    'assets/images/trophy_color.png',
                    width: 100,
                    height: 100,
                  )
                : Image.asset(
                    'assets/images/trophy.png',
                    width: 100,
                    height: 100,
                  ),
            SizedBox(
              height: 40,
            ),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DayContainerCircle(
                    isFirst: true,
                    fill: FakeWaterDays().statusDays[0],
                    inputText: 'Dia 1',
                    currentDay: FakeWaterDays().currentDayArray[0],
                  ),
                  DayContainerCircle(fill: FakeWaterDays().statusDays[1], inputText: 'Dia 2', currentDay: FakeWaterDays().currentDayArray[1]),
                  DayContainerCircle(fill: FakeWaterDays().statusDays[2], inputText: 'Dia 3', currentDay: FakeWaterDays().currentDayArray[2]),
                  DayContainerCircle(fill: FakeWaterDays().statusDays[3], inputText: 'Dia 4', currentDay: FakeWaterDays().currentDayArray[3]),
                  DayContainerCircle(
                    fill: FakeWaterDays().statusDays[4],
                    inputText: 'Dia 5',
                    currentDay: FakeWaterDays().currentDayArray[4],
                  ),
                  DayContainerCircle(fill: FakeWaterDays().statusDays[5], inputText: 'Dia 6', currentDay: FakeWaterDays().currentDayArray[5]),
                  DayContainerCircle(fill: FakeWaterDays().statusDays[6], inputText: 'Dia 7', currentDay: FakeWaterDays().currentDayArray[6]),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            (FakeWaterDays().currentDay < 6)
                ? Text(
                    'Lograste terminar el reto hoy?',
                    style: TextStyle(color: AppColors.BLACK, fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : SizedBox(),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                _moveToCenter();
                if (FakeWaterDays().currentDay < 7) {
                  FakeWaterDays().currentDayArray[FakeWaterDays().currentDay] = false;
                  FakeWaterDays().currentDay++;
                  FakeWaterDays().currentDayArray[FakeWaterDays().currentDay] = true;
                  FakeWaterDays().statusDays[FakeWaterDays().currentDay] = true;
                  setState(() {});
                  if (FakeWaterDays().currentDay == 6) {
                    timer = Timer(Duration(seconds: 2), () => _navigatePop());
                  }
                }
              },
              child: (FakeWaterDays().currentDay < 6)
                  ? Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(color: AppColors.SECONDARY, borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text(
                        'MARCAR',
                        style: TextStyle(color: AppColors.WHITE, fontSize: 20),
                      )),
                    )
                  : SizedBox(),
            )
          ],
        ));
  }

  void _navigatePop() {
    Navigator.popAndPushNamed(context, Routes.feeding_challenges);
    timer?.cancel();
  }

  void _moveToCenter() {
    _scrollController.animateTo(200, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

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
        (isFirst == false)
            ? Center(
                child: Container(
                height: 10,
                width: 30,
                color: (fill) ? AppColors.PRIMARY : AppColors.PRIMARY_LIGHT,
              ))
            : SizedBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            (currentDay)
                ? SizedBox(
                    height: 40,
                  )
                : SizedBox(),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: (fill) ? AppColors.PRIMARY : AppColors.PRIMARY_LIGHT, borderRadius: BorderRadius.circular(80), border: Border.all(color: AppColors.PRIMARY)),
              child: Center(
                child: Text(
                  inputText,
                  style: TextStyle(color: AppColors.WHITE),
                ),
              ),
            ),
            (currentDay)
                ? Icon(
                    Icons.arrow_drop_up,
                    color: AppColors.PRIMARY,
                  )
                : SizedBox(),
            (currentDay)
                ? Text(
                    'Hoy',
                    style: TextStyle(color: AppColors.BLACK, fontWeight: FontWeight.bold),
                  )
                : SizedBox()
          ],
        ),
      ],
    );
  }
}
