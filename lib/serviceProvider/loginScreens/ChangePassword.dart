import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/changePasswordProviderResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/sendVerifyResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;

import 'OTPScreen/otp_field.dart';
import 'OTPScreen/style.dart';
import 'ForgetPassword.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var reSendVerifyResponse = SendVerifyResponseModel();
  String userOTP;
  TextEditingController pinCodeText = TextEditingController();
  TextEditingController createPassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool createPasswordVisibility = true;
  bool confirmPasswordVisibility = true;
  FocusNode pinCodeFoucs = FocusNode();
  FocusNode createPasswordFocus = FocusNode();
  FocusNode confrimPasswordFocus = FocusNode();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var changePassword = ChangePasswordProviderResponseModel();
  List<String> changePasswordDetails = [];

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

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
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ForgetPassword()));
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
                        "+81 ${HealingMatchConstants.ProviderPhnNum} " +
                            HealingMatchConstants.changePasswordTxt,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
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
                      child: OTPTextField(
                        length: 4,
                        keyboardType: TextInputType.number,
                        width: MediaQuery.of(context).size.width,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textFieldAlignment: MainAxisAlignment.spaceEvenly,
                        fieldStyle: FieldStyle.underline,
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          userOTP = pin;
                          pinCodeText.text = pin;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      obscureText: createPasswordVisibility,
                      textInputAction: TextInputAction.next,
                      focusNode: createPasswordFocus,
                      maxLength: 16,
                      controller: createPassword,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        counterText: "",
                        border: HealingMatchConstants.textFormInputBorder,
                        focusedBorder:
                            HealingMatchConstants.textFormInputBorder,
                        disabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        enabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        suffixIcon: IconButton(
                            icon: createPasswordVisibility
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                createPasswordVisibility =
                                    !createPasswordVisibility;
                              });
                            }),
                        filled: true,
                        labelText: HealingMatchConstants.changePasswordNewpass,
                        fillColor: ColorConstants.formFieldFillColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: confirmPasswordVisibility,
                      textInputAction: TextInputAction.done,
                      focusNode: confrimPasswordFocus,
                      controller: confirmpassword,
                      maxLength: 16,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        counterText: "",
                        border: HealingMatchConstants.textFormInputBorder,
                        focusedBorder:
                            HealingMatchConstants.textFormInputBorder,
                        disabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        enabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        suffixIcon: IconButton(
                            icon: confirmPasswordVisibility
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                confirmPasswordVisibility =
                                    !confirmPasswordVisibility;
                              });
                            }),
                        filled: true,
                        labelText:
                            HealingMatchConstants.changePasswordConfirmpass,
                        fillColor: ColorConstants.formFieldFillColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          HealingMatchConstants.changePasswordBtn,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          //!Changed for Dev Purpose
                          _providerChangePasswordDetails();
                          // DialogHelper.showPasswordResetSuccessDialog(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      child: Text(
                        HealingMatchConstants.changeResendOtp,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                      onTap: resendOtp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _providerChangePasswordDetails() async {
    //var pinCode = pinCodeText.text.toString();
    var pinCode = userOTP;
    var password = createPassword.text.toString();
    var confirmPassword = confirmpassword.text.toString();

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
              child: Text('パスワードは必須項目なので入力してください。',
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

    if (password.length < 8 || confirmPassword.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは8文字以上で入力してください。  ',
            style: TextStyle(fontFamily: 'Oxygen')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.length > 16 || confirmPassword.length > 16) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードは16文字以内で入力してください。',
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

    // Combination password

    if (!passwordRegex.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワードには、大文字、小文字、数字、特殊文字を1つ含める必要があります。',
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

    //Confirm Password Validation
    if (confirmPassword == null || confirmPassword.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('パスワード再確認は必須項目なので入力してください。',
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
      ProgressDialogBuilder.showChangePasswordUserProgressDialog(context);
      final url = HealingMatchConstants.CHANGE_PASSWORD_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.ProviderPhnNum,
            "otp": pinCode,
            "password": password,
            "password_confirmation": confirmPassword,
            "isTherapist": "1"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isChangePasswordUser(
          response.statusCode, context, response.body)) {
        final changepass = json.decode(response.body);
        changePassword =
            ChangePasswordProviderResponseModel.fromJson(changepass);
        ProgressDialogBuilder.hideChangePasswordUserProgressDialog(context);
        DialogHelper.showPasswordProviderResetSuccessDialog(context);
      } else {
        ProgressDialogBuilder.hideChangePasswordUserProgressDialog(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {}
    changePasswordDetails.add(pinCode);
    changePasswordDetails.add(password);
    changePasswordDetails.add(confirmPassword);

    print('User details length in array : ${changePasswordDetails.length}');
  }

  resendOtp() async {
    try {
      ProgressDialogBuilder.showForgetPasswordUserProgressDialog(context);
      final url = HealingMatchConstants.SEND_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.ProviderPhnNum,
            "isTherapist": "1"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isSendVerify(
          response.statusCode, context, response.body)) {
        final sendVerify = json.decode(response.body);
        reSendVerifyResponse = SendVerifyResponseModel.fromJson(sendVerify);

        ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
        // NavigationRouter.switchToProviderChangePasswordScreen(context);
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
