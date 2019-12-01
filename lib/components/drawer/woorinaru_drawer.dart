import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/user_model.dart';
import '../../models/user/user.dart';
import '../../components/localization/app_localizations.dart';

class WoorinaruDrawer extends StatefulWidget {
  @override
  _WoorinaruDrawerState createState() => _WoorinaruDrawerState();
}

class _WoorinaruDrawerState extends State<WoorinaruDrawer> {

  List<Widget> _guestListTiles() {
    List<Widget> widgets = [];

    ListTile loginListTile = ListTile(
      title: Text(AppLocalizations.of(context).trans('login')),
      trailing: IconButton(
        icon: Icon(Icons.person),
        onPressed: () {}
      ),
    );

    widgets.add(loginListTile);
    widgets.add(new Divider());
    widgets.addAll(_commonWidgets());
    return widgets;
  }

  List<Widget> _commonWidgets() {

    return [];
  }

  List<Widget> _getWidgets(User user) {
    if (user == null) {
      return _guestListTiles();
    } else {
      if (user.userType == UserType.STUDENT) {

      } else if (user.userType == UserType.STAFF) {

      } else if (user.userType == UserType.ADMIN) {

      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (_, userModel, __) => Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: userModel.loggedInUser == null ? Text('Guest') : Text(userModel.loggedInUser.name),
              accountEmail: userModel.loggedInUser == null ? Text('') : Text(userModel.loggedInUser.email),
              currentAccountPicture: CircleAvatar(
                  child: userModel.loggedInUser == null ? Text('G', style: TextStyle(fontSize: 40.0)) : Text(userModel.loggedInUser.name.substring(0, 1).toUpperCase())),
            ),
            ... _getWidgets(userModel.loggedInUser),
          ],
        ),
      ),
    );
  }
}
