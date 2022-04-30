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
                  builder: (_) => buildDraggableEventDetail(context, data));
            },
          );
        });
  }

  Widget buildDraggableEventDetail(BuildContext context, JoinedEvent event) {
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
              ImageRouteType.event.url(event.event.imagePath),
              width: double.infinity,
              height: 300,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        ListTile(
          title: Center(
            child: Text(
              event.event.name,
              style: context.themeText.headline5,
            ),
          ),
          subtitle: Text(
            event.event.description,
            textAlign: TextAlign.justify,
            style: context.themeText.headline6,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: () {
                  context.read<UserCubit>().changeState();
                  log(event.event.owner.id.toString());
                  RouteService.instance
                      .push(RouteConstants.profile, event.event.owner.id);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.profile.url(event.event.owner.imagePath!)),
                ),
                title: const Text("Etkinliği Hazırlayan"),
                subtitle: Text(
                    "${event.event.owner.fullName} @${event.event.owner.username}"),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(event.event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.event.category.name),
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
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(event.event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.event.category.name),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(event.event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(event.event.category.name),
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
                subtitle:
                    Text(event.event.startTime.getTimeDifferenceFromNow()),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Katılım Bitiş Tarihi"),
                subtitle: Text(event.event.endTime.getTimeDifferenceFromNow()),
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
