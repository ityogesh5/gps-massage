import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';
import 'package:gps_massageapp/serviceUser/userLoginScreen.dart';

class UserDefineScreen extends StatefulWidget {
  @override
  _UserDefineScreenState createState() => _UserDefineScreenState();
}

class _UserDefineScreenState extends State<UserDefineScreen> {
  Size size;
  int state = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state == 0) {
        state = 1;
        size = MediaQuery.of(context).size;
        showUserDefineDialog();
      }
    });
    return Container(
      color: Colors.white30,
    );
  }

  showUserDefineDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 16,
            child: Container(
              //height: 300.0,
              //width: 450.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "計算したい日付を選択し",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print("User onTapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UserLogin()));
                                },
                                child: Image.asset(
                                  'assets/images_gps/usernew.png',
                                  height: 150.0,
                                  //width: 150.0,
                                ),
                              ),
                              SizedBox(height: 7),
                              /*Text(
                                "不動産カレンダー",
                                style: TextStyle(fontSize: 10.0),
                              ),*/
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print("Provider onTapped");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()));
                                },
                                child: Image.asset(
                                  'assets/images_gps/providernew.png',
                                  height: 150.0,
                                  //width: 150.0,
                                ),
                              ),
                              SizedBox(height: 7),
                              /*Text(
                                "不動産カレンダー",
                                style: TextStyle(fontSize: 10.0),
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "不動産カレンダー不動産カレンダー \n証明書をアップロードしてください。",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
