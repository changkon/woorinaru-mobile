import 'package:flutter/material.dart';
import 'package:woorinaru/components/localization/app_localizations.dart';

class WoorinaruAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WoorinaruAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).trans('woorinaru'),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(new AppBar().preferredSize.height);
}
