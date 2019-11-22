import 'package:flutter/material.dart';
import 'package:woorinaru/components/app_localizations.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Woorinaru Login'),
      ),
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
