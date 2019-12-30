import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppLocalizations {

  static Map<String, dynamic> SUPPORTED_LOCALES_DISPLAY = {
    '한국어': 'kr.svg',
    'English': 'us.svg',
    '中文': 'cn.svg',
  };

  static const List<Locale> SUPPORTED_LOCALES = [
    Locale('ko', 'KR'),
    Locale('en', 'US'),
    Locale.fromSubtags(languageCode: 'cn', scriptCode: 'Hans', countryCode: 'zh')
  ];

  // Helper method to keep the code in the widgets consise
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Locale _locale;

  AppLocalizations(this._locale);

  // Static member to have a simple access to the delegate from the MaterialApp
  // static LocalizationsDelegate<AppLocalizations> delegate(Locale locale) => _AppLocalizationsDelegate(locale);

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/i18n/${this._locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);
    // final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    // final String localeName = Intl.canonicalizedLocale(name);
    // Intl.defaultLocale = localeName;

    _localizedStrings = _result.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String trans(String key) {
    return _localizedStrings[key];
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // const _AppLocalizationsDelegate();

  // final BuildContext context;
  final Locale newLocale;

  const AppLocalizationsDelegate(this.newLocale);

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.SUPPORTED_LOCALES.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(newLocale ?? locale);
    await localizations.load();
    // return await AppLocalizations.load(newLocale ?? locale);
    return localizations;
    // return Provider.of<AppLocalizations>(this.context, listen: false).load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return true;
  }
}
