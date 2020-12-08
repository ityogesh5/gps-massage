import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/OTPScreen/style.dart';

import 'otp_field.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  GlobalKey<ScaffoldState> _toastKey = new GlobalKey<ScaffoldState>();
  String userOTP;
  bool register = true;

  String _email = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _toastKey = GlobalKey();

    //progressStyle();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Scaffold(
              key: _toastKey,
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(0, 214, 255, 1),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 150, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$_email に届いた【認証コード】を入力し、確認ボタンをクリックしてください。",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 12.0,
                                    ),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromRGBO(0, 255, 247, 1),
                                              Color.fromRGBO(0, 187, 255, 1),
                                            ]),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 400,
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
                                                    Colors.white,
                                                    Colors.white,
                                                  ]),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: OTPTextField(
                                              length: 6,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              textFieldAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              fieldStyle: FieldStyle.underline,
                                              onCompleted: (pin) {
                                                print("Completed: " + pin);
                                                userOTP = pin;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.white)),
                                          onPressed: () {},
                                          minWidth: 330.0,
                                          color:
                                              Color.fromRGBO(251, 72, 227, 1),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.0,
                                          ),
                                          child: Text(
                                            'confirm',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Container(
                                height: 40.0,
                                width: 330.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [
                                          0.3,
                                          1
                                        ],
                                        colors: [
                                          Color.fromRGBO(253, 99, 232, 1),
                                          Color.fromRGBO(253, 99, 232, 1),
                                        ]),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {},
                                      splashColor: Colors.green,
                                      child: new Text(
                                        'Resend',
                                        style: new TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: new Text(
                                        'resend 2',
                                        style: new TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ],
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
            );
          },
        );
      },
    );
  }
}
