import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

// Import screens
import './screens/splash/splash_screen.dart';
import './screens/login/login.dart';
import './screens/home/home.dart';
import './service/token_service.dart';

import './models/user/user.dart';
import './models/user/user_model.dart';
import './models/token/access_token_payload.dart';

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
    String accessToken = await tokenService.getLocalAccessToken();

    if (accessToken == null) {
      String idToken = await tokenService.getLocalIdToken();
      String refreshToken = await tokenService.getLocalIdRefreshToken();
      accessToken = await tokenService.generateAccessToken(idToken: idToken, refreshToken: refreshToken);
    }

    AccessTokenPayload tokenPayload = AccessTokenPayload.fromAccessToken(accessToken);

    if (tokenPayload.role == 'visitor') {
      // GUEST user
      Provider.of<UserModel>(context, listen: false).setLoggedInUser(null);
    } else {
      // Logged in user
      String idToken = await tokenService.getLocalIdToken();
      User loggedInUser = User.fromIdToken(idToken);
      Provider.of<UserModel>(context, listen: false).setLoggedInUser(loggedInUser);
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
