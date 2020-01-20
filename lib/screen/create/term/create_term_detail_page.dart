import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:provider/provider.dart';
import '../../../theme/localization/app_localizations.dart';
import '../../../theme/typography/title.dart' as WoorinaruTitle;
import '../../../service/user/staff_service.dart';
import '../../../model/user/user.dart';
import '../../../component/tile/staff_tile.dart';

class CreateTermDetailPage extends StatefulWidget {
  @override
  _CreateTermDetailPageState createState() => _CreateTermDetailPageState();
}

class _CreateTermDetailPageState extends State<CreateTermDetailPage> {
  ValueNotifier _valueNotifier = ValueNotifier<int>(0);
  DateTime _startDate;
  DateTime _endDate;
  List<User> _staffMembers = [];

  @override
  initState() {
    super.initState();
    DateTime now = DateTime.now().add(Duration(days: 1));
    _startDate = now;
    _endDate = now;
  }

  void _addStaffCallback(User selectedStaffMember) async {
    // Adding staff
    // Add to existing list and close popup
    setState(() {
      _staffMembers.add(selectedStaffMember);
    });
    Navigator.of(context).pop();
  }

  void _removeStaffCallback(User selectedStaffMember) {
    setState(() {
      _staffMembers.remove(selectedStaffMember);
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
        return StaffTile(
            staffMember: selectableStaffMembers[index],
            callback: () async =>
                _addStaffCallback(selectableStaffMembers[index]),
            actionType: true);
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

  _formatDate(DateTime date) {
    return DateFormat("EEEE dd MMMM yyyy").format(date);
  }

  static bool _defaultFunc() {
    return true;
  }

  Widget _dateRow(String text, Function callback,
      {Function validator = _defaultFunc}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Text(
        //   text,
        //   style: TextStyle(
        //     color: Colors.black87,
        //   ),
        // ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextSpan(text: validator() ? "" : "\n"),
              TextSpan(
                text: validator()
                    ? ""
                    : AppLocalizations.of(context)
                        .trans("create_term_detail_dates_error"),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        ClipOval(
          child: Material(
            child: InkWell(
              child: SizedBox(
                  width: 56, height: 56, child: Icon(Icons.date_range)),
              onTap: callback,
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> _selectDate(
      BuildContext context, DateTime initialDate, Function callback) async {
    DateTime now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.isBefore(now) ? initialDate : now,
      lastDate: now.add(Duration(minutes: 525600)), // one year
    );
    if (picked != null) {
      callback(picked);
    }
  }

  List<Widget> _showStaffTiles() {
    if (_staffMembers.length == 0) {
      return [
        Text("No staff"),
      ];
    } else {
      List<StaffTile> staffTiles = [];
      staffTiles = this
          ._staffMembers
          .map((staffMember) => StaffTile(
              staffMember: staffMember,
              callback: () async => _removeStaffCallback(staffMember),
              actionType: false))
          .toList();
      return staffTiles;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          WoorinaruTitle.Title(
            AppLocalizations.of(context).trans('create_term_detail_title'),
          ),
          Text(AppLocalizations.of(context).trans('create_term_detail_dates'),
              style: Theme.of(context).textTheme.headline),
          _dateRow(
            _formatDate(_startDate),
            () => _selectDate(
              context,
              _startDate,
              (picked) => setState(() => _startDate = picked),
            ),
          ),
          _dateRow(
            _formatDate(_endDate),
            () => _selectDate(
              context,
              _endDate,
              (picked) => setState(() => _endDate = picked),
            ),
            validator: () => _endDate.isAfter(_startDate),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).trans('create_term_detail_staff'),
                style: Theme.of(context).textTheme.headline,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showStaffAddDropdown(context),
              ),
            ],
          ),
          // TODO add staff tiles
          Column(
            children: <Widget>[..._showStaffTiles()],
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            onPressed: () => {},
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
