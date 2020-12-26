import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/models/sensor_model.dart';

import '../dashboard/dashboard.dart';
import '../challenges/challenges_screen.dart';
import '../monitor/monitor_screen.dart';
import '../profile/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;

  List<String> _titles = ["Inicio", "Monitor", "Retos", "Perfil"];

  Timer timer;

  var rng = new Random();

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _generate();
    });
    super.initState();
  }

  _generate() {
    double imc = doubleInRange(rng, 18.5, 30.0);
    double lpm = doubleInRange(rng, 50.0, 110.0);
    double temp = doubleInRange(rng, 36.0, 39.0);
    double os = doubleInRange(rng, 95.0, 100.0);

    DateTime time = DateTime.now();
    setState(() {
      sensors[0].values.add(Values(value: imc, time: time));
      sensors[1].values.add(Values(value: lpm, time: time));
      sensors[2].values.add(Values(value: temp, time: time));
      sensors[3].values.add(Values(value: os, time: time));
    });
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ALICE_BLUE,
      appBar: AppBar(
        title: Center(
                  child: Text(_titles[_currentTab], style: TextStyle(color: AppColors.BLACK),),
        ),
        backgroundColor: AppColors.ALICE_BLUE,
        elevation: 0,

      ),
      body: _getBody(),
      bottomNavigationBar: _bottonNavigationBar(),
    );
  }

  Widget _getBody(){
    if(_currentTab == 0) return DashboardScreen();
    else if (_currentTab == 1) return MonitorScreen();
    else if (_currentTab == 2) return ChallengesScreen();
    else return ProfileScreen();
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.ALICE_BLUE,
      selectedItemColor: AppColors.PRIMARY_DARK,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentTab,
      onTap: (index) {
        setState(() {
          _currentTab = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(IconData(0xf21e, fontFamily: 'Health', fontPackage: null),), label: 'Monitor'),
        BottomNavigationBarItem(icon: Icon(IconData(0xf5a2, fontFamily: 'Medal', fontPackage: null)),label: 'Retos'),
        BottomNavigationBarItem(icon: Icon(Icons.person_pin),label: 'Perfil'),
      ],
    );
  }
}
