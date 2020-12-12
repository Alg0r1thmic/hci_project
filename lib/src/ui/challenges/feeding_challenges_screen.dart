import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/constants/fake_water_days.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/ui/challenges/widgets/start_challenge_container.dart';
import 'package:health_body_checking/src/models/challenge_model.dart';

class FeedingChallengesScreen extends StatefulWidget {
  FeedingChallengesScreen({Key key}) : super(key: key);

  @override
  FeedingChallengesScreenState createState() => FeedingChallengesScreenState();
}

class FeedingChallengesScreenState extends State<FeedingChallengesScreen> with WidgetsBindingObserver {

  List<ChallengeModel> challenges = [
    ChallengeModel(amount: "1 vaso diario", duration: "1 semana", enable: true, complete: false),
    ChallengeModel(amount: "2 vasos diarios", duration: "1 semana", enable: false, complete: false),
    ChallengeModel(amount: "3 vasos diarios", duration: "1 semana", enable: false, complete: false),
  ];

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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView. builder(
                  itemCount: challenges.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _getChallenge(challenges[index].amount, challenges[index].duration, challenges[index].enable);
                  }
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _getChallenge(String amount, String duration, bool enable) {
    return StartChallengeContainer(
        amountText: amount,
        durationText: duration,
        enable: enable,
        complete: (FakeWaterDays().currentDay < 6) ? false : true,
        inputFunction: () {
          Navigator.pushNamed(context, Routes.current_challenge);
        }
    );
  }
}
