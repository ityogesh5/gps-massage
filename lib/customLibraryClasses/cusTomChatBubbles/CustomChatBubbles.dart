import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleReceiver.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleSender.dart';

class CustomChatBubble extends StatelessWidget {
  final CustomClipper clipper;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final Color backGroundColor;
  final Color shadowColor;
  final Alignment alignment;

  CustomChatBubble({
    this.clipper,
    this.child,
    this.margin,
    this.elevation,
    this.backGroundColor,
    this.shadowColor,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      margin: margin ?? EdgeInsets.all(0),
      child: PhysicalShape(
        clipper: clipper,
        elevation: elevation ?? 1,
        color: backGroundColor ?? Colors.blue,
        shadowColor: shadowColor ?? Colors.grey.shade200,
        child: Padding(
          padding: setPadding(),
          child: child ?? Container(),
        ),
      ),
    );
  }

  EdgeInsets setPadding() {
    if (clipper is ChatBubbleReceiver) {
      if ((clipper as ChatBubbleReceiver).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 40);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
      }
    } else if (clipper is ChatBubbleSender) {
      if ((clipper as ChatBubbleSender).type == BubbleType.sendBubble) {
        return EdgeInsets.all(10);
      } else {
        return EdgeInsets.all(10);
      }
    }

    return EdgeInsets.all(10);
  }
}
