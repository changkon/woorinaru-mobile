import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'circular_icon.dart';

class StaffCircularIcon extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return CircularIcon(
      radius: 10,
      icon: SvgPicture.asset('assets/icons/bxs-user-circle.svg',
          color: Colors.blueAccent),
    );
  }

  @override
  Size get preferredSize => new Size(20, 20);
}
