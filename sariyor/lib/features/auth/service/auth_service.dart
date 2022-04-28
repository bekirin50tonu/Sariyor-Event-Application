import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/auth/models/user_data_response.dart';
import 'package:sariyor/features/auth/models/user_login.request.dart';
import 'package:sariyor/features/auth/models/user_register_request.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';

import '../../events/models/base/base_user_model.dart';

class AuthService {
  static Future<User?> register(Dio service,
      {required String firstName,
      required String lastName,
      required String userName,
      required String email,
      required String password,
      required bool rememberMe}) async {
    var response = await service.post(URLConstants.register,
        data: UserRegisterRequest(
            firstName: firstName,
            lastName: lastName,
            username: userName,
            email: email,
            password: password));
    UserDataResponse model = UserDataResponse.fromJson(response.data!);
    var token = model.data.token;
    var user = model.data.user;
    Auth.instance!.login(user, token, rememberMe);
    return user;
  }

  static Future<User?> login(Dio service,
      {required String email,
      required String password,
      bool rememberMe = false}) async {
    var response = await service.post(URLConstants.login,
        data: UserLoginRequest(email: email, password: password));
    UserDataResponse model = UserDataResponse.fromJson(response.data!);
    var token = model.data.token;
    var user = model.data.user;
    Auth.instance!.login(user, token, rememberMe);
    return user;
  }

  static Future<void> logout(Dio service) async {
    await service.post(URLConstants.logout);
      Auth.instance!.logout();
  }

  void updateUser(User user) {}

  void updateToken() {}

  void updateRememberMe() {}
}
