import 'package:flutter/material.dart';
import 'package:sariyor/themes/theme_manager.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_manager.dart';
import 'package:sariyor/utils/web_service/web_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  WebService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.lightTheme(),
      darkTheme: ThemeManager.darkTheme(),
      initialRoute: '/auth/register',
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
