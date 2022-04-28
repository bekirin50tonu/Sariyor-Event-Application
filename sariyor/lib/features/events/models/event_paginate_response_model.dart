import 'base/base_category_model.dart';
import 'base/base_user_model.dart';

class EventPaginateResponse {
  bool success;
  String message;
  Events data;

  EventPaginateResponse(
      {required this.success, required this.message, required this.data});

  factory EventPaginateResponse.fromJson(Map<String, dynamic> json) {
    return EventPaginateResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'][0]);
  }
}

class Events {
  int currentPage;
  List<Event> events;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  String nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;

  Events(
      {required this.currentPage,
      required this.events,
      required this.firstPageUrl,
      required this.from,
      required this.lastPage,
      required this.lastPageUrl,
      required this.links,
      required this.nextPageUrl,
      required this.path,
      required this.perPage,
      this.prevPageUrl,
      required this.to,
      required this.total});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
        currentPage: json['current_page'],
        events: json['data'].map((data) => Event.fromJson(data)).toList(),
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: json['links'],
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        to: json['to'],
        total: json['total'],
        prevPageUrl: json['prev_page_url']);
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
  User user;
  Category category;

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
      required this.user,
      required this.category});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
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
}

class Links {
  String url;
  String label;
  bool active;

  Links({required this.url, required this.label, required this.active});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
        url: json['url'], label: json['label'], active: json['active']);
  }
}
