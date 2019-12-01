import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/service/identity_provider_service.dart';

import './components/localization/app_localizations.dart';
import './route.dart' as MyRoute;
import './config/env.dart';
import './service/authentication_service.dart';
import './service/localstorage_service.dart';
import './service/token_service.dart';

import './models/user/user_model.dart';

class WoorinaruApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<TokenService>(
          create: (_) => TokenService(
            authenticationService: AuthenticationService(baseUrl: env.baseUrl),
            localStorageService: LocalStorageService(),
            identityProviderService: IdentityProviderService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserModel(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
