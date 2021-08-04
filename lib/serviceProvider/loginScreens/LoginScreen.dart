import 'dart:convert';
import 'dart:core';
import 'dart:io';

// import 'package:apple_sign_in/apple_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/lineLoginHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/keyboardDoneButton/keyboardActionConfig.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:toast/toast.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/snsAndAppleResponse.dart'
    as snsLogin;

class ProviderLogin extends StatefulWidget {
  @override
  _ProviderLoginState createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  String lineBotId;
  String appleUserId;
  int isTherapist = 1;
  var loginResponseModel = new LoginResponseModel();
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  final fireBaseMessaging = new FirebaseMessaging();
  var fcmToken;

  FocusNode phoneNumberFocus = FocusNode();
  FocusNode createPasswordFocus = FocusNode();

  List<String> serviceProviderLoginDetails = [];

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    HealingMatchConstants.snsLoginFlag = 1;
    print('snsFlag:   ${HealingMatchConstants.snsLoginFlag}');
    _getFCMLoginToken();
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      /*  AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      }); */
    }
  }

  _getFCMLoginToken() async {
    fireBaseMessaging.getToken().then((fcmTokenValue) {
      if (fcmTokenValue != null) {
        fcmToken = fcmTokenValue;
        print('FCM Login Token : $fcmToken');
      } else {
        fireBaseMessaging.onTokenRefresh.listen((refreshToken) {
          if (refreshToken != null) {
            fcmToken = refreshToken;
            print('FCM Login Refresh Tokens : $fcmToken');
          }
        }).onError((handleError) {
          print('On FCM Login Token Refresh error : ${handleError.toString()}');
        });
      }
    }).catchError((onError) {
      print('FCM Login Token Exception : ${onError.toString()}');
    });
    _sharedPreferences.then((value) {
      lineBotId = value.getString('lineBotIdProvider');
      appleUserId = value.getString('lineBotIdProvider');
      print('lineBotId  : ${value.getString('appleIdProvider')}');
    });
    print('lineBotId!!! : ${lineBotId}');
  }

  showOverlayLoader() {
    Loader.show(
      context,
      progressIndicator: SpinKitThreeBounce(color: Colors.lime),
    );
  }

  hideLoader() {
    Future.delayed(Duration(seconds: 0), () {
      Loader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0.0),
      bottomNavigationBar: buildBottomBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: KeyboardActions(
        config: KeyboardCustomActions().buildConfig(context, phoneNumberFocus),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  //  top: MediaQuery.of(context).size.height / 7,
                  right: MediaQuery.of(context).size.width / 25,
                  left: MediaQuery.of(context).size.width / 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* SvgPicture.asset('assets/images_gps/normalLogo.svg',
                      height: 150, width: 140),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(HealingMatchConstants.loginText,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    style: HealingMatchConstants.formTextStyle,
                    focusNode: phoneNumberFocus,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      border: HealingMatchConstants.textFormInputBorder,
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
                      filled: true,
                      labelText: HealingMatchConstants.loginUserPhoneNumber,
                      labelStyle: HealingMatchConstants.formLabelTextStyle,
                      fillColor: ColorConstants.formFieldFillColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    style: HealingMatchConstants.formTextStyle,
                    focusNode: createPasswordFocus,
                    controller: passwordController,
                    obscureText: passwordVisibility,
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
                      labelText: HealingMatchConstants.loginPassword,
                      labelStyle: HealingMatchConstants.formLabelTextStyle,
                      fillColor: ColorConstants.formFieldFillColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          // NavigationRouter.switchToProviderForgetPasswordScreen(context);
                          NavigationRouter.switchToProviderForgetPasswordScreen(
                              context);
                        },
                        child: Text(
                          HealingMatchConstants.loginForgetPassword,
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 12.0
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
                      color: ColorConstants.buttonColor,
                      onPressed: () {
                        //  NavigationRouter.switchToServiceProviderBottomBar(context);

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
                              color: Color.fromRGBO(225, 225, 225, 1))),
                    ),
                    Text(
                      "または",
                      style: TextStyle(color: Color.fromRGBO(225, 225, 225, 1)),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(color: Color.fromRGBO(225, 225, 225, 1)
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
                          customBorder: CircleBorder(),
                          onTap: () {
                            _initiateLineLogin();
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
                              customBorder: CircleBorder(),
                              onTap: () {
                                _initiateAppleSignIn();
                              },
                              child: Container(
                                width: 45.0,
                                height: 45,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  width: 30.0,
                                  height: 30,
                                  margin: EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(
                                    "assets/images_gps/appleLogo.svg",
                                    height: 20.0,
                                    width: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                          : Container(),
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
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 12.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
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
          NavigationRouter.switchToUserInitialTutorialScreen(context);
          /*      NavigationRouter.switchToUserLogin(context); */
        },
        child: Center(
          child: Text(
            HealingMatchConstants.loginServiceUser,
            style: TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
//                            decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  _providerLoginDetails() async {
    showOverlayLoader();
    var userPhoneNumber = phoneNumberController.text.toString();
    var password = passwordController.text.toString();
    SharedPreferences instances = await SharedPreferences.getInstance();

    // user phone number and password null check validation
    if ((userPhoneNumber == null || userPhoneNumber.isEmpty) &&
        (password == null || password.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('電話番号とパスワードを入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      hideLoader();
      return;
    }

    // user phone number validation
    if (userPhoneNumber.length > 11 ||
        userPhoneNumber.length < 10 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('電話番号・パスワードに誤りがあるか、登録されていません。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      hideLoader();
      return;
    }

    if (password == null || password.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードを入力してください。 ',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      hideLoader();
      return;
    }

    if (password.length < 8 || password.length > 16) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('電話番号・パスワードに誤りがあるか、登録されていません。 ',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      hideLoader();
      return;
    }

    try {
      final url = HealingMatchConstants.LOGIN_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": userPhoneNumber,
            "password": password,
            "isTherapist": "1",
            "fcmToken": instances.getString("notificationStatus") == "accepted"
                ? fcmToken
                : ''
          }));
      print('Status code : ${response.statusCode}');

      if (StatusCodeHelper.isLoginSuccess(
          response.statusCode, context, response.body)) {
        print('Response Success');
        final Map loginResponse = json.decode(response.body);
        loginResponseModel = LoginResponseModel.fromJson(loginResponse);
        Data userData = loginResponseModel.data;
        instances.setString("userData", json.encode(userData));
        instances.setBool('isActive', loginResponseModel.data.isActive);
        instances.setString("accessToken", loginResponseModel.accessToken);
        instances.setString(
            "lineBotIdProvider", loginResponseModel.data.lineBotUserId);
        instances.setString(
            "appleIdProvider", loginResponseModel.data.appleUserId);
        print('Login response : ${loginResponseModel.toJson()}');
        print('Login token : ${loginResponseModel.accessToken}');
        print('Is Provider verified : ${loginResponseModel.data.isVerified}');
        HealingMatchConstants.isActive = loginResponseModel.data.isActive;
        if (loginResponseModel.data.isVerified) {
          instances.setBool('isProviderLoggedIn', true);
          instances.setBool('isUserLoggedIn', false);
          firebaseChatLogin(userData, password);
        } else {
          HealingMatchConstants.fbUserid =
              loginResponseModel.data.phoneNumber.toString() +
                  loginResponseModel.data.id.toString() +
                  "@nexware.global.com";
          HealingMatchConstants.isLoginRoute = true;
          HealingMatchConstants.serviceProviderPassword = password;
          HealingMatchConstants.serviceProviderPhoneNumber = userPhoneNumber;
          hideLoader();
          Toast.show("アカウントが確認されていません。", context,
              duration: 4,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
          resendOtp(userData);
          print('Unverified User!!');
        }
      } else {
        print('Response Failure !!');
        hideLoader();
        return;
      }
    } catch (e) {
      print('Response Error !! ${e.toString()}');
      hideLoader();
      return;
    }
  }

  void firebaseChatLogin(Data userData, String password) {
    Auth()
        .signIn(
            userData.phoneNumber.toString() +
                userData.id.toString() +
                "@nexware.global.com",
            password)
        .then((value) {
      hideLoader();
      if (value) {
        NavigationRouter.switchToServiceProviderBottomBar(context);
      } else {
        hideLoader();
        return;
      }
    });
  }

  _initiateAppleSignIn() async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    var password;
    ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      if (appleUserId != null && appleUserId.isNotEmpty) {
        appleSNSLocalServcerSignIn(instances, password);
      } else {
        if (await SignInWithApple.isAvailable()) {
          try {
            var redirectURL = HealingMatchConstants.appleIDRedirectUrl;

            AuthorizationCredentialAppleID appleIdCredential =
                await SignInWithApple.getAppleIDCredential(
                    scopes: [
                  AppleIDAuthorizationScopes.email,
                  AppleIDAuthorizationScopes.fullName,
                ],
                    webAuthenticationOptions: WebAuthenticationOptions(
                        clientId: '', redirectUri: Uri.parse(redirectURL)));
            HealingMatchConstants.appleUserName = appleIdCredential.givenName;
            HealingMatchConstants.appleEmailId = appleIdCredential.email;
            HealingMatchConstants.appleTokenId =
                appleIdCredential.userIdentifier;
            appleUserId = appleIdCredential.userIdentifier;
            final oAuthProvider = OAuthProvider('apple.com');
            final credential = oAuthProvider.credential(
              idToken: appleIdCredential.identityToken,
              accessToken: appleIdCredential.authorizationCode,
            );
            FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
            final authResult =
                await _firebaseAuth.signInWithCredential(credential);
            if (appleIdCredential.givenName == null) {
              appleSNSLocalServcerSignIn(instances, password);
            } else {
              ProgressDialogBuilder.hideCommonProgressDialog(context);
              NavigationRouter.switchToServiceProviderFirstScreen(context);
            }
            print("Apple Sign in Success");
            return authResult.user;
          } on Exception catch (e) {
            ProgressDialogBuilder.hideCommonProgressDialog(context);
            print("Apple Sign in Exception : $e");
          }
        } else {
          print('Apple SignIn is not available for your device');
        }
      }
    } on Exception catch (e) {
      print("Apple Sign in Exception : $e");
    }
  }

  void appleSNSLocalServcerSignIn(SharedPreferences instances, password) {
    var snsAndApple = ServiceProviderApi.snsAndAppleLoginProvider(
        context, lineBotId, appleUserId, isTherapist, fcmToken);
    print('Hi snsLogin Provider');
    snsAndApple.then((value) {
      Data userData = value.data;
      if (userData != null) {
        instances.setString("userData", json.encode(userData));
        instances.setString("lineBotIdProvider", value.data.lineBotUserId);
        instances.setString("appleIdProvider", value.data.appleUserId);
        instances.setBool('isActive', value.data.isActive);
        instances.setString("accessToken", value.accessToken);
        print('Login response : ${value.toJson()}');
        print('Login token : ${value.accessToken}');
        print('Is Provider verified : ${value.data.isVerified}');
        HealingMatchConstants.isActive = value.data.isActive;
        if (value.data.isVerified) {
          instances.setBool('isProviderLoggedIn', true);
          instances.setBool('isUserLoggedIn', false);
          ProgressDialogBuilder.hideCommonProgressDialog(context);
          firebaseChatLogin(userData, password);
        } else {
          HealingMatchConstants.fbUserid = value.data.phoneNumber.toString() +
              value.data.id.toString() +
              "@nexware.global.com";
          HealingMatchConstants.isLoginRoute = true;
          HealingMatchConstants.serviceProviderPassword = password;
          HealingMatchConstants.serviceProviderPhoneNumber =
              value.data.phoneNumber.toString();
          hideLoader();
          Toast.show("アカウントが確認されていません。", context,
              duration: 4,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
          resendOtp(userData);
          print('Unverified User!!');
        }
      } else {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        NavigationRouter.switchToServiceProviderFirstScreen(context);
      }
    });
  }

  void _initiateLineLogin() async {
    showOverlayLoader();
    SharedPreferences instances = await SharedPreferences.getInstance();
    var password;
    print('Entering line login...');
    try {
      if (lineBotId != null && lineBotId.isNotEmpty) {
        var snsAndApple = ServiceProviderApi.snsAndAppleLoginProvider(
            context, lineBotId, appleUserId, isTherapist, fcmToken);
        print('Hi snsLogin Provider');
        snsAndApple.then((value) {
          Data userData = value.data;
          instances.setString("userData", json.encode(userData));
          instances.setBool('isActive', value.data.isActive);
          instances.setString("accessToken", value.accessToken);
          instances.setString("lineBotIdProvider", value.data.lineBotUserId);
          instances.setString("appleIdProvider", value.data.appleUserId);
          print('Login response : ${value.toJson()}');
          print('Login token : ${value.accessToken}');
          print('Is Provider verified : ${value.data.isVerified}');
          HealingMatchConstants.isActive = value.data.isActive;
          if (value.data.isVerified) {
            instances.setBool('isProviderLoggedIn', true);
            instances.setBool('isUserLoggedIn', false);
            firebaseChatLogin(userData, password);
          } else {
            HealingMatchConstants.fbUserid = value.data.phoneNumber.toString() +
                value.data.id.toString() +
                "@nexware.global.com";
            HealingMatchConstants.isLoginRoute = true;
            HealingMatchConstants.serviceProviderPassword = password;
            HealingMatchConstants.serviceProviderPhoneNumber =
                value.data.phoneNumber.toString();
            hideLoader();
            Toast.show("アカウントが確認されていません。", context,
                duration: 4,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
            resendOtp(userData);
            print('Unverified User!!');
          }
        });
      } else {
        hideLoader();
        LineLoginHelper.startLineLogin(context);
      }
    } catch (e) {
      print(e);
    }
  }

  resendOtp(Data userData) async {
    try {
      ProgressDialogBuilder.showForgetPasswordUserProgressDialog(context);
      final url = HealingMatchConstants.SEND_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(
              {"phoneNumber": userData.phoneNumber, "isTherapist": "1"}));
      print('Status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final sendVerify = json.decode(response.body);
        //reSendVerifyResponse = SendVerifyResponseModel.fromJson(sendVerify);

        ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
        NavigationRouter.switchToProviderOtpScreen(context);
        //     NavigationRouter.switchToUserChangePasswordScreen(context);
      } else {
        ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {
      ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
  }
}
