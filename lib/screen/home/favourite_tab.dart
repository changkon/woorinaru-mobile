import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/empty/generic_empty_state_card.dart';
import '../../model/user/client_model.dart';
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
  ClientModel clientModel;

  @override
  void initState() {
    super.initState();
    _loadFavouriteResources();
  }

  Future<void> _loadFavouriteResources() async {
    if (clientModel == null) {
      setState(() {
        isLoading = false;
        _favouriteResources = [];
      });
    }
    
    // TODO get resources from user

    return null;
  }

  Widget _getEmptyResourcesWidget() {
    return GenericEmptyStateCard(
      title: AppLocalizations.of(context).trans('favourite_resources'),
      description: AppLocalizations.of(context).trans('favourite_resources_empty'),
      assetName: "assets/icons/bxs-file-find.svg",
      color: Colors.black87,
    );
  }

  List<Widget> _displayWidgets(bool isLoading) {
    if (isLoading) {
      return [
        Center(
          child: new CircularProgressIndicator(),
        ),
      ];
    } else {
      Widget resourceWidget = null;

      if (_favouriteResources.length == 0) {
        resourceWidget = _getEmptyResourcesWidget();
      } else {
        // TODO list view
      }

      return [
        WoorinaruTitle.Title(
          AppLocalizations.of(context).trans('favourite_resources'),
        ),
        resourceWidget,
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientModel>(
      builder: (_, clientModel, __) {
        this.clientModel = clientModel;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ..._displayWidgets(this.isLoading),
          ],
        );
      },
    );
  }
}
