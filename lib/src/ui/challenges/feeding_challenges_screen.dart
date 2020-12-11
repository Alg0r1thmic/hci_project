import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/constants/fake_water_days.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/ui/challenges/widgets/start_challenge_container.dart';

class FeedingChallengesScreen extends StatefulWidget {
  FeedingChallengesScreen({Key key}) : super(key: key);

  @override
  FeedingChallengesScreenState createState() => FeedingChallengesScreenState();
}

class FeedingChallengesScreenState extends State<FeedingChallengesScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agua',
          style: TextStyle(color: AppColors.BLACK),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.WHITE,
        elevation: 0.6,
        leading: MaterialButton(onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
              child: Image.asset(
            'assets/images/glass-of-water.png',
            width: 80,
            height: 80,
          )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                (FakeWaterDays().currentDay < 6)
                    ? StartChallengeContainer(
                        amountText: '1 Vaso diario',
                        durationText: '1 Semana',
                        imagePath: 'assets/images/unlock.png',
                        inputFunction: () {
                          Navigator.pushNamed(context, Routes.current_challenge);
                        },
                      )
                    : StartChallengeContainer(
                        amountText: '1 Vaso diario',
                        durationText: '1 Semana',
                        imagePath: 'assets/images/check_1.png',
                        complete: true,
                        inputFunction: () {
                          Navigator.pushNamed(context, Routes.current_challenge);
                        },
                      ),
                (FakeWaterDays().currentDay == 6)
                    ? StartChallengeContainer(
                        amountText: '2 Vaso diario',
                        imagePath: 'assets/images/unlock.png',
                        durationText: '1 Semana',
                      )
                    : Opacity(
                        opacity: 0.5,
                        child: StartChallengeContainer(
                          amountText: '2 Vaso diario',
                          imagePath: 'assets/images/padlock.png',
                          durationText: '1 Semana',
                        ),
                      ),
                Opacity(
                  opacity: 0.5,
                  child: StartChallengeContainer(
                    amountText: '3 Vaso diario',
                    imagePath: 'assets/images/padlock.png',
                    durationText: '1 Semana',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
