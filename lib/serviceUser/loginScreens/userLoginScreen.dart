import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bottomBarUser.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userForgetPassword.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7,
                    right: MediaQuery.of(context).size.height / 25,
                    left: MediaQuery.of(context).size.height / 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images_gps/logo.svg',
                        height: 100, width: 140),
                    Center(
                        child: Text('サービス利用者のログイン',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "電話番号",
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
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
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "パスワード",
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserForgetPassword()));
                          },
                          child: Text(
                            'パスワードを忘れた方はこちら',
                            style: TextStyle(
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
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          '${HealingMatchConstants.loginButton}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BottomBarUser()));
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
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              // height: 50,
                              color: Colors.black,
                            )),
                      ),
                      Text("または"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              // height: 50,
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
                              //_initiateLineLogin();
                              print('Line login');
                            },
                            child: Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: new AssetImage(
                                        'assets/images_gps/line.jpg'),
                                  ),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              print('Apple login');
                              //_initiateAppleSignIn();
                            },
                            child: Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: new AssetImage(
                                        'assets/images_gps/apple2.jpg'),
                                  ),
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        NavigationRouter.switchToServiceUserRegistration(
                            context);
                      },
                      child: Text(
                        '新規の方はこちら',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ],
                ),
              ),
//              Align(alignment: Alignment.bottomCenter, child: Text('weyfgfgb')),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 1.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        NavigationRouter.switchToProviderLogin(context);
                      },
                      child: Text(
                        'セラピストのログイン',
                        style: TextStyle(
//                            decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
