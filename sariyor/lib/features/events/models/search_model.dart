import 'dart:developer';

import 'package:sariyor/features/events/models/base/base_event_model.dart';

import 'base/base_category_model.dart';
import 'base/base_user_model.dart';

class SearchResponseModel {
  List<User?> users;
  List<Category?> categories;
  List<Event?> events;

  SearchResponseModel(
      {required this.users, required this.categories, required this.events});

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    List<User?> users =
        json['users'].map<User>((user) => User.fromJson(user)).toList();
    List<Category?> categories = json['categories']
        .map<Category>((cat) => Category.fromJson(cat))
        .toList();
    List<Event?> events =
        json['events'].map<Event>((event) => Event.fromJson(event)).toList();
    return SearchResponseModel(
        users: users, categories: categories, events: events);
  }
}
