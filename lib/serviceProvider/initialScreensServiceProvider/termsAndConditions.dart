import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';

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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Login()));
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

  /* Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }*/
}
