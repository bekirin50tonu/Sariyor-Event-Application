class UserRegisterRequest {
  late String firstName;
  late String lastName;
  late String username;
  late String email;
  late String password;

  UserRegisterRequest(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password});

  UserRegisterRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
