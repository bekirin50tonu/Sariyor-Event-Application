// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/utils/web_service/web_service.dart';
import 'package:sariyor/widgets/event_card_widget.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCubit(WebService.getInstance(), context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: buildAppBarWidget(),
        body: BlocBuilder<EventCubit, BaseState>(
            builder: (context, state) => buildEventPage(context, state)),
        bottomNavigationBar: buildBottomNavigationBarWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 85, 72, 164),
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBarWidget() {
    return BottomAppBar(
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      color: Color.fromARGB(255, 85, 72, 164),
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
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
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            iconSize: 35,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      centerTitle: true,
      title: const Image(
        height: 50,
        fit: BoxFit.scaleDown,
        image: AssetImage('images/image17.png'),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 85, 72, 164)),
        ),
        Container(
          width: double.infinity,
          height: 70,
          color: const Color.fromARGB(255, 85, 72, 164),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
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
              Positioned(
                top: 0.0,
                left: 0.0,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color.fromARGB(255, 78, 84, 89),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white38,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    iconSize: 35,
                    color: Colors.white70,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 35,
                color: Colors.white70,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
                iconSize: 35,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildEventPage(BuildContext context, BaseState state) {
    if (state is IdleState) {
      context.read<EventCubit>().getAlljoinedEvents();
    }
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: RefreshIndicator(
        onRefresh: () async {
          return context.read<EventCubit>().getAlljoinedEvents();
        },
        child: buildEventCard(
          context,
        ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context) {
    return ListView.builder(
        itemCount: context.watch<EventCubit>().events.length,
        itemBuilder: (context, index) {
          var data = context.watch<EventCubit>().events[index];
          return EventCard(
            userName: data.user.fullName,
            userImage: data.user.imagePath!,
            eventName: data.event.name,
            eventImage: data.event.imagePath!,
            timeForHuman: data.timeStr,
            locate: '',
            onTab: () => null,
          );
        });
  }
}
