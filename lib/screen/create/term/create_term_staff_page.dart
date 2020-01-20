import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import '../../../theme/localization/app_localizations.dart';
import '../../../theme/typography/title.dart' as WoorinaruTitle;

class CreateTermStaffPage extends StatelessWidget {
  ValueNotifier valueNotifier = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          WoorinaruTitle.Title(AppLocalizations.of(context).trans('create_term_staff_title')),
          CirclePageIndicator(
            itemCount: 2,
            size: 12,
            selectedSize: 15,
            currentPageNotifier: valueNotifier,
          ),
        ],
      ),
    );
  }
}
