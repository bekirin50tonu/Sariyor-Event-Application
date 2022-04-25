import 'package:flutter/material.dart';
import 'package:sariyor/utils/router/route_service_interface.dart';

class RouteService extends IRouteService {
  static final RouteService _instance = RouteService._init();
  static RouteService get instance => _instance;
  RouteService._init();

  static final GlobalKey<NavigatorState> globalKey = GlobalKey();

  // ignore: prefer_function_declarations_over_variables
  final removeAllOldRoutes = (Route<dynamic> route) => false;
  @override
  Future<void> push(String route, Object params) async {
    await globalKey.currentState?.pushNamed(route, arguments: params);
  }

  @override
  Future<void> pushAndClear(String route, Object params) async {
    await globalKey.currentState
        ?.pushNamedAndRemoveUntil(route, removeAllOldRoutes, arguments: params);
  }
}
