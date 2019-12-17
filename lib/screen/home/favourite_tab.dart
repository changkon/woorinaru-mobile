import 'package:flutter/material.dart';
import '../../theme/localization/app_localizations.dart';
import '../../theme/typography/title.dart' as WoorinaruTitle;
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
    return _favouriteTabState._loadFavouriteResources();
  }
}

class _FavouriteTabState extends State<FavouriteTab> {
  List _favouriteResources = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavouriteResources();
  }

  Future<void> _loadFavouriteResources() async {
    setState(() {
      isLoading = true;
    });

    _favouriteResources = [];

    setState(() {
      isLoading = false;
    });

    return null;
  }

  List<Widget> _displayWidgets(bool isLoading) {
    if (isLoading) {
      return [
        Center(
          child: new CircularProgressIndicator(),
        ),
      ];
    } else {
      return [
        WoorinaruTitle.Title(
          AppLocalizations.of(context).trans('favourite_resources'),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ..._displayWidgets(this.isLoading),
      ],
    );
  }
}
