import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../components/localization/app_localizations.dart';
import '../../models/event/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    Duration diff = this.event.endDateTime.difference(this.event.startDateTime);

    return Container(
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
                        DateFormat('yy/MM/dd').format(this.event.startDateTime),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 15,
                                              maxWidth: 15,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/bx-time.svg',
                                              semanticsLabel: 'Duration',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${diff.inMinutes} ${AppLocalizations.of(context).trans('min')}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 15,
                                              maxWidth: 15,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/bx-chalkboard.svg',
                                              semanticsLabel: 'Classes',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${this.event.wooriClassIds.length}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 15,
                                              maxWidth: 15,
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/bx-user.svg',
                                              semanticsLabel: 'StudentReservations',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${this.event.studentReservationIds.length}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //   padding: EdgeInsets.only(
                      //     top: 10,
                      //   ),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: <Widget>[
                      //             SvgPicture.asset(
                      //               'assets/icons/bx-time.svg',
                      //               semanticsLabel: 'Duration',
                      //               color: Colors.grey,
                      //             ),
                      //             FittedBox(
                      //               child: Text(
                      //                 '${diff.inMinutes} min',
                      //                 overflow: TextOverflow.ellipsis,
                      //                 maxLines: 1,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: <Widget>[
                      //             SvgPicture.asset(
                      //               'assets/icons/bx-time.svg',
                      //               semanticsLabel: 'Duration',
                      //               color: Colors.grey,
                      //             ),
                      //             FittedBox(
                      //               child: Text('Hello'),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
