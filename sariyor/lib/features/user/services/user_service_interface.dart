import 'dart:io';


import '../../events/models/base/base_user_model.dart';

abstract class IUserService {
  Future<User?> updateData(
      String firstName, String lastName, String username, String email);

  Future<void> updateImage(File image);

  Future<User?> getUserData(int id);
}
