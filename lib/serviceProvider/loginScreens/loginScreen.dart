import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/bottomBar.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/forgetPassword.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSecondScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5,
                    right: MediaQuery.of(context).size.width / 25,
                    left: MediaQuery.of(context).size.width / 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/logo.svg',
                            height: 100, width: 140),
                        Padding(
                          padding: EdgeInsets.all(20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('セラピストのログイン',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
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
                      height: 20,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
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
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "パスワード",
                          fillColor: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgetPassword()));
                          },
                          child: Text(
                            'パスワードを忘れた方はこちら',
                            style: TextStyle(
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
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          'パスワード',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage()));
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
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              // height: 50,
                              color: Colors.black,
                            )),
                      ),
                      Text("または"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              // height: 50,
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
                              /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePage()));*/
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black12,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/line.jpg'),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black12,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/apple2.jpg'),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterFirstScreen()));
                      },
                      child: Text(
                        '新規の方はこちら',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResetPassword()));*/
                          },
                          child: Text(
                            'サービス利用者のログイン',
                            style: TextStyle(
//                            decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
//              Align(alignment: Alignment.bottomCenter, child: Text('weyfgfgb')),
            ],
          ),
        ),
      ),
    );
  }
}
