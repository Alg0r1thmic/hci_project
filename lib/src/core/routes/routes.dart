import 'package:flutter/cupertino.dart';
import 'package:health_body_checking/src/ui/challenges/challenges_screen.dart';
import 'package:health_body_checking/src/ui/challenges/exercises_challenge_screen.dart';

import '../../ui/auth/login_screen.dart';
import '../../ui/challenges/feeding_challenges_screen.dart';
import '../../ui/dashboard/dashboard.dart';
import '../../ui/home/home.dart';
import '../../ui/monitor/data_visualization_screen.dart';
import '../../ui/profile/profile_edit_screen.dart';
import '../../ui/profile/profile_screen.dart';
import '../../ui/profile/profile_settings_creen.dart';

class Routes {
  Routes._();
  static const String splash_screem='/splash_screem';
  static const String login='/login';
  static const String register='/register';
  static const String home='/home';
  static const String dashboard='/dashboard';
  static const String settings='/settings';
  static const String nearby='/nearby';
  static const String profile='/profile';
  static const String wallet='/wallet';
  static const String feeding_challenges='/feeding_challenges';
  static const String exercises_challenges = '/exercises_challenge';
  static const String food_challenges = '/feeding_challenges_screen';
  static const String data_visualization='/data_visualization';
  static const String profile_settings='/profile_settings';
  static const String profile_edit='/profile_edit';

  static final routes=<String,WidgetBuilder>{
    login:(BuildContext context)=>LoginScreen(),
    home:(BuildContext context)=>Home(),
    dashboard:(BuildContext context)=>DashboardScreen(),
    profile:(BuildContext context)=>ProfileScreen(),
    feeding_challenges:(BuildContext context)=>FeedingChallengesScreen(),
    exercises_challenges:(BuildContext context)=>Home(tab: 2,),
    food_challenges:(BuildContext context)=>Home(tab: 2, challengeTab: 1),
    data_visualization:(BuildContext context)=>DataVisualizationScreen(),
    profile_settings:(BuildContext context)=>ProfileSettingsScreen(),
    profile_edit:(BuildContext context)=>ProfileEditScreen()
  }; 
}