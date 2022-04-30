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
                  builder: (_) => buildDraggableEventDetail(context, data));
            },
          );
        });
  }

  Widget buildDraggableEventDetail(BuildContext context, Event event) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              ImageRouteType.event.url(event.imagePath ?? "Nope"),
              width: double.infinity,
              height: 300,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        ListTile(
          title: Center(
            child: Text(
              event.name,
              style: context.themeText.headline5,
            ),
          ),
          subtitle: Text(
            event.description,
            textAlign: TextAlign.justify,
            style: context.themeText.headline6,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.profile.url(event.owner.imagePath!)),
                ),
                title: const Text("Etkinliği Hazırlayan"),
                subtitle:
                    Text("${event.owner.fullName} @${event.owner.username}"),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.category.url(event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.category.name),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.red,
            child: Center(
                child: Text(
              "AHA DA BURAYA MAP GELECEK.\n EGE FITNESS FUCKING BUSINESS MEEEN XDD",
              style: context.themeText.headline3!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
        ),
        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.category.url(event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.category.name),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.category.url(event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.category.name),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Katılım Başlama Tarihi"),
                subtitle: Text(event.startTime.getTimeDifferenceFromNow()),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Katılım Bitiş Tarihi"),
                subtitle: Text(event.endTime.getTimeDifferenceFromNow()),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: CustomElevatedButton(
            label: 'Ayrılmak İstiyorum',
            deactiveLabel: 'Katılmak İstiyorum',
            onPressed: () {},
            onPressedDisabled: () {},
            disabled: false,
          ),
        ),
      ],
    );
  }
}
