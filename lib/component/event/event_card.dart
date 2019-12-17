import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/localization/app_localizations.dart';
import '../../model/event/event.dart';
import './event_info.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    Duration diff = this.event.endDateTime.difference(this.event.startDateTime);

    // TODO change to Table layout later
    return InkWell(
      onTap: () => print('${this.event.id} clicked!'),
      child: Container(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return CircleAvatar(
                      radius: constraints.biggest.width / 2,
                      child: FittedBox(
                        child: Text(
                          DateFormat('yy/MM/dd')
                              .format(this.event.startDateTime),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          this.event.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          this.event.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Table(
                            // defaultColumnWidth: FixedColumnWidth(50),
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  EventInfo(
                                    svgPath: 'assets/icons/bx-time.svg',
                                    text:
                                        '${diff.inMinutes} ${AppLocalizations.of(context).trans('min')}',
                                  ),
                                  EventInfo(
                                    svgPath: 'assets/icons/bx-chalkboard.svg',
                                    text:
                                        '${this.event.wooriClassIds.length}',
                                  ),
                                  EventInfo(
                                    svgPath: 'assets/icons/bx-user.svg',
                                    text:
                                        '${this.event.studentReservationIds.length}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return LayoutBuilder(builder: (context, constraints) {
    //   return InkWell(
    //     onTap: () => print('${this.event.id} clicked!'),
    //     child: Container(
    //       width: constraints.biggest.width,
    //       child: Card(
    //         child: Container(
    //           padding: EdgeInsets.all(10),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Expanded(
    //                 flex: 1,
    //                 child: LayoutBuilder(builder: (context, constraints) {
    //                   return CircleAvatar(
    //                     radius: constraints.biggest.width / 2,
    //                     child: FittedBox(
    //                       child: Text(
    //                         DateFormat('yy/MM/dd')
    //                             .format(this.event.startDateTime),
    //                         style: TextStyle(fontSize: 14),
    //                       ),
    //                     ),
    //                   );
    //                 }),
    //               ),
    //               Expanded(
    //                 flex: 4,
    //                 child: Container(
    //                   padding: EdgeInsets.only(
    //                     left: 15,
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.stretch,
    //                     children: <Widget>[
    //                       Text(
    //                         this.event.description,
    //                         overflow: TextOverflow.ellipsis,
    //                         maxLines: 1,
    //                       ),
    //                       Text(
    //                         this.event.address,
    //                         overflow: TextOverflow.ellipsis,
    //                         maxLines: 1,
    //                         style: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.grey,
    //                         ),
    //                       ),
    //                       Container(
    //                         padding: EdgeInsets.only(
    //                           top: 10,
    //                         ),
    //                         child: Column(
    //                           children: <Widget>[
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: <Widget>[
    //                                 EventInfo(
    //                                   svgPath: 'assets/icons/bx-time.svg',
    //                                   text:
    //                                       '${diff.inMinutes} ${AppLocalizations.of(context).trans('min')}',
    //                                 ),
    //                                 SizedBox(
    //                                   width: 20,
    //                                 ),
    //                                 EventInfo(
    //                                     svgPath:
    //                                         'assets/icons/bx-chalkboard.svg',
    //                                     text:
    //                                         '${this.event.wooriClassIds.length}'),
    //                                 SizedBox(
    //                                   width: 20,
    //                                 ),
    //                                 EventInfo(
    //                                     svgPath: 'assets/icons/bx-user.svg',
    //                                     text:
    //                                         '${this.event.studentReservationIds.length}'),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }
}
