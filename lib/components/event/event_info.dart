import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventInfo extends StatelessWidget {
  String svgPath;
  String text;

  EventInfo({
    @required this.svgPath,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 5,
            ),
            constraints: BoxConstraints(
              maxHeight: 15,
              maxWidth: 15,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(
                this.svgPath,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            this.text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
