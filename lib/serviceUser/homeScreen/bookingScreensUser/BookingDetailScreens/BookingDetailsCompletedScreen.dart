import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import 'package:gps_massageapp/customFavoriteButton/CustomHeartFavorite.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
List<String> _options = [
  'エステ',
  '脱毛（女性・全身）',
  '骨盤矯正',
  'ロミロミ（全身）',
  'ホットストーン（全身）',
  'カッピング（全身）',
  'リラクゼーション'
];
double ratingsValue = 4.0;
int _massageValue;
int _maternityMassageValue;

int _selectedIndex;

class BookingDetailsCompletedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookingDetailsCompletedScreenState();
  }
}

class _BookingDetailsCompletedScreenState
    extends State<BookingDetailsCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        padding: MediaQuery.of(context).padding * 0.84,
        physics: BouncingScrollPhysics(),
        children: [
          CarouselWithIndicatorDemo(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Colors.black45,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.grey[200],
                        child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeOne.svg',
                            height: 15,
                            width: 15),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text('エステ'),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Colors.black45,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.grey[200],
                        child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeTwo.svg',
                            height: 15,
                            width: 15),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text('整骨・整体'),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Colors.black45,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.grey[200],
                        child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeThree.svg',
                            height: 15,
                            width: 15),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text('リラクゼーション'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: new Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: new AssetImage('assets/images_gps/logo.png'),
                          ),
                        )),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "店舗名",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
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
                                                Colors.grey[200],
                                                Colors.grey[200]
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
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
                                                Colors.grey[200],
                                                Colors.grey[200]
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
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
                                                Colors.grey[200],
                                                Colors.grey[200]
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text('コロナ対策実施有無')),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
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
                                  EdgeInsets.symmetric(horizontal: 1.0),
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
                            Spacer(),
                            Container(
                              child: Text(
                                'もっとみる',
                                style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('女性のみ予約可')),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('キッズスペース有')),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('保育士常駐')),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('国家資格')),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('民間資格')),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('国家資格')),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text('民間資格')),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[200], Colors.grey[200]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.16,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/images_gps/gps.svg',
                                height: 25, width: 25),
                            SizedBox(width: 5),
                            new Text(
                              '住所:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '東京都',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '墨田区',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '押上',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '1-1-2',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/images_gps/clock.svg',
                                height: 25, width: 25),
                            SizedBox(width: 5),
                            new Text(
                              '営業時間:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '10:30 ～ 11:30',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontFamily: 'Oxygen'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(),
            )),
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'メッセージ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Oxygen'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: true,
                      text: new TextSpan(
                        text: '${HealingMatchConstants.sampleText}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[400],
                            fontFamily: 'Oxygen'),
                        children: <TextSpan>[
                          new TextSpan(
                              text: 'もっとみる',
                              style: new TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Oxygen',
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(),
            )),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                '以前の予約内容',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Oxygen'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[300], Colors.grey[300]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[100],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[100]),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.38,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Row(
                      children: [
                        Image.asset('assets/images_gps/calendar.png',
                            height: 25, width: 25),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          '10月17',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oxygen'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03),
                        Text(
                          '月曜日出張',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'Oxygen'),
                        ),
                        Spacer(),
                        Text(
                          '完了済み',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'Oxygen'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/clock.svg',
                            height: 25, width: 25),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        new Text(
                          '09:  00～10:  00',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Oxygen'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        new Text(
                          '60分',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              fontFamily: 'Oxygen'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images_gps/cost.svg',
                            height: 25, width: 25),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Chip(
                          label: Text('足つぼ'),
                          backgroundColor: Colors.grey[100],
                        ),
                        Text(
                          "\t\t¥4,500",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01),
                        Text(
                          '(交通費込み-1,000)',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'Oxygen'),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Divider(),
                      )),
                    ]),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/gps.svg',
                            height: 25, width: 25),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          '施術を受ける場所',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oxygen'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                              // padding: EdgeInsets.only(left: 15, right: 15),
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
                              child: FittedBox(
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
                                ),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
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
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[200], Colors.grey[200]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.89,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images_gps/gps.svg'),
                    SizedBox(width: 15),
                    Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.grey[200], Colors.grey[200]]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '店舗',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Oxygen'),
                          ),
                        )),
                    SizedBox(width: 15),
                    new Text(
                      '埼玉県浦和区高砂4丁目4',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Oxygen',
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                '受けたい施術を選んでください',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Oxygen'),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _massageValue = 0),
                  child: Column(
                    children: [
                      Container(
                        height: 85,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _massageValue == 0
                              ? Colors.grey[400]
                              : Colors.transparent,
                          border: Border.all(),
                          boxShadow: [
                            _massageValue == 0
                                ? BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    // changes position of shadow
                                  )
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeOne.svg',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'エステ',
                        style: TextStyle(
                          color: _massageValue == 0
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => setState(() => _massageValue = 1),
                  child: Column(
                    children: [
                      Container(
                        height: 85,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _massageValue == 1
                              ? Colors.grey[400]
                              : Colors.transparent,
                          border: Border.all(),
                          boxShadow: [
                            _massageValue == 1
                                ? BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    // changes position of shadow
                                  )
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeTwo.svg',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        '整骨・整体',
                        style: TextStyle(
                          color: _massageValue == 1
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => setState(() => _massageValue = 2),
                  child: Column(
                    children: [
                      Container(
                        height: 85,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _massageValue == 2
                              ? Colors.grey[400]
                              : Colors.transparent,
                          border: Border.all(),
                          boxShadow: [
                            _massageValue == 2
                                ? BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    // changes position of shadow
                                  )
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeThree.svg',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'リラクゼーション',
                        style: TextStyle(
                          color: _massageValue == 2
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => setState(() => _massageValue = 3),
                  child: Column(
                    children: [
                      Container(
                        height: 85,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _massageValue == 3
                              ? Colors.grey[400]
                              : Colors.transparent,
                          border: Border.all(),
                          boxShadow: [
                            _massageValue == 3
                                ? BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    // changes position of shadow
                                  )
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeFour.svg',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'フィットネス',
                        style: TextStyle(
                          color: _massageValue == 3
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _maternityMassageValue = 0),
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: SimpleTooltip(
                        show: _maternityMassageValue == 0 ? true : false,
                        tooltipDirection: TooltipDirection.right,
                        hideOnTooltipTap: true,
                        borderWidth: 0.1,
                        borderColor: Colors.grey[400],
                        borderRadius: 10.0,
                        minHeight: 50,
                        minWidth: 305,
                        content: SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _maternityMassageValue == 0
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                border: Border.all(),
                                boxShadow: [
                                  _maternityMassageValue == 0
                                      ? BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        )
                                      : BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          // changes position of shadow
                                        )
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/images_gps/serviceTypeOne.svg',
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              'マッサージ',
                              style: TextStyle(
                                color: _maternityMassageValue == 0
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                            Text(
                              '（全身）',
                              style: TextStyle(
                                color: _maternityMassageValue == 0
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _maternityMassageValue = 1),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: SimpleTooltip(
                        show: _maternityMassageValue == 1 ? true : false,
                        tooltipDirection: TooltipDirection.up,
                        hideOnTooltipTap: true,
                        borderWidth: 0.1,
                        borderColor: Colors.grey[400],
                        borderRadius: 10.0,
                        minHeight: 50,
                        minWidth: 280,
                        content: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  width: 80,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _maternityMassageValue == 1
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                border: Border.all(),
                                boxShadow: [
                                  _maternityMassageValue == 1
                                      ? BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        )
                                      : BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          // changes position of shadow
                                        )
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/images_gps/serviceTypeFour.svg',
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              'ストレッチ',
                              style: TextStyle(
                                color: _maternityMassageValue == 1
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                            Text(
                              '（全身）',
                              style: TextStyle(
                                color: _maternityMassageValue == 1
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _maternityMassageValue = 2),
                    child: Align(
                      alignment: Alignment.center,
                      child: SimpleTooltip(
                        show: _maternityMassageValue == 2 ? true : false,
                        tooltipDirection: TooltipDirection.down,
                        hideOnTooltipTap: true,
                        borderWidth: 0.1,
                        borderColor: Colors.grey[400],
                        borderRadius: 10.0,
                        minHeight: 50,
                        minWidth: 320,
                        content: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  width: 80,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  decoration:
                                                      TextDecoration.none,
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
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _maternityMassageValue == 2
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                border: Border.all(),
                                boxShadow: [
                                  _maternityMassageValue == 2
                                      ? BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        )
                                      : BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          // changes position of shadow
                                        )
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/images_gps/serviceTypeTwo.svg',
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              'カッピング',
                              style: TextStyle(
                                color: _maternityMassageValue == 2
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                            Text(
                              '（全身）',
                              style: TextStyle(
                                color: _maternityMassageValue == 2
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _maternityMassageValue = 3),
                    child: SimpleTooltip(
                      show: _maternityMassageValue == 3 ? true : false,
                      tooltipDirection: TooltipDirection.up,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Colors.grey[400],
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 270,
                      content: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 80,
                                width: 80,
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
                      child: Column(
                        children: [
                          Container(
                            height: 85,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _maternityMassageValue == 3
                                  ? Colors.grey[400]
                                  : Colors.transparent,
                              border: Border.all(),
                              boxShadow: [
                                _maternityMassageValue == 3
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    : BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        // changes position of shadow
                                      )
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeThree.svg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'マダニティ',
                            style: TextStyle(
                              color: _maternityMassageValue == 3
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: _maternityMassageValue == 3
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _maternityMassageValue = 4),
                    child: SimpleTooltip(
                      show: _maternityMassageValue == 4 ? true : false,
                      tooltipDirection: TooltipDirection.left,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Colors.grey[400],
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 280,
                      content: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 80,
                                width: 80,
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
                      child: Column(
                        children: [
                          Container(
                            height: 85,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _maternityMassageValue == 4
                                  ? Colors.grey[400]
                                  : Colors.transparent,
                              border: Border.all(),
                              boxShadow: [
                                _maternityMassageValue == 4
                                    ? BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    : BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        // changes position of shadow
                                      )
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeThree.svg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            'ベビーマッサ',
                            style: TextStyle(
                              color: _maternityMassageValue == 4
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: _maternityMassageValue == 4
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                '施術を受ける日時',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Oxygen'),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[200], Colors.grey[200]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.89,
              height: MediaQuery.of(context).size.height * 0.10,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    new Text(
                      '日時をカレンダーから選択してください。',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Oxygen',
                          color: Colors.grey[500]),
                    ),
                    Spacer(),
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.grey[300],
                      child: CircleAvatar(
                          maxRadius: 35,
                          backgroundColor: Colors.grey[100],
                          child: SvgPicture.asset(
                              'assets/images_gps/calendar.svg',
                              height: 25,
                              width: 25,
                              color: Colors.lime)),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                //side: BorderSide(color: Colors.black),
              ),
              color: Colors.lime,
              onPressed: () {
                NavigationRouter.switchToServiceUserBookingConfirmationScreen(
                    context);
              },
              child: new Text(
                'もう一度予約する',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Build Carousel images for banner
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  enlargeCenterPage: false,
                  viewportFraction: 1.02,
                  aspectRatio: 1.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ]),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          right: 20.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              maxRadius: 18,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  NavigationRouter.switchToServiceUserBottomBar(context);
                },
              ),
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.white,
                  child: CustomFavoriteButton(
                      iconSize: 40,
                      iconColor: Colors.red,
                      valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                      }),
                ),
              ],
            ),
          ]),
        ),
        Positioned(
          bottom: 5.0,
          left: 50.0,
          right: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 45.0,
                height: 4.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(40.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 2000.0),
                  ],
                )),
          ),
        ))
    .toList();
