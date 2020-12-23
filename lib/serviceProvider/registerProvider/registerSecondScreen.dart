import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/expandable/customAccordan.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ヒーリングマッチ',
      home: RegisterSecondScreen(),
    );
  }
}

class RegisterSecondScreen extends StatefulWidget {
  @override
  _RegisterSecondScreenState createState() => _RegisterSecondScreenState();
}

class _RegisterSecondScreenState extends State<RegisterSecondScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    _navigateUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Form(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Color.fromRGBO(243, 249, 250, 1),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FadeTransition(
                      opacity: animation,
                      child: GFAccordion(
                        title: '検索',
                        titlePadding: EdgeInsets.only(
                            left: 13, top: 10, bottom: 10, right: 12),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        customdecoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(0, 229, 250, 1),
                                  Color.fromRGBO(0, 187, 255, 1)
                                ]),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0)),
                        contentChild: Container(
                          height: 400,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 185, left: 3),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: SvgPicture.asset(
                                        'assets/images_michishirube/3_star_blue.svg',
                                        height: 50,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 35.0),
                                        child: SvgPicture.asset(
                                          'assets/images_michishirube/4_star_pink.svg',
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  margin: EdgeInsets.only(top: 280),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60.0)),
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {},
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        251, 72, 227, 1),
                                                    Color.fromRGBO(
                                                        255, 138, 239, 1),
                                                    Color.fromRGBO(
                                                        251, 72, 227, 1),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 400.0,
                                                minHeight: 45.0),
                                            alignment: Alignment.center,
                                            child: Text('検索',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 185, left: 3),
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          margin: EdgeInsets.only(
                                              bottom: 10.0, left: 6.0),
                                          child: TextFormField(
//enableInteractiveSelection: false,
                                            autofocus: false,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Open Sans'),
                                            cursorColor: Colors.redAccent,
                                            decoration: new InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: '年齢の入力',
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          margin: EdgeInsets.only(
                                              bottom: 10.0, right: 6.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30, left: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    new Text(
                                      '性別',
                                      style: new TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'Open Sans',
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 160, right: 0, left: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        '年齢',
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Open Sans',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '血液型',
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Open Sans',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                        collapsedIcon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 30),
                        expandedIcon: Icon(Icons.keyboard_arrow_up,
                            color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
                FadeTransition(
                  opacity: animation,
                  child: GFAccordion(
                    title: '検索',
                    titlePadding: EdgeInsets.only(
                        left: 13, top: 10, bottom: 10, right: 12),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    customdecoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 229, 250, 1),
                              Color.fromRGBO(0, 187, 255, 1)
                            ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0)),
                    contentChild: Container(
                      height: 400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 185, left: 3),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    'assets/images_michishirube/3_star_blue.svg',
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 35.0),
                                    child: SvgPicture.asset(
                                      'assets/images_michishirube/4_star_pink.svg',
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: EdgeInsets.only(top: 280),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0)),
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () {},
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(251, 72, 227, 1),
                                                Color.fromRGBO(
                                                    255, 138, 239, 1),
                                                Color.fromRGBO(251, 72, 227, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 400.0, minHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text('検索',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 185, left: 3),
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, left: 6.0),
                                      child: TextFormField(
//enableInteractiveSelection: false,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Open Sans'),
                                        cursorColor: Colors.redAccent,
                                        decoration: new InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: '年齢の入力',
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, right: 6.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Text(
                                  '性別',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Open Sans',
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 160, right: 0, left: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '年齢',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '血液型',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    collapsedIcon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 30),
                    expandedIcon: Icon(Icons.keyboard_arrow_up,
                        color: Colors.white, size: 30),
                  ),
                ),
                FadeTransition(
                  opacity: animation,
                  child: GFAccordion(
                    title: '検索',
                    titlePadding: EdgeInsets.only(
                        left: 13, top: 10, bottom: 10, right: 12),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    customdecoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 229, 250, 1),
                              Color.fromRGBO(0, 187, 255, 1)
                            ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0)),
                    contentChild: Container(
                      height: 400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 185, left: 3),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    'assets/images_michishirube/3_star_blue.svg',
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 35.0),
                                    child: SvgPicture.asset(
                                      'assets/images_michishirube/4_star_pink.svg',
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: EdgeInsets.only(top: 280),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0)),
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () {},
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(251, 72, 227, 1),
                                                Color.fromRGBO(
                                                    255, 138, 239, 1),
                                                Color.fromRGBO(251, 72, 227, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 400.0, minHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text('検索',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 185, left: 3),
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, left: 6.0),
                                      child: TextFormField(
//enableInteractiveSelection: false,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Open Sans'),
                                        cursorColor: Colors.redAccent,
                                        decoration: new InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: '年齢の入力',
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, right: 6.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Text(
                                  '性別',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Open Sans',
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 160, right: 0, left: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '年齢',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '血液型',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    collapsedIcon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 30),
                    expandedIcon: Icon(Icons.keyboard_arrow_up,
                        color: Colors.white, size: 30),
                  ),
                ),
                FadeTransition(
                  opacity: animation,
                  child: GFAccordion(
                    title: '検索',
                    titlePadding: EdgeInsets.only(
                        left: 13, top: 10, bottom: 10, right: 12),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    customdecoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 229, 250, 1),
                              Color.fromRGBO(0, 187, 255, 1)
                            ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0)),
                    contentChild: Container(
                      height: 400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 185, left: 3),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    'assets/images_michishirube/3_star_blue.svg',
                                    height: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 35.0),
                                    child: SvgPicture.asset(
                                      'assets/images_michishirube/4_star_pink.svg',
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: EdgeInsets.only(top: 280),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0)),
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () {},
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromRGBO(251, 72, 227, 1),
                                                Color.fromRGBO(
                                                    255, 138, 239, 1),
                                                Color.fromRGBO(251, 72, 227, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 400.0, minHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text('検索',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Open Sans',
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 185, left: 3),
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, left: 6.0),
                                      child: TextFormField(
//enableInteractiveSelection: false,
                                        autofocus: false,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Open Sans'),
                                        cursorColor: Colors.redAccent,
                                        decoration: new InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: '年齢の入力',
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, right: 6.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Text(
                                  '性別',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Open Sans',
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 160, right: 0, left: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '年齢',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '血液型',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Open Sans',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    collapsedIcon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 30),
                    expandedIcon: Icon(Icons.keyboard_arrow_up,
                        color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateUser() async {
    return null;
  }
}
