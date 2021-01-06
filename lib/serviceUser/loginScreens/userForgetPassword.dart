import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userChangePassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userLoginScreen.dart';

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
                        HealingMatchConstants.forgetPasswordTxt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
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
                          contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          labelText: HealingMatchConstants.forgetPasswordPhn,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: HealingMatchConstants.forgetPasswordPhn,
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

    // user phone number validation
    if (userPhoneNumber.length > 11 ||
        userPhoneNumber.length < 11 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('11文字の電話番号を入力してください。',
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

    NavigationRouter.switchToUserChangePasswordScreen(context);
  }
}
