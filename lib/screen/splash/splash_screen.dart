import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  static const int DURATION = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image(image: AssetImage('assets/images/logo.png')),
      ),
    );
  }
}
