import 'base/base_event_model.dart';
import 'base/base_user_model.dart';

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
