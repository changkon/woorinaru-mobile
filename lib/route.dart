import 'package:flutter/material.dart';

import './model/term/term.dart';

// Import screens
import './screen/splash/splash_screen.dart';
import './screen/login/login_screen.dart';
import './screen/home/home_screen.dart';
import './screen/init/init_screen.dart';
import './screen/term/term_screen.dart';

class Route {
  static const String ROOT = '/';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  static const String TERM = '/term';
  static const String EVENT = '/event';

  // static Map<String, WidgetBuilder> routes = {
  //   ROOT: (BuildContext context) => Init(),
  //   HOME: (BuildContext context) => Home(),
  //   LOGIN: (BuildContext context) => Login(),
  // };

  static RouteFactory onGenerateRoutes = (RouteSettings settings) {
    final String route = settings.name;

    if (route == ROOT) {
      return MaterialPageRoute(builder: (BuildContext context) => InitScreen());
    } else if (route == HOME) {
      return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
    } else if (route == LOGIN) {
      return MaterialPageRoute(builder: (BuildContext context) => LoginScreen());
    } else if (route == TERM) {
      final Map<String, dynamic> routeArgs =
          settings.arguments as Map<String, dynamic>;
      Term term = routeArgs['term'] as Term;

      return MaterialPageRoute(
          builder: (BuildContext context) => TermScreen(term));
    }

    return MaterialPageRoute(builder: (BuildContext context) => InitScreen());
  };
}
