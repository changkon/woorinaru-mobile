import 'package:flutter/material.dart';

import './user.dart';

class UserModel extends ChangeNotifier {
  User _loggedInUser;

  User get loggedInUser => _loggedInUser;

  void setLoggedInUser(User user) {
    _loggedInUser = user;
    notifyListeners();
  }
}
