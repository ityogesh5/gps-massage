import 'package:flutter/material.dart';

class BubbleText extends StatelessWidget {
  const BubbleText({
    Key key,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color,
        ),
      ),
    );
  }
}
