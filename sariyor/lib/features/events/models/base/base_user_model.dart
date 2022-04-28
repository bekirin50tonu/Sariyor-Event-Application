import 'package:sariyor/features/events/models/base/base_friendship_model.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String? imagePath;
  Friendship? friendship;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      this.imagePath,
      this.friendship});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        imagePath: json['image_path'],
        friendship: json['friendship'] != null
            ? Friendship.fromJson(json['friendship'])
            : null);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['image_path'] = imagePath;
    data['friendship'] = friendship?.toJson();
    return data;
  }

  get fullName {
    return "$firstName $lastName";
  }
}
