import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../model/user/user.dart';

class StaffTile extends StatelessWidget {
  User staffMember;
  Function callback;
  bool actionType;

  StaffTile({
    @required this.staffMember,
    this.callback,
    this.actionType,
  });

  Widget _getActionWidget(BuildContext context) {
    if (this.actionType) {
      return IconSlideAction(
        caption: 'Add staff',
        color: Colors.green,
        icon: Icons.check,
        onTap: () => this.callback(),
      );
    } else {
      return IconSlideAction(
        caption: 'Delete staff',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => this.callback(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = this.callback == null ? [] : [ _getActionWidget(context) ];

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: actions,
      child: ListTile(
        leading: Icon(Icons.person, size: 35),
        title: Text(this.staffMember.name),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: this.staffMember.getTeam,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              TextSpan(text: '\n'),
              TextSpan(text: this.staffMember.getStaffRole),
            ],
          ),
        ),
        isThreeLine: true,
        onTap: () => {},
      ),
    );
  }
}
