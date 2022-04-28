import '../../events/models/base/base_user_model.dart';

class UserDataResponse {
  bool success;
  String message;
  Data data;

  UserDataResponse(
      {required this.success, required this.message, required this.data});

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
        success: json['success'],
        message: json['message'],
        data: Data.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  User user;
  String token;

  Data({required this.user, required this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(user: User.fromJson(json['user']), token: json['token']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['token'] = token;
    return data;
  }
}
