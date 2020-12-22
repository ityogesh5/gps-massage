import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';
import 'package:gps_massageapp/serviceUser/userLoginScreen.dart';

class IntroTermsAndPolicy extends StatefulWidget {
  @override
  _IntroTermsAndPolicyState createState() => _IntroTermsAndPolicyState();
}

class _IntroTermsAndPolicyState extends State<IntroTermsAndPolicy> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 249, 250, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'TERMS AND PRIVACY POLICY',
          style: TextStyle(fontSize: 15, fontFamily: 'Open Sans'),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Container(
              child: FutureBuilder(
                  future:
                      rootBundle.loadString("assets/terms_and_conditions.md"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(
                          data: snapshot.data,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                                      p: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(fontSize: 12.0)));
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              color: Color.fromRGBO(243, 249, 250, 1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.green,
                          value: _value,

                          onChanged: (bool newValue) {
                            setState(() {
                              _value = newValue;
                            });
                          },

                          //activeColor: Colors.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      Text(
                        'I agree to the above terms of use',
                        style: TextStyle(fontSize: 12, fontFamily: 'Open Sans'),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Container(
                                child: _value
                                    ? RaisedButton(
                                        textColor: Colors.white60,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.green,
                                        onPressed: () {
                                          showChooseServiceAlert(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text('AGREE',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.w800,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1))),
                                        ),
                                      )
                                    : RaisedButton(
                                        textColor: Colors.white60,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.green[200],
                                        onPressed: () {
                                          /* Toast.show(
                                              'Please Accept our Terms and Conditions!',
                                              context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.CENTER,
                                              backgroundColor: Colors.red);*/
                                          return;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text('AGREE',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Open Sans',
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1))),
                                        ),
                                      )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  showChooseServiceAlert(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
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
                                //print("LAT: ${test}");
                                print("User onTapped");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                            UserLogin()));
                              },
                              child: Image.asset(
                                'assets/images/usernew.png',
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
                              onTap:() {
                                print("Provider onTapped");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                            Login()));
                              },
                              child: Image.asset(
                                'assets/images/providernew.png',
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
                      "不動産カレンダー不動産カレンダー \n証明書をアップロードしてください。", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /* Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }*/
}
