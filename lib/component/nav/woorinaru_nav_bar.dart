import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../model/user/client_model.dart';
import '../../model/user/client.dart';
import '../../model/user/user.dart';
import '../../screen/home/tabs.dart';

import "../../route.dart" as WoorinaruRoute;

class WoorinaruNavBar extends StatelessWidget {
  static const double HEIGHT = 40;

  final String currentTab;
  final Function tabTapCallback;
  final Map<String, Widget> _items = {};
  final ClientModel clientModel;

  WoorinaruNavBar({
    Key key,
    this.currentTab,
    this.tabTapCallback,
    this.clientModel,
  }) : super(key: key) {
    Widget homeTab =
        _createTab('assets/icons/bxs-home.svg', 'Home Tab', Tabs.HOME_TAB);
    Widget favouriteTab = _createTab(
        'assets/icons/bx-heart.svg', 'Favourite Tab', Tabs.FAVOURITE_TAB);
    Widget termTab =
        _createTab('assets/icons/bx-archive.svg', 'Term Tab', Tabs.TERM_TAB);
    Widget userManagementTab = _createTab('assets/icons/bxs-user-detail.svg',
        'User Management Tab', Tabs.USER_MANAGEMENT_TAB);

    // Add tabs
    this._items[Tabs.HOME_TAB] = homeTab;
    this._items[Tabs.FAVOURITE_TAB] = favouriteTab;
    this._items[Tabs.TERM_TAB] = termTab;
    this._items[Tabs.USER_MANAGEMENT_TAB] = userManagementTab;
  }

  Widget _createTab(String svgPath, String label, String key) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return InkWell(
          onTap: () => this.tabTapCallback(key),
          child: Container(
            padding: EdgeInsets.all(
              constraints.biggest.height * 0.15,
            ),
            child: SvgPicture.asset(
              svgPath,
              semanticsLabel: label,
              color: key == currentTab ? Colors.black45 : Colors.white,
            ),
          ),
        );
      }),
    );
  }

  Widget _createActionButton(Client model) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return IconButton(
          icon: Icon(
            Icons.control_point,
            color: Colors.white,
          ),
          // Add navigation
          onPressed: () => Navigator.of(context)
              .pushNamed(WoorinaruRoute.Route.CREATE_OPTION),
          iconSize: (constraints.biggest.height -
              (constraints.biggest.height * 0.15 * 2)),
        );
      }),
    );
  }

  List<Widget> _getItems(Client model) {
    List<Widget> items = [];

    if (model == null) {
      items.add(_items[Tabs.HOME_TAB]);
      items.add(_items[Tabs.TERM_TAB]);
    } else if (model.userType == UserType.ADMIN) {
      items.add(_items[Tabs.HOME_TAB]);
      items.add(_items[Tabs.FAVOURITE_TAB]);
      items.add(_createActionButton(model));
      items.add(_items[Tabs.TERM_TAB]);
      items.add(_items[Tabs.USER_MANAGEMENT_TAB]);
    } else if (model.userType == UserType.STAFF) {
      // Add more options
      items.add(_items[Tabs.HOME_TAB]);
      items.add(_items[Tabs.FAVOURITE_TAB]);
      items.add(_createActionButton(model));
      items.add(_items[Tabs.TERM_TAB]);

      StaffRole staffRole = model.staffRole;
      if (staffRole == StaffRole.LEADER ||
          staffRole == StaffRole.VICE_LEADER ||
          staffRole == StaffRole.SUB_LEADER) {
        items.add(_items[Tabs.USER_MANAGEMENT_TAB]);
      }
    } else if (model.userType == UserType.STUDENT) {
      items.add(_items[Tabs.HOME_TAB]);
      items.add(_items[Tabs.FAVOURITE_TAB]);
      items.add(_items[Tabs.TERM_TAB]);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Material(
      elevation: 20.0,
      child: Container(
        height: HEIGHT,
        color: Theme.of(context).primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ..._getItems(this.clientModel.loggedInClient),
          ],
        ),
      ),
    );
  }
}
