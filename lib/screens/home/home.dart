import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/localization/app_localizations.dart';
import '../../components/appbar/woorinaru_app_bar.dart';
import '../../components/drawer/woorinaru_drawer.dart';
import '../../service/term_service.dart';
import '../../models/event/event.dart';
import '../../models/term/term.dart';
import '../../service/event_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Event> _upcomingEvents;
  List<Event> _pastEvents;

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
          });
        } else {
          setState(() {
            _upcomingEvents.add(event);
          });
        }
      });
    }
  }

  Widget _getEmptyUpcomingEventsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).trans('upcoming_events_title'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          Icons.event_busy,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .trans('upcoming_events_empty'),
                      style: TextStyle(
                        fontSize: 20,
                      ),
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

  Widget _getUpcomingEventsListWidget(List<Event> upcomingEvents) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: upcomingEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Center(
                child: Text('Entry ${upcomingEvents[index].description}')),
          );
        });
  }

  Widget _getUpcomingEventsWidget(List<Event> upcomingEvents) {
    if (upcomingEvents == null || upcomingEvents.isEmpty) {
      return _getEmptyUpcomingEventsWidget();
    } else {
      return _getUpcomingEventsListWidget(upcomingEvents);
    }
  }

  Widget _getEmptyPastEventsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).trans('past_events_title'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                AppLocalizations.of(context).trans('past_events_empty'),
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPastEventsListWidget(List<Event> pastEvents) {
    return null;
  }

  Widget _getPastEventsWidget(List<Event> pastEvents) {
    if (pastEvents == null || pastEvents.isEmpty) {
      return _getEmptyPastEventsWidget();
    } else {
      return _getPastEventsListWidget(pastEvents);
    }
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar();
    double availableScreenHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      drawer: WoorinaruDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            children: <Widget>[
              _getUpcomingEventsWidget(_upcomingEvents),
              _getPastEventsWidget(_pastEvents),
            ],
          ),
        );
      }),
    );
  }
}
