import 'package:flutter/material.dart';

// Import screens
import './screen/splash/splash_screen.dart';
import './screen/login/login.dart';
import './screen/home/home.dart';
import './screen/init/init.dart';

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
