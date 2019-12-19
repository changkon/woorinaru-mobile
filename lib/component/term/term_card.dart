import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';

import '../../model/term/term.dart';
import '../../route.dart' as WoorinaruRoute;

import './term_info.dart';

class TermCard extends StatelessWidget {
  final Term term;

  TermCard(this.term);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => print('${this.term.id} clicked!'),
      onTap: () => Navigator.of(context).pushNamed(
        WoorinaruRoute.Route.TERM,
        arguments: {'term': this.term},
      ),
      child: Container(
        child: Card(
          color: Colors.amberAccent,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      '${AppLocalizations.of(context).trans('term_title')} ${this.term.term}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TermInfo(
                        svgPath: 'assets/icons/bx-calendar.svg',
                        title: AppLocalizations.of(context)
                            .trans('term_start_date'),
                        text:
                            DateFormat('yy/MM/dd').format(this.term.startDate),
                      ),
                      TermInfo(
                        svgPath: 'assets/icons/bx-calendar.svg',
                        title:
                            AppLocalizations.of(context).trans('term_end_date'),
                        text: DateFormat('yy/MM/dd').format(this.term.endDate),
                      ),
                      TermInfo(
                        svgPath: 'assets/icons/bxs-group.svg',
                        title:
                            AppLocalizations.of(context).trans('term_teachers'),
                        text: '${this.term.staffMemberIds.length}',
                      ),
                      TermInfo(
                        svgPath: 'assets/icons/bxs-bookmark.svg',
                        title:
                            AppLocalizations.of(context).trans('term_events'),
                        text: '${this.term.eventIds.length}',
                      ),
                      // Text('Hello'),
                      // Text('Hello'),
                      // Text('Hello'),
                      // Text('Hello'),
                      // Text('Hello'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Text(
          //       '${AppLocalizations.of(context).trans('term_title')} ${this.term.term}',
          //       style: TextStyle(
          //         fontSize: 18,
          //         color: Theme.of(context).primaryColorDark,
          //       ),
          //     ),

          //   ],
          // ),
        ),
      ),
    );
  }
}
