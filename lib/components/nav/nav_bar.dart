import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String activePane;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 30,
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: SvgPicture.asset(
    //           'assets/icons/bx-home.svg',
    //           semanticsLabel: 'Home',
    //           color: Colors.black,
    //         ),
    //       ),
    //       Expanded(
    //         child: SvgPicture.asset(
    //           'assets/icons/bx-heart.svg',
    //           semanticsLabel: 'Favourite',
    //           color: Colors.black,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    // return Consumer<ClientModel>(
    //   // builder: (_, clientModel, __) => 
    // );
  }
}
