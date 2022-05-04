import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/extensions/datetime_extensions.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/cubit/discovery_event_cubit.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';
import 'package:sariyor/widgets/appbar_widget.dart';
import 'package:sariyor/widgets/bottom_navigation_bar_widget.dart';
import 'package:sariyor/widgets/custom_drawer_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/event_card_widget.dart';
import 'package:sariyor/widgets/event_detail_field.dart';
import 'package:sariyor/widgets/floating_action_button_widget.dart';

import '../models/base/base_event_model.dart';

// ignore: must_be_immutable
class EventPage extends StatelessWidget {
  int id;
  EventPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoveryEventCubit, DiscoveryEventBaseState>(
      listener: (context, state) async {
        log(state.toString());
        if (state is DiscoveryEventErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(child: Text(state.message))));
        }
        if (state is DiscoveryEventIdleState) {
          context.read<DiscoveryEventCubit>().getEventsByCategory(id);
        }
      },
      builder: (context, state) => buildScaffold(state, context),
    );
  }

  Scaffold buildScaffold(DiscoveryEventBaseState state, BuildContext context) {
    if (state is DiscoveryEventIdleState) {
      context.read<DiscoveryEventCubit>().getEventsByCategory(id);
    }
    return Scaffold(
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: buildAppBarWidget(),
      body: state is DiscoveryEventLoadingState
          ? const Center(child: CircularProgressIndicator.adaptive())
          : buildEventPage(context, state),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: FloatingButton(),
    );
  }

  Widget buildEventPage(BuildContext context, DiscoveryEventBaseState state) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<DiscoveryEventCubit>().getEventsByCategory(id);
          context.read<UserCubit>().getUserData(Auth.instance!.user!.id);
        },
        child: state is DiscoveryEventLoadedState
            ? buildEventCard(context, state.events)
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context, List<Event> events) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var data = events[index];
          return EventCard(
            event: data,
            onTab: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => EventDetailView(
                        event: data,
                        isJoined: data.isJoined,
                      ));
            },
          );
        });
  }
}
