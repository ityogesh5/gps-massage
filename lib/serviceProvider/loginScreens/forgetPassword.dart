import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/changePassword.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'loginScreen.dart';

import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final phoneNumberController = new TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  List<String> forgetPasswordDetails = [];

  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;
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
            Navigator.pop(context,
                MaterialPageRoute(builder: (BuildContext context) => Login()));
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
                        'パスワードを再設定するための認証コードを\n送信しますので、ご登録の電話番号を入力の上\n「送信」ボタンをクリックしてください',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      focusNode: phoneNumberFocus,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
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
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          '送信',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          _providerForgetPasswordDetails();
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

  _providerForgetPasswordDetails() async {
    var userPhoneNumber = phoneNumberController.text.toString();

    // user phone number validation
    if (userPhoneNumber.length > 11 ||
        userPhoneNumber.length < 11 ||
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

    forgetPasswordDetails.add(userPhoneNumber);

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

    NavigationRouter.switchToProviderChangePasswordScreen(context);
  }
}
