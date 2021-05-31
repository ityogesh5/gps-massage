import 'dart:convert';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/lineLoginHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/loginResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var loginResponseModel = new LoginResponseModel();
  var addressResponse = new Address();
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  List<Address> addressList = List<Address>();
  var phnNum;
  final fireBaseMessaging = new FirebaseMessaging();
  var fcmToken = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User firebaseUser;

//Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Placemark userAddedAddressPlaceMark;
  Position _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                HealingMatchConstants.isUserRegistrationSkipped = true;
                _getFCMToken();
              },
              child: Text(
                HealingMatchConstants.loginUserSkipText,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP',
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
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 20,
                            fontFamily: 'NotoSansJP',
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  style: HealingMatchConstants.formTextStyle,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    border: HealingMatchConstants.textFormInputBorder,
                    focusedBorder: HealingMatchConstants.textFormInputBorder,
                    disabledBorder: HealingMatchConstants.textFormInputBorder,
                    enabledBorder: HealingMatchConstants.textFormInputBorder,
                    filled: true,
                    labelText: HealingMatchConstants.loginPhoneNumber,
                    labelStyle: HealingMatchConstants.formLabelTextStyle,
                    fillColor: ColorConstants.formFieldFillColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  style: HealingMatchConstants.formTextStyle,
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
                    // hintStyle:
                    //     TextStyle(color: Colors.grey, fontFamily: 'NotoSansJP'),
                    labelText: HealingMatchConstants.loginUserPassword,
                    labelStyle: HealingMatchConstants.formLabelTextStyle,
                    fillColor: ColorConstants.formFieldFillColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationRouter.switchToUserForgetPasswordScreen(
                            context);
                        // NavigationRouter.switchToNearByProviderAndShop(context);
                      },
                      child: Text(
                        '${HealingMatchConstants.loginUserForgetPassword}',
                        style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'NotoSansJP'
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
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'NotoSansJP',
                          fontSize: 18),
                    ),
                    color: Color.fromRGBO(200, 217, 33, 1),
                    onPressed: () {
                      _loginServiceUser();
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
                          color: Color.fromRGBO(225, 225, 225, 1),
                        )),
                  ),
                  Text(
                    "または",
                    style: TextStyle(
                      color: Color.fromRGBO(225, 225, 225, 1),
                    ),
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Color.fromRGBO(225, 225, 225, 1),
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
                          _initiateLineLogin();
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
                                  width: 20.0,
                                  height: 20,
                                  margin: EdgeInsets.all(8.0),
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
                  onTap: () {
                    NavigationRouter.switchToServiceUserRegistration(context);
                  },
                  child: Text(
                    HealingMatchConstants.loginUserNewRegistrationText,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        decoration: TextDecoration.underline,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.bold),
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
          NavigationRouter.switchToProviderInitialTutorialScreen(context);
          /*    NavigationRouter.switchToProviderLogin(context); */
        },
        child: Center(
          child: Text(
            HealingMatchConstants.loginServiceProvider,
            style: TextStyle(
                color: Color.fromRGBO(102, 102, 102, 1),
                fontFamily: 'NotoSansJP'
//                            decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }

  _loginServiceUser() async {
    var userPhoneNumber = phoneNumberController.text.toString();
    // var editedPhone = userPhoneNumber.replaceFirst(RegExp(r'^0+'), "");
    //print('phnNumber: ${editedPhone}');
    var password = passwordController.text.toString();

    // user phone number and password null check validation
    if ((userPhoneNumber == null || userPhoneNumber.isEmpty) &&
        (password == null || password.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('電話番号とパスワードを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // user phone number validation
    if (userPhoneNumber.length > 10 ||
        userPhoneNumber.length < 10 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('正しい電話番号とパスワードを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    if (password == null || password.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    if (password.length < 8 || password.length > 16) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('正しいパスワードを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    try {
      ProgressDialogBuilder.showOverlayLoader(context);

      final url = HealingMatchConstants.LOGIN_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": userPhoneNumber,
            "password": password,
            "isTherapist": "0"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isLoginSuccess(
          response.statusCode, context, response.body)) {
        print('Response Success');
        final Map loginResponse = json.decode(response.body);
        loginResponseModel = LoginResponseModel.fromJson(loginResponse);
        // print('Login response : ${loginResponseModel.toJson()}');
        print('Login token : ${loginResponseModel.accessToken}');
        print('Login Response : ${loginResponseModel.toJson()}');
        print('response:${response.body}');
        _sharedPreferences.then((value) {
          value.clear();
          value.setString('accessToken', loginResponseModel.accessToken);
          value.setString('did', loginResponseModel.data.id.toString());
          value.setString(
              'profileImage', loginResponseModel.data.uploadProfileImgUrl);
          value.setString('userName', loginResponseModel.data.userName);
          value.setString('userPhoneNumber',
              loginResponseModel.data.phoneNumber.toString());
          value.setString('userEmailAddress', loginResponseModel.data.email);
          value.setString(
              'userDOB',
              DateFormat("yyyy-MM-dd")
                  .format(loginResponseModel.data.dob)
                  .toString()
                  .toString());
          value.setString('userAge', loginResponseModel.data.age.toString());
          value.setString('userGender', loginResponseModel.data.gender);
          value.setString(
              'userOccupation', loginResponseModel.data.userOccupation);
          value.setString('deviceToken', loginResponseModel.data.fcmToken);
          /* value.setString(
              'userAddress', json.encode(loginResponseModel.data.addresses));*/

          print('DOB of user : ${loginResponseModel.data.dob.toString()}');
          for (var userAddressData in loginResponseModel.data.addresses) {
            print('Address of user : ${userAddressData.toJson()}');
            print(
                'Address of user : ${loginResponseModel.data.addresses.length}');
            value.setString('userAddress', userAddressData.address);
            value.setString('buildingName', userAddressData.buildingName);
            value.setString('roomNumber', userAddressData.userRoomNumber);
            value.setString('area', userAddressData.area);
            value.setString(
                'addressType', userAddressData.addressTypeSelection);
            value.setString('addressID', userAddressData.id.toString());
            value.setString('userID', userAddressData.userId.toString());
            value.setString(
                'userPlaceForMassage', userAddressData.userPlaceForMassage);
            value.setString('otherOption', userAddressData.otherAddressType);
            value.setString('cityName', userAddressData.cityName);
            value.setString(
                'capitalAndPrefecture', userAddressData.capitalAndPrefecture);
            value.setBool('isUserLoggedIn', true);
            value.setBool('userLoginSkipped', false);
            value.setBool('isProviderLoggedIn', false);

            print(
                'Address place : ${userAddressData.userPlaceForMassage} : ${userAddressData.otherAddressType}');
          }

          print('ID: ${loginResponseModel.data.id}');
          print(loginResponseModel.data.userName);
          print(loginResponseModel.data.phoneNumber.toString());
          print(loginResponseModel.data.email);
          print(DateFormat("yyyy-MM-dd")
              .format(loginResponseModel.data.dob)
              .toString()
              .toString());
          print(loginResponseModel.data.age.toString());
          print(loginResponseModel.data.gender);
          print(loginResponseModel.data.userOccupation);
        });
        print('Is User verified : ${loginResponseModel.data.isVerified}');
        HealingMatchConstants.isUserRegistrationSkipped = false;
        if (loginResponseModel.data.isVerified) {
          firebaseChatLogin(loginResponseModel.data, password);
        } else {
          ProgressDialogBuilder.hideLoader(context);
          Toast.show("許可されていないユーザー。", context,
              duration: 4,
              gravity: Toast.CENTER,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
          print('Unverified User!!');
          return;
        }
      } else {
        ProgressDialogBuilder.hideLoader(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Response catch error : ${e.toString()}');
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
      ProgressDialogBuilder.hideLoader(context);
      if (value) {
        NavigationRouter.switchToServiceUserBottomBar(context);
      }
    });
  }

  _initiateAppleSignIn() async {
    if (await AppleSignIn.isAvailable()) {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          print("user credentials : ${result.credential.user}");
          print(result.credential.authorizationCode);
          print(result.credential.authorizedScopes);
          print(result.credential.email);
          print(result.credential.fullName);
          print(result.credential.identityToken);
          print(result.credential.realUserStatus);
          print(result.credential.state);
          print(result.credential.user); //All the required credentials
          break;
        case AuthorizationStatus.error:
          print("Sign in failed: ${result.error.localizedDescription}");
          break;
        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    } else {
      print('Apple SignIn is not available for your device');
    }
  }

  void _initiateLineLogin() async {
    print('Entering line login...');
    try {
      LineLoginHelper.startLineLogin(context);
    } catch (e) {
      print(e);
    }
  }

  _getFCMToken() async {
    fireBaseMessaging.getToken().then((fcmTokenValue) {
      if (fcmTokenValue != null) {
        fcmToken = fcmTokenValue;
        print('FCM Skip Token : $fcmToken');
        _getCurrentLocation();
      } else {
        fireBaseMessaging.onTokenRefresh.listen((refreshToken) {
          if (refreshToken != null) {
            fcmToken = refreshToken;
            print('FCM Skip Refresh Tokens : $fcmToken');
          }
        }).onError((handleError) {
          print('On FCM Skip Token Refresh error : ${handleError.toString()}');
        });
      }
    }).catchError((onError) {
      print('FCM Skip Token Exception : ${onError.toString()}');
    });
  }

  _getGuestUserAccessToken() async {
    var isTherapistValue = 0;
    try {
      ServiceUserAPIProvider.handleGuestUser(isTherapistValue)
          .then((guestUserResponse) {
        if (guestUserResponse != null) {
          _sharedPreferences.then((value) {
            value.setString('accessToken', guestUserResponse.accessToken);
          });
          ProgressDialogBuilder.hideLoader(context);
          NavigationRouter.switchToServiceUserBottomBar(context);
        } else {
          ProgressDialogBuilder.hideLoader(context);
          print('Guest user response has no value !!');
        }
      }).catchError((onError) {
        ProgressDialogBuilder.hideLoader(context);
        print('Catch error guest user : ${onError.toString()}');
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Skip exception : ${e.toString()}');
    }
  }

  // Get current address from Latitude Longitude
  _getCurrentLocation() async {
    ProgressDialogBuilder.showOverlayLoader(context);
    bool isGPSEnabled = await geoLocator.isLocationServiceEnabled();
    print('GPS Enabled : $isGPSEnabled');
    if (HealingMatchConstants.isUserRegistrationSkipped && !isGPSEnabled) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('GPSを有効にしてさらに進んでください！',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      ProgressDialogBuilder.hideLoader(context);
      return;
    } else {
      print('Guest User GPS Enabled : $isGPSEnabled');
      geoLocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        _currentPosition = position;
        print(
            'Current latLong Guest user : ${_currentPosition.latitude} && \n${_currentPosition.longitude}');
        HealingMatchConstants.currentLatitude = _currentPosition.latitude;
        HealingMatchConstants.currentLongitude = _currentPosition.longitude;
        _getGuestUserAccessToken();
      }).catchError((e) {
        print('Current Location exception : ${e.toString()}');
      });
    }
  }
}
