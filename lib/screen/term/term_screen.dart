import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/user/user.dart';

import '../../service/term/term_service.dart';
import '../../service/event/event_service.dart';
import '../../service/user/staff_service.dart';
import '../../component/appbar/woorinaru_app_bar.dart';
import '../../theme/localization/app_localizations.dart';

import '../../model/term/term.dart';
import '../../model/event/event.dart';
import '../../model/user/user.dart';
import '../../model/user/client_model.dart';
import '../../model/user/client.dart';
import '../../component/event/event_card.dart';
import '../../theme/typography/title.dart' as WoorinaruTitle;

import '../../component/term/term_info.dart';

class TermScreen extends StatefulWidget {
  final Term term;

  TermScreen(this.term);

  @override
  _TermScreenState createState() => _TermScreenState(term);
}

class _TermScreenState extends State<TermScreen> {
  Term _term;
  Term _editableTerm;
  List<Event> _events;
  List<User> _staffMembers;
  bool _isLoading = false;

  _TermScreenState(this._term) {
    _editableTerm = _term;
  }

  @override
  void initState() {
    super.initState();
    // Extract arguments
    // final Map<String, dynamic> routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    // setState(() {
    //   term = routeArgs['term'] as Term;
    // });
    _initTerm();
  }

  Future<void> _initTerm() async {
    setState(() {
      _isLoading = true;
    });

    TermService termService = Provider.of<TermService>(context, listen: false);
    EventService eventService =
        Provider.of<EventService>(context, listen: false);
    StaffService staffService = Provider.of<StaffService>(context, listen: false);

    // Get term
    final Term updatedTerm = await termService.getTerm(this._term.id);

    // Get events
    List<Event> events = [];

    for (int i = 0; i < _term.eventIds.length; i++) {
      // add to collection
      Event event = await eventService.getEvent(_term.eventIds[i]);
      events.add(event);
    }

    // TODO get staff members
    List<User> staffMembers = [];

      for (int i = 0; i < _term.staffMemberIds.length; i++) {
      // add to collection
      User staffMember = await staffService.getStaff(_term.staffMemberIds[i]);
      staffMembers.add(staffMember);
    }

    setState(() {
      _term = updatedTerm;
      _editableTerm = updatedTerm;
      _events = events;
      _staffMembers = staffMembers;
      _isLoading = false;
    });
  }

  Widget _displayBanner(Client client) {
    bool editableBanner = false;

    if (client == null) {
      editableBanner = false;
    } else if (client.userType == UserType.ADMIN ||
        (client.userType == UserType.STAFF &&
            client.staffRole == StaffRole.LEADER)) {
      editableBanner = true;
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);
    // double availableScreenHeight = (mediaQuery.size.height -
    //     appBar.preferredSize.height -
    //     mediaQuery.padding.top);

    return Container(
      height: mediaQuery.size.height * 0.35,
      color: Colors.orangeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.biggest.width * 0.6,
              child: FittedBox(
                // TODO add editable
                child: Text(
                  '${AppLocalizations.of(context).trans('term_title')} ${this._term.term}',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _displayTermDescription(Client client) {
    return [
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('term_description'),
      ),
      TermInfo(
        svgPath: 'assets/icons/bx-calendar.svg',
        title: AppLocalizations.of(context).trans('term_start_date'),
        text: '${DateFormat('yy/MM/dd').format(this._term.startDate)}'
      ),
      TermInfo(
        svgPath: 'assets/icons/bx-calendar.svg',
        title: AppLocalizations.of(context).trans('term_end_date'),
        text: '${DateFormat('yy/MM/dd').format(this._term.endDate)}'
      ),
      TermInfo(
        svgPath: 'assets/icons/bxs-group.svg',
        title: AppLocalizations.of(context).trans('term_teachers'),
        text: '${this._term.staffMemberIds.length}'
      ),
      TermInfo(
        svgPath: 'assets/icons/bxs-bookmark.svg',
        title:
            AppLocalizations.of(context).trans('term_events'),
        text: '${this._term.eventIds.length}',
      ),
    ];
  }

  List<Widget> _displayTermStaffMembers(Client client) {
    return [
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('term_staff_members'),
      ),
    ];
  }

  List<Widget> _displayEvents() {
    List<Widget> eventWidgets =
        _events.map((event) => EventCard(event)).toList();

    return [
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('events'),
      ),
      ...eventWidgets,
    ];
  }

  List<Widget> _displayTermSaveButton(Client client) {
    return [];
  }

  List<Widget> _displayWidgets(bool _isLoading, Client client) {
    if (_isLoading) {
      return [
        Center(
          child: CircularProgressIndicator(),
        ),
      ];
    } else {
      return [
        _displayBanner(client),
        Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ..._displayTermDescription(client),
              ..._displayTermStaffMembers(client),
              ..._displayEvents(),
              ..._displayTermSaveButton(client),
            ],
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar(
        text:
            "${AppLocalizations.of(context).trans('term_title')} ${_term.term}");

    var mediaQuery = MediaQuery.of(context);
    double availableScreenHeight = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    double availableScreenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: availableScreenHeight,
        width: availableScreenWidth,
        child: RefreshIndicator(
          onRefresh: _initTerm,
          child: SingleChildScrollView(
            // padding: const EdgeInsets.all(15),
            physics: AlwaysScrollableScrollPhysics(),
            child: Consumer<ClientModel>(
              builder: (_, clientModel, __) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ..._displayWidgets(
                      this._isLoading, clientModel.loggedInClient),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
