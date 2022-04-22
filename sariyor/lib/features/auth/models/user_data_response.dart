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

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String? imagePath;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      this.emailVerifiedAt,
      this.imagePath,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        emailVerifiedAt: DateTime.parse(json['email_verified_at']),
        imagePath: json['image_path']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image_path'] = imagePath;
    data['email_verified_at'] = emailVerifiedAt!.toIso8601String();
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    return data;
  }
}
