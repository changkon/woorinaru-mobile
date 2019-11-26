import 'package:flutter/material.dart';
import 'package:woorinaru/components/localization/app_localizations.dart';
import '../../components/appbar/woorinaru_app_bar.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WoorinaruAppBar(),
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
