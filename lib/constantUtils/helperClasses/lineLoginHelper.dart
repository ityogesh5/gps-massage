import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:gps_massageapp/models/LineResponseModels/LineIDTokenModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

import '../constantsUtils.dart';

class LineLoginHelper {
  // Initiate LINE User Login SDK
  static void startLineLogin(BuildContext context) async {
    await LineSDK.instance
        .setup(HealingMatchConstants.clientLineChannelID)
        .then((_) {
      print("LineSDK is Prepared");
    });
    try {
      await LineSDK.instance
          .login(scopes: ["profile", "openid", "email"]).then((value) async {
        if (value.data != null) {
          var displayName = value.userProfile.displayName;
          var imgUrl = value.userProfile.pictureUrl;
          var userId = value.userProfile.userId;
          var userProfile = value.userProfile;
          var accessToken = value.accessToken.value;
          var idToken = value.accessToken.idToken;

          final idTokenResponseModel =
              LineIDTokenResponseModel.fromJson(idToken);

          print('Line Access Token : $accessToken');
          print('Line ID Token : $idToken');
          print(
              'User data : ${idTokenResponseModel.picture},\n${idTokenResponseModel.name},\n${idTokenResponseModel.email}');

          Future.delayed(Duration(seconds: 2), () {});
          HealingMatchConstants.lineAccessToken = accessToken;
          HealingMatchConstants.lineUserID = userId;
          HealingMatchConstants.lineUsername = idTokenResponseModel.name;
          HealingMatchConstants.lineUserProfileURL =
              idTokenResponseModel.picture;
          HealingMatchConstants.lineUserProfileDetails =
              jsonEncode(userProfile.data);
          HealingMatchConstants.lineUserEmail = idTokenResponseModel.email;
          NavigationRouter.switchToServiceUserRegistration(context);
        } else {
          print('Line Login Result null');
          return null;
        }
      }).catchError((error) {});
    } on PlatformException catch (e) {
      print(e);
      switch (e.code.toString()) {
        case "CANCEL":
          showDialogBox(
              "ログインをキャンセルしました。", "ログインのキャンセルを押した瞬間。 もう一度ログインしてください。", context);
          print("User Cancel the login");
          break;
        case "AUTHENTICATION_AGENT_ERROR":
          showDialogBox("ログインも許可しません。 ライン！",
              "ログインのキャンセルを押した瞬間。 もう一度ログインしてください。", context);
          print("User decline the login");
          break;
        default:
          showDialogBox(
              "何かがうまくいかなかった", "不明なエラーが発生しました。 もう一度ログインしてください。", context);
          print("Unknown but failed to login");
          break;
      }
    }
  }

  static void showDialogBox(
      String title, String body, BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(body)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void logOutLine() async {
    try {
      await LineSDK.instance.logout();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
