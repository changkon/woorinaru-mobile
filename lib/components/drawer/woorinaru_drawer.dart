import 'package:flutter/material.dart';

class WoorinaruDrawer extends StatefulWidget {
  @override
  _WoorinaruDrawerState createState() => _WoorinaruDrawerState();
}

class _WoorinaruDrawerState extends State<WoorinaruDrawer> {

  // TODO refactor to a model class
  String _name;
  String _nameInitial;
  String _role;
  String _team;
  bool _isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Visitor'),
            accountEmail: Text('test@random.com'),
            currentAccountPicture: CircleAvatar(
                child: Text('V', style: TextStyle(fontSize: 40.0))),
          ),
          ListTile(
            title: Text('Login'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
