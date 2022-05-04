import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/extensions/datetime_extensions.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/events/models/joined_event_response_model.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';
import 'package:sariyor/utils/router/route_service.dart';
import 'package:sariyor/widgets/appbar_widget.dart';
import 'package:sariyor/widgets/bottom_navigation_bar_widget.dart';
import 'package:sariyor/widgets/custom_drawer_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/event_detail_field.dart';
import 'package:sariyor/widgets/joined_event_card_widget.dart';
import 'package:sariyor/widgets/floating_action_button_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCubit, EventBaseState>(
      listener: (context, state) async {
        if (state is EventErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(child: Text(state.error))));
        }
        if (state is EventIdleState) {
          context.read<EventCubit>().getAlljoinedEvents();
        }
      },
      builder: (context, state) => buildScaffold(state, context),
    );
  }

  Scaffold buildScaffold(EventBaseState state, BuildContext context) {
    if (state is EventIdleState) {
      context.read<EventCubit>().getAlljoinedEvents();
      context.read<UserCubit>().getUserData(Auth.instance!.user!.id);
    }
    return Scaffold(
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: buildAppBarWidget(),
      body: state is EventLoadingState
          ? const Center(child: CircularProgressIndicator.adaptive())
          : buildEventPage(context, state),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: FloatingButton(),
    );
  }

  Widget buildEventPage(BuildContext context, EventBaseState state) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<EventCubit>().getAlljoinedEvents();
          context.read<UserCubit>().getUserData(Auth.instance!.user!.id);
        },
        child: state is EventLoadedState
            ? buildEventCard(context, state.events)
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context, List<JoinedEvent> events) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var data = events[index];
          return JoinedEventCard(
            userName: data.user.fullName,
            userImage: data.user.imagePath!,
            eventName: data.event.name,
            eventImage: data.event.imagePath!,
            timeForHuman: data.timeStr,
            locate: '',
            onTab: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => EventDetailView(
                        event: data.event,
                        isJoined: data.event.isJoined,
                      ));
            },
          );
        });
  }
}
