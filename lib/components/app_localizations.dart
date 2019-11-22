import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

class AppLocalizations {
  final Locale locale;

  static const List<Locale> SUPPORTED_LOCALES = [
    Locale('en', 'US'),
    Locale('ko', 'KR'),
    Locale.fromSubtags(countryCode: 'zh')
  ];

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets consise
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;  
  
  Future<bool> load() async {
    String data = await rootBundle.loadString('assets/i18n/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    _localizedStrings = _result.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }
  
  String trans(String key) {  
    return this._localizedStrings[key];  
  }  
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.SUPPORTED_LOCALES.contains(locale);
    // if (locale.countryCode != null) {

    // }
    // return AppLocalizations.SUPPORTED_LOCALES.map((l) {
    //   return l.languageCode;
    // }).contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
