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
  Color _selectedColor = AppColors.PRIMARY_DARK;
  Color _unSelectedColor = AppColors.PRIMARY_LIGHT;
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
      indicatorColor: Colors.transparent,
      tabs: [_tabBarHeaderTextContainer(text: 'Ejercicios', color: _selectedColor), _tabBarHeaderTextContainer(text: 'Alimentación', color: _unSelectedColor)],
      onTap: (index) {
        if (index == 0) {
          _selectedColor = AppColors.PRIMARY_DARK;
          _unSelectedColor = AppColors.PRIMARY_LIGHT;
        } else if (index == 1) {
          _selectedColor = AppColors.PRIMARY_LIGHT;
          _unSelectedColor = AppColors.PRIMARY_DARK;
        }
        setState(() {});
      },
    );
  }

  Widget _tabBarHeaderTextContainer({String text, Color color}) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
              contentText: 'Empesemos el habito de tomar agua',
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
              contentText: 'Empesemos el hábito de comer',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Empesemos el habito de tomar agua',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
