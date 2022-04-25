import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/features/auth/cubit/auth_cubit.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/profile/cubit/profile_cubit.dart';
import 'package:sariyor/themes/theme_manager.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_manager.dart';
import 'package:sariyor/utils/router/route_service.dart';
import 'package:sariyor/utils/web_service/web_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(WebService.getInstance(), context)),
    BlocProvider<EventCubit>(
        create: (context) => EventCubit(WebService.getInstance(), context)),
    BlocProvider<ProfileCubit>(
        create: ((context) => ProfileCubit(WebService.getInstance(), context))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Prefs.setBool('firstLaunch', true);
    return MaterialApp(
      navigatorKey: RouteService.globalKey,
      title: 'Sarıyo',
      theme: ThemeManager(context).lightTheme(),
      darkTheme: ThemeManager(context).darkTheme(),
      themeMode: ThemeMode.dark,
      home: RouteManager.initialRoute,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
