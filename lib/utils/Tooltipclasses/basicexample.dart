import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class BasicsExamplePage extends StatefulWidget {
  const BasicsExamplePage({Key key}) : super(key: key);

  @override
  _BasicsExamplePageState createState() => _BasicsExamplePageState();
}

class _BasicsExamplePageState extends State<BasicsExamplePage> {
  bool _show = false;
  bool hideOnTap = false;
  TooltipDirection _direction = TooltipDirection.down;
  bool _changeBorder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basics"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("toogle: $_show"),
                onPressed: () {
                  setState(() {
                    _show = !_show;
                  });
                },
              ),
              RaisedButton(
                child: Text("change direction"),
                onPressed: () {
                  setState(() {
                    switch (_direction) {
                      case TooltipDirection.up:
                        _direction = TooltipDirection.right;
                        break;
                      case TooltipDirection.right:
                        _direction = TooltipDirection.down;
                        break;
                      case TooltipDirection.down:
                        _direction = TooltipDirection.left;
                        break;
                      case TooltipDirection.left:
                        _direction = TooltipDirection.up;
                        break;
                      default:
                    }
                  });
                },
              ),
              RaisedButton(
                child: Text("hideOnTap: $hideOnTap"),
                onPressed: () {
                  setState(() {
                    hideOnTap = !hideOnTap;
                  });
                },
              ),
              RaisedButton(
                child: Text("change border: $hideOnTap"),
                onPressed: () {
                  setState(() {
                    _changeBorder = !_changeBorder;
                  });
                },
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: SimpleTooltip(
                  show: _show,
                  tooltipDirection: _direction,
                  hideOnTooltipTap: hideOnTap,
                  borderWidth: 0.1,
                  borderColor: Colors.grey[400],
                  borderRadius: 10.0,
                  child: Container(
                    color: Colors.cyan,
                    width: 80,
                    height: 80,
                  ),
                  minHeight: 50,
                  minWidth: 300,
                  content: Container(
                    width: 400,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/processing.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.black),
                                        SizedBox(width: 5),
                                        new Text(
                                          '60分',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    '\t¥4,500',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          SizedBox(width: 10),
                          Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/processing.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.black),
                                        SizedBox(width: 5),
                                        new Text(
                                          '90分',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    '\t¥4,500',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          SizedBox(width: 10),
                          Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/processing.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.black),
                                        SizedBox(width: 5),
                                        new Text(
                                          '120分',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    '\t¥4,500',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          SizedBox(width: 10),
                          Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/processing.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.black),
                                        SizedBox(width: 5),
                                        new Text(
                                          '150分',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    '\t¥4,500',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          SizedBox(width: 10),
                          Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/processing.svg',
                                            height: 25,
                                            width: 25,
                                            color: Colors.black),
                                        SizedBox(width: 5),
                                        new Text(
                                          '180分',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Text(
                                    '\t¥4,500',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Oxygen',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  //routeObserver: MyApp.of(context).routeObserver,
                ),
              ),
              RaisedButton(
                child: Text("New route"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return Scaffold(
                          appBar: AppBar(),
                          body: Placeholder(),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
