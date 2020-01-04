import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CircularIcon extends StatelessWidget implements PreferredSizeWidget {

  double radius = 3.0;
  Widget icon;

  CircularIcon({ this.radius, @required this.icon });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.white,
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: this.icon,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size(this.radius * 2, this.radius * 2);
}
