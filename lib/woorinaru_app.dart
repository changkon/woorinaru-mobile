import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/service/identity_provider_service.dart';

import './components/localization/app_localizations.dart';
import './route.dart' as WoorinaruRoute;
import './config/env.dart';
import './service/authentication_service.dart';
import './service/localstorage_service.dart';
import './service/token_service.dart';
import './service/term_service.dart';
import './service/event_service.dart';

import './models/user/client_model.dart';

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
        ProxyProvider<TokenService, TermService>(
          builder: (_, tokenService, __) => TermService(baseUrl: env.baseUrl, tokenService: tokenService)
          // create: (context) => TermService(baseUrl: env.baseUrl, tokenService: Provider.of<TokenService>(context)),
          // update: (context, tokenService, termService) => TermService(baseUrl: env.baseUrl, tokenService: tokenService)
        ),
        ProxyProvider<TokenService, EventService>(
          builder: (_, tokenService, __) => EventService(baseUrl: env.baseUrl, tokenService: tokenService)
        ),
        ChangeNotifierProvider(
          create: (_) => ClientModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Woorinaru Beta',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          fontFamily: 'NotoSansKr',
        ),
        // home: MyRoute.Route(),
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
        initialRoute: WoorinaruRoute.Route.ROOT,
        routes: WoorinaruRoute.Route.routes,
      ),
    );
  }
}
