import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woorinaru/service/identity_provider_service.dart';

import './components/localization/app_localizations.dart';
import './route.dart' as MyRoute;
import './models/storage/woorinaru_local_storage.dart';
import './config/env.dart';
import './service/authentication_service.dart';
import './service/localstorage_service.dart';
import './service/token_service.dart';

class WoorinaruApp extends StatefulWidget {
  @override
  _WoorinaruAppState createState() => _WoorinaruAppState();
}

class _WoorinaruAppState extends State<WoorinaruApp> {

  TokenService tokenService;

  @override
  void initState() {
    super.initState();

    this.tokenService = TokenService(
      localStorageService: LocalStorageService(),
      authenticationService: AuthenticationService(baseUrl: env.baseUrl),
      identityProviderService: IdentityProviderService(),
    );

    _loadAccessToken();
    _loadUser();
  }

  void _loadAccessToken() async {
    String accessToken = await this.tokenService.getAccessToken();
  }

  void _loadUser() async {
    // TODO
    String idToken = await this.tokenService.getLocalIdToken();
    if (idToken == null) {
      // GUEST user
    } else {
      // Logged in user
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woorinaru Beta',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        fontFamily: 'Gaegu',
      ),
      home: MyRoute.Route(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.SUPPORTED_LOCALES,
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
    );
  }
}
