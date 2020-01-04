import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'circular_icon.dart';

class EventCircularIcon extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return CircularIcon(
      radius: 10,
      icon: SvgPicture.asset('assets/icons/bx-chalkboard.svg',
          color: Colors.black),
    );
  }

  @override
  Size get preferredSize => new Size(20, 20);
}
