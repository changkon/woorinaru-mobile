import 'package:shared_preferences/shared_preferences.dart';

import '../models/storage/woorinaru_local_storage.dart';

class LocalStorageService {

  LocalStorageService();

  Future<String> _get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      return null;
    }
    return prefs.getString(key);
  }

  Future<void> _save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> saveIdToken(String token) async {
    _save(WoorinaruLocalStorage.ID_TOKEN, token);
  }

  Future<void> saveAccessToken(String token) async {
    _save(WoorinaruLocalStorage.ACCESS_TOKEN, token);
  }

  Future<String> getIdToken() async {
    return _get(WoorinaruLocalStorage.ID_TOKEN);
  }

  Future<String> getAccessToken() async {
    return _get(WoorinaruLocalStorage.ACCESS_TOKEN);
  }
}
