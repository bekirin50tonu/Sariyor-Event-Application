import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/events/cubit/category_cubit.dart';
import 'package:sariyor/features/events/cubit/discovery_event_cubit.dart';
import 'package:sariyor/utils/router/route_service.dart';
import 'package:sariyor/widgets/appbar_widget.dart';
import 'package:sariyor/widgets/background_widget.dart';
import 'package:sariyor/widgets/bottom_navigation_bar_widget.dart';
import 'package:sariyor/widgets/custom_drawer_field.dart';
import 'package:sariyor/widgets/floating_action_button_widget.dart';

import '../../../widgets/activity_card_widget.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBlocConsumer(context);
  }

  Widget buildBlocConsumer(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryBaseState>(
      listener: (context, state) {
        if (state is CategoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
            child: Text(state.message),
          )));
        }
      },
      builder: (context, state) => buildScaffold(context, state),
    );
  }

  Scaffold buildScaffold(BuildContext context, CategoryBaseState state) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: buildAppBarWidget(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: backgroundImageWidget(buildDiscoveryWidget(context, state)),
    );
  }

  Padding buildDiscoveryWidget(BuildContext context, CategoryBaseState state) {
    if (state is CategoryIdleState) {
      log("seks");
      context.read<CategoryCubit>().getCategories();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 100,
              child: const Text(
                'Yeni Aktiviteler Keşfet',
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 168, 199),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Etkinlik Ara',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0))),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      label: const Text(''),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 60),
                          elevation: 3,
                          primary: const Color.fromARGB(255, 217, 125, 84),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ))),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          state is CategoryLoadedState
              ? Expanded(
                  flex: 5,
                  child: RefreshIndicator(
                    onRefresh: () =>
                        context.read<CategoryCubit>().getCategories(),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                        ),
                        itemCount: state.category.length,
                        itemBuilder: (BuildContext ctx, index) {
                          var data = state.category[index];
                          return ActivityCard(
                            id: data.id,
                            title: data.name,
                            subtitle: 'Etkinlik Sayısı: ${data.count}',
                            imagePath: data.imagePath,
                            onTab: () {
                              context.read<DiscoveryEventCubit>().stateChange();
                              RouteService.instance
                                  .push(RouteConstants.eventRoute, data.id);
                            },
                          );
                        }),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
        ],
      ),
    );
  }
}
