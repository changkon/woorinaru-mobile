import 'package:flutter/material.dart';
import './tab.dart' as WoorinaruTab;

class UserManagementTab extends StatefulWidget implements WoorinaruTab.Tab {

  _UserManagementTabState _userManagementTabState;

  @override
  _UserManagementTabState createState() {
    _UserManagementTabState _userManagementTabState = _UserManagementTabState();
    return _userManagementTabState;
  }

  @override
  Future<void> onRefresh() {
    return _userManagementTabState._loadUsers();
  }
}

class _UserManagementTabState extends State<UserManagementTab> {

  Future<void> _loadUsers() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WoorinaruTab.Tab.PADDING),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('User management'),
        ],
      ),
    );
  }
}
