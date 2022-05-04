import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/events/models/base/base_friendship_model.dart';
import 'package:sariyor/features/user/services/user_service.dart';

import '../../events/models/base/base_user_model.dart';

class UserCubit extends Cubit<UserBaseState> {
  GlobalKey globalKey = GlobalKey();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  User? user;

  BuildContext context;
  UserCubit(this.service, this.context) : super(const UserIdleState());
  Dio service;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  DateTime joinStartTime = DateTime.now();
  DateTime joinEndTime = DateTime.now();

  Future<void> changeState() async {
    emit(const UserIdleState());
  }

  Future<void> photoSelected(File file) async {
    log("state değiş");
    emit(const UserLoadingState());
    log(file.path);
    image = file;
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(UserLoadedState(user: user!, image: image));
    log("state değişti");
  }

  Future<void> updateProfile() async {
    try {
      emit(const UserLoadingState());
      if (image != null) {
        await UserService(service).updateImage(image!);
        image = null;
      }
      log("geldi");
      user = await UserService(service).updateData(
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          usernameController.text.trim(),
          emailController.text.trim());
      Auth.instance!.user = user;
      if (user != null) {
        emit(UserLoadedState(user: user!));
        return;
      }
      emit(const UserIdleState());
    } on DioError catch (error) {
      emit(UserErrorState(error.response!.data["message"]));
    }
  }

  Future<void> getUserData(int id) async {
    try {
      emit(const UserLoadingState());
      var _user = await UserService(service).getUserData(id);
      user = _user;
      if (_user!.id == Auth.instance!.user!.id) {
        Auth.instance!.user = _user;
        firstnameController.text = _user.firstName;
        lastnameController.text = _user.lastName;
        emailController.text = _user.email;
        usernameController.text = _user.username;
      }
      emit(UserLoadedState(user: _user));
    } on DioError catch (error) {
      emit(UserErrorState(error.response!.data["message"]));
    }
  }

  Future<void> addFriend(int id) async {
    try {
      log(id.toString());
      emit(const UserLoadingState());
      var response =
          await service.post(URLConstants.addFriend, data: {"user_id": id});
      if (response.statusCode == 200) {
        emit(UserLoadedState(user: user!));
      }
      emit(const UserIdleState());
    } on DioError catch (e) {
      log(e.message);
      emit(UserErrorState(e.response!.data['message']));
    }
  }

  Future<void> removeFriend(int id) async {
    emit(const UserLoadingState());
    var response = await service.post(URLConstants.addFriend, data: {"id": id});
    if (response.statusCode == 200) {
      emit(UserLoadedState(user: user!));
    }
    emit(const UserIdleState());
  }
}

abstract class UserBaseState {
  const UserBaseState();
}

class UserIdleState extends UserBaseState {
  const UserIdleState();
}

class UserLoadingState extends UserBaseState {
  const UserLoadingState();
}

class UserLoadedState extends UserBaseState {
  User user;
  File? image;
  UserLoadedState({required this.user, this.image});
}

class UserErrorState extends UserBaseState {
  String error;

  UserErrorState(this.error);
}
