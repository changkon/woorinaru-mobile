import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta/meta.dart';
import '../localization/app_localizations.dart';

class GenericEmptyStateCard extends StatelessWidget {

  String title;
  String description;
  String assetName;
  Color color = Colors.black;

  GenericEmptyStateCard({
    @required this.title,
    @required this.description,
    @required this.assetName,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      this.description,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 72,
                  minHeight: 72,
                ),
                child: SvgPicture.asset(
                  this.assetName,
                  semanticsLabel: 'Empty Logo',
                  color: this.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
