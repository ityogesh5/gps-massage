import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/DeleteSubAddressScreen.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/LogOutScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constantsUtils.dart';

class DialogHelper {
  static Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  // notification popup
  static void showNotificationDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                NotificationPopup(),
              ],
            ),
          );
        });
  }

  // Login or Register user popup
  static void showUserLoginOrRegisterDialog(BuildContext context) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      dismissOnTouchOutside: false,
      useRootNavigator: true,
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              new AssetImage('assets/images_gps/appIcon.png')),
                    )),
                Center(
                    child: InkWell(
                  onTap: () {
                    HealingMatchConstants.lineUserProfileURL = null;
                    HealingMatchConstants.lineUsername = null;
                    HealingMatchConstants.lineUserEmail = null;
                    dialog.dissmiss();
                    NavigationRouter.switchToServiceUserRegistration(context);
                  },
                  child: Text('登録する',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.underline)),
                )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            //  height: 50,
                            color: Colors.grey,
                          )),
                    ),
                    Text(
                      "または",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.grey,
                            //height: 50,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    HealingMatchConstants.lineUserProfileURL = null;
                    HealingMatchConstants.lineUsername = null;
                    HealingMatchConstants.lineUserEmail = null;
                    HealingMatchConstants.isUserRegistrationSkipped = false;
                    dialog.dissmiss();
                    NavigationRouter.switchToUserLogin(context);
                  },
                  child: Text('すでにアカウントをお持ちの方',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.underline)),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOk: AnimatedButton(
          color: Color.fromRGBO(200, 217, 33, 1),
          text: 'OK',
          pressEvent: () {
            dialog.dissmiss();
            NavigationRouter.switchToServiceUserBottomBar(context);
          }),
    )..show();
  }

  //Add address SkipPopup

  static void showUserAddAddressDialog(BuildContext context) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      //showCloseIcon: true,
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              new AssetImage('assets/images_gps/appIcon.png')),
                    )),
                Center(
                    child: InkWell(
                  onTap: () {
                    NavigationRouter.switchToServiceUserRegistration(context);
                  },
                  child: Text('登録する',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.underline)),
                )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            //  height: 50,
                            color: Colors.grey,
                          )),
                    ),
                    Text(
                      "または",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.grey,
                            //height: 50,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    NavigationRouter.switchToUserLogin(context);
                  },
                  child: Text('すでにアカウントをお持ちの方',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.underline)),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOk: AnimatedButton(
          color: Color.fromRGBO(200, 217, 33, 1),
          text: 'OK',
          pressEvent: () {
            dialog.dissmiss();
            NavigationRouter.switchToServiceUserBottomBar(context);
            // Navigator.pop(context);
          }),
    )..show();
  }

  // User Register Success popup
  static void showRegisterSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          '登録が完了しました。',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              // Navigator.pop(context);
                              _sharedPreferences.then((value) {
                                value.setBool('isUserVerified', true);
                              });
                              NavigationRouter.switchToServiceUserBottomBar(
                                  context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.13,
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images_gps/correct.svg",
                        // height: 5.0,
                        // width: 5.0,
                      ),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.height * 0.18,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Provider Password reset success popup
  static void providerResetSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('パスワードを更新いたしました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              //Navigator.pop(context);
                              NavigationRouter.switchToProviderLogin(context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/padlock.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // User Password reset success popup
  static void showPasswordResetSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('パスワードを更新いたしました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              //Navigator.pop(context);
                              NavigationRouter.switchToUserLogin(context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/lock.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Provider Password reset success popup
  static void showPasswordProviderResetSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('パスワードを更新いたしました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              //Navigator.pop(context);
                              NavigationRouter.switchToProviderLogin(context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/padlock.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Provider Register Success popup
  static void showProviderRegisterSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CustomPaint(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                        foregroundPainter: HeaderCurvedContainer(),
                      ),
                    ),
                    Container(
                      //  height: MediaQuery.of(context).size.height * 0.38,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: FittedBox(
                                child: Text(
                                  '登録いただいた内容を確認しております。\n確認ができ次第アプリの使用が可能になります。',
                                  style: TextStyle(fontSize: 14.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            ButtonTheme(
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: new RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  //side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.lime,
                                onPressed: () {
                                  //Navigator.pop(context);
                                  _sharedPreferences.then((value) {
                                    value.setBool('isProviderVerified', true);
                                  });
                                  NavigationRouter
                                      .switchToServiceProviderBottomBar(
                                          context);
                                },
                                child: new Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/tick.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Provider Password reset success popup
  static void showProviderPasswordResetSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('パスワードを変更いたしました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              //Navigator.pop(context);
                              NavigationRouter.switchToProviderLogin(context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/padlock.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

// User Profile Details Update success popup
  static void showUserProfileUpdatedSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('更新が完了しました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
//side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
//Navigator.pop(context);
                              NavigationRouter
                                  .switchToServiceUserBottomBarViewProfile(
                                      context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/correct.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Provider Profile Details Update success popup
  static void showProviderProfileUpdatedSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('更新が完了しました。')),
                        SizedBox(height: 15),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
//side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              Navigator.pop(context);
                              NavigationRouter.switchToServiceProviderMyAccount(
                                  context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/tick.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Login or Register user popup
  /*static void showUserLoginOrRegisterDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: InkWell(
                            onTap: () {
                              NavigationRouter.switchToServiceUserRegistration(
                                  context);
                            },
                            child: Text('登録する',
                                style: new TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.w100,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 15.0),
                                  child: Divider(
                                    //  height: 50,
                                    color: Colors.grey,
                                  )),
                            ),
                            Text(
                              "または",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 15.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    //height: 50,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            NavigationRouter.switchToUserLogin(context);
                          },
                          child: Text('すでにアカウントをお持ちの方',
                              style: new TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'NotoSansJP',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w100,
                                  decoration: TextDecoration.underline)),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                */ /* Positioned(
                  top: -5,
                  right: -5,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.white]),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),*/ /*
                Positioned(
                  top: 42,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/logo.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }*/

  // Cancel pop up dialog
  static void showUserBookingCancelDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    foregroundPainter: HeaderCurvedContainer(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('予約がキャンセルされました。')),
                        SizedBox(height: 20),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              NavigationRouter.switchToServiceUserBottomBar(
                                  context);
                            },
                            child: new Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: MediaQuery.of(context).size.width * 0.11,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images_gps/calendar.png'),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 100,
                    right: 50,
                    left: 80,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      maxRadius: 9.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        maxRadius: 8.0,
                        child: Icon(Icons.clear, size: 12, color: Colors.black),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  // Logout service user
  static void showLogOutUserDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                LogOutServiceUser(),
              ],
            ),
          );
        });
  }

  // Delete sub address service user
  static void showDeleteSubAddressDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                DeleteSubAddress(),
              ],
            ),
          );
        });
  }

  // Awesome custom dialog viewer
  static void showNoTherapistsDialog(BuildContext context) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.INFO,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: false,
        closeIcon: Icon(Icons.close),
        title: '情報',
        desc: 'セラピストは見つかりませんでした！',
        btnOkOnPress: () {
          print('Ok pressed!!');
        })
      ..show();
  }

  // show no internet doalog
  static void showNoInternetConnectionDialog(
      BuildContext context, Widget classWidget) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.INFO,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: false,
        closeIcon: Icon(Icons.close),
        title: '情報',
        desc: 'インターネット接続が必要です！',
        btnOkOnPress: () {
          print('Ok pressed!!');
          return Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => classWidget),
              (Route<dynamic> route) => false);
        })
      ..show();
  }

  // Report / Block User
  static openReportBlockUserDialog(BuildContext context) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      headerAnimationLoop: false,
      dialogBackgroundColor: Colors.grey[200],
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.WARNING,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      showCloseIcon: false,
      body: CupertinoActionSheet(
        message: Text(
          'このセラピストをブロック/報告しますか？',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: false,
            child: Text(
              '報告する',
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              dialog.dissmiss();
              NavigationRouter.switchToReportUserScreen(context);
            },
          ),
          CupertinoActionSheetAction(
            isDefaultAction: false,
            child: Text(
              'ブロックする',
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              dialog.dissmiss();
              //_blockUser();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: false,
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
    )..show();
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.lime;
    Path path = Path()
      ..relativeLineTo(-12, 0)
      ..quadraticBezierTo(size.width / 2, 190.0, size.width, 12)
      ..relativeLineTo(0, -12)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
