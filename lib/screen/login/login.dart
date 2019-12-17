import 'package:flutter/material.dart';
import '../../component/drawer/woorinaru_drawer.dart';
import '../../component/appbar/woorinaru_app_bar.dart';
import '../../theme/localization/app_localizations.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    WoorinaruAppBar appBar = WoorinaruAppBar(text: AppLocalizations.of(context).trans('login'));

    return Scaffold(
      appBar: appBar,
      drawer: WoorinaruDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).trans('hello')
            ),
          ],
        ),
      ),
    );
  }
}
