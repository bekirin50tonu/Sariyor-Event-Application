class UserLoginRequest {
  String email;
  String password;

  UserLoginRequest({required this.email, required this.password});

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) {
    return UserLoginRequest(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
