import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/localization/app_localizations.dart';
import '../../../component/appbar/woorinaru_app_bar.dart';
import './create_term_detail_page.dart';
import './create_term_staff_page.dart';
import '../../../util/debounce/debouncer.dart';

class CreateTermScreen extends StatefulWidget {
  @override
  _CreateTermScreenState createState() => _CreateTermScreenState();
}

class _CreateTermScreenState extends State<CreateTermScreen> {
  int _currentPageIndex = 0;
  List<Widget> _pages = [];
  Debouncer _swipeDebouncer = Debouncer(milliseconds: 100);

  @override
  initState() {
    super.initState();
    CreateTermDetailPage createTermDetailPage = CreateTermDetailPage();
    // CreateTermStaffPage createTermStaffPage = CreateTermStaffPage();

    _pages.add(createTermDetailPage);
    // _pages.add(createTermStaffPage);
  }

  _onSwipeUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // go left
      int updateIndex = max(_currentPageIndex - 1, 0);
      _swipeDebouncer.run(() {
        setState(() {
          _currentPageIndex = updateIndex;
        });
      });
    } else {
      // go right
      int updateIndex = min(_currentPageIndex + 1, (_pages.length - 1));
      _swipeDebouncer.run(() {
        setState(() {
          _currentPageIndex = updateIndex;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WoorinaruAppBar appBar = WoorinaruAppBar(
        text: "${AppLocalizations.of(context).trans('create_term_subtitle')}");

    return Scaffold(
        appBar: appBar,
        body: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanUpdate: _onSwipeUpdate,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight, minWidth: viewportConstraints.maxWidth),
                  child: _pages[_currentPageIndex],
                ),
              ),
            );
          },
        )
        );
  }
}
