import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import '../icon/circular_icon.dart';

class CircularCountView extends StatelessWidget {
  static const int MAX_STACK = 3;

  List<PreferredSizeWidget> _circularIcons;
  PreferredSizeWidget defaultIcon;

  CircularCountView(this._circularIcons, this.defaultIcon);

  List<Widget> _getCircularIcons(List<PreferredSizeWidget> icons) {
    List<Widget> circularIcons = [];

    // incrementing positioned left value
    double positionedLeft = 0;

    for (int i = 0; i < min(icons.length, MAX_STACK); i++) {
      if (i != 0) {
        double width = icons.elementAt(i - 1).preferredSize.width;
        positionedLeft += (width * 0.65);
      }

      circularIcons.add(
        Positioned(
          left: positionedLeft,
          child: icons.elementAt(i),
        ),
      );
    }

    if (circularIcons.length == 0) {
      // Add default one
      circularIcons.add(this.defaultIcon);
    }

    return circularIcons;
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.biggest.width,
          height: this._circularIcons.isEmpty ? this.defaultIcon.preferredSize.height : this._circularIcons.first.preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: this._circularIcons.isEmpty ? this.defaultIcon.preferredSize.width + 15 : this._circularIcons.first.preferredSize.width * min(this._circularIcons.length, MAX_STACK) + 15,
                height: this._circularIcons.isEmpty ? this.defaultIcon.preferredSize.height : this._circularIcons.first.preferredSize.height,
                child: Stack(
                  children: <Widget>[
                    ... _getCircularIcons(this._circularIcons),
                  ],
                ),
              ),
              Text(
                '${_circularIcons.length}',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}
