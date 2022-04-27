import 'dart:convert';
import 'dart:developer';

import 'package:sariyor/features/auth/models/user_data_response.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

class Auth {
  static Auth? instance;
  Auth._init({User? userData, String? tokenData, bool rememberMe = false}) {
    user = userData;
    token = tokenData;
    remember = rememberMe;
  }

  User? user;
  String? token;
  bool remember = false;
  Auth({this.user, this.token});
//-*-*-*-*-*-*-*-*-*-*-*-*//

  void login(User userData, String tokenData, bool rememberMeData) {
    Prefs.setString('user', jsonEncode(userData.toJson()));
    Prefs.setString('token', tokenData);
    user = userData;
    token = tokenData;
    remember = rememberMeData;
  }

  Future<void> logout() async {
    if (!remember) {
      await _removeKeys();
    }
    token = null;
    user = null;
  }

  Future<void> _removeKeys() async {
    await Prefs.remove('token');
    await Prefs.remove('user');
  }
}

class AuthPreference {
  static Future<void> getInstance() async {
    var user = _getUserData();
    var token = _getTokenData();
    Auth.instance =
        Auth._init(userData: user, tokenData: token, rememberMe: false);
  }

  static User? _getUserData() {
    var userData = Prefs.getString('user');
    if (userData != null) {
      Map<String, dynamic> json = jsonDecode(userData);
      return User.fromJson(json);
    }
    return null;
  }

  static String? _getTokenData() {
    if (Prefs.getString('user') != null) {
      return Prefs.getString('token');
    }
    return null;
  }
}
