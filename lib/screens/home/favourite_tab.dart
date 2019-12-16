import 'package:flutter/material.dart';
import './tab.dart' as WoorinaruTab;

class FavouriteTab extends StatefulWidget implements WoorinaruTab.Tab {

  _FavouriteTabState _favouriteTabState;

  @override
  _FavouriteTabState createState() {
    _favouriteTabState = _FavouriteTabState();
    return _favouriteTabState;
  }

  @override
  Future<void> onRefresh() {
    return _favouriteTabState._loadFavouriteResource();
  }
}

class _FavouriteTabState extends State<FavouriteTab> {

  Future<void> _loadFavouriteResource() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Favourite'),
      ],
    );
  }
}
