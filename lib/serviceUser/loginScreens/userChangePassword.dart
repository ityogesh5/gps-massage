import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/OTPScreen/otp_field.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/OTPScreen/style.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userForgetPassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userLoginScreen.dart';

class UserChangePassword extends StatefulWidget {
  @override
  _UserChangePasswordState createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userOTP;
  TextEditingController pin = TextEditingController();
  TextEditingController createPassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool createPasswordVisibility = true;
  bool confirmPasswordVisibility = true;
  FocusNode pinCodeFoucs = FocusNode();
  FocusNode createPasswordFocus = FocusNode();
  FocusNode confrimPasswordFocus = FocusNode();

  List<String> changePasswordDetails = [];

  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

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
            NavigationRouter.switchToUserLogin(context);
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
                        HealingMatchConstants.changePasswordTxt,
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
                              Colors.grey[200],
                              Colors.grey[200],
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
                      maxLength: 14,
                      controller: createPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                          labelText:
                              HealingMatchConstants.changePasswordNewpass,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          hintText: HealingMatchConstants.changePasswordNewpass,
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: confirmPasswordVisibility,
                      textInputAction: TextInputAction.done,
                      focusNode: confrimPasswordFocus,
                      controller: confirmpassword,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 14,
                      decoration: new InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          labelText:
                              HealingMatchConstants.changePasswordConfirmpass,
                          hintText:
                              HealingMatchConstants.changePasswordConfirmpass,
                          fillColor: Colors.grey[200]),
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
                          _providerChangePasswordDetails();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          HealingMatchConstants.changeResendOtp,
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

  _providerChangePasswordDetails() async {
    //var pinCode = pinCodeText.text.toString();
    var pinCode = userOTP;
    var password = createPassword.text.toString();
    var confirmPassword = confirmpassword.text.toString();

    // user phone number validation
    if (pinCode.length < 4 || pinCode == null || pinCode.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('4文字以上の電話番号を入力してください。',
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

    if (password.length < 8 || confirmPassword.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは8文字以上で入力してください。  ',
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

    if (password.length > 14 || confirmPassword.length > 14) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは15文字以内で入力してください。 ',
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

    // Combination password

    if (!passwordRegex.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードには、大文字、小文字、数字、特殊文字を1つ含める必要があります。'),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password != confirmPassword) {
      //print("Entering password state");
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードと確認パスワードの入力が一致しません。',
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
    if (password.contains(regexEmojis)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な文字でパスワードを入力してください。',
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

    changePasswordDetails.add(pinCode);
    changePasswordDetails.add(password);
    changePasswordDetails.add(confirmPassword);

    print('User details length in array : ${changePasswordDetails.length}');

    NavigationRouter.switchToUserLogin(context);

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
}
