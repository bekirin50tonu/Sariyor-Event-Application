import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/features/events/cubit/discovery_event_cubit.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';
import 'package:sariyor/utils/router/route_service.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoveryEventCubit, DiscoveryEventBaseState>(
      listener: (context, state) {
        if (state is DiscoveryEventIdleState) {
          context.read<DiscoveryEventCubit>().getSearchData();
        }
        if (state is DiscoverySearchState) {
          log("zoort ${state.model.users.length}");
        }
      },
      builder: (context, state) => DefaultTabController(
        length: 3,
        child: buildScaffoldWidget(context, state),
      ),
    );
  }

  Widget buildScaffoldWidget(
      BuildContext context, DiscoveryEventBaseState state) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(tabs: [
          Tab(text: 'Kullanıcılar'),
          Tab(text: 'Etkinlikler'),
          Tab(text: 'Kategoriler'),
        ]),
        centerTitle: true,
        title: TextFormField(
          onChanged: (text) {
            context.read<DiscoveryEventCubit>().getSearchData();
          },
          controller: context.read<DiscoveryEventCubit>().searchController,
        ),
      ),
      body: buildTabBarViewWidget(context, state),
    );
  }

  Widget buildTabBarViewWidget(
      BuildContext context, DiscoveryEventBaseState state) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<DiscoveryEventCubit>().getSearchData();
      },
      child: TabBarView(children: [
        state is DiscoverySearchState
            ? state.model.users.isEmpty
                ? const Text("Sonuç Bulunamadı.")
                : ListView.builder(
                    itemCount: state.model.users.length,
                    itemBuilder: ((context, index) => ListTile(
                          onTap: () {
                            BlocProvider.of<UserCubit>(context)
                                .getUserData(state.model.users[index]!.id);
                            RouteService.instance.push(RouteConstants.profile,
                                state.model.users[index]!.id);
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(ImageRouteType.profile
                                .url(state.model.users[index]!.imagePath)),
                          ),
                          title: Text(state.model.users[index]!.fullName),
                          subtitle:
                              Text("@${state.model.users[index]!.username}"),
                        )))
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
        state is DiscoverySearchState
            ? state.model.events.isEmpty
                ? const Text("Sonuç Bulunamadı.")
                : ListView.builder(
                    itemCount: state.model.events.length,
                    itemBuilder: ((context, index) => ListTile(
                          title: Text(state.model.events[index]!.name),
                          subtitle:
                              Text(state.model.events[index]!.description),
                        )))
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
        state is DiscoverySearchState
            ? state.model.categories.isEmpty
                ? const Text("Sonuç Bulunamadı.")
                : ListView.builder(
                    itemCount: state.model.categories.length,
                    itemBuilder: ((context, index) => ListTile(
                          title: Text(state.model.categories[index]!.name),
                          subtitle:
                              Text("${state.model.categories[index]!.count}"),
                        )))
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ]),
    );
  }
}
