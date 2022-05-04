import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/events/models/search_model.dart';

import '../models/base/base_event_model.dart';

class DiscoveryEventCubit extends Cubit<DiscoveryEventBaseState> {
  Dio service;
  BuildContext context;

  TextEditingController searchController = TextEditingController();
  DiscoveryEventCubit(this.service, this.context)
      : super(const DiscoveryEventIdleState());

  Future<void> stateChange() async {
    emit(const DiscoveryEventIdleState());
  }

  Future<void> getEventsByCategory(int id) async {
    try {
      emit(const DiscoveryEventLoadingState());
      var response = await service
          .get(URLConstants.getEventByCategory, queryParameters: {"id": id});
      if (response.statusCode == 200) {
        emit(DiscoveryEventLoadedState(response.data['data']
            .map<Event>((json) => Event.fromJson(json))
            .toList()));
        return;
      }
      emit(const DiscoveryEventIdleState());
    } on DioError catch (e) {
      emit(DiscoveryEventErrorState(e.response?.data['message']));
    }
  }

  Future<void> getSearchData() async {
    try {
      log(searchController.text);
      emit(const DiscoveryEventLoadingState());
      var response = await service.post(URLConstants.getSearchData,
          data: {'search': searchController.text.trim()});
      log(response.data['message']);
      if (response.statusCode == 200) {
        log("status okey");
        emit(DiscoverySearchState(
            SearchResponseModel.fromJson(response.data['data'])));
        return;
      }
      emit(const DiscoveryEventIdleState());
    } on DioError catch (e) {
      log(e.message);
      emit(DiscoveryEventErrorState(e.response!.data['message']));
    }
  }
}

abstract class DiscoveryEventBaseState {
  const DiscoveryEventBaseState();
}

class DiscoveryEventIdleState extends DiscoveryEventBaseState {
  const DiscoveryEventIdleState();
}

class DiscoveryEventLoadingState extends DiscoveryEventBaseState {
  const DiscoveryEventLoadingState();
}

class DiscoveryEventLoadedState extends DiscoveryEventBaseState {
  List<Event> events;
  DiscoveryEventLoadedState(this.events);
}

class DiscoveryEventErrorState extends DiscoveryEventBaseState {
  String message;
  DiscoveryEventErrorState(this.message);
}

class DiscoverySearchState extends DiscoveryEventBaseState {
  SearchResponseModel model;
  DiscoverySearchState(this.model);
}
