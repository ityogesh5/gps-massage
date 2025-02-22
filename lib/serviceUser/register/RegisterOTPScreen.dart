import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/sendVerifyResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/verifyOtp.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
//final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

class RegisterOtpScreen extends StatefulWidget {
  @override
  _RegisterOtpScreenState createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  var reSendVerifyResponse = SendVerifyResponseModel();
  String userOTP;
  TextEditingController pin = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var UserVerifyOtp = VerifyOtpModel();
  var phoneNumber;

  void initState() {
    super.initState();
    //getUserPhoneNumber();
    setUserVerifyStatus(HealingMatchConstants.isUserVerified);
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
            HealingMatchConstants.isLoginRoute = false;
            NavigationRouter.switchToUserLogin(context);
            // Navigator.pop(context);
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
          autovalidateMode: AutovalidateMode.disabled,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        "+81 ${HealingMatchConstants.serviceUserPhoneNumber} " +
                            HealingMatchConstants.serviceUserOtpTxt,
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
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        child: Text(
                          HealingMatchConstants.serviceUserOtpBtn,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          verifyOtp();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      child: InkWell(
                        onTap: () {
                          resendOtp();
                        },
                        child: Text(
                          HealingMatchConstants.serviceResendOtpTxt,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
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

  verifyOtp() async {
    var pinCode = userOTP;

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
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final url = HealingMatchConstants.CHANGE_PASSWORD_VERIFY_OTP_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.serviceUserPhoneNumber,
            "otp": pinCode,
            "isTherapist": "0"
          }));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isVerifyOtpUserUser(
          response.statusCode, context, response.body)) {
        final vrfyOtp = json.decode(response.body);
        UserVerifyOtp = VerifyOtpModel.fromJson(vrfyOtp);
        if (HealingMatchConstants.isLoginRoute) {
          sharedPreferences.setBool('isUserLoggedIn', true);
          sharedPreferences.setBool('userLoginSkipped', false);
          sharedPreferences.setBool('isProviderLoggedIn', false);
          firebaseChatLogin();
        } else {
          HealingMatchConstants.isLoginRoute = false;
          ProgressDialogBuilder.hideLoader(context);
          HealingMatchConstants.isUserVerified = true;
          setUserVerifyStatus(HealingMatchConstants.isUserVerified);
          DialogHelper.showRegisterSuccessDialog(context);
        }
      } else {
        setUserVerifyStatus(HealingMatchConstants.isUserVerified);
        ProgressDialogBuilder.hideLoader(context);
        print('Response Failure !!');
        return;
      }
    } catch (e) {
      setUserVerifyStatus(HealingMatchConstants.isUserVerified);
      ProgressDialogBuilder.hideLoader(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
  }

  resendOtp() async {
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      final url = HealingMatchConstants.SEND_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "phoneNumber": HealingMatchConstants.serviceUserPhoneNumber,
            "isTherapist": "0"
          }));
      print('Status code : ${response.statusCode}');
      print('responseResend : ${response.body}');
      if (StatusCodeHelper.isSendVerify(
          response.statusCode, context, response.body)) {
        final sendVerify = json.decode(response.body);
        reSendVerifyResponse = SendVerifyResponseModel.fromJson(sendVerify);

        ProgressDialogBuilder.hideLoader(context);
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

  void firebaseChatLogin() {
    Auth()
        .signIn(HealingMatchConstants.fbUserid,
            HealingMatchConstants.serviceUserPhoneNumber)
        .then((value) {
      if (value) {
        HealingMatchConstants.isLoginRoute = false;
        ProgressDialogBuilder.hideLoader(context);
        HealingMatchConstants.isUserVerified = true;
        setUserVerifyStatus(HealingMatchConstants.isUserVerified);
        DialogHelper.showRegisterSuccessDialog(context);
      } else {
        ProgressDialogBuilder.hideLoader(context);
      }
    });
  }

  void getUserPhoneNumber() async {
    /*_sharedPreferences.then((value) {
      HealingMatchConstants.serviceUserPhoneNumber =
          value.getString('userPhoneNumber');
      debugPrint(
          'user phone number : ${HealingMatchConstants.serviceUserPhoneNumber}');
    });*/
  }

  void setUserVerifyStatus(bool isUserVerified) async {
    _sharedPreferences.then((value) {
      var userVerifyStatus = value.setBool('userVerifyStatus', isUserVerified);
      debugPrint('user verified : $userVerifyStatus');
    });
  }
}
