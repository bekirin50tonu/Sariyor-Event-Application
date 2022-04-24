import 'dart:developer';

class JoinedEventResponseModel {
  bool success;
  String message;
  List<JoinedEvent> events;

  JoinedEventResponseModel(
      {required this.success, required this.message, required this.events});

  factory JoinedEventResponseModel.fromJson(Map<String, dynamic> json) {
    List<JoinedEvent> model = json['data']
        .map<JoinedEvent>((val) => JoinedEvent.fromJson(val))
        .toList();

    return JoinedEventResponseModel(
        success: json['success'], message: json['message'], events: model);
  }
}

class JoinedEvent {
  int id;
  String createdAt;
  String updatedAt;
  String timeStr;
  String locate;
  User user;
  Event event;

  JoinedEvent(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.timeStr,
      required this.locate,
      required this.user,
      required this.event});

  factory JoinedEvent.fromJson(Map<String, dynamic> json) {
    return JoinedEvent(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        timeStr: json['time_str'],
        locate: json['locate'],
        user: User.fromJson(json['user']),
        event: Event.fromJson(json['event']));
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  String? imagePath;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      this.imagePath});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        imagePath: json['image_path']);
  }

  get fullName {
    return "$firstName $lastName";
  }
}

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
      required this.updatedAt});

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
        updatedAt: DateTime.parse(json['updated_at']));
  }
}
