import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../di/service_locator.dart';

@Singleton()
class SharedPrefs {
  final SharedPreferences _sharedPrefs = sl<SharedPreferences>();

  static const String _settingsKey = "settings_sp_key";
  static const String _authTokenKey = "auth_token_sp_key";

  setTaskTracker(String id, Map<String, dynamic>? data) {
    data == null
        ? _sharedPrefs.remove(id)
        : _sharedPrefs.setString(id, json.encode(data));
  }

  Map<String, dynamic>? getTaskTracker(String id) {
    final jsonString = _sharedPrefs.getString(id);
    return jsonString != null
        ? json.decode(jsonString) as Map<String, dynamic>
        : null;
  }

  // Settings
  set settings(String? settings) => settings == null
      ? _sharedPrefs.remove(_settingsKey)
      : _sharedPrefs.setString(_settingsKey, settings);

  String? get settings => _sharedPrefs.getString(_settingsKey);

  set token(String? token) => token == null
      ? _sharedPrefs.remove(_authTokenKey)
      : _sharedPrefs.setString(_authTokenKey, token);

  String? get token => _sharedPrefs.getString(_authTokenKey);
}
