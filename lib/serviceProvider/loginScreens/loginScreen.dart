import 'dart:convert';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/progressDialogs.dart';
import 'package:gps_massageapp/constantUtils/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/responseModels/serviceUser/login/loginResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;

class ProviderLogin extends StatefulWidget {
  @override
  _ProviderLoginState createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();

  FocusNode phoneNumberFocus = FocusNode();
  FocusNode createPasswordFocus = FocusNode();

  List<String> serviceProviderLoginDetails = [];

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  UserProfile _userProfile;
  String _userEmail;
  var loginResponseModel = new LoginResponseModel();

  void initState() {
    super.initState();
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7,
                    right: MediaQuery.of(context).size.width / 25,
                    left: MediaQuery.of(context).size.width / 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images_gps/normalLogo.svg',
                        height: 100, width: 140),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(HealingMatchConstants.loginText,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: phoneNumberFocus,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          labelText: HealingMatchConstants.loginUserPhoneNumber,
                          hintText: HealingMatchConstants.loginUserPhoneNumber,
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: createPasswordFocus,
                      controller: passwordController,
                      obscureText: passwordVisibility,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
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
                              TextStyle(color: Colors.grey, fontSize: 13),
                          labelText: HealingMatchConstants.loginPassword,
                          hintText: HealingMatchConstants.loginPassword,
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            NavigationRouter
                                .switchToProviderForgetPasswordScreen(context);
                          },
                          child: Text(
                            HealingMatchConstants.loginForgetPassword,
                            style: TextStyle(
                              color: Colors.grey,
//                    decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: RaisedButton(
                        child: Text(
                          HealingMatchConstants.loginButton,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          _providerLoginDetails();
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
                        /* InkWell(
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
                        ),*/
                        InkWell(
                            onTap: () {
                              _linelogin();
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
                          width: 10,
                        ),
                        InkWell(
                            onTap: () async {
                              if (await AppleSignIn.isAvailable()) {
                                final AuthorizationResult result =
                                    await AppleSignIn.performRequests([
                                  AppleIdRequest(requestedScopes: [
                                    Scope.email,
                                    Scope.fullName
                                  ])
                                ]);

                                switch (result.status) {
                                  case AuthorizationStatus.authorized:
                                    print(
                                        "user credentials : ${result.credential.user}");
                                    print(result.credential.authorizationCode);
                                    print(result.credential.authorizedScopes);
                                    print(result.credential.email);
                                    print(result.credential.fullName);
                                    print(result.credential.identityToken);
                                    print(result.credential.realUserStatus);
                                    print(result.credential.state);
                                    print(result.credential
                                        .user); //All the required credentials
                                    break;
                                  case AuthorizationStatus.error:
                                    print(
                                        "Sign in failed: ${result.error.localizedDescription}");
                                    break;
                                  case AuthorizationStatus.cancelled:
                                    print('User cancelled');
                                    break;
                                }
                              } else {
                                print(
                                    'Apple SignIn is not available for your device');
                              }
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
                            )),
                        //_initiateLineLogin();
                        /*   print('Line login');
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
                            )), */
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        NavigationRouter.switchToServiceProviderFirstScreen(
                            context);
                      },
                      child: Text(
                        HealingMatchConstants.loginNewRegistrationText,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
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
          NavigationRouter.switchToUserLogin(context);
        },
        child: Center(
          child: Text(
            HealingMatchConstants.loginServiceUser,
            style: TextStyle(
              color: Colors.grey,
//                            decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  void _linelogin() async {
    try {
      final result = await LineSDK.instance.login();
      setState(() {
        _userProfile = result.userProfile;
        // user id -> result.userProfile.userId
        // user name -> result.userProfile.displayName
        // user avatar -> result.userProfile.pictureUrl
        // etc...
      });
    } on PlatformException catch (e) {
      // Error handling.
      print(e);
    }
  }

  _providerLoginDetails() async {
    var userPhoneNumber = phoneNumberController.text.toString();
    var password = passwordController.text.toString();

    // user phone number validation
    if (userPhoneNumber.length < 11 ||
        userPhoneNumber.length > 11 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('11文字以上の電話番号を入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは8文字以上で入力してください。  ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.length > 14) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは15文字以内で入力してください。 ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    try {
      ProgressDialogBuilder.showLoginProviderProgressDialog(context);
      final url = HealingMatchConstants.LOGIN_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json
              .encode({"phoneNumber": userPhoneNumber, "password": password}));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isLoginSuccess(response.statusCode, context)) {
        print('Response Success');
        final Map loginResponse = json.decode(response.body);
        loginResponseModel = LoginResponseModel.fromJson(loginResponse);
        print('Login response : ${loginResponseModel.toJson()}');
        print('Login token : ${loginResponseModel.accessToken}');
        ProgressDialogBuilder.hideLoginProviderProgressDialog(context);
        NavigationRouter.switchToServiceProviderBottomBar(context);
      } else {
        ProgressDialogBuilder.hideLoginProviderProgressDialog(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {}
  }
}
