import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woorinaru/service/auth/token_service.dart';

import '../../service/storage/woorinaru_local_storage.dart';
import '../../theme/localization/app_localizations.dart';

class LocalizationModel extends ChangeNotifier {
  static final Logger log = new Logger('LocalStorageService');
  static Locale _initialLocale = AppLocalizations.SUPPORTED_LOCALES.first;

  Locale _locale;
  Locale get currentLocale => _locale;

  LocalizationModel();

  Future<bool> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(WoorinaruLocalStorage.LOCALE)) {
      log.warning('Not loading initial locale');
      // Return the first locale
      return true;
    }

    String localeLanguageCode = prefs.getString(WoorinaruLocalStorage.LOCALE);
    Locale savedLocale = AppLocalizations.SUPPORTED_LOCALES.firstWhere((locale) => locale.languageCode == localeLanguageCode, orElse: () => _initialLocale);
    log.info('Loading saved locale: ${savedLocale.languageCode}');
    setLocale(savedLocale);
    return true;
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
