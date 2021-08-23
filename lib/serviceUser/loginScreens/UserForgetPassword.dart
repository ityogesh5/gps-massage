import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/keyboardDoneButton/keyboardActionConfig.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/login/sendVerifyResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserLoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_actions/keyboard_actions.dart';

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
      body: KeyboardActions(
        config: KeyboardCustomActions().buildConfig(context, phoneNumberFocus),
        child: GestureDetector(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          HealingMatchConstants.userPasswordTxt1,
                          style: TextStyle(
                              fontFamily: 'NotoSansJP',
                              color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          HealingMatchConstants.userPasswordTxt2,
                          style: TextStyle(
                              fontFamily: 'NotoSansJP',
                              color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          HealingMatchConstants.userPasswordTxt3,
                          style: TextStyle(
                              fontFamily: 'NotoSansJP',
                              color: Color.fromRGBO(102, 102, 102, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        maxLength: 11,
                        textInputAction: TextInputAction.done,
                        style: HealingMatchConstants.formTextStyle,
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
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          /* hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NotoSansJP',
                              fontSize: 13),
                          hintText: HealingMatchConstants.forgetPasswordPhn,*/
                          fillColor: ColorConstants.formFieldFillColor,
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Container(
                        width: double.infinity,
                        height: 41,
                        child: RaisedButton(
                          child: Text(
                            HealingMatchConstants.userForgetPassBtn,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansJP',
                                fontSize: 20),
                          ),
                          color: Color.fromRGBO(200, 217, 33, 1),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
        content: Text('正しい電話番号を入力してください。',
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

    // user phone number validation
    if (userPhoneNumber.length > 11 ||
        userPhoneNumber.length < 10 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('正しい電話番号を入力してください。',
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
  }
}
