import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/model/user/user.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';

import '../../model/term/term.dart';
import '../../route.dart' as WoorinaruRoute;

import '../icon/circular_icon.dart';
import '../count/circular_count_view.dart';
import '../icon/staff_circular_icon.dart';
import '../icon/event_circular_icon.dart';
import '../../model/user/client_model.dart';
import '../../model/user/client.dart';

class TermCard extends StatelessWidget {
  final Term term;

  TermCard(this.term);

  String _getFormattedDate(DateTime date) {
    // return "Some date";
    return DateFormat("EE dd MMM yyyy").format(date);
  }

  Widget _displayStaffMembers(List<int> staffMemberIds) {
    if (staffMemberIds == null || staffMemberIds.isEmpty) {
      return CircularCountView([], StaffCircularIcon());
    } else {
      List<StaffCircularIcon> circularIcons =
          staffMemberIds.map((staff) => StaffCircularIcon()).toList();

      return CircularCountView(circularIcons, StaffCircularIcon());
    }
  }

  Widget _displayEvents(List<int> eventIds) {
    if (eventIds == null || eventIds.isEmpty) {
      return CircularCountView([], EventCircularIcon());
    } else {
      List<EventCircularIcon> circularIcons =
          eventIds.map((event) => EventCircularIcon()).toList();

      return CircularCountView(circularIcons, EventCircularIcon());
    }
  }

  Widget _displayStaffAttendance(BuildContext context, Client loggedInClient) {
    if (loggedInClient == null || loggedInClient.userType != UserType.STAFF) {
      return SizedBox.shrink();
    } else if (loggedInClient.userType == UserType.STAFF) {
      return Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.green,
        child: Text(AppLocalizations.of(context).trans('term_staff_attendance'), style: TextStyle(color: Colors.white70)),
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientModel>(
      builder: (_, clientModel, __) => InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          WoorinaruRoute.Route.TERM,
          arguments: {'term': this.term},
        ),
        child: Container(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // TODO add attending or not for staff members
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${AppLocalizations.of(context).trans('term_title')} ${this.term.term}',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      _displayStaffAttendance(context, clientModel.loggedInClient),
                    ],
                  ),
                  Text(
                    '${_getFormattedDate(this.term.startDate)} - ${_getFormattedDate(this.term.endDate)}',
                    style: TextStyle(fontSize: 13),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1, child: _displayEvents(this.term.eventIds)),
                        Expanded(
                            flex: 1,
                            child:
                                _displayStaffMembers(this.term.staffMemberIds)),
                        Spacer(flex: 3),
                      ],
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
