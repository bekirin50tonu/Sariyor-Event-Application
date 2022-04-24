import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/auth/models/user_data_response.dart';
import 'package:sariyor/features/auth/models/user_login.request.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

class LoginCubit extends Cubit<BaseState> {
  LoginCubit({required this.service, required this.context})
      : super(const IdleState());
  Dio service;
  BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void login() async {
    try {
      emit(const LoadingState());
      var response = await service.post(URLConstants.login,
          data: UserLoginRequest(
              email: emailController.text.trim(),
              password: passwordController.text.trim()));
      UserDataResponse model = UserDataResponse.fromJson(response.data!);
      var token = model.data.token;
      var user = model.data.user;
      Prefs.setString('token', token);
      Prefs.setString('user', user.toJson().toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Başarıyla Giriş Yapıldı. Yönlendiriliyorsunuz.'),
        duration: Duration(milliseconds: 1500),
      ));

      Navigator.pushNamedAndRemoveUntil(
          context, RouteConstants.indexRoute, (Route<dynamic> route) => false);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      log(e.message);
      if (e.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (e.response!.statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.response!.data['errors'].join('\n'))));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }

      emit(const IdleState());
      passwordController.text = '';
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
