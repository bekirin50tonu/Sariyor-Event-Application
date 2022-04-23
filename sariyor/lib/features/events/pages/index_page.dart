import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/utils/web_service/web_service.dart';

class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCubit(WebService.getInstance(), context),
      child: Scaffold(
          body: BlocBuilder<EventCubit, BaseState>(
        builder: (context, state) => buildEventPage(context, state),
      )),
    );
  }

  Widget buildEventPage(BuildContext context, BaseState state) {
    return Container();
  }
}
