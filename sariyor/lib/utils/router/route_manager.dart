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
        return animationPageBuilder(IndexPage(), settings);
      case RouteConstants.loginRoute:
        return animationPageBuilder(LoginPage(), settings);
      case RouteConstants.splashRoute:
        return animationPageBuilder(OnBoardPage(), settings);
      case RouteConstants.registerRoute:
        return animationPageBuilder(RegisterPage(), settings);
      default:
        return normalPageBuilder(_buildNotFoundWidget(), settings);
    }
  }

  static MaterialPageRoute<dynamic> normalPageBuilder(
      Widget widget, RouteSettings settings) {
    return MaterialPageRoute(settings: settings, builder: (context) => widget);
  }

  static PageRouteBuilder<dynamic> animationPageBuilder(
      Widget widget, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
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
  }

  static Widget get initialRoute {
    final bool firstLaunch = Prefs.getBool('firstLaunch') ?? true;
    final bool isAuth = Prefs.getString('token') != '' ? true : false;
    return isAuth
        ? IndexPage()
        : firstLaunch
            ? const OnBoardPage()
            : const RegisterPage();
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
