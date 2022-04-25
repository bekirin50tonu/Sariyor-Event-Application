import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/events/models/joined_event_response_model.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

import '../../../constants/route_constant.dart';

class EventCubit extends Cubit<BaseState> {
  final Dio service;
  final BuildContext context;
  List<JoinedEvent> events = [];
  bool isJoin = false;
  EventCubit(this.service, this.context) : super(const IdleState());

  Future<void> isJoinEvent() async {
    isJoin = !isJoin;
  }

  Future<void> getAlljoinedEvents() async {
    try {
      emit(const LoadingState());
      var response = await service.get(URLConstants.get_all_joined_events);
      log(response.statusCode.toString());
      if (response.statusCode == 401) {
        Prefs.setString('token', '');
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.loginRoute, (route) => false);
        return;
      }
      JoinedEventResponseModel model =
          JoinedEventResponseModel.fromJson(response.data!);
      events = [];
      events = model.events;
      log(events.length.toString());
      emit(const LoadedState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        return;
      }
      if (e.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        return;
      }
      log(e.message);

      emit(const IdleState());
    }
  }
}

abstract class BaseState {
  const BaseState();
}

class IdleState extends BaseState {
  const IdleState();
}

class LoadingState extends BaseState {
  const LoadingState();
}

class LoadedState extends BaseState {
  const LoadedState();
}
