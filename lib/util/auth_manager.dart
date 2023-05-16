import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/di.dart';

class AuthManager {
  static final ValueNotifier<String?> authchangenotifire = ValueNotifier(null);
  static final SharedPreferences _sharepref = locator.get();

  static void savetoken(String token) async {
    _sharepref.setString('access_token', token);
    authchangenotifire.value = token;
  }

  static String readauth() {
    return _sharepref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharepref.clear();
    authchangenotifire.value = null;
  }

  static bool islogedin() {
    String token = readauth();
    return token.isNotEmpty;
  }
}
