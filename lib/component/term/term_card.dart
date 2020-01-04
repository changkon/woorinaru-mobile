import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';

import '../../model/term/term.dart';
import '../../route.dart' as WoorinaruRoute;

import '../icon/circular_icon.dart';
import '../count/circular_count_view.dart';
import '../icon/staff_circular_icon.dart';
import '../icon/event_circular_icon.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                Text(
                  '${AppLocalizations.of(context).trans('term_title')} ${this.term.term}',
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  '${_getFormattedDate(this.term.startDate)} - ${_getFormattedDate(this.term.endDate)}',
                  style: TextStyle(fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: <Widget>[
                      _displayEvents(this.term.eventIds),
                      _displayStaffMembers(this.term.staffMemberIds),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
