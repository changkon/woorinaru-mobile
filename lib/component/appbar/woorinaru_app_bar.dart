import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './lang/lang_dropdown.dart';

class WoorinaruAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const WoorinaruAppBar({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        this.text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <Widget>[
        LangDropDown(),
      ],
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(new AppBar().preferredSize.height);
}
