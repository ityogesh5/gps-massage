import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class DialogHelper {
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
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('登録が完了しました。')),
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
                        SizedBox(height: 20),
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
                  height: MediaQuery.of(context).size.height * 0.40,
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
                        SizedBox(height: 20),
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
                  height: MediaQuery.of(context).size.height * 0.40,
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
                        SizedBox(height: 20),
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
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text('登録が完了しました。')),
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
                              NavigationRouter.switchToServiceProviderBottomBar(
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
                        SizedBox(height: 20),
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
                  height: MediaQuery.of(context).size.height * 0.45,
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
                        SizedBox(height: 20),
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
                  height: MediaQuery.of(context).size.height * 0.45,
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
                        SizedBox(height: 15),
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
                  height: MediaQuery.of(context).size.height * 0.45,
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
                              NavigationRouter.switchToServiceProviderBottomBar(
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
                        SizedBox(height: 20),
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
