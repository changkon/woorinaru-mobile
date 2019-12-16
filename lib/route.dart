import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

// Import screens
import './screens/splash/splash_screen.dart';
import './screens/login/login.dart';
import './screens/home/home.dart';
import './service/token_service.dart';

import './models/user/user.dart';
import './models/user/client.dart';
import './models/user/client_model.dart';
import './models/token/access_token_payload.dart';
import 'config/env.dart';

class Route extends StatefulWidget {
  @override
  _RouteState createState() => _RouteState();
}

class _RouteState extends State<Route> {

  // TODO
  bool _userFirstLoad = false;

  @override
  void initState() {
    super.initState();
    _initTokenCredentialsAndUser();
    // Splash screen navigation
    _splashScreenNavigation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _splashScreenNavigation() {
    Future.delayed(const Duration(seconds: SplashScreen.DURATION), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
  }

  void _initTokenCredentialsAndUser() async {
    TokenService tokenService = Provider.of<TokenService>(context, listen: false);
    if (env.flavor == BuildFlavor.development) {
      // Setup token
      // Setup local user (No local access token/id token/refresh token)
      await tokenService.localStorageService.removeAccessToken();
      await tokenService.localStorageService.removeIdToken();
      await tokenService.localStorageService.removeIdRefreshToken();

      // Guest user
      // Do nothing
      // Student user
      // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN0dWRlbnRAdGVzdC5jb20iLCJuYW1lIjoiQWxpY2UgTGVlIiwibmlja25hbWUiOiJBbGljZSIsInBpY3R1cmUiOiJwaWN0dXJlIn0.aBiwIPASKs_pZeV0VFqOYWJ2yXik9tLzVSrH9yk2T3M
      // await tokenService.localStorageService.saveIdToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN0dWRlbnRAdGVzdC5jb20iLCJuYW1lIjoiQWxpY2UgTGVlIiwibmlja25hbWUiOiJBbGljZSIsInBpY3R1cmUiOiJwaWN0dXJlIn0.aBiwIPASKs_pZeV0VFqOYWJ2yXik9tLzVSrH9yk2T3M');
      // await tokenService.localStorageService.saveIdRefreshToken('token');
      // Teacher user
      // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlYWNoZXJAdGVzdC5jb20iLCJuYW1lIjoiSGVucnkgV2Fsa2VyIiwibmlja25hbWUiOiJIZW5yeSIsInBpY3R1cmUiOiJwaWN0dXJlIn0.OGzUuaO2AmL8Kt_zbCPZOi9Lpu-I3heF1aYE468M0vw
      //await tokenService.localStorageService.saveIdToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlYWNoZXJAdGVzdC5jb20iLCJuYW1lIjoiSGVucnkgV2Fsa2VyIiwibmlja25hbWUiOiJIZW5yeSIsInBpY3R1cmUiOiJwaWN0dXJlIn0.OGzUuaO2AmL8Kt_zbCPZOi9Lpu-I3heF1aYE468M0vw');
      //await tokenService.localStorageService.saveIdRefreshToken('token');
      // Admin user
      // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwibmFtZSI6IkFsYW4gV2Fsa2VyIiwibmlja25hbWUiOiJBbGFuIiwicGljdHVyZSI6InBpY3R1cmUifQ.-KRyYkb62eCSCF9125YFGVj96V_BZgnd6TuwXwsyFj0
      await tokenService.localStorageService.saveIdToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwibmFtZSI6IkFsYW4gV2Fsa2VyIiwibmlja25hbWUiOiJBbGFuIiwicGljdHVyZSI6InBpY3R1cmUifQ.-KRyYkb62eCSCF9125YFGVj96V_BZgnd6TuwXwsyFj0');
      await tokenService.localStorageService.saveIdRefreshToken('token');
    }
    
    String accessToken = await tokenService.getLocalAccessToken();

    if (accessToken == null) {
      String idToken = await tokenService.getLocalIdToken();
      String refreshToken = await tokenService.getLocalIdRefreshToken();
      accessToken = await tokenService.generateAccessToken(idToken: idToken, refreshToken: refreshToken);
    }

    AccessTokenPayload tokenPayload = AccessTokenPayload.fromAccessToken(accessToken);

    if (tokenPayload.role == 'visitor') {
      // GUEST user
      Provider.of<ClientModel>(context, listen: false).setLoggedInClient(null);
    } else {
      // Logged in user
      String idToken = await tokenService.getLocalIdToken();
      Client loggedInClient = Client.fromIdToken(idToken);
      // TODO populate more from user using access token
      if (tokenPayload.role == 'admin') {
        loggedInClient.userType = UserType.ADMIN;
      } else if (tokenPayload.role == 'staff') {
        loggedInClient.userType = UserType.STAFF;
      } else if (tokenPayload.role == 'student') {
        loggedInClient.userType = UserType.STUDENT;
      }
      Provider.of<ClientModel>(context, listen: false).setLoggedInClient(loggedInClient);
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
