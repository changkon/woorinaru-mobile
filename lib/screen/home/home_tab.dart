import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../model/user/client_model.dart';
import '../../component/empty/generic_empty_state_card.dart';
import '../../theme/localization/app_localizations.dart';
import '../../service/term/term_service.dart';
import '../../model/term/term.dart';
import '../../model/event/event.dart';
import '../../service/event/event_service.dart';
import '../../theme/typography/title.dart' as WoorinaruTitle;
import '../../component/event/event_card.dart';
import './tab.dart' as WoorinaruTab;

class HomeTab extends StatefulWidget implements WoorinaruTab.Tab {
  _HomeTabState homeTabState;

  @override
  Future<void> onRefresh() {
    return homeTabState._loadEvents();
  }

  @override
  _HomeTabState createState() {
    homeTabState = _HomeTabState();
    return homeTabState;
  }
}

class _HomeTabState extends State<HomeTab> {
  List<Event> _upcomingEvents = [];
  List<Event> _pastEvents = [];
  bool isLoading = true;
  ClientModel clientModel;

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

    // reset
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

      List<Future<Event>> eventFutures = [];

      // term.eventIds.forEach((id) async {
      //   // add to collection
      //   Event event = await eventService.getEvent(id);
      //   if (event.startDateTime.isBefore(now)) {
      //     setState(() {
      //       _pastEvents.add(event);
      //       isLoading = false;
      //     });
      //   } else {
      //     setState(() {
      //       _upcomingEvents.add(event);
      //       isLoading = false;
      //     });
      //   }
      // });

      term.eventIds.forEach((id) {
        eventFutures.add(eventService.getEvent(id));
      });

      List<Event> events = await Future.wait(eventFutures);

      List<Event> pastEvents = [];
      List<Event> upcomingEvents = [];

      events.forEach((event) {
        if (event.startDateTime.isBefore(now)) {
          pastEvents.add(event);
        } else {
          upcomingEvents.add(event);
        }
      });

      setState(() {
        _pastEvents.addAll(pastEvents);
        _upcomingEvents.addAll(upcomingEvents);
        isLoading = false;
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
        _pastEvents.map((pastEvent) => EventCard(pastEvent, this.clientModel)).toList();
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
          child: CircularProgressIndicator(),
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
    return Consumer<ClientModel>(
      builder: (_, clientModel, __) {
        this.clientModel = clientModel;

        return Padding(
          padding: const EdgeInsets.all(WoorinaruTab.Tab.PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ..._displayWidgets(this.isLoading),
            ],
          ),
        );
      },
    );
  }
}
