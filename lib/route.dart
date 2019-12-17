import 'package:flutter/material.dart';

// Import screens
import './screens/splash/splash_screen.dart';
import './screens/login/login.dart';
import './screens/home/home.dart';
import './screens/init/init.dart';

class Route {
  static const String ROOT = '/';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  static const String TERM = '/term';
  static const String EVENT = '/event';

  static Map<String, WidgetBuilder> routes = {
    ROOT: (context) => Init(),
    HOME: (context) => Home(),
  };
}
