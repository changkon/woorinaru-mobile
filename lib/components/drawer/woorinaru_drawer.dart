import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/client_model.dart';
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
      trailing: IconButton(icon: Icon(Icons.person), onPressed: () {}),
    );

    widgets.add(loginListTile);
    widgets.add(new Divider());
    widgets.addAll(_commonWidgets());
    return widgets;
  }

  List<Widget> _commonWidgets() {
    return [];
  }

  List<Widget> _commonLoggedInWidgets() {
    List<Widget> widgets = [];

    ListTile logoutListTile = ListTile(
      title: Text(AppLocalizations.of(context).trans('logout')),
      trailing: IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
    );

    widgets.add(logoutListTile);
    return widgets;
  }

  List<Widget> _studentListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.addAll(_commonLoggedInWidgets());
    return widgets;
  }

  List<Widget> _staffListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.addAll(_commonLoggedInWidgets());
    return widgets;
  }

  List<Widget> _adminListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.addAll(_commonLoggedInWidgets());
    return widgets;
  }

  List<Widget> _getWidgets(User user) {
    if (user == null) {
      return _guestListTiles();
    } else {
      if (user.userType == UserType.STUDENT) {
        return _studentListTiles();
      } else if (user.userType == UserType.STAFF) {
        return _staffListTiles();
      } else if (user.userType == UserType.ADMIN) {
        return _adminListTiles();
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientModel>(
      builder: (_, clientModel, __) => Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: clientModel.loggedInClient == null
                  ? Text(AppLocalizations.of(context).trans('guest'))
                  : Text(clientModel.loggedInClient.name),
              accountEmail: clientModel.loggedInClient == null
                  ? Text('')
                  : Text(clientModel.loggedInClient.email),
              currentAccountPicture: CircleAvatar(
                  child: clientModel.loggedInClient == null
                      ? Text(
                          'G',
                          style: TextStyle(fontSize: 40.0),
                        )
                      : Text(
                          clientModel.loggedInClient.name
                              .substring(0, 1)
                              .toUpperCase(),
                          style: TextStyle(fontSize: 40.0),
                        )),
            ),
            ..._getWidgets(clientModel.loggedInClient),
          ],
        ),
      ),
    );
  }
}
