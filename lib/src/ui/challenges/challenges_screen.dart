import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/ui/challenges/widgets/feeding_challenge_container.dart';

class ChallengesScreen extends StatefulWidget {
  ChallengesScreen({Key key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: _tabBarHeader(),
            ),
            key: _scaffoldKey,
            body: TabBarView(children: [_exercises(), _feeding()])));
  }

  Widget _tabBarHeader() {
    return TabBar(
      unselectedLabelColor: AppColors.PRIMARY_DARK,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.PRIMARY_DARK),
      tabs: [_tabBarHeaderTextContainer(text: 'Actividad física'), _tabBarHeaderTextContainer(text: 'Alimentación')]
    );
  }


  Widget _tabBarHeaderTextContainer({String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.PRIMARY_DARK, width: 1)),
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }

  Widget _exercises() {
    return Column(
      children: [Text('Exercices body')],
    );
  }

  Widget _feeding() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FeedingChallengeContainer(
              contentText: 'Empecemos el habito de tomar agua',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {
                Navigator.pushNamed(context, Routes.feeding_challenges);
              },
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Mantengamos el hábito de comer fruta',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Empecemos el hábito de comer',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Empecemos el habito de tomar agua',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
