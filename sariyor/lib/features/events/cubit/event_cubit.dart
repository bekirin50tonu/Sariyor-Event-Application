import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/events/models/joined_event_response_model.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_service.dart';

import '../../../constants/route_constant.dart';

class EventCubit extends Cubit<EventBaseState> {
  final Dio service;
  final BuildContext context;
  bool isJoin = false;
  EventCubit(this.service, this.context) : super(const EventIdleState());

  Future<void> getAlljoinedEvents() async {
    try {
      log("yükleniyor..");
      emit(const EventLoadingState());
      var response = await service.get(URLConstants.get_all_joined_events);
      log(response.statusCode.toString());
      if (response.statusCode == 401) {
        Prefs.setString('token', '');
        RouteService.instance.push(RouteConstants.loginRoute, "");
        return;
      }
      JoinedEventResponseModel model =
          JoinedEventResponseModel.fromJson(response.data!);
      log(model.events.length.toString());
      emit(EventLoadedState(model.events));
    } on DioError catch (e) {
      emit(EventErrorState(e.message));
    }
  }
}

abstract class EventBaseState {
  const EventBaseState();
}

class EventIdleState extends EventBaseState {
  const EventIdleState();
}

class EventLoadingState extends EventBaseState {
  const EventLoadingState();
}

class EventLoadedState extends EventBaseState {
  List<JoinedEvent> events;
  EventLoadedState(this.events);
}

class EventErrorState extends EventBaseState {
  String error;
  EventErrorState(this.error);
}
