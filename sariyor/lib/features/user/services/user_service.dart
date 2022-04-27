import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:sariyor/constants/url_constant.dart';
import 'package:sariyor/features/user/models/update_user_request_model.dart';
import 'package:sariyor/features/user/services/user_service_interface.dart';

import '../../auth/models/user_data_response.dart';

class UserService extends IUserService {
  UserService(this.service);

  Dio service;

  @override
  Future<User?> updateData(
      String firstName, String lastName, String username, String email) async {
    var response = await service.post(URLConstants.updateUser,
        data: UpdateUserRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          username: username,
        ));
    if (response.statusCode == 200) {
      return User.fromJson(response.data['data'][0]);
    }
    return null;
  }

  @override
  Future<void> updateImage(File image) async {
    try {
      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'png')),
      });
      await service.post(URLConstants.updateUser,
          data: data,
          options: Options(contentType: 'multipart/form-data', headers: {
            Headers.contentLengthHeader: await image.length(),
          }), onSendProgress: (progress, size) {
        log(progress.toString());
        log(size.toString());
      });
    } on DioError catch (e) {
      log(e.response!.data["message"]);
    }
  }

  @override
  Future<User?> getUserData() async {
    var response = await service.post(URLConstants.getUserData);
    if (response.statusCode == 200) {
      return User.fromJson(response.data['data'][0]);
    }
    return null;
  }
}
