import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/sendVerifyResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/changePasswordResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

class UserChangePassword extends StatefulWidget {
  @override
  _UserChangePasswordState createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  var changePassword = ChangePasswordResponseModel();
  var reSendVerifyResponse = SendVerifyResponseModel();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userOTP;
  TextEditingController pin = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _secureText = true;
  bool passwordConfirmVisibility = true;
  FocusNode pinCodeFoucs = FocusNode();
  FocusNode createPasswordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  double containerHeight = 48.0;

  List<String> changePasswordDetails = [];

  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    super.initState();
    userOTP = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "+81 ${HealingMatchConstants.userPhnNum} " +
                            HealingMatchConstants.changePasswordTxt,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'NotoSansJP'),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.all(8.0),
                      /*     padding: const EdgeInsets.only(bottom: 8.0), */
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              0.3,
                              1
                            ],
                            colors: [
                              ColorConstants.formFieldFillColor,
                              ColorConstants.formFieldFillColor,
                            ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: PinCodeTextField(
                          backgroundColor: ColorConstants.formFieldFillColor,
                          //controller: pin,
                          textInputAction: TextInputAction.next,
                          //focusNode: pinCodeFoucs,
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 4,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          onSubmitted: (pin) {
                            print("Completed: " + pin);
                            userOTP = pin;
                          },
                          onChanged: (val) {},
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            userOTP = pin;
                          },
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'NotoSansJP',
                          ),
                          enableActiveFill: true,
                          pinTheme: PinTheme(
                              fieldHeight: 40.0,
                              borderRadius: BorderRadius.circular(10.0),
                              selectedFillColor: Colors.transparent,
                              selectedColor: Colors.black,
                              inactiveFillColor: Colors.transparent,
                              inactiveColor: Colors.black,
                              activeColor: Colors.black,
                              fieldWidth: 50.0,
                              activeFillColor: Colors.transparent,
                              shape: PinCodeFieldShape.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: containerHeight,
                      child: TextFormField(
                        obscureText: _secureText,
                        textInputAction: TextInputAction.next,
                        focusNode: createPasswordFocus,
                        maxLength: 16,
                        controller: createPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        style: HealingMatchConstants.formTextStyle,
                        decoration: new InputDecoration(
                          counterText: "",
                          border: HealingMatchConstants.textFormInputBorder,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          disabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          suffixIcon: IconButton(
                              icon: _secureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              }),
                          filled: true,
                          labelText:
                              HealingMatchConstants.changePasswordNewpass,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          fillColor: ColorConstants.formFieldFillColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: containerHeight,
                      child: TextFormField(
                        obscureText: passwordConfirmVisibility,
                        textInputAction: TextInputAction.done,
                        focusNode: confirmPasswordFocus,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        style: HealingMatchConstants.formTextStyle,
                        maxLength: 16,
                        decoration: new InputDecoration(
                          counterText: "",
                          border: HealingMatchConstants.textFormInputBorder,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          disabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          suffixIcon: IconButton(
                              icon: passwordConfirmVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordConfirmVisibility =
                                      !passwordConfirmVisibility;
                                });
                              }),
                          filled: true,
                          labelText:
                              HealingMatchConstants.changePasswordConfirmpass,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          fillColor: ColorConstants.formFieldFillColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: RaisedButton(
                        child: Text(
                          HealingMatchConstants.changePasswordBtn,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSansJP',
                              fontSize: 20),
                        ),
                        color: Color.fromRGBO(200, 217, 33, 1),
                        onPressed: () {
                          _userChangePasswordDetails();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      /*   onTap: () {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            backgroundColor: ColorConstants.snackBarColor,
                            content: Text('認証コードが正常に送信されました。 ',
                                style: TextStyle(fontFamily: 'NotoSansJP')),
                            action: SnackBarAction(
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      .hideCurrentSnackBar();
                                },
                                label: 'はい',
                                textColor: Colors.white),
                          ));
                        },*/
                      child: Text(
                        HealingMatchConstants.changeResendOtp,
                        style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: resendOtp,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _userChangePasswordDetails() async {
    //var pinCode = pinCodeText.text.toString();
    var pinCode = userOTP;
    var password = createPasswordController.text.toString();
    var confirmPassword = confirmPasswordController.text.toString();

    // OTP validation
    if (pinCode == null || pinCode.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('認証コード入力は必須項目なので入力してください。',
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

    if (pinCode.length < 4) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('認証コードと一致しませんのでもう一度お試しください。',
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
              child: Text('パスワードは必須項目なので入力してください。',
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

    if (password.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは8文字以上で入力してください。  ',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.length > 16) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードは16文字以内で入力してください。',
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

    // Combination password

    /*if (!passwordRegex.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードには、大文字、小文字、数字、特殊文字を1つ含める必要があります。',
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
    }*/

    if (password.contains(regexEmojis)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('有効な文字でパスワードを入力してください。',
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

    //Confirm Password Validation
    if (confirmPassword == null || confirmPassword.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワード(確認用)を入力してください。',
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

    if (password != confirmPassword) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードが一致がしませんのでもう一度お試しください。',
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
      ProgressDialogBuilder.showChangePasswordUserProgressDialog(context);
      final url = HealingMatchConstants.CHANGE_PASSWORD_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.userPhnNum,
            "otp": pinCode,
            "password": password,
            "password_confirmation": confirmPassword,
            "isTherapist": "0"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isChangePasswordUser(
          response.statusCode, context, response.body)) {
        final changepass = json.decode(response.body);
        changePassword = ChangePasswordResponseModel.fromJson(changepass);
        ProgressDialogBuilder.hideChangePasswordUserProgressDialog(context);
        DialogHelper.showPasswordResetSuccessDialog(context);
      } else {
        ProgressDialogBuilder.hideChangePasswordUserProgressDialog(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {
      ProgressDialogBuilder.hideChangePasswordUserProgressDialog(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
    changePasswordDetails.add(pinCode);
    changePasswordDetails.add(password);
    changePasswordDetails.add(confirmPassword);

    print('User details length in array : ${changePasswordDetails.length}');

    /*  final url = '';
    http.post(url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${'token'}"
        },
        body: json.encode({
          "serviceUserDetails": changePasswordDetails,
        })); */
  }

  resendOtp() async {
    try {
      ProgressDialogBuilder.showForgetPasswordUserProgressDialog(context);
      final url = HealingMatchConstants.SEND_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.userPhnNum,
            "isTherapist": "0"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isSendVerify(
          response.statusCode, context, response.body)) {
        final sendVerify = json.decode(response.body);
        reSendVerifyResponse = SendVerifyResponseModel.fromJson(sendVerify);

        ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
    //    NavigationRouter.switchToUserChangePasswordScreen(context);
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
