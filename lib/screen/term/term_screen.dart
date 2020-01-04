import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../component/tile/staff_tile.dart';

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

    for (int i = 0; i < updatedTerm.eventIds.length; i++) {
      // add to collection
      Event event = await eventService.getEvent(updatedTerm.eventIds[i]);
      events.add(event);
    }

    List<User> staffMembers = [];

    for (int i = 0; i < updatedTerm.staffMemberIds.length; i++) {
      // add to collection
      User staffMember = await staffService.getStaff(updatedTerm.staffMemberIds[i]);
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

  void _addStaffCallback(User selectedStaffMember) async {
    // Adding staff
    TermService termService =
        Provider.of<TermService>(context, listen: false);
    // 1. Add to list and update state.
    setState(() {
      _term.staffMemberIds.add(selectedStaffMember.id);
      _staffMembers.add(selectedStaffMember);
    });
    // 2. Add to term API call
    await termService.modifyTerm(_term);
    Navigator.of(context).pop();
  }

  void _removeStaffCallback(User selectedStaffMember) async {
    // Adding staff
      TermService termService =
          Provider.of<TermService>(context, listen: false);
      // 1. Add to list and update state.
      setState(() {
        _term.staffMemberIds.remove(selectedStaffMember.id);
        _staffMembers.remove(selectedStaffMember);
      });
      // 2. Add to term API call
      await termService.modifyTerm(_term);
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
        return StaffTile(staffMember: selectableStaffMembers[index], callback: () async => _addStaffCallback(selectableStaffMembers[index]), actionType: true);
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

  Widget _getTermDescription(String icon, String title, String subtitle) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/$icon', width: 35, height: 35),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  List<Widget> _displayTermDescription(Client client) {
    return [
      WoorinaruTitle.Title(
        AppLocalizations.of(context).trans('term_description'),
      ),
      _getTermDescription(
          'bx-rocket.svg',
          AppLocalizations.of(context).trans('term_title'),
          '${this._term.term}'),
      _getTermDescription(
          'bx-calendar.svg',
          AppLocalizations.of(context).trans('term_start_date'),
          '${DateFormat('EE dd MMM yyyy').format(this._term.startDate)}'),
      _getTermDescription(
          'bx-calendar.svg',
          AppLocalizations.of(context).trans('term_end_date'),
          '${DateFormat('EE dd MMM yyyy').format(this._term.endDate)}'),
      _getTermDescription(
          'bxs-user-circle.svg',
          AppLocalizations.of(context).trans('term_teachers'),
          '${this._term.staffMemberIds.length}'),
      _getTermDescription(
          'bxs-bookmark.svg',
          AppLocalizations.of(context).trans('term_events'),
          '${this._term.eventIds.length}'),
    ];
  }

  List<Widget> _displayTermStaffMembers(Client client) {
    List<Widget> staffWidget = [];

    if (_staffMembers.length == 0) {
      staffWidget.add(
        Text(AppLocalizations.of(context).trans('term_staff_empty'),
            style: Theme.of(context).textTheme.headline),
      );
    } else {
      bool addActionButton = client == null ? false : client.userType == UserType.ADMIN || (client.userType == UserType.STAFF && client.staffRole == StaffRole.LEADER);
      List<StaffTile> staffTiles = [];
      if (addActionButton) {
        staffTiles = this._staffMembers.map((staffMember) => StaffTile(staffMember: staffMember, callback: () async => _removeStaffCallback(staffMember), actionType: false)).toList();
      } else {
        staffTiles = this._staffMembers.map((staffMember) => StaffTile(staffMember: staffMember)).toList();
      }
      Column staffList = Column(
        children: <Widget>[
          ... staffTiles,
        ],
      );
      staffWidget.add(staffList);
      // staffWidget.add([]);
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
