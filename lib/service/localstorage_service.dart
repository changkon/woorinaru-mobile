import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/storage/woorinaru_local_storage.dart';

class LocalStorageService {

  final Logger log = new Logger('LocalStorageService');

  LocalStorageService();

  Future<String> _get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      log.warning('No value from key: $key');
      return null;
    }
    String value = prefs.getString(key);
    log.info('Returning $value from key: $key');
    return value;
  }

  Future<void> _save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    log.info('Saving $key: $value');
  }

  Future<void> _remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    log.info('Deleted key: $key');
  }

  Future<void> saveIdToken(String token) async {
    _save(WoorinaruLocalStorage.ID_TOKEN, token);
  }

  Future<void> saveIdRefreshToken(String token) async {
    _save(WoorinaruLocalStorage.ID_REFRESH_TOKEN, token);
  }

  Future<void> saveAccessToken(String token) async {
    _save(WoorinaruLocalStorage.ACCESS_TOKEN, token);
  }

  Future<void> removeAccessToken() async {
    await _remove(WoorinaruLocalStorage.ACCESS_TOKEN);
  }

  Future<void> removeIdToken() async {
    await _remove(WoorinaruLocalStorage.ID_TOKEN);
  }

  Future<void> removeIdRefreshToken() async {
    await _remove(WoorinaruLocalStorage.ID_REFRESH_TOKEN);
  }

  Future<String> getIdToken() async {
    return _get(WoorinaruLocalStorage.ID_TOKEN);
  }
  
  Future<String> getIdRefreshToken() async {
    return _get(WoorinaruLocalStorage.ID_REFRESH_TOKEN);
  }

  Future<String> getAccessToken() async {
    return _get(WoorinaruLocalStorage.ACCESS_TOKEN);
  }
}
