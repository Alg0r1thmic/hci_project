import 'package:flutter/cupertino.dart';
import 'package:health_body_checking/src/ui/challenges/current_challenge_screen.dart';
import 'package:health_body_checking/src/ui/challenges/feeding_challenges_screen.dart';
import 'package:health_body_checking/src/ui/monitor/data_visualization_screen.dart';

import '../../ui/auth/login_screen.dart';
import '../../ui/home/home.dart';
import '../../ui/profile/profile_screen.dart';

class Routes {
  Routes._();
  static const String splash_screem='/splash_screem';
  static const String login='/login';
  static const String register='/register';
  static const String home='/home';
  static const String settings='/settings';
  static const String nearby='/nearby';
  static const String profile='/profile';
  static const String wallet='/wallet';
  static const String feeding_challenges='/feeding_challenges';
  static const String current_challenge='/current_challenge';
  static const String data_visualization='/data_visualization';

  static final routes=<String,WidgetBuilder>{
    login:(BuildContext context)=>LoginScreen(),
    home:(BuildContext context)=>Home(),
    profile:(BuildContext context)=>ProfileScreen(),
    feeding_challenges:(BuildContext context)=>FeedingChallengesScreen(),
    current_challenge:(BuildContext context)=>CurrentChallengeScreen(),
    data_visualization:(BuildContext context)=>DataVisualizationScreen()
  }; 
}