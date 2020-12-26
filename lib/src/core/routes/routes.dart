import 'package:flutter/cupertino.dart';

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
  static const String data_visualization='/data_visualization';
  static const String profile_settings='/profile_settings';
  static const String profile_edit='/profile_edit';

  static final routes=<String,WidgetBuilder>{
    login:(BuildContext context)=>LoginScreen(),
    home:(BuildContext context)=>Home(),
    dashboard:(BuildContext context)=>DashboardScreen(),
    profile:(BuildContext context)=>ProfileScreen(),
    feeding_challenges:(BuildContext context)=>FeedingChallengesScreen(),
    data_visualization:(BuildContext context)=>DataVisualizationScreen(),
    profile_settings:(BuildContext context)=>ProfileSettingsScreen(),
    profile_edit:(BuildContext context)=>ProfileEditScreen()
  }; 
}