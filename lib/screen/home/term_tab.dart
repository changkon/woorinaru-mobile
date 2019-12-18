import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tab.dart' as WoorinaruTab;
import '../../service/term/term_service.dart';
import '../../model/term/term.dart';

import '../../theme/localization/app_localizations.dart';
import '../../theme/typography/title.dart' as WoorinaruTitle;

import '../../component/term/term_card.dart';

class TermTab extends StatefulWidget implements WoorinaruTab.Tab {

  _TermTabState _termTabState;

  @override
  _TermTabState createState() {
    _termTabState = _TermTabState();
    return _termTabState;
  }

  @override
  Future<void> onRefresh() {
    return _termTabState._loadTerms();
  }

}

class _TermTabState extends State<TermTab> {

  List<Term> _terms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTerms();
  }

  Future<void> _loadTerms() async {
    setState(() {
      isLoading = true;
    });

    _terms = [];
    TermService termService = Provider.of<TermService>(context, listen: false);
    List<Term> terms = await termService.getAllTerms();

    setState(() {
      isLoading = false;
      _terms = terms;
    });
  }

  List<TermCard> _getTerms(List<Term> terms) {
    List<TermCard> termCards = terms.map((term) => TermCard(term)).toList();
    return termCards;
  }

  List<Widget> _displayWidgets(bool isLoading) {
    if (isLoading) {
      return [
        Center(
          child: CircularProgressIndicator(),
        ),
      ];
    } else {
      return [
        WoorinaruTitle.Title(
          AppLocalizations.of(context).trans('terms'),
        ),
        ... _getTerms(_terms),
        // ..._getUpcomingEventsWidget(_upcomingEvents),
        // WoorinaruTitle.Title(
        //   AppLocalizations.of(context).trans('past_events_title'),
        // ),
        // ..._getPastEventsWidget(_pastEvents),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ..._displayWidgets(this.isLoading),
      ],
    );
  }
}
