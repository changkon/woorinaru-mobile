import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventInfo extends StatelessWidget {
  String title;
  String text;

  EventInfo({
    @required this.title,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //     right: 5,
          //   ),
          //   constraints: BoxConstraints(maxHeight: 15, maxWidth: 15),
          //   child: SvgPicture.asset(
          //     this.svgPath,
          //     color: Colors.grey,
          //   ),
          // ),
          // Text(
          //   this.text,
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 1,
          //   style: TextStyle(
          //     color: Colors.grey,
          //     fontSize: 10,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
