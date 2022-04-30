import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/events/models/base/base_category_model.dart';
import 'package:sariyor/features/events/models/joined_event_response_model.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';
import 'package:sariyor/utils/router/route_service.dart';
import 'package:http_parser/http_parser.dart';

import '../../../constants/route_constant.dart';

class EventCubit extends Cubit<EventBaseState> {
  final Dio service;
  final BuildContext context;
  bool isJoin = false;
  EventCubit(this.service, this.context) : super(const EventIdleState());

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventCountController = TextEditingController();

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  DateTime joinStartTime = DateTime.now();
  DateTime joinEndTime = DateTime.now();
  Category? selectedCategory;
  File? image;
  ImagePicker picker = ImagePicker();

  bool onlyFriend = false;

  List<Category>? categories;

  Future<void> photoSelected(File img) async {
    emit(const EventLoadingState());
    image = img;
    emit(EventPhotoLoadedState(img));
  }

  Future<void> getCategories() async {
    var response = await service.get(URLConstants.getCategories);
    if (response.statusCode == 200) {
      categories = response.data['data']
          .map<Category>((json) => Category.fromJson(json))
          .toList();
    }
  }

  Future<void> getAlljoinedEvents() async {
    try {
      dev.log("yükleniyor..");
      emit(const EventLoadingState());
      var response = await service.get(URLConstants.get_all_joined_events);
      dev.log(response.statusCode.toString());
      if (response.statusCode == 401) {
        Prefs.setString('token', '');
        RouteService.instance.push(RouteConstants.loginRoute, "");
        return;
      }
      JoinedEventResponseModel model =
          JoinedEventResponseModel.fromJson(response.data!);
      dev.log(model.events.length.toString());
      emit(EventLoadedState(model.events));
    } on DioError catch (e) {
      emit(EventErrorState(e.message));
    }
  }

  Future<void> addEvent() async {
    try {
      emit(const EventLoadingState());
      FormData data = FormData.fromMap({
        "name": eventNameController.text.trim(),
        "description": eventDescriptionController.text.trim(),
        "count": int.parse(eventCountController.text.trim()),
        "only_friends": onlyFriend,
        "lat": Random().nextDouble(),
        "long": Random().nextDouble(),
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "join_start_time": joinStartTime.toIso8601String(),
        "join_end_time": joinEndTime.toIso8601String(),
        "image": image != null
            ? await MultipartFile.fromFile(image!.path,
                filename: image!.path.split('/').last,
                contentType: MediaType('image', 'png'))
            : null,
        "cat_id": selectedCategory!.id
      });
      var response = await service.post(URLConstants.addEvent,
          data: data,
          options: Options(contentType: 'multipart/form-data', headers: {
            Headers.contentLengthHeader: await image!.length(),
          }));
      if (response.statusCode == 403) {
        dev.log(response.data["message"]);
      }
      emit(const EventIdleState());
    } on DioError catch (e) {
      dev.log(e.response!.data["message"]);
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

class EventPhotoLoadedState extends EventBaseState {
  File image;
  EventPhotoLoadedState(this.image);
}
