import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/extensions/datetime_extensions.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/events/models/joined_event_response_model.dart';
import 'package:sariyor/utils/web_service/web_service.dart';
import 'package:sariyor/widgets/custom_drawer_field.dart';
import 'package:sariyor/widgets/custom_elevated_button.dart';
import 'package:sariyor/widgets/event_card_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);
  static bool isJoin = false;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCubit(WebService.getInstance(), context),
      child: Scaffold(
        drawer: CustomDrawer(
          fullName: 'Bekir Görmez',
          userImage: '123',
          userName: 'bekirin50tonu',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: buildAppBarWidget(),
        body: BlocBuilder<EventCubit, BaseState>(
            builder: (context, state) => buildEventPage(context, state)),
        bottomNavigationBar: buildBottomNavigationBarWidget(),
        floatingActionButton: buildFloatingActionButtonWidget(context),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 85, 72, 164),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => buildDraggableCreateEvent(context));
      },
      child: const Icon(Icons.add),
    );
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
              ImageRouteType.event.url(event.event.imagePath ?? "Nope"),
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
            onPressed: () {
              log('geldi');
              IndexPage.isJoin = !IndexPage.isJoin;
            },
            onPressedDisabled: () {
              log('ühühüüüü');
              IndexPage.isJoin = !IndexPage.isJoin;
            },
            disabled: false,
          ),
        ),
      ],
    );
  }

  Widget buildDraggableCreateEvent(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('Etkinlik Ekleme Buraya Gelecek!!!'))
      ],
    );
  }
}
