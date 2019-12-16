import 'package:flutter/material.dart';
import '../../components/nav/nav_bar.dart' as WoorinaruNavBar;
import '../../components/appbar/woorinaru_app_bar.dart';
import '../../components/drawer/woorinaru_drawer.dart';

import './home_tab.dart';
import './favourite_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  Map<int, Map> _tabDetails = {};

  @override
  void initState() {
    Map<String, dynamic> homeTabMap = {};
    HomeTab homeTab = HomeTab();
    homeTabMap['widget'] = homeTab;
    homeTabMap['refreshCallback'] = homeTab.onRefresh;

    Map<String, dynamic> favouriteTabMap = {};
    FavouriteTab favouriteTab = FavouriteTab();
    favouriteTabMap['widget'] = favouriteTab;
    favouriteTabMap['refreshCallback'] = favouriteTab.onRefresh;

    _tabDetails[0] = homeTabMap;
    _tabDetails[1] = favouriteTabMap;
  }

  // Callback
  void onTabTap(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar();
    // WoorinaruNavBar.NavBar navBar = WoorinaruNavBar.NavBar(currentTab: this.currentTab, tabTapCallback: this.onTabTap);
    var mediaQuery = MediaQuery.of(context);
    double availableScreenHeight = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    double availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: appBar,
      drawer: WoorinaruDrawer(),
      body: Center(
        child: RefreshIndicator(
          onRefresh: _tabDetails[currentTab]['refreshCallback'],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            physics: AlwaysScrollableScrollPhysics(),
            child: _tabDetails[currentTab]['widget'],
          ),
        ),
      ),
      bottomNavigationBar: WoorinaruNavBar.NavBar(
          currentTab: this.currentTab, tabTapCallback: this.onTabTap),
    );
  }
}
