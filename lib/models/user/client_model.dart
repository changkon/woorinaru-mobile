import 'package:flutter/material.dart';

import './client.dart';

class ClientModel extends ChangeNotifier {
  Client _loggedInClient;

  Client get loggedInClient => _loggedInClient;

  void setLoggedInClient(Client client) {
    _loggedInClient = client;
    notifyListeners();
  }
}
