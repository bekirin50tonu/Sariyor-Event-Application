import 'base_user_model.dart';

class Friendship {
  int id;
  int requestUserId;
  int responseUserId;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Friendship(
      {required this.id,
      required this.requestUserId,
      required this.responseUserId,
      required this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory Friendship.fromJson(Map<String, dynamic> json) {
    var userData = json['user'] != null ? User.fromJson(json['user']) : null;
    return Friendship(
        id: json['id'],
        requestUserId: int.parse(json['request_user_id']),
        responseUserId: int.parse(json['response_user_id']),
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        user: userData);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['request_user_id'] = requestUserId;
    data['response_user_id'] = responseUserId;
    data['status'] = status;
    return data;
  }
}
