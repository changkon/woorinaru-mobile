import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/component/empty/generic_empty_state_card.dart';
import 'package:woorinaru/screen/term/term_staff_list.dart';
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
  ClientModel clientModel;

  _TermScreenState(this._term) {
    _editableTerm = _term;
  }

  @override
  void initState() {
    super.initState();
    _initTerm();
  }

  Future<void> _initTerm() async {
    setState(() {
      _isLoading = true;
    });

    TermService termService = Provider.of<TermService>(context, listen: false);
    EventService eventService =
        Provider.of<EventService>(context, listen: false);
    StaffService staffService =
        Provider.of<StaffService>(context, listen: false);

    // Get term
    final Term updatedTerm = await termService.getTerm(this._term.id);

    // Get events
    List<Event> events = [];

    for (int i = 0; i < _term.eventIds.length; i++) {
      // add to collection
      Event event = await eventService.getEvent(_term.eventIds[i]);
      events.add(event);
    }

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

  void _showStaffAddDropdown(BuildContext context) async {
    StaffService staffService =
        Provider.of<StaffService>(context, listen: false);

    List<User> selectableStaffMembers = await staffService.getStaffList();

    // Go through term staff and subtract
    _staffMembers.forEach((staff) {
      int id = staff.id;
      selectableStaffMembers.removeWhere((staff) => staff.id == id);
    });

    Widget modalWidget = ListView.builder(
      itemCount: selectableStaffMembers.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Add staff',
              color: Colors.green,
              icon: Icons.check,
              onTap: () async {
                // Adding staff
                // 1. Add to term API call
                // 2. Add to list and update state.
                // TermService termService = Provider.of<TermService>(context, listen: false);
                // final Term updatedTerm = await termService.getTerm(this._term.id);
                // updatedTerm.staffMemberIds.add()
              },
            ),
          ],
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 35,
            ),
            title: Text(selectableStaffMembers.elementAt(index).name),
            subtitle: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: selectableStaffMembers.elementAt(index).getTeam,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                      text:
                          selectableStaffMembers.elementAt(index).getStaffRole),
                ],
              ),
            ),
            isThreeLine: true,
            onTap: () => {},
          ),
        );
      },
    );

    if (selectableStaffMembers.length == 0) {
      modalWidget = ListTile(
        title: Text('There are no staff members to add'),
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return modalWidget;
      },
    );
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
          text: '${DateFormat('yy/MM/dd').format(this._term.startDate)}'),
      TermInfo(
          svgPath: 'assets/icons/bx-calendar.svg',
          title: AppLocalizations.of(context).trans('term_end_date'),
          text: '${DateFormat('yy/MM/dd').format(this._term.endDate)}'),
      TermInfo(
          svgPath: 'assets/icons/bxs-group.svg',
          title: AppLocalizations.of(context).trans('term_teachers'),
          text: '${this._term.staffMemberIds.length}'),
      TermInfo(
        svgPath: 'assets/icons/bxs-bookmark.svg',
        title: AppLocalizations.of(context).trans('term_events'),
        text: '${this._term.eventIds.length}',
      ),
    ];
  }

  List<Widget> _displayTermStaffMembers(Client client) {
    List<Widget> staffWidget = [];

    if (_staffMembers.length == 0) {
      staffWidget.add(Text('There are no staff'));
    } else {
      TermStaffList staffList = TermStaffList(_staffMembers);
      staffWidget.add(staffList);
    }

    List<Widget> titleWidgets = [];
    titleWidgets.add(
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('term_staff_members'),
      ),
    );
    bool addButton = client == null
        ? false
        : client.userType == UserType.ADMIN ||
            (client.userType == UserType.STAFF &&
                client.staffRole == StaffRole.LEADER);
    if (addButton) {
      titleWidgets.add(
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showStaffAddDropdown(context),
        ),
      );
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[...titleWidgets],
      ),
      ...staffWidget,
    ];
  }

  List<Widget> _displayEvents(Client client) {
    List<Widget> eventWidgets =
        _events.map((event) => EventCard(event, this.clientModel)).toList();

    if (eventWidgets.length == 0) {
      // add generic empty state
      eventWidgets.add(
        GenericEmptyStateCard(
          title: AppLocalizations.of(context).trans('past_events_title'),
          description: AppLocalizations.of(context).trans('past_events_empty'),
          assetName: "assets/icons/bx-history.svg",
        ),
      );
    }

    List<Widget> titleWidgets = [];
    titleWidgets.add(
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('term_events'),
      ),
    );

    bool addButton = client == null
        ? false
        : client.userType == UserType.ADMIN ||
            client.userType == UserType.STAFF;
    if (addButton) {
      titleWidgets.add(
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {},
        ),
      );
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[...titleWidgets],
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
              ..._displayEvents(client),
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
              builder: (_, clientModel, __) {
                this.clientModel = clientModel;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ..._displayWidgets(
                        this._isLoading, clientModel.loggedInClient),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
