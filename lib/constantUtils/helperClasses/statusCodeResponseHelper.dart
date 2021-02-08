import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/models/apiErrorModels/serviceUser/registerErrorHandler.dart';
import 'package:toast/toast.dart';

class StatusCodeHelper {
  //Checking register user response
  static bool isRegisterSuccess(
      int statusCode, BuildContext context, String body) {
    final Map errorResponse = json.decode(body);
    final errorDetails = RegisterErrorHandler.fromJson(errorResponse);
    if (statusCode == 200) {
      Toast.show("ユーザーが正常に登録されました。", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.lime,
          textColor: Colors.white);
      print('Response Success!!');
      return true;
    } else if (statusCode == 400) {
      if (errorDetails.status != null &&
          errorDetails.status.contains('error')) {
        Toast.show("この電話番号はすでに登録されています。", context,
            duration: 4,
            gravity: Toast.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      } else {
        Toast.show("登録中にエラーが発生しました。再試行してください。", context,
            duration: 4,
            gravity: Toast.CENTER,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      }
      print('Improper Image!!');
      return false;
    } else if (statusCode == 401) {
      print('Unauthorized User!!');
      return false;
    } else if (statusCode == 412) {
      Toast.show("すべての必須値を入力してください。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      return false;
    }
    return false;
  }

  // 200 response login success
  static bool isLoginSuccess(
      int statusCode, BuildContext context, String body) {
    if (statusCode == 200) {
      Toast.show("正常にログインしました。", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.lime,
          textColor: Colors.white);
      print('Response Success!!');
      return true;
    } else if (statusCode == 400) {
      //ユーザーが見つかりません。
      Toast.show("ユーザーが見つかりません。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('User Not Found!!');
      return false;
    } else if (statusCode == 401) {
      Toast.show("許可されていないユーザー。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('Unauthorized User!!');
      return false;
    }
    return false;
  }

  // send verify
  static bool isSendVerify(int statusCode, BuildContext context, String body) {
    if (statusCode == 200) {
      Toast.show("認証コードは正常に送信しました。", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.lime,
          textColor: Colors.white);
      print('Response Success!!');
      return true;
    } else if (statusCode == 400) {
      //ユーザーが見つかりません。
      Toast.show("ユーザーが見つかりません。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('User Not Found!!');
      return false;
    } else if (statusCode == 401) {
      Toast.show("許可されていないユーザー。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('Unauthorized User!!');
      return false;
    }
    return false;
  }

  //Change Password User
  static bool isChangePasswordUser(
      int statusCode, BuildContext context, String body) {
    if (statusCode == 200) {
      // DialogHelper.showPasswordResetSuccessDialog(context);
      print('Response Success!!');
      return true;
    } else if (statusCode == 400) {
      //ユーザーが見つかりません。
      Toast.show("ユーザーが見つかりません。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('User Not Found!!');
      return false;
    } else if (statusCode == 401) {
      Toast.show("許可されていないユーザー。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('Unauthorized User!!');
      return false;
    }
    return false;
  }

  //User Verify Otp
  static bool isVerifyOtpUserUser(
      int statusCode, BuildContext context, String body) {
    if (statusCode == 200) {
      print('Response Success!!');
      return true;
    } else if (statusCode == 400) {
      //ユーザーが見つかりません。
      Toast.show("正しい確認コードを入力してください。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('User Not Found!!');
      return false;
    } else if (statusCode == 401) {
      Toast.show("許可されていないユーザー。", context,
          duration: 4,
          gravity: Toast.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      print('Unauthorized User!!');
      return false;
    }
    return false;
  }
}
