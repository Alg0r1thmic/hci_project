import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../challenges/challenges_screen.dart';
import '../dashboard/dashboard.dart';
import '../monitor/monitor_screen.dart';
import '../profile/profile_screen.dart';

class Home extends StatefulWidget {
  final int tab;
  final int challengeTab;
  const Home({Key key, this.tab = 0, this.challengeTab = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;

  List<String> _titles = ["Inicio", "Monitor", "Retos", "Perfil"];

  @override
  void initState() {
    super.initState();
    _currentTab = widget.tab;
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
    else if (_currentTab == 2) return ChallengesScreen(currentTab: widget.challengeTab);
    else return ProfileScreen();
  }

  Widget _bottonNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.WHITE,
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
