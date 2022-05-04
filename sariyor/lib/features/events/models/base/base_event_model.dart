import 'package:sariyor/features/events/models/base/base_friendship_model.dart';

import 'base_category_model.dart';
import 'base_user_model.dart';

class Event {
  int id;
  String name;
  String description;
  String? imagePath;
  int count;
  bool onlyFriends;
  double lat;
  double long;
  DateTime startTime;
  DateTime endTime;
  DateTime joinStartTime;
  DateTime joinEndTime;
  DateTime createdAt;
  DateTime updatedAt;
  User owner;
  Category category;
  bool isJoined;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      this.imagePath,
      required this.count,
      required this.onlyFriends,
      required this.lat,
      required this.long,
      required this.startTime,
      required this.endTime,
      required this.joinStartTime,
      required this.joinEndTime,
      required this.createdAt,
      required this.updatedAt,
      required this.owner,
      required this.category,
      required this.isJoined});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      count: json['count'],
      onlyFriends: json['only_friends'],
      lat: json['lat'],
      long: json['long'],
      imagePath: json['image_path'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      joinStartTime: DateTime.parse(json['join_start_time']),
      joinEndTime: DateTime.parse(json['join_end_time']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      owner: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
      isJoined: json['is_joined'] as bool,
    );
  }
}
