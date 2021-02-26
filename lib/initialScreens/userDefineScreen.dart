import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/LoginScreen.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserLoginScreen.dart';

class UserDefineScreen extends StatefulWidget {
  @override
  _UserDefineScreenState createState() => _UserDefineScreenState();
}

class _UserDefineScreenState extends State<UserDefineScreen> {
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();
  Size size;
  int state = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state == 0) {
        state = 1;
        size = MediaQuery.of(context).size;
        showUserDefineDialog();
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20),
            child: InkWell(
              onTap: () {
                // NavigationRouter.switchToServiceUserBottomBar(context);
              },
              child: Text(
                HealingMatchConstants.loginUserSkipText,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oxygen',
                    fontSize: 18.0),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                // top: MediaQuery.of(context).size.height / 7,
                right: MediaQuery.of(context).size.width / 25,
                left: MediaQuery.of(context).size.width / 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*   SvgPicture.asset('assets/images_gps/normalLogo.svg',
                    height: 150, width: 140),*/
                Center(
                    child: Text(HealingMatchConstants.loginUserText,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    border: HealingMatchConstants.textFormInputBorder,
                    focusedBorder: HealingMatchConstants.textFormInputBorder,
                    disabledBorder: HealingMatchConstants.textFormInputBorder,
                    enabledBorder: HealingMatchConstants.textFormInputBorder,
                    filled: true,
                    labelText: HealingMatchConstants.loginPhoneNumber,
                    fillColor: ColorConstants.formFieldFillColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    border: HealingMatchConstants.textFormInputBorder,
                    focusedBorder: HealingMatchConstants.textFormInputBorder,
                    disabledBorder: HealingMatchConstants.textFormInputBorder,
                    enabledBorder: HealingMatchConstants.textFormInputBorder,
                    suffixIcon: IconButton(
                        icon: passwordVisibility
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        }),
                    filled: true,
                    // hintStyle:
                    //     TextStyle(color: Colors.grey, fontFamily: 'Oxygen'),
                    labelText: HealingMatchConstants.loginUserPassword,
                    fillColor: ColorConstants.formFieldFillColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '${HealingMatchConstants.loginUserForgetPassword}',
                        style:
                            TextStyle(color: Colors.grey, fontFamily: 'Oxygen'
//                    decoration: TextDecoration.underline,
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: RaisedButton(
                    child: Text(
                      '${HealingMatchConstants.loginUserButton}',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Oxygen',
                          fontSize: 18),
                    ),
                    color: Colors.lime,
                    onPressed: () {
                      // _loginServiceUser();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
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
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Colors.grey,
                          //height: 50,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          // _initiateLineLogin();
                          print('Line login');
                        },
                        child: Container(
                          width: 45.0,
                          height: 45,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                              width: 20.0,
                              height: 20,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.contain,
                                  image: new AssetImage(
                                      'assets/images_gps/line1.png'),
                                ),
                              )),
                        )),
                    SizedBox(
                      width: Platform.isIOS ? 10 : 0,
                    ),
                    Platform.isIOS
                        ? InkWell(
                            onTap: () {
                              print('Apple login');
                              // _initiateAppleSignIn();
                            },
                            child: Container(
                              width: 45.0,
                              height: 45,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                  width: 20.0,
                                  height: 20,
                                  decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.contain,
                                      image: new AssetImage(
                                          'assets/images_gps/apple2.jpg'),
                                    ),
                                  )),
                            ))
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    HealingMatchConstants.loginUserNewRegistrationText,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      child: InkWell(
        onTap: () {
          // NavigationRouter.switchToProviderLogin(context);
        },
        child: Center(
          child: Text(
            HealingMatchConstants.loginServiceProvider,
            style: TextStyle(color: Colors.grey, fontFamily: 'Oxygen'
//                            decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }

  showUserDefineDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 16,
            child: Stack(
              children: [
                Container(
                  //height: 300.0,
                  //width: 450.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            HealingMatchConstants.UserSelectFirtTxt,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("User onTapped");
                                      NavigationRouter
                                          .switchToUserInitialTutorialScreen(
                                              context);
                                      /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  UserLogin())); */
                                    },
                                    child: Image.asset(
                                      'assets/images_gps/user_image.png',
                                      height: 150.0,
                                      //width: 150.0,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  /*Text(
                                    "不動産カレンダー",
                                    style: TextStyle(fontSize: 10.0),
                                  ),*/
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("Provider onTapped");
                                      NavigationRouter
                                          .switchToProviderInitialTutorialScreen(
                                              context);
                                      /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ProviderLogin())); */
                                    },
                                    child: Image.asset(
                                      'assets/images_gps/Provider_image.png',
                                      height: 150.0,
                                      //width: 150.0,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  /*Text(
                                    "不動産カレンダー",
                                    style: TextStyle(fontSize: 10.0),
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: size.width * 0.9,
                          child: Text(
                            HealingMatchConstants.UserSelectLastTxt,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 35,
                  left: 35,
                  child: Text(
                    'サービス利用者',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 41,
                  child: Text(
                    'セラピスト',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
