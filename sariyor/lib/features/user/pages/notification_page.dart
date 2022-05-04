import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/extensions/datetime_extensions.dart';
import 'package:sariyor/features/user/cubit/notification_cubit.dart';
import 'package:sariyor/widgets/bottom_navigation_bar_widget.dart';
import 'package:sariyor/widgets/custom_drawer_field.dart';
import 'package:sariyor/widgets/floating_action_button_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationBaseState>(
      listener: (context, state) {
        if (state is NotificationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
            child: Text(state.message),
          )));
        }
        if (state is NotificationIdleState) {
          context.read<NotificationCubit>().getFriendRequest();
        }
      },
      builder: (context, state) => RefreshIndicator(
        onRefresh: () {
          return context.read<NotificationCubit>().getFriendRequest();
        },
        child: Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(
            bottom: PreferredSize(
                child: Text(
                  "Arkadaşlık İstekleri",
                  style: context.themeText.headline5,
                ),
                preferredSize: Size(double.infinity, 30)),
            backgroundColor: Colors.transparent,
            elevation: 1,
            centerTitle: true,
            title: const Image(
              height: 50,
              fit: BoxFit.scaleDown,
              image: AssetImage('images/image17.png'),
            ),
          ),
          body: buildBodyWidget(context, state),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CustomBottomNavigationBar(),
          floatingActionButton: FloatingButton(),
        ),
      ),
    );
  }

  Widget buildBodyWidget(BuildContext context, NotificationBaseState state) {
    if (state is NotificationIdleState) {
      context.read<NotificationCubit>().changeState();
      context.read<NotificationCubit>().getFriendRequest();
    }
    return buildFriendQuestWidget(context, state);
  }

  Widget buildFriendQuestWidget(
      BuildContext context, NotificationBaseState state) {
    return state is NotificationLoadedState
        ? ListView.builder(
            itemCount: state.friendship!.length,
            itemBuilder: ((context, index) => ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<NotificationCubit>()
                                .acceptFriendQuest(state.friendship![index].id);
                          },
                          icon: const Icon(Icons.add)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<NotificationCubit>()
                                .declineFriendQuest(
                                    state.friendship![index].id);
                          },
                          icon: const Icon(Icons.remove)),
                    ],
                  ),
                  title: Text(state.friendship![index].user!.fullName),
                  subtitle: Text(
                      state.friendship![index].updatedAt!.getTimePastFromNow()),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(ImageRouteType.profile
                        .url(state.friendship![index].user!.imagePath)),
                  ),
                )))
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }
}
