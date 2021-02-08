import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/sendVerifyResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userLoginScreen.dart';
import 'package:http/http.dart' as http;

class UserForgetPassword extends StatefulWidget {
  @override
  _UserForgetPasswordState createState() => _UserForgetPasswordState();
}

class _UserForgetPasswordState extends State<UserForgetPassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  List<String> forgetPasswordDetails = [];
  var sendVerifyResponse = new SendVerifyResponseModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                    builder: (BuildContext context) => UserLogin()));
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: formKey,
          autovalidate: autoValidate,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        HealingMatchConstants.userPasswordTxt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Oxygen',
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      maxLength: 10,
                      textInputAction: TextInputAction.done,
                      focusNode: phoneNumberFocus,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        border: HealingMatchConstants.textFormInputBorder,
                        focusedBorder:
                            HealingMatchConstants.textFormInputBorder,
                        disabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        enabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        filled: true,
                        labelText: HealingMatchConstants.userPasswordPhn,
                        /* hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Oxygen',
                            fontSize: 13),
                        hintText: HealingMatchConstants.forgetPasswordPhn,*/
                        fillColor: ColorConstants.formFieldFillColor,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          HealingMatchConstants.userForgetPassBtn,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oxygen',
                              fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          _userForgetPasswordDetails();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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

  _userForgetPasswordDetails() async {
    var userPhoneNumber = phoneNumberController.text.toString();
    HealingMatchConstants.userPhnNum = phoneNumberController.text.toString();
    // user phone number
    if ((userPhoneNumber == null || userPhoneNumber.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          children: [
            Flexible(
              child: Text('正しい電話番号を入力してください。',
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
              child: Text('正しい電話番号を入力してください。',
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
    forgetPasswordDetails.add(userPhoneNumber);
    try {
      ProgressDialogBuilder.showForgetPasswordUserProgressDialog(context);
      final url = HealingMatchConstants.SEND_VERIFY_USER_URL;
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json
              .encode({"phoneNumber": userPhoneNumber, "isTherapist": "0"}));
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isSendVerify(
          response.statusCode, context, response.body)) {
        final sendVerify = json.decode(response.body);
        sendVerifyResponse = SendVerifyResponseModel.fromJson(sendVerify);

        ProgressDialogBuilder.hideForgetPasswordUserProgressDialog(context);
        NavigationRouter.switchToUserChangePasswordScreen(context);
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

    print('User details length in array : ${forgetPasswordDetails.length}');

    /*   final url = '';
    http.post(url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${'token'}"
        },
        body: json.encode({
          "serviceUserDetails": forgetPasswordDetails,
        })); */
  }
}
