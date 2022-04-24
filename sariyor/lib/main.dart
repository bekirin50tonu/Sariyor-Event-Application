import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sariyor/themes/theme_manager.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_manager.dart';
import 'package:sariyor/utils/router/route_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteService.globalKey,
      title: 'Sarıyo',
      theme: ThemeManager.lightTheme(),
      darkTheme: ThemeManager.darkTheme(),
      themeMode: ThemeMode.dark,
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
