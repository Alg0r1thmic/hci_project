import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../models/challenge_model.dart';
import 'widgets/start_challenge_container.dart';

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
        backgroundColor: AppColors.ALICE_BLUE,
        elevation: 0.0,
        leading: MaterialButton(onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.west),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView. builder(
                padding: EdgeInsets.only(right: 15),
                  itemCount: challenges.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ChallengeContainer(index: index);
                  }
              )
            )
          ],
        ),
      ),
    );
  }

}
