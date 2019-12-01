import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import screens
import './screens/splash/splash_screen.dart';
import './screens/login/login.dart';
import './screens/home/home.dart';
import './service/token_service.dart';

class Route extends StatefulWidget {
  @override
  _RouteState createState() => _RouteState();
}

class _RouteState extends State<Route> {

  // TODO
  bool _userFirstLoad = false;
  bool _init = false;

  @override
  void initState() {
    super.initState();
    // Splash screen navigation
    _splashScreenNavigation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      _init = true;
      _initTokenCredentialsAndUser();
    }
  }

  void _splashScreenNavigation() {
    Future.delayed(const Duration(seconds: SplashScreen.DURATION), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
  }

  void _initTokenCredentialsAndUser() async {
    TokenService tokenService = Provider.of<TokenService>(context);
    await tokenService.getAccessToken();
    String idToken = await tokenService.getLocalIdToken();
    if (idToken == null) {
      // GUEST user
      // print("Guest");
    } else {
      // Logged in user
      // print(idToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SplashScreen(),
    );
  }
}
