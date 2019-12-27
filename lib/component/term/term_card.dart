import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';

import '../../model/term/term.dart';
import '../../route.dart' as WoorinaruRoute;

import './term_info.dart';

class TermCard extends StatelessWidget {
  final Term term;

  TermCard(this.term);

  List<Widget> _getDateWidget(String title, DateTime date) {
    return [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      Text(
        DateFormat('EE dd').format(date),
        style: TextStyle(
          fontSize: 35,
        ),
      ),
      Text(
        DateFormat('MMMM yyyy').format(date),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ];
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${AppLocalizations.of(context).trans('term_title')} ${this.term.term}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              ..._getDateWidget(
                                  AppLocalizations.of(context)
                                      .trans('term_start_date'),
                                  this.term.startDate),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              ..._getDateWidget(
                                  AppLocalizations.of(context)
                                      .trans('term_end_date'),
                                  this.term.endDate),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .trans('term_teachers'),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${this.term.staffMemberIds.length}',
                                style: TextStyle(fontSize: 35),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .trans('term_events'),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${this.term.eventIds.length}',
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              )
                            ],
                          ),
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
    );
  }
}
