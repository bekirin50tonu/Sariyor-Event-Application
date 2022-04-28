import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/features/auth/service/auth_service.dart';
import 'package:sariyor/utils/router/route_service.dart';

class AuthCubit extends Cubit<AuthBaseState> {
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

  AuthCubit(this.service, this.context) : super(const AuthIdleState());

  Future<void> register() async {
    try {
      emit(const AuthLoadingState());
      var user = await AuthService.register(service,
          firstName: firstnameController.text.trim(),
          lastName: lastnameController.text.trim(),
          userName: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rememberMe: rememberMe);
      RouteService.instance.pushAndClear(RouteConstants.indexRoute, '');
      emit(const AuthLoadedState());
    } on DioError catch (e) {}
  }

  Future<void> login() async {
    try {
      emit(const AuthLoadingState());
      var user = await AuthService.login(service,
          email: emailLoginController.text.trim(),
          password: passwordLoginController.text.trim());
      RouteService.instance.pushAndClear(RouteConstants.indexRoute, '');
      emit(const AuthLoadedState());
    } on DioError catch (e) {
      emit(AuthErrorState(e.response!.data['errors'].join('\n')));
    }
  }

  Future<void> logout() async {
    try {
      emit(const AuthLoadingState());
      AuthService.logout(service);
      emit(const AuthIdleState());
      RouteService.instance.pushAndClear(RouteConstants.loginRoute, "");
    } on DioError catch (e) {
      emit(e.response!.data["errors"].join('\n'));
    }
  }
}

abstract class AuthBaseState {
  const AuthBaseState();
}

class AuthIdleState extends AuthBaseState {
  const AuthIdleState();
}

class AuthLoadingState extends AuthBaseState {
  const AuthLoadingState();
}

class AuthLoadedState extends AuthBaseState {
  const AuthLoadedState();
}

class AuthErrorState extends AuthBaseState {
  String message;
  AuthErrorState(this.message);
}
