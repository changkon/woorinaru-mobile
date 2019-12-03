import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/localization/app_localizations.dart';
import '../../components/appbar/woorinaru_app_bar.dart';
import '../../components/drawer/woorinaru_drawer.dart';
import '../../service/term_service.dart';
import '../../models/event/event.dart';
import '../../models/term/term.dart';

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
    int latestTermId = await termService.getLatestTermId();
    Term term = await termService.getTerm(latestTermId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WoorinaruAppBar(),
      drawer: WoorinaruDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).trans('hello')),
          ],
        ),
      ),
    );
  }
}
