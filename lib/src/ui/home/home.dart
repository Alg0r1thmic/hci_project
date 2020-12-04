import 'package:flutter/material.dart';

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
  Widget _currentScreem;
  List<Widget> _screems;
  //Pages or Screems For Tab
  MonitorScreen _monitorScreen;
  ChallengesScreen _challengesScreen;
  ProfileScreen _profileScreem;
  @override
  void initState() {
    super.initState();
    _monitorScreen = MonitorScreen();
    _challengesScreen = ChallengesScreen();
    _profileScreem = ProfileScreen();
    _screems = [_monitorScreen,_challengesScreen, _profileScreem];
    _currentScreem = _monitorScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.dodgerBlue,
      appBar: AppBar(
        title: Center(
                  child: Text(_currentTab == 0
              ? 'Monitor'
              : _currentTab == 1
                  ? 'Retos'
                  : 'Perfil', style: TextStyle(color: Colors.black),),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _currentScreem,
      bottomNavigationBar: _bottonNavigationBar(),
    );
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentTab,
      onTap: (index) {
        setState(() {
          _currentTab = index;
          _currentScreem = _screems[_currentTab];
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Monitor'),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit),label: 'Retos'),
        BottomNavigationBarItem(icon: Icon(Icons.person_pin),label: 'Perfil'),
      ],
    );
  }
}
