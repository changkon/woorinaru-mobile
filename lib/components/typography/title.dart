import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  String text;

  Title(this.text);

  double _getFontSize(BuildContext context) {
    double size = MediaQuery.of(context).size.longestSide;
    // HARD coded for now
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.text,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: _getFontSize(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
