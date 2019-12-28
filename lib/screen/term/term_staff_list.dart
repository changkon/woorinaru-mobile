import 'package:flutter/material.dart';
import 'package:woorinaru/model/user/user.dart';

class TermStaffList extends StatefulWidget {
  List<User> _staff;

  TermStaffList(this._staff);

  @override
  _TermStaffListState createState() => _TermStaffListState(_staff);
}

class _TermStaffListState extends State<TermStaffList> {
  List<User> _staff;

  _TermStaffListState(this._staff);

  ListTile _createStaffList(User staff) {
    return ListTile(
      leading: Icon(
        Icons.person,
        size: 35,
      ),
      title: Text(staff.name),
      subtitle: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: staff.getTeam,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: '\n'
            ),
            TextSpan(text: staff.getStaffRole),
          ],
        ),
      ),
      isThreeLine: true,
      onTap: () => {},
    );
  }

  List<Widget> _displayTiles(List<User> staff) {
    List<Widget> staffList = [];
    staff.forEach((user) {
      staffList.add(_createStaffList(user));
    });
    return staffList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[..._displayTiles(this._staff)],
    );
  }
}
