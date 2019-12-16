import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/user/client_model.dart';
import '../../models/user/client.dart';

class NavBar extends StatelessWidget {
  final int currentTab;
  final Function tabTapCallback;
  Map<String, Widget> _items;

  NavBar({
    Key key,
    this.currentTab,
    this.tabTapCallback,
  }) : super(key: key) {
    this._items = {};

    Widget homeTab = _createTab('assets/icons/bxs-home.svg', 'Home Tab', 0);
    Widget favouriteTab =
        _createTab('assets/icons/bx-heart.svg', 'Favourite Tab', 1);

    // Add tabs
    this._items['home'] = homeTab;
    this._items['favourite'] = favouriteTab;
  }

  Widget _createTab(String svgPath, String label, int index) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return InkWell(
          onTap: () => this.tabTapCallback(index),
          child: Container(
            padding: EdgeInsets.all(
              constraints.biggest.height * 0.15,
            ),
            child: SvgPicture.asset(
              svgPath,
              semanticsLabel: label,
              color: index == currentTab ? Colors.black45 : Colors.white,
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _getItems(Client model) {
    List<Widget> items = [];
    items.add(_items['home']);
    items.add(_items['favourite']);
    return items;
    // return TableRow(
    //   children: [
    //     TableRowInkWell(
    //       onTap: () => print('Tab clicked'),
    //       child: SvgPicture.asset(
    //         'assets/icons/bx-home.svg',
    //         fit: BoxFit.contain,
    //       ),
    //     ),
    //     TableRowInkWell(
    //       onTap: () => print('Tab clicked'),
    //       child: SvgPicture.asset(
    //         'assets/icons/bx-heart.svg',
    //         fit: BoxFit.contain,
    //       ),
    //     ),
    //   ],
    // );
    //   child: InkWell(
    //     onTap: () => print('Tab clicked'),
    //     child: ConstrainedBox(
    //       constraints: BoxConstraints(
    //         maxHeight: 20,
    //         maxWidth: 20,
    //       ),
    //       child: SvgPicture.asset(
    //         'assets/icons/bx-home.svg',
    //         fit: BoxFit.contain,
    //       ),
    //     ),
    //   ),
    // ),
    // TableRow(
    //   child: InkWell(
    //     onTap: () => print('Tab clicked'),
    //     child: SvgPicture.asset(
    //       'assets/icons/bx-heart.svg',
    //     ),
    //   ),
    // ),
    // InkWell(
    //   onTap: () => print('Tab clicked'),
    //   child: SvgPicture.asset(
    //     'assets/icons/bx-home.svg',
    //   ),
    // ),
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<ClientModel>(
      builder: (_, clientModel, __) => Material(
        elevation: 20.0,
        child: Container(
          height: 40,
          color: Theme.of(context).primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ..._getItems(clientModel.loggedInClient),
            ],
          ),
        ),
      ),
    );
  }
}
