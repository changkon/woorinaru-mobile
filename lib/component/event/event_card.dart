import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/user/client_model.dart';
import '../../theme/localization/app_localizations.dart';
import '../../model/event/event.dart';
import './event_info.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final ClientModel clientModel;

  EventCard(this.event, this.clientModel);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd').format(this.event.startDateTime);
    String monthYear = DateFormat('MMM yyyy').format(this.event.startDateTime);
    Duration diff = this.event.endDateTime.difference(this.event.startDateTime);

    // TODO change to Table layout later
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Join',
          color: Colors.green,
          icon: Icons.check,
          onTap: () => print('Check'),
        ),
      ],
      child: InkWell(
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
                    child: Column(
                      children: <Widget>[
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          monthYear,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    flex: 3,
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
                            style: TextStyle(
                              fontSize: 18,
                            ),
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
                              top: 20,
                            ),
                            child: Table(
                              // defaultColumnWidth: FixedColumnWidth(50),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    EventInfo(
                                      title: AppLocalizations.of(context)
                                          .trans('event_duration'),
                                      text:
                                          '${diff.inMinutes} ${AppLocalizations.of(context).trans('min')}',
                                    ),
                                    EventInfo(
                                      title: AppLocalizations.of(context)
                                          .trans('event_classes'),
                                      text:
                                          '${this.event.wooriClassIds.length}',
                                    ),
                                    EventInfo(
                                      title: AppLocalizations.of(context)
                                          .trans('event_students'),
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
      ),
    );
  }
}
