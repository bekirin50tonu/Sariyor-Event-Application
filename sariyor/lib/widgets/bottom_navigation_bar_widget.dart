import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/events/cubit/category_cubit.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/utils/router/route_service.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return buildBottomNavigationBarWidget();
  }

  Widget buildBottomNavigationBarWidget() {
    return BottomAppBar(
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(255, 85, 72, 164),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<EventCubit>(context).getAlljoinedEvents();
              RouteService.instance.pushAndClear(RouteConstants.indexRoute, "");
            },
            icon: const Icon(Icons.home),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.airplanemode_active_outlined),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {
              RouteService.instance
                  .pushAndClear(RouteConstants.notificationPage, "");
            },
            icon: const Icon(Icons.notifications),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<CategoryCubit>(context).getCategories();
              RouteService.instance.pushAndClear(RouteConstants.discovery, "");
            },
            icon: const Icon(Icons.travel_explore),
            iconSize: 35,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
