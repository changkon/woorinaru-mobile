import 'package:flutter/material.dart';
import 'package:woorinaru/components/localization/app_localizations.dart';

class WoorinaruAppBar extends StatelessWidget implements PreferredSizeWidget {

  const WoorinaruAppBar({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          print('Menu pressed');
        }
      ),
      title: Text(
        AppLocalizations.of(context).trans('woorinaru'),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
    // return Container(
    //   color: Colors.white,
    //   padding: EdgeInsets.only(top: 25),
    //   child: Row(
    //     children: <Widget>[
    //       IconButton(
    //         icon: Icon(Icons.menu),
    //         onPressed: () {
    //           print('Menu pressed');
    //         },
    //       ),
    //       Expanded(
    //         child: Text(
    //           AppLocalizations.of(context).trans('woorinaru'),
    //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       // TODO include support for changing locale
    //       // DropdownButton<IconButton>(
    //       //   value: IconButton(
    //       //     icon: Icon(Icons.korea)
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }

  @override
  Size get preferredSize => new Size.fromHeight(new AppBar().preferredSize.height);
}
