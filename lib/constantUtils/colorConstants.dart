import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/hexColor.dart';

class ColorConstants {
  static final snackBarColor = Colors.redAccent;
  static final formFieldFillColor = Color.fromRGBO(246, 246, 246, 1);
  static final formFieldBorderColor = Colors.transparent;
  static final formTextColor = Colors.black;
  static final formHintTextColor = Color.fromRGBO(197, 197, 197, 1);
  static final formLabelTextColor = Color.fromRGBO(0, 0, 0, 1);
  static final multiTextHintTextColor = Color.fromRGBO(217, 217, 217, 1);
  static final buttonColor = Color.fromRGBO(200, 217, 33, 1);
  static final fontFamily = 'NotoSansJP';
  static final dateFieldBorderColor = Color.fromRGBO(228, 228, 228, 1);

  static final statusBarColor = Colors.grey[200];
}

Color kBorderColor1 = Colors.white.withOpacity(0.1);
Color kBorderColor2 = Colors.white.withOpacity(0.07);
Color kBorderColor3 = Colors.white.withOpacity(0.2);
Color kBorderColor4 = Colors.white.withOpacity(0.2);
Color kBaseWhiteColor = Colors.white.withOpacity(0.87);

Color kBlackColor = Colors.black; //('#1C1C1E');
Color kBlackColor2 = Hexcolor('#121212'); // Hexcolor('#161616');
Color kBlackColor3 = Hexcolor('#1C1C1E'); // Hexcolor('#2C2C2E');

TextStyle kWhatsAppStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: Colors.black.withOpacity(0.95),
);

TextStyle kSelectedTabStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.95),
);

TextStyle kUnselectedTabStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.4),
);

TextStyle kChatItemTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

TextStyle kChatItemSubtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white.withOpacity(0.7),
);

TextStyle kAppBarTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: kBaseWhiteColor,
);

TextStyle kChatBubbleTextStyle = TextStyle(
  fontSize: 17,
  color: kBaseWhiteColor,
);

TextStyle kReplyTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Hexcolor('#FF0266'),
);

TextStyle kReplySubtitleStyle = TextStyle(
  fontSize: 14,
  color: kBaseWhiteColor,
);

class ReplyColorPair {
  final Color user;
  final Color peer;

  ReplyColorPair({this.user, this.peer});
}

List<ReplyColorPair> replyColors = [
  ReplyColorPair(user: Hexcolor('#09af00'), peer: Hexcolor('#FF0266')),
  ReplyColorPair(user: Hexcolor('#C62828'), peer: Hexcolor('#d602ee')),
  ReplyColorPair(user: Hexcolor('#f47100'), peer: Hexcolor('#61d800')),
  ReplyColorPair(user: Hexcolor('#4E342E'), peer: Hexcolor('#BF360C')),
];
