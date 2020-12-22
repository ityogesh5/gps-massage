import 'package:flutter/material.dart';

import 'OTPScreen/otp_field.dart';
import 'OTPScreen/style.dart';
import 'forgetPassword.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "+81****に届いた認証コード及び\n 新しいパスワードを入力し、「パスワードを\n 再設定する」ボタンをクリックしてください。",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
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
                              ] 
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
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
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.0,
                            ),
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
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "新しいパスワード *",
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
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.0,
                            ),
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
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "新しいパスワード(確認) *",
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
                          'パスワードを再設定する',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChangePassword()));
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
                          '認証コードを再送する',
                          style: TextStyle(),
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
}
