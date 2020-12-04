import 'package:flutter/material.dart';
import 'package:health_body_checking/src/ui/challenges/widgets/start_challenge_container.dart';

class FeedingChallengesScreen extends StatefulWidget {
  FeedingChallengesScreen({Key key}) : super(key: key);

  @override
  _FeedingChallengesScreenState createState() => _FeedingChallengesScreenState();
}

class _FeedingChallengesScreenState extends State<FeedingChallengesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agua'),
      ),
      body: Column(
        children: [
          Center(child: Image.asset('assets/images/no-image.jpg',width: 100,height: 100,)),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                StartChallengeContainer(amountText: '1 Vaso diario',durationText: '1 Semana',),
                StartChallengeContainer(amountText: '1 Vaso diario',durationText: '1 Semana',),
                StartChallengeContainer(amountText: '1 Vaso diario',durationText: '1 Semana',),
              ],
            ),
          )
        ],
      ),
    );
  }
}
