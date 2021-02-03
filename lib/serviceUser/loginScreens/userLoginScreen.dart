import 'dart:convert';
import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/lineLoginHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/loginResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  /*List<Address> addressFromJson(String str) =>
      List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

  String addressToJson(List<Address> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  void saveData(String key, List<Address> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, addressToJson(value));
  }

  Future<List<Address>> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString(key);
    return Future.value(addressFromJson(keyString));
  }*/

  var loginResponseModel = new LoginResponseModel();
  var addressResponse = new Address();
  bool passwordVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  final passwordController = new TextEditingController();
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  List<Address> addressList = List<Address>();

//Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

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
                NavigationRouter.switchToServiceUserBottomBar(context);
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
                  maxLength: 10,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    border: HealingMatchConstants.textFormInputBorder,
                    focusedBorder: HealingMatchConstants.textFormInputBorder,
                    disabledBorder: HealingMatchConstants.textFormInputBorder,
                    enabledBorder: HealingMatchConstants.textFormInputBorder,
                    filled: true,
                    labelText: HealingMatchConstants.loginPhoneNumber,
                    labelStyle: TextStyle(color: Colors.grey),
                    fillColor: ColorConstants.formFieldFillColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                    // hintStyle:
                    //     TextStyle(color: Colors.grey, fontFamily: 'Oxygen'),
                    labelText: HealingMatchConstants.loginUserPassword,
                    labelStyle: TextStyle(color: Colors.grey),
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
                      onTap: () {
                        NavigationRouter.switchToUserForgetPasswordScreen(
                            context);
                        // NavigationRouter.switchToNearByProviderAndShop(context);
                      },
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
          NavigationRouter.switchToProviderLogin(context);
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

  _loginServiceUser() async {
    var userPhoneNumber = phoneNumberController.text.toString();
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
                  style: TextStyle(fontFamily: 'Oxygen')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'Oxygen',
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
                  style: TextStyle(fontFamily: 'Oxygen')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'Oxygen',
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
                  style: TextStyle(fontFamily: 'Oxygen')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'Oxygen',
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
              child: Text('正しい電話番号とパスワードを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'Oxygen')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'Oxygen',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    try {
      ProgressDialogBuilder.showLoginUserProgressDialog(context);

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
        // print('Login token : ${loginResponseModel.accessToken}');
        print('Login token : ${loginResponseModel.toJson()}');
        _sharedPreferences.then((value) {
          value.setString(
              'profileImage', loginResponseModel.data.uploadProfileImgUrl);
          value.setString('userName', loginResponseModel.data.userName);
          value.setString('userPhoneNumber',
              loginResponseModel.data.phoneNumber.toString());
          value.setString('userEmailAddress', loginResponseModel.data.email);
          value.setString('userDOB', loginResponseModel.data.dob.toString());
          value.setString('userAge', loginResponseModel.data.age.toString());
          value.setString('userGender', loginResponseModel.data.gender);
          value.setString(
              'userOccupation', loginResponseModel.data.userOccupation);
          value.setString(
              'userAddress', json.encode(loginResponseModel.data.addresses));
    /*       value.setString(
              'userAddressType', json.encode(loginResponseModel.data.addresses)); */
          // final Map addressRes = json.decode(response.body);
          // addressResponse = Address.fromJson(addressRes);

          // value.setString('userAddress', loginResponseModel.data.addresses);

        

          for (var address in loginResponseModel.data.addresses) {
            setState(() {
              addressList.add(address);

              // for (var i = 0; i < addressList.length; i++) {
              //   print(addressList[2]);
              // }
            });
          }
          HealingMatchConstants.addressList.addAll(addressList);

          print(loginResponseModel.data.userName);
          print(loginResponseModel.data.phoneNumber.toString());
          print(loginResponseModel.data.email);
          print(loginResponseModel.data.dob.toString());
          print(loginResponseModel.data.age.toString());
          print(loginResponseModel.data.gender);
          print(loginResponseModel.data.userOccupation);
          // print(addressList);
          // print(addressResponse.addressTypeSelection);

          //value.setString('userAddress', loginResponseModel.data.addresses);
        });

        ProgressDialogBuilder.hideLoginUserProgressDialog(context);
        NavigationRouter.switchToServiceUserBottomBar(context);
      } else {
        ProgressDialogBuilder.hideLoginUserProgressDialog(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {
      ProgressDialogBuilder.hideLoginUserProgressDialog(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
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
      LineLoginHelper.startLineLoginForUser(context);
    } catch (e) {
      print(e);
    }
  }
}
