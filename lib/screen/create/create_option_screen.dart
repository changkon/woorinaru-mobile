import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/component/appbar/woorinaru_app_bar.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';

import '../../model/user/client_model.dart';
import '../../model/user/client.dart';
import '../../model/user/user.dart';

class CreateOptionScreen extends StatelessWidget {
  ListTile _createListTile(
    String title,
    String subtitle,
    String leadingIconPath,
  ) {
    SvgPicture leadingIcon = SvgPicture.asset(
      leadingIconPath,
      height: 30,
      width: 30,
    );

    return ListTile(
      leading: leadingIcon,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: () => {},
    );
  }

  List<ListTile> _displayTiles(Client client, BuildContext context) {
    if (client == null) {
      return [];
    } else {
      UserType userType = client.userType;
      StaffRole staffRole = client.staffRole;

      ListTile termTile = _createListTile(
        AppLocalizations.of(context).trans('create_term_title'),
        AppLocalizations.of(context).trans('create_term_subtitle'),
        'assets/icons/bx-rocket.svg',
      );

      ListTile eventTile = _createListTile(
        AppLocalizations.of(context).trans('create_event_title'),
        AppLocalizations.of(context).trans('create_event_subtitle'),
        'assets/icons/bx-calendar-plus.svg',
      );

      ListTile resourceTile = _createListTile(
        AppLocalizations.of(context).trans('create_resource_title'),
        AppLocalizations.of(context).trans('create_resource_subtitle'),
        'assets/icons/bx-file.svg',
      );

      if (userType == UserType.ADMIN ||
          (userType == UserType.STAFF && staffRole == StaffRole.LEADER)) {
        return [
          termTile,
          eventTile,
          resourceTile,
        ];
      } else if (userType == UserType.STAFF) {
        return [
          eventTile,
          resourceTile,
        ];
      }
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar(
        text: "${AppLocalizations.of(context).trans('create')}");

    // MediaQueryData mediaQuery = MediaQuery.of(context);
    // double availableScreenHeight = (mediaQuery.size.height - mediaQuery.padding.top);

    return Scaffold(
      appBar: appBar,
      body: Consumer<ClientModel>(
        builder: (_, clientModel, __) => ListView(
          children: <Widget>[
            ..._displayTiles(clientModel.loggedInClient, context),
          ],
        ),
      ),
    );
  }
}
