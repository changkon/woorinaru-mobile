import 'package:flutter/material.dart';
import './tab.dart' as WoorinaruTab;

class TermTab extends StatefulWidget implements WoorinaruTab.Tab {

  _TermTabState _termTabState;

  @override
  _TermTabState createState() {
    _termTabState = _TermTabState();
    return _termTabState;
  }

  @override
  Future<void> onRefresh() {
    return _termTabState._loadTerms();
  }

}

class _TermTabState extends State<TermTab> {

  Future<void> _loadTerms() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Terms'),
      ],
    );
  }
}
