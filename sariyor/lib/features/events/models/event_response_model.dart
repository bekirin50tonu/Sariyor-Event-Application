class EventResponse {
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
  User user;
  Category category;

  EventResponse(
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
      required this.user,
      required this.category});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
        imagePath: json['image_path'],
        id: json['id'],
        name: json['name'],
        description: json['description'],
        count: json['count'] as int,
        onlyFriends: json['only_friends'] as bool,
        lat: json['lat'] as double,
        long: json['long'] as double,
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        joinStartTime: DateTime.parse(json['join_start_time']),
        joinEndTime: DateTime.parse(json['join_end_time']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        user: User.fromJson(json['user']),
        category: Category.fromJson(json['category']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image_path'] = imagePath;
    data['count'] = count;
    data['only_friends'] = onlyFriends;
    data['lat'] = lat;
    data['long'] = long;
    data['start_time'] = startTime.toString();
    data['end_time'] = endTime.toString();
    data['join_start_time'] = joinStartTime.toString();
    data['join_end_time'] = joinEndTime.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['user'] = user.toJson();
    data['category'] = category.toJson();
    return data;
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String? imagePath;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      this.imagePath});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        imagePath: json['image_path']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['image_path'] = imagePath;
    return data;
  }
}

class Category {
  int id;
  String name;
  String? imagePath;

  Category({required this.id, required this.name, this.imagePath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'], name: json['name'], imagePath: json['image_path']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_path'] = imagePath;
    return data;
  }
}
