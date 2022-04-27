import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sariyor/features/auth/models/user_data_response.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/features/user/services/user_service.dart';

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

  Future<void> photoSelected(File file) async {
    emit(const UserLoadingState());
    log(file.path);
    image = file;

    emit(UserCacheImageState(image!));
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
      log("gitti");
      emit(const UserLoadedState());
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.type == DioErrorType.receiveTimeout) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.response == null) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.response!.statusCode == 422) {
        emit(UserErrorState(error.response!.data['errors'].join('\n')));
        return;
      }
      if (error.response!.statusCode == 403) {
        emit(UserErrorState(error.message));
        return;
      }
      log(error.message);
      emit(UserErrorState(error.message));
    }
  }

  Future<void> getUserData() async {
    try {
      emit(const UserLoadingState());
      user = await UserService(service).getUserData();
      Auth.instance!.user = user;
      firstnameController.text = user!.firstName;
      lastnameController.text = user!.lastName;
      emailController.text = user!.email;
      usernameController.text = user!.username;
      emit(const UserLoadedState());
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.type == DioErrorType.receiveTimeout) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.response == null) {
        emit(UserErrorState(
            'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.'));
        return;
      }
      if (error.response!.statusCode == 422) {
        emit(UserErrorState(error.response!.data['errors'].join('\n')));
        return;
      }
      log(error.message);
      emit(UserErrorState(error.message));
    }
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
  const UserLoadedState();
}

class UserErrorState extends UserBaseState {
  String error;
  UserErrorState(this.error);
}

class UserCacheImageState extends UserBaseState {
  File image;
  UserCacheImageState(this.image);
}
