import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sariyor/features/auth/models/user_data_response.dart';

abstract class IUserService {
  Future<User?> updateData(
      String firstName, String lastName, String username, String email);

  Future<void> updateImage(File image);

  Future<User?> getUserData();
}
