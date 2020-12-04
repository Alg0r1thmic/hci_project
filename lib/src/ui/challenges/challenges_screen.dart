import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';

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
    return Column(
      children: [Text('Exercices body')],
    );
  }
}
