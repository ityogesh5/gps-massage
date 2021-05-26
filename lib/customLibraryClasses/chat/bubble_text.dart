import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';

class BubbleText extends StatelessWidget {
  const BubbleText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 17,
          color: kBaseWhiteColor,
        ),
      ),
    );
  }
}
