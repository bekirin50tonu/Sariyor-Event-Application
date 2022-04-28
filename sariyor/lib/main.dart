import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/features/auth/cubit/auth_cubit.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/cubit/category_cubit.dart';
import 'package:sariyor/features/events/cubit/discovery_event_cubit.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/user/cubit/notification_cubit.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';
import 'package:sariyor/themes/theme_manager.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_manager.dart';
import 'package:sariyor/utils/router/route_service.dart';
import 'package:sariyor/utils/web_service/web_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  await AuthPreference.getInstance();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(
      lazy: false,
        create: (context) => AuthCubit(WebService.getInstance(), context)),
    BlocProvider<EventCubit>(
      lazy: false,
        create: (context) => EventCubit(WebService.getInstance(), context)),
    BlocProvider<UserCubit>(
      lazy: false,
        create: ((context) => UserCubit(WebService.getInstance(), context))),
    BlocProvider(
      lazy: false,
        create: ((context) =>
            CategoryCubit(WebService.getInstance(), context))),
    BlocProvider(
        lazy: false,
        create: ((context) =>
            DiscoveryEventCubit(WebService.getInstance(), context))),
    BlocProvider(
        lazy: false,
        create: ((context) =>
            NotificationCubit(WebService.getInstance(), context))),
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
