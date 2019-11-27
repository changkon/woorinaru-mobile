import 'package:flutter/material.dart';
import '../../components/localization/app_localizations.dart';
import '../../components/appbar/woorinaru_app_bar.dart';
import '../../components/drawer/woorinaru_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WoorinaruAppBar(),
      drawer: WoorinaruDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).trans('hello')),
          ],
        ),
      ),
    );
  }
}
