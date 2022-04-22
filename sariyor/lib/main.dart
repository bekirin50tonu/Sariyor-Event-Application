import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sariyor/themes/theme_manager.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final bool firstLaunch = Prefs.getBool('firstLaunch') ?? true;

  @override
  Widget build(BuildContext context) {
    String initialRoute = !firstLaunch ? '/splash' : '/register';
    log(initialRoute);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.lightTheme(),
      darkTheme: ThemeManager.darkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: initialRoute,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
