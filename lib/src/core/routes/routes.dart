import 'package:flutter/cupertino.dart';

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

  static final routes=<String,WidgetBuilder>{
    login:(BuildContext context)=>LoginScreen(),
    home:(BuildContext context)=>Home(),
    profile:(BuildContext context)=>ProfileScreen()
  }; 
}