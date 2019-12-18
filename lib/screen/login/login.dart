import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../component/appbar/woorinaru_app_bar.dart';
import '../../theme/localization/app_localizations.dart';

class Login extends StatelessWidget {
  @override
Widget build(BuildContext context) {
    WoorinaruAppBar appBar =
        WoorinaruAppBar(text: AppLocalizations.of(context).trans('login'));

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double availableScreenHeight = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    double availableScreenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: availableScreenHeight,
        width: availableScreenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              // Colors.redAccent.shade400,
              // Colors.redAccent.shade200,
              Colors.white10,
              Colors.redAccent.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text(
            //   AppLocalizations.of(context).trans('woorinaru'),
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 35,
            //     color: Colors.white,
            //   ),
            // ),
            Image(image: AssetImage('assets/images/logo.png')),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton.icon(
                    color: Colors.blueAccent,
                    elevation: 10,
                    onPressed: () => print('Pressed'),
                    icon: SvgPicture.asset(
                      'assets/icons/bxl-google.svg',
                      semanticsLabel: 'LoginGoogle',
                      color: Colors.white,
                    ),
                    label: Text(
                      AppLocalizations.of(context).trans('signin_google'),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // LayoutBuilder(builder: (context, constraints) {
            //   return Container(
            //     // constraints: BoxConstraints(
            //     //   maxWidth: availableScreenWidth * 0.6,
            //     //   minHeight: 100,
            //     // ),
            //     child: RaisedButton.icon(
            //       color: Colors.blueAccent,
            //       elevation: 10,
            //       onPressed: () => print('Pressed'),
            //       icon: SvgPicture.asset(
            //         'assets/icons/bxl-google.svg',
            //         semanticsLabel: 'LoginGoogle',
            //         color: Colors.white,
            //       ),
            //       label: Text(
            //         AppLocalizations.of(context).trans('signin_google'),
            //         style: TextStyle(
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
