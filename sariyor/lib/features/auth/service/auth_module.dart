import 'dart:convert';
import 'dart:developer';

import 'package:sariyor/features/auth/models/user_data_response.dart';
import 'package:sariyor/utils/locale/shared_preferences.dart';

class Auth {
  static User? user = _getUserData();
  static String? token = _getTokenData();
  static bool rememberMe = false;

  static void login(User userData, String tokenData, bool rememberMeData) {
    Prefs.setString('user', jsonEncode(userData.toJson()));
    Prefs.setString('token', tokenData);
    user = userData;
    token = tokenData;
    rememberMe = rememberMeData;
  }

  static void logout() {
    if (!rememberMe) {
      Prefs.remove('token');
      Prefs.remove('user');
    }
    token = null;
    user = null;
  }

  static User? _getUserData() {
    if (!rememberMe) {
      Prefs.remove('token');
      Prefs.remove('user');
    }
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
