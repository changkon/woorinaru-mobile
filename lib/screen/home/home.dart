import 'package:flutter/material.dart';

import '../../theme/localization/app_localizations.dart';
import '../../component/nav/woorinaru_nav_bar.dart';
import '../../component/appbar/woorinaru_app_bar.dart';
import '../../component/drawer/woorinaru_drawer.dart';

import './home_tab.dart';
import './favourite_tab.dart';
import './term_tab.dart';
import './user_management_tab.dart';
import './tabs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentTab = Tabs.HOME_TAB;
  Map<String, Map> _tabDetails = {};

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> homeTabMap = {};
    HomeTab homeTab = HomeTab();
    homeTabMap['widget'] = homeTab;
    homeTabMap['refreshCallback'] = homeTab.onRefresh;

    Map<String, dynamic> favouriteTabMap = {};
    FavouriteTab favouriteTab = FavouriteTab();
    favouriteTabMap['widget'] = favouriteTab;
    favouriteTabMap['refreshCallback'] = favouriteTab.onRefresh;

    Map<String, dynamic> termTabMap = {};
    TermTab termTab = TermTab();
    termTabMap['widget'] = termTab;
    termTabMap['refreshCallback'] = termTab.onRefresh;

    Map<String, dynamic> userManagementTabMap = {};
    UserManagementTab userManagementTab = UserManagementTab();
    userManagementTabMap['widget'] = userManagementTab;
    userManagementTabMap['refreshCallback'] = userManagementTab.onRefresh;

    _tabDetails[Tabs.HOME_TAB] = homeTabMap;
    _tabDetails[Tabs.FAVOURITE_TAB] = favouriteTabMap;
    _tabDetails[Tabs.TERM_TAB] = termTabMap;
    _tabDetails[Tabs.USER_MANAGEMENT_TAB] = userManagementTabMap;
  }

  // Callback
  void onTabTap(String tab) {
    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar =
        WoorinaruAppBar(text: AppLocalizations.of(context).trans('woorinaru'));
    // WoorinaruNavBar.NavBar navBar = WoorinaruNavBar.NavBar(currentTab: this.currentTab, tabTapCallback: this.onTabTap);
    var mediaQuery = MediaQuery.of(context);
    double availableScreenHeight = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top) - WoorinaruNavBar.HEIGHT;
    double availableScreenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: appBar,
      drawer: WoorinaruDrawer(),
      body: Container(
        height: availableScreenHeight,
        width: availableScreenWidth,
        child: RefreshIndicator(
          onRefresh: _tabDetails[currentTab]['refreshCallback'],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            physics: AlwaysScrollableScrollPhysics(),
            child: _tabDetails[currentTab]['widget'],
          ),
        ),
      ),
      bottomNavigationBar: WoorinaruNavBar(
        currentTab: this.currentTab,
        tabTapCallback: this.onTabTap,
      ),
    );
  }
}
