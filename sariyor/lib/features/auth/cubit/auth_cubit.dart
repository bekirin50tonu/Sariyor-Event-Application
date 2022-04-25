import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/service/auth_service.dart';
import 'package:sariyor/utils/router/route_service.dart';

class AuthCubit extends Cubit<BaseState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  bool userCheckboxState = false;
  bool mailCheckBoxState = false;

  bool isObscure = true;
  bool rememberMe = false;
  
  final Dio service;
  final BuildContext context;

  AuthCubit(this.service, this.context) : super(const IdleState());

  Future<void> register() async {
    emit(const LoadingState());
    await AuthService.register(service, () {
      emit(const IdleState());
      RouteService.instance.pushAndClear(RouteConstants.indexRoute, "");
    }, (error, message) {
      if (error.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        checkPasswordController.text = '';
        return;
      }
      if (error.type == DioErrorType.receiveTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        checkPasswordController.text = '';
        return;
      }
      if (error.response!.statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.response!.data['errors'].join('\n'))));
        emit(const IdleState());
        passwordController.text = '';
        checkPasswordController.text = '';
        return;
      }
      log(error.message);
      emit(const IdleState());
      passwordController.text = '';
      checkPasswordController.text = '';
    },
        firstName: firstnameController.text.trim(),
        lastName: lastnameController.text.trim(),
        userName: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rememberMe: rememberMe);
  }

  Future<void> login() async {
    emit(const LoadingState());
    await AuthService.login(service, () {
      emit(const IdleState());
      RouteService.instance.pushAndClear(RouteConstants.indexRoute, "");
    }, (error, message) {
      if (error.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.type == DioErrorType.receiveTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.response == null) {
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.response!.statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.response!.data['errors'].join('\n'))));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }

      log(error.message);
      emit(const IdleState());
      passwordController.text = '';
    },
        email: emailLoginController.text.trim(),
        password: passwordLoginController.text.trim());
  }

  Future<void> logout() async {
    emit(const LoadingState());
    AuthService.logout(service, () {
      emit(const IdleState());
      RouteService.instance.pushAndClear(RouteConstants.loginRoute, "");
    }, (error, message) {
      if (error.type == DioErrorType.connectTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.type == DioErrorType.receiveTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hata Meydana Geldi. Lütfen Bağlantınızı Kontrol Ediniz.')));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }
      if (error.response!.statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.response!.data['errors'].join('\n'))));
        emit(const IdleState());
        passwordController.text = '';
        return;
      }

      log(error.message);
      emit(const IdleState());
    });
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
