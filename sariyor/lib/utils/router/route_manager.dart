import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/pages/login_page.dart';
import 'package:sariyor/features/auth/pages/register_page.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/pages/discover_page.dart';
import 'package:sariyor/features/events/pages/event_page.dart';
import 'package:sariyor/features/events/pages/index_page.dart';
import 'package:sariyor/features/events/pages/search_page.dart';
import 'package:sariyor/features/onboard/page/onboard_page.dart';
import 'package:sariyor/features/user/pages/notification_page.dart';
import 'package:sariyor/features/user/pages/profile_page.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/widgets/map_page_widget.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.indexRoute:
        return animationPageBuilder(const IndexPage(), settings);
      case RouteConstants.loginRoute:
        return animationPageBuilder(LoginPage(), settings);
      case RouteConstants.splashRoute:
        return animationPageBuilder(const OnBoardPage(), settings);
      case RouteConstants.registerRoute:
        return animationPageBuilder(RegisterPage(), settings);
      case RouteConstants.profile:
        return animationPageBuilder(
            ProfilePage(id: settings.arguments as int), settings);
      case RouteConstants.discovery:
        return animationPageBuilder(const DiscoveryPage(), settings);
      case RouteConstants.eventRoute:
        return animationPageBuilder(
            EventPage(id: settings.arguments as int), settings);
      case RouteConstants.notificationPage:
        return animationPageBuilder(const NotificationPage(), settings);
      case RouteConstants.searchPage:
        return animationPageBuilder(const SearchPage(), settings);
      case RouteConstants.googleMap:
        return animationPageBuilder(MapViewPage(), settings);
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
    final bool isAuth =
        Auth.instance!.token != null && Auth.instance!.token != null
            ? true
            : false;
    return isAuth
        ? const IndexPage()
        : firstLaunch
            ? RegisterPage()
            : const OnBoardPage();
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
