import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sariyor/features/events/models/base/base_friendship_model.dart';

import '../../../constants/url_constant.dart';

class NotificationCubit extends Cubit<NotificationBaseState> {
  Dio service;
  BuildContext context;

  List<Friendship>? friendship;
  NotificationCubit(this.service, this.context)
      : super(const NotificationIdleState());

  Future<void> changeState() async {
    emit(const NotificationIdleState());
  }

  Future<void> getFriendRequest() async {
    try {
      emit(const NotificationLoadingState());
      log("geldi");
      var response = await service.get(URLConstants.getFriendQuest);
      List<Friendship> model = response.data['data']
          .map<Friendship>((json) => Friendship.fromJson(json))
          .toList();
      friendship = model;
      log(model.length.toString());
      emit(NotificationLoadedState(model));
    } on DioError catch (e) {
      emit(NotificationErrorState(e.response!.data['errors'].join('\n')));
    }
  }

  Future<void> acceptFriendQuest(int id) async {
    try {
      log("buradasın $id");
      emit(const NotificationLoadingState());
      var response =
          await service.post(URLConstants.acceptFriendQuest, data: {"id": id});
      log(response.data['message']);
      emit(const NotificationIdleState());
    } on DioError catch (e) {
      log("hata geldi $id");
      log(e.message);
      emit(NotificationErrorState(e.response!.data['message']));
    }
  }

  Future<void> declineFriendQuest(int id) async {
    try {
      emit(const NotificationLoadingState());
      var response =
          await service.post(URLConstants.removeFriend, data: {"id": id});
      emit(const NotificationIdleState());
    } on DioError catch (e) {
      log(e.message);
      emit(NotificationErrorState(e.response!.data['message']));
    }
  }
}

abstract class NotificationBaseState {
  const NotificationBaseState();
}

class NotificationIdleState extends NotificationBaseState {
  const NotificationIdleState();
}

class NotificationLoadingState extends NotificationBaseState {
  const NotificationLoadingState();
}

class NotificationLoadedState extends NotificationBaseState {
  List<Friendship>? friendship;
  NotificationLoadedState(this.friendship);
}

class NotificationErrorState extends NotificationBaseState {
  String message;
  NotificationErrorState(this.message);
}
