import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_body_checking/src/providers/push_notification_provider.dart';
import 'package:provider/provider.dart';

import 'flavor.dart';
import 'myapp.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/languaje_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/services/hearth_service.dart';
import 'src/services/oxygen_saturation_service.dart';
import 'src/services/temperature_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final notifications=PushNotificationsProvider();
  notifications.initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Flavor>.value(value: Flavor.dev),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
          Provider<TemperatureService>(create: (_) =>TemperatureService()),
          Provider<HearthRateService>(create: (_) =>HearthRateService()),
          Provider<OxygenSaturationService>(create: (_) =>OxygenSaturationService()),

        ],
        child: MyApp(
          //databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        ),
      ),
    );
  });
}

