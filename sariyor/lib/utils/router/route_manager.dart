import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/pages/login_page.dart';
import 'package:sariyor/features/auth/pages/register_page.dart';
import 'package:sariyor/features/events/pages/index_page.dart';
import 'package:sariyor/features/onboard/page/onboard_page.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.indexRoute:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => IndexPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteConstants.loginRoute:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteConstants.splashRoute:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnBoardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case RouteConstants.registerRoute:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
            settings: settings, builder: (context) => _buildNotFoundWidget());
    }
  }

  static String get initialRoute {
    final bool firstLaunch = Prefs.getBool('firstLaunch') ?? true;
    final bool isAuth = Prefs.getString('token') != '' ? true : false;
    return isAuth
        ? RouteConstants.indexRoute
        : firstLaunch
            ? RouteConstants.splashRoute
            : RouteConstants.registerRoute;
  }

  static Scaffold _buildNotFoundWidget() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Ters giden bir şeyler oldu'),
      ),
    );
  }
}
