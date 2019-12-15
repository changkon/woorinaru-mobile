import 'package:flutter/material.dart';
import '../../models/event/event.dart';

import 'package:provider/provider.dart';
import '../../components/empty/generic_empty_state_card.dart';
import '../../components/localization/app_localizations.dart';
import '../../service/term_service.dart';
import '../../models/term/term.dart';
import '../../service/event_service.dart';
import '../../components/typography/title.dart' as WoorinaruTitle;
import '../../components/event/event_card.dart';
import './woorinaru_tab.dart';

class HomeTab extends StatefulWidget implements WoorinaruTab {
  _HomeTabState homeTabState = _HomeTabState();

  @override
  Future<void> onRefresh() {
    return homeTabState._loadEvents();
  }

  @override
  _HomeTabState createState() => homeTabState;
}

class _HomeTabState extends State<HomeTab> {
  List<Event> _upcomingEvents = [];
  List<Event> _pastEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initEvents();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _initEvents() async {
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      isLoading = true;
    });

    _upcomingEvents = [];
    _pastEvents = [];
    // initialise
    TermService termService = Provider.of<TermService>(context, listen: false);
    EventService eventService =
        Provider.of<EventService>(context, listen: false);
    int latestTermId = await termService.getLatestTermId();

    if (latestTermId != -1) {
      Term term = await termService.getTerm(latestTermId);
      // Get current date
      DateTime now = DateTime.now();

      term.eventIds.forEach((id) async {
        // add to collection
        Event event = await eventService.getEvent(id);
        if (event.startDateTime.isBefore(now)) {
          setState(() {
            _pastEvents.add(event);
            isLoading = false;
          });
        } else {
          setState(() {
            _upcomingEvents.add(event);
            isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _getEmptyUpcomingEventsWidget() {
    return GenericEmptyStateCard(
      title: AppLocalizations.of(context).trans('upcoming_events_title'),
      description: AppLocalizations.of(context).trans('upcoming_events_empty'),
      assetName: "assets/icons/bx-calendar-x.svg",
      color: Colors.amberAccent,
    );
  }

  List<Widget> _getUpcomingEventsListWidget(List<Event> upcomingEvents) {
    List<Widget> upcomingEvents = [];
    return upcomingEvents;

    // return ListView.builder(
    //     padding: const EdgeInsets.all(8),
    //     itemCount: upcomingEvents.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         height: 50,
    //         child: Center(
    //             child: Text('Entry ${upcomingEvents[index].description}')),
    //       );
    //     });
  }

  List<Widget> _getUpcomingEventsWidget(List<Event> upcomingEvents) {
    if (upcomingEvents == null || upcomingEvents.isEmpty) {
      List<Widget> emptyWidget = [];
      emptyWidget.add(_getEmptyUpcomingEventsWidget());
      return emptyWidget;
    } else {
      return _getUpcomingEventsListWidget(upcomingEvents);
    }
  }

  Widget _getEmptyPastEventsWidget() {
    return GenericEmptyStateCard(
      title: AppLocalizations.of(context).trans('past_events_title'),
      description: AppLocalizations.of(context).trans('past_events_empty'),
      assetName: "assets/icons/bx-history.svg",
    );
  }

  List<Widget> _getPastEventsListWidget(List<Event> pastEvents) {
    List<Widget> pastEventWidgets =
        _pastEvents.map((pastEvent) => EventCard(pastEvent)).toList();
    return pastEventWidgets;
  }

  List<Widget> _getPastEventsWidget(List<Event> pastEvents) {
    if (pastEvents == null || pastEvents.isEmpty) {
      List<Widget> emptyWidget = [];
      emptyWidget.add(_getEmptyPastEventsWidget());
      return emptyWidget;
    } else {
      return _getPastEventsListWidget(pastEvents);
    }
  }

  List<Widget> _displayWidgets(bool isLoading) {
    if (isLoading) {
      return [
        Center(
          child: new CircularProgressIndicator(),
        ),
      ];
    } else {
      return [
        WoorinaruTitle.Title(
          AppLocalizations.of(context).trans('upcoming_events_title'),
        ),
        ..._getUpcomingEventsWidget(_upcomingEvents),
        WoorinaruTitle.Title(
          AppLocalizations.of(context).trans('past_events_title'),
        ),
        ..._getPastEventsWidget(_pastEvents),
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
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     return Container(
    //       // width: constraints.biggest.width,
    //       // height: constraints.biggest.height,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           ..._displayWidgets(this.isLoading),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
