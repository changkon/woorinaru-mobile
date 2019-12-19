import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermInfo extends StatelessWidget {
  String svgPath;
  String title;
  String text;

  TermInfo({
    @required this.svgPath,
    @required this.title,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(6),
      },
      children: [
        TableRow(
          children: [
            SvgPicture.asset(
              this.svgPath,
              color: Colors.grey,
              height: 20,
              width: 20,
              alignment: Alignment.centerLeft,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    // color: Theme.of(context).primaryColorDark,
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  this.text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ],
    );
    // return Container(
    //   child: Row(
    //     children: <Widget>[
    //       Container(
    //         margin: EdgeInsets.only(
    //           right: 5,
    //         ),
    //         constraints: BoxConstraints(maxHeight: 15, maxWidth: 15),
    //         child: SvgPicture.asset(
    //           this.svgPath,
    //           color: Colors.grey,
    //         ),
    //       ),
    //       Text(
    //         this.text,
    //         overflow: TextOverflow.ellipsis,
    //         maxLines: 1,
    //         style: TextStyle(
    //           color: Colors.grey,
    //           fontSize: 10,
    //         ),
    //         textAlign: TextAlign.center,
    //       ),
    //     ],
    //   ),
    // );
  }
}
