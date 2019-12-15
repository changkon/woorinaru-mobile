import 'package:flutter/material.dart';
import '../../components/nav/nav_bar.dart';
import '../../components/appbar/woorinaru_app_bar.dart';
import '../../components/drawer/woorinaru_drawer.dart';
import './home_tab.dart';

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

    _tabDetails[0] = homeTabMap;
  }

  // Callback
  void onTabTap(int index) {
    print('$index tab tapped');
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar();
    NavBar navBar = NavBar();
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
            // child: Container(
            //   padding: EdgeInsets.all(15),
            //   child: _tabDetails[currentTab]['widget'],
            // ),
            child: _tabDetails[currentTab]['widget'],
          ),
          // child: Container(
          //   height: availableScreenHeight,
          //   width: availableWidth,
          //   padding: EdgeInsets.all(15),
          //   child: _tabDetails[currentTab]['widget'],
          // ),
          // child: SingleChildScrollView(
          //   physics: AlwaysScrollableScrollPhysics(),
          //   child: Container(
          //     height: availableScreenHeight,
          //     width: availableWidth,
          //     padding: EdgeInsets.all(15),
          //     child: _tabDetails[currentTab]['widget'],
          //   ),
          // ),
        ),
      ),
    );
  }
}
