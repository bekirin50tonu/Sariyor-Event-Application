import 'package:dio/dio.dart';

class UpdateUserRequestModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;

  UpdateUserRequestModel(
      {this.firstName, this.lastName, this.username, this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstName!.isNotEmpty) {
      data['first_name'] = firstName;
    }
    if (lastName!.isNotEmpty) {
      data['last_name'] = lastName;
    }
    if (lastName!.isNotEmpty) {
      data['username'] = username;
    }
    if (email!.isNotEmpty) {
      data['email'] = email;
    }
    return data;
  }
}
