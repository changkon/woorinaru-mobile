import 'package:flutter/material.dart';

// Import screens
import './screens/splash/splash_screen.dart';
import './screens/login/login.dart';
import './screens/home/home.dart';

class Route extends StatefulWidget {
  @override
  _RouteState createState() => _RouteState();
}

class _RouteState extends State<Route> {

  bool _firstLoad = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: SplashScreen.DURATION), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
  }

  void retrieveUserDetails() {
    // TODO
  }

  void retrieveAPIToken() async {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SplashScreen(),
    );
  }
}
