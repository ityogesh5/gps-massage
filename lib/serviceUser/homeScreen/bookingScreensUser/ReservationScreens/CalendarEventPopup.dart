import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

double ratingsValue = 4.0;

class EventPopupScreen extends StatefulWidget {
  @override
  State createState() {
    return _EventPopupScreenState();
  }
}

class _EventPopupScreenState extends State<EventPopupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(child: Container(child: CancelPopupScreen())),
        Positioned(
          left: 360,
          bottom: 580,
          child: CircleAvatar(
            maxRadius: 18,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              maxRadius: 16,
              child: IconButton(
                icon: SvgPicture.asset('assets/images_gps/cancel.svg'),
                onPressed: () {
                  print('Closed Pressed');
                },
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget CancelPopupScreen() {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 1),
                            Color.fromRGBO(255, 255, 255, 1),
                          ]),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey[100],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Stack(
                                fit: StackFit.loose,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      new Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    232, 232, 232, 1)),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: new AssetImage(
                                                  'assets/images_gps/logo.png'),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Positioned(
                                    top: 60,
                                    child: Chip(
                                      padding: EdgeInsets.all(0.5),
                                      labelPadding: EdgeInsets.zero,
                                      avatar: SvgPicture.asset(
                                          'assets/images_gps/clock.svg'),
                                      label: Text('5分60秒'),
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(232, 232, 232, 1),
                                          fontSize: 14),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "店舗名",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(width: 5),
                                      CircleAvatar(
                                        maxRadius: 15,
                                        backgroundColor: Colors.black26,
                                        child: CircleAvatar(
                                          maxRadius: 14,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              'assets/images_gps/info.svg',
                                              height: 15,
                                              width: 15),
                                        ),
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                          'assets/images_gps/processing.svg',
                                          height: 17,
                                          width: 15),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '承認待ち',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                            child: Text('店舗')),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                            child: Text('出張')),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                            child: Text('コロナ対策実施有無')),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                            child: Text('コロナ対策実施有無')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                            child: Divider(color: Colors.grey[300], height: 1)),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Text(
                              '(${ratingsValue.toString()})',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  fontFamily: 'Oxygen'),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 5,
                                color: Colors.black,
                              ),
                              onRatingUpdate: (rating) {
                                // print(rating);
                                setState(() {
                                  ratingsValue = rating;
                                });
                                print(ratingsValue);
                              },
                            ),
                            Text(
                              '(1518)',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontFamily: 'Oxygen'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/images_gps/calendar.svg',
                                height: 25, width: 25),
                            Text(
                              ' 10月17\t\t\t',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'oxygen'),
                            ),
                            Text(
                              '月曜日出張',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                  fontFamily: 'oxygen'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/images_gps/clock.svg',
                                height: 25, width: 25),
                            Text(
                              '\t9：00～10: 00\t\t\t',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'oxygen'),
                            ),
                            Text(
                              '60分',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                  fontFamily: 'oxygen'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/images_gps/cost.svg',
                                height: 25, width: 25),
                            SizedBox(width: 3),
                            Chip(
                              label: Text('足つぼ'),
                              backgroundColor: Colors.grey[300],
                            ),
                            Text(
                              "\t\t¥4,500",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                            child: Divider(color: Colors.grey[300], height: 1)),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 15),
                          SvgPicture.asset('assets/images_gps/gps.svg',
                              height: 25, width: 25),
                          SizedBox(width: 5),
                          Text(
                            '\t\t施術を受ける場所',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'oxygen'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.grey[200],
                                          Colors.grey[200]
                                        ]),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '店舗',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Oxygen'),
                                  ),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Text(
                              '埼玉県浦和区高砂4丁目4',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                  fontFamily: 'Oxygen'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
