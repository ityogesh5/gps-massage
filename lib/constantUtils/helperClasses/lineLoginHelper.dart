import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

import '../constantsUtils.dart';

class LineLoginHelper {
  // Initiate LINE Provider Login SDK
  static void startLineLoginForProvider(BuildContext context) async {
    await LineSDK.instance
        .setup(HealingMatchConstants.clientLineChannelID)
        .then((_) {
      print("LineSDK is Prepared");
    });
    try {
      final result = await LineSDK.instance.login(scopes: ["profile"]);
      if (result.data != null) {
        var accessToken = await getAccessToken();
        var displayName = result.userProfile.displayName;
        var statusMessage = result.userProfile.statusMessage;
        var imgUrl = result.userProfile.pictureUrl;
        var userId = result.userProfile.userId;
        var userProfile = result.userProfile;

        print("AccessToken> " + accessToken);
        print("DisplayName> " + displayName);
        print("StatusMessage> " + statusMessage);
        print("ProfileURL> " + imgUrl);
        print("userId> " + userId);
        print("User profile " + userProfile.data.toString());
        NavigationRouter.switchToServiceProviderBottomBar(context);
      } else {
        print('Line Login Result null');
        return null;
      }
    } on PlatformException catch (e) {
      print(e);
      switch (e.code.toString()) {
        case "CANCEL":
          showDialogBox(
              "You canceled the login.",
              "A moment you pressed cancel login. Please log in again.",
              context);
          print("User Cancel the login");
          break;
        case "AUTHENTICATION_AGENT_ERROR":
          showDialogBox(
              "You do not allow login either. LINE",
              "A moment you pressed cancel login. Please log in again.",
              context);
          print("User decline the login");
          break;
        default:
          showDialogBox("Something went wrong",
              "An unknown error has occurred. Please log in again.", context);
          print("Unknown but failed to login");
          break;
      }
    }
  }

  // Initiate LINE User Login SDK
  static void startLineLoginForUser(BuildContext context) async {
    await LineSDK.instance
        .setup(HealingMatchConstants.clientLineChannelID)
        .then((_) {
      print("LineSDK is Prepared");
    });
    try {
      final result = await LineSDK.instance.login(scopes: ["profile"]);
      if (result.data != null) {
        var accessToken = await getAccessToken();
        var displayName = result.userProfile.displayName;
        var statusMessage = result.userProfile.statusMessage;
        var imgUrl = result.userProfile.pictureUrl;
        var userId = result.userProfile.userId;
        var userProfile = result.userProfile;

        HealingMatchConstants.lineAccessToken = accessToken;
        HealingMatchConstants.lineUserID = userId;
        HealingMatchConstants.lineUsername = displayName;
        HealingMatchConstants.lineUserProfileURL = imgUrl;
        HealingMatchConstants.lineUserProfileDetails =
            jsonEncode(userProfile.data);

        print("AccessToken > " +
            accessToken +
            '\n${HealingMatchConstants.lineAccessToken}');
        print("DisplayName > " +
            displayName +
            '\n${HealingMatchConstants.lineUsername}');
        print("ProfileURL > " +
            imgUrl +
            '\n${HealingMatchConstants.lineUserProfileURL}');
        print("userId > " + userId + '\n${HealingMatchConstants.lineUserID}');
        print("User profile >" +
            jsonEncode(userProfile.data) +
            '\n${HealingMatchConstants.lineUserProfileDetails}');
        NavigationRouter.switchToServiceUserBottomBar(context);
      } else {
        print('Line Login Result null');
        return null;
      }
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

  static Future getAccessToken() async {
    try {
      final result = await LineSDK.instance.currentAccessToken;
      return result.value;
    } on PlatformException catch (e) {
      print(e.message);
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
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void logOutLineUser() async {
    try {
      await LineSDK.instance.logout();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
