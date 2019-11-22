import 'package:flutter/material.dart';
import 'config/env.dart';
import './woorinaru_app.dart';

void main() {
  BuildEnvironment.initDev();
  assert(env != null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WoorinaruApp();
  }
}
