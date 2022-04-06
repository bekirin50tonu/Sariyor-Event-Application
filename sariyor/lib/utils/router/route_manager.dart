import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/pages/auth_page.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.authRoute:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Ters giden bir şeyler oldu'),
            ),
          ),
        );
    }
  }
}
