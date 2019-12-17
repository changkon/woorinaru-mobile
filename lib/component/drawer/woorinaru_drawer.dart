import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user/client_model.dart';
import '../../model/user/user.dart';
import '../../theme/localization/app_localizations.dart';

import '../../service/storage/localstorage_service.dart';
import '../../service/auth/token_service.dart';

import '../../model/auth/woorinaru_access_token_payload.dart';

import '../../route.dart' as WoorinaruRoute;

class WoorinaruDrawer extends StatefulWidget {
  @override
  _WoorinaruDrawerState createState() => _WoorinaruDrawerState();
}

class _WoorinaruDrawerState extends State<WoorinaruDrawer> {
  List<Widget> _guestListTiles() {
    List<Widget> widgets = [];

    ListTile loginListTile = ListTile(
      onTap: () => Navigator.of(context).pushNamed(WoorinaruRoute.Route.LOGIN),
      title: Text(AppLocalizations.of(context).trans('login')),
      trailing: SvgPicture.asset(
        'assets/icons/bx-user.svg',
        semanticsLabel: 'User',
        color: Colors.grey,
      ),
    );

    widgets.add(loginListTile);
    widgets.add(new Divider());
    widgets.addAll(_commonWidgets());
    return widgets;
  }

  Future<void> _logout() async {
    // Clear out local storage
    // Login as guest
    // Go to home page
    TokenService tokenService = Provider.of<TokenService>(context, listen: false);

    // Clear out local storage
    await tokenService.removeLocalIdToken();
    await tokenService.removeLocalIdRefreshToken();
    await tokenService.removeLocalAccessToken();

    String accessToken = await tokenService.generateAccessToken(idToken: null, refreshToken: null);
    WoorinaruAccessTokenPayload tokenPayload = WoorinaruAccessTokenPayload.fromAccessToken(accessToken);

    assert(tokenPayload.role == 'visitor');
    // Login as guest and save access token
    // Log in as guest
    Provider.of<ClientModel>(context, listen: false).setLoggedInClient(null);

    // Go to home
    Navigator.of(context).pushReplacementNamed(WoorinaruRoute.Route.HOME);
  }

  List<Widget> _commonWidgets() {
    List<Widget> widgets = [];

    ListTile facebookListTile = ListTile(
      onTap: () async => launch('https://facebook.com/woorinaru'),
      title: const Text('Facebook'),
      trailing: SvgPicture.asset(
        'assets/icons/bxl-facebook-square.svg',
        semanticsLabel: 'Facebook',
        color: Colors.blueAccent,
      ),
    );

    ListTile instagramListTile = ListTile(
      onTap: () async => launch('https://instagram.com/woori_naru'),
      title: const Text('Instagram'),
      trailing: SvgPicture.asset(
        'assets/icons/bxl-instagram.svg',
        semanticsLabel: 'Instagram',
        color: Colors.deepPurpleAccent,
      ),
    );

    ListTile youtubeListTile = ListTile(
      onTap: () async => launch('https://www.youtube.com/channel/UCm51IEBxHG0x4-YBAnC-Sgw'),
      title: const Text('Youtube'),
      trailing: SvgPicture.asset(
        'assets/icons/bxl-youtube.svg',
        semanticsLabel: 'Youtube',
        color: Colors.redAccent,
      ),
    );

    ListTile websiteListTile = ListTile(
      onTap: () async => launch('https://www.woorinaru.com'),
      title: const Text('Website'),
      trailing: SvgPicture.asset(
        'assets/icons/bx-link-external.svg',
        semanticsLabel: 'Website',
        color: Colors.grey,
      ),
    );

    widgets.add(facebookListTile);
    widgets.add(instagramListTile);
    widgets.add(youtubeListTile);
    widgets.add(websiteListTile);
    return widgets;
  }

  List<Widget> _commonLoggedInWidgets() {
    List<Widget> widgets = [];

    ListTile logoutListTile = ListTile(
      onTap: _logout,
      title: Text(AppLocalizations.of(context).trans('logout')),
      trailing: Icon(Icons.exit_to_app),
    );

    widgets.add(logoutListTile);
    return widgets;
  }

  List<Widget> _studentListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.add(new Divider());
    widgets.addAll(_commonLoggedInWidgets());
    return widgets;
  }

  List<Widget> _staffListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.add(new Divider());
    widgets.addAll(_commonLoggedInWidgets());
    return widgets;
  }

  List<Widget> _adminListTiles() {
    List<Widget> widgets = [];
    widgets.addAll(_commonWidgets());
    widgets.add(new Divider());
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
