import 'package:flutter/material.dart';

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
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(new AppBar().preferredSize.height);
}
