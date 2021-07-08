import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

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

int _selectedIndex;

class DetailPageSearchOne extends StatefulWidget {
  final userID;

  DetailPageSearchOne(this.userID);

  @override
  _DetailPageSearchOneState createState() => _DetailPageSearchOneState();
}

class _DetailPageSearchOneState extends State<DetailPageSearchOne> {
  int _current = 0;
  int _value;
  int massageTipColor;
  int strechTipColor;
  int cuppingTipColor;
  int maternityTipColor;
  int babyTipColor;
  var therapistId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CauroselWithIndicatorSearchPage(),
          Padding(
            padding:
                const EdgeInsets.only(right: 8, left: 15, top: 15, bottom: 15),
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
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeOne.svg',
                            color: Color.fromRGBO(0, 0, 0, 1),
                            height: 15,
                            width: 15),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text(
                      'エステ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
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
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeTwo.svg',
                            color: Color.fromRGBO(0, 0, 0, 1),
                            height: 15,
                            width: 15),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Text(
                      '整骨・整体',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                FittedBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 12,
                        backgroundColor: Colors.black45,
                        child: CircleAvatar(
                          maxRadius: 10,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeThree.svg',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 15,
                              width: 15),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        'リラクゼーション',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
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
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
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
                                        color: Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Color.fromRGBO(228, 228, 228, 1),
                                    ),
                                    child: Text(
                                      '店舗',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    )),
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
                                            Color.fromRGBO(255, 255, 255, 1),
                                            Color.fromRGBO(255, 255, 255, 1),
                                          ]),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Color.fromRGBO(228, 228, 228, 1),
                                    ),
                                    child: Text(
                                      '出張',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    )),
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
                                            Color.fromRGBO(255, 255, 255, 1),
                                            Color.fromRGBO(255, 255, 255, 1),
                                          ]),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Color.fromRGBO(228, 228, 228, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Color.fromRGBO(228, 228, 228, 1),
                                    ),
                                    child: Text(
                                      'コロナ対策実施有無',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    )),
                              ],
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
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: 14,
                                  fontFamily: 'NotoSansJP'),
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
                                color: Color.fromRGBO(255, 217, 0, 1),
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
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: 12,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  NavigationRouter
                                      .switchToServiceUserDisplayReviewScreen(
                                          context, therapistId);
                                },
                                child: Container(
                                  child: Text(
                                    'もっとみる',
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'NotoSansJP',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        fontSize: 14),
                                  ),
                                ),
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
                              colors: [
                                Color.fromRGBO(255, 255, 255, 1),
                                Color.fromRGBO(255, 255, 255, 1),
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          '女性のみ予約可',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                              colors: [
                                Color.fromRGBO(255, 255, 255, 1),
                                Color.fromRGBO(255, 255, 255, 1),
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          'キッズスペース有',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                                Color.fromRGBO(255, 255, 255, 1),
                                Color.fromRGBO(255, 255, 255, 1),
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          '保育士常駐',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                                colors: [
                                  Color.fromRGBO(255, 255, 255, 1),
                                  Color.fromRGBO(255, 255, 255, 1),
                                ]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromRGBO(228, 228, 228, 1),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200]),
                        child: Text(
                          '国家資格',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                                Color.fromRGBO(255, 255, 255, 1),
                                Color.fromRGBO(255, 255, 255, 1),
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          '民間資格',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                                Color.fromRGBO(255, 255, 255, 1),
                                Color.fromRGBO(255, 255, 255, 1),
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          '国家資格',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
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
                                Colors.white,
                                Colors.white,
                              ]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Text(
                          '民間資格',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
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
                                color: Color.fromRGBO(26, 26, 26, 1),
                                height: 25,
                                width: 25),
                            SizedBox(width: 5),
                            new Text(
                              '住所:',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '東京都',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '墨田区',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '押上',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '1-1-2',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/images_gps/clock.svg',
                                color: Color.fromRGBO(0, 0, 0, 1),
                                height: 25,
                                width: 25),
                            SizedBox(width: 5),
                            new Text(
                              '営業時間:',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '10:30 ～ 11:30',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
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
          SizedBox(height: 7),
          Row(children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Divider(
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
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
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'NotoSansJP'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: '${HealingMatchConstants.sampleText}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'NotoSansJP'),
                        children: <TextSpan>[
                          new TextSpan(
                              text: 'もっとみる',
                              style: new TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'NotoSansJP',
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
              padding: const EdgeInsets.all(11.0),
              child: Divider(),
            )),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '施術を受ける場所',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.09,
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
                                color: Color.fromRGBO(0, 0, 0, 1),
                                height: 25,
                                width: 25),
                            SizedBox(width: 5),
                            Container(
                                padding: EdgeInsets.all(4),
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
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.grey[200]),
                                child: Text(
                                  '店舗',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                )),
                            SizedBox(width: 5),
                            new Text(
                              '東京都',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '墨田区',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '押上',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            SizedBox(width: 5),
                            new Text(
                              '1-1-2',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP'),
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
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '施術メニューを選んでください',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _value = 1),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SimpleTooltip(
                      show: _value == 1 ? true : false,
                      tooltipDirection: TooltipDirection.right,
                      ballonPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Color.fromRGBO(228, 228, 228, 1),
                      borderRadius: 10.0,
                      minimumOutSidePadding: 10.0,
                      minHeight: 50,
                      minWidth: 305,
                      content: Stack(
                        children: [
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => massageTipColor = 1),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: massageTipColor == 1
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => massageTipColor = 2),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: massageTipColor == 2
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => massageTipColor = 3),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: massageTipColor == 3
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => massageTipColor = 4),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: massageTipColor == 4
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => massageTipColor = 5),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: massageTipColor == 5
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        3.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 1
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 1
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                'assets/images_gps/Massage.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            'マッサージ',
                            style: TextStyle(
                              color: _value == 1
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                          Text(
                            '（全身）',
                            style: TextStyle(
                              color: _value == 1
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
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
                  onTap: () => setState(() => _value = 2),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SimpleTooltip(
                      show: _value == 2 ? true : false,
                      tooltipDirection: TooltipDirection.down,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Color.fromRGBO(228, 228, 228, 1),
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 305,
                      content: Stack(
                        children: [
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => strechTipColor = 1),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: strechTipColor == 1
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => strechTipColor = 2),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: strechTipColor == 2
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => strechTipColor = 3),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: strechTipColor == 3
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => strechTipColor = 4),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: strechTipColor == 4
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => strechTipColor = 5),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: strechTipColor == 5
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        3.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 2
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 2
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/images_gps/stretch.svg',
                                  fit: BoxFit.contain,
                                )),
                          ),
                          Text(
                            'ストレッチ',
                            style: TextStyle(
                              color: _value == 2
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                          Text(
                            '（全身）',
                            style: TextStyle(
                              color: _value == 2
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
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
                  onTap: () => setState(() => _value = 3),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SimpleTooltip(
                      show: _value == 3 ? true : false,
                      tooltipDirection: TooltipDirection.down,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Color.fromRGBO(228, 228, 228, 1),
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 305,
                      content: Stack(
                        children: [
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => cuppingTipColor = 1),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: cuppingTipColor == 1
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => cuppingTipColor = 2),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: cuppingTipColor == 2
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => cuppingTipColor = 3),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: cuppingTipColor == 3
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => cuppingTipColor = 4),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: cuppingTipColor == 4
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => cuppingTipColor = 5),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: cuppingTipColor == 5
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        3.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 3
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 3
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                'assets/images_gps/Cupping.svg',
                              ),
                            ),
                          ),
                          Text(
                            'カッピング',
                            style: TextStyle(
                              color: _value == 3
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                          Text(
                            '（全身）',
                            style: TextStyle(
                              color: _value == 3
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
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
                  onTap: () => setState(() => _value = 4),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SimpleTooltip(
                      show: _value == 4 ? true : false,
                      tooltipDirection: TooltipDirection.down,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Color.fromRGBO(228, 228, 228, 1),
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 305,
                      content: Stack(
                        children: [
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => maternityTipColor = 1),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: maternityTipColor == 1
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => maternityTipColor = 2),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: maternityTipColor == 2
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => maternityTipColor = 3),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: maternityTipColor == 3
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => maternityTipColor = 4),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: maternityTipColor == 4
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => maternityTipColor = 5),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: maternityTipColor == 5
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        3.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 4
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 4
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                'assets/images_gps/Maternity.svg',
                              ),
                            ),
                          ),
                          Text(
                            'マタニティ',
                            style: TextStyle(
                              color: _value == 4
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: _value == 4
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
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
                  onTap: () => setState(() => _value = 5),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SimpleTooltip(
                      show: _value == 5 ? true : false,
                      tooltipDirection: TooltipDirection.left,
                      hideOnTooltipTap: true,
                      borderWidth: 0.1,
                      borderColor: Color.fromRGBO(228, 228, 228, 1),
                      borderRadius: 10.0,
                      minHeight: 50,
                      minWidth: 305,
                      content: Stack(
                        children: [
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => babyTipColor = 1),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: babyTipColor == 1
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => babyTipColor = 2),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: babyTipColor == 2
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => babyTipColor = 3),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: babyTipColor == 3
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => babyTipColor = 4),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: babyTipColor == 4
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => babyTipColor = 5),
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: babyTipColor == 5
                                                  ? Color.fromRGBO(
                                                      242, 242, 242, 1)
                                                  : Color.fromRGBO(
                                                      255, 255, 255, 1),
                                              border: Border.all(),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                new Text(
                                                  '\t¥4,500',
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        3.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 5
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 5
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/images_gps/Baby.svg',
                                )),
                          ),
                          Text(
                            'ベビーマッサ',
                            style: TextStyle(
                              color: _value == 5
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: _value == 5
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(102, 102, 102, 1),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    'assets/images_gps/calendar.svg',
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    height: 22,
                                    width: 22),
                                SizedBox(width: 5),
                                new Text(
                                  '10月17',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16,
                                      fontFamily: 'NotoSansJP'),
                                ),
                                SizedBox(width: 5),
                                new Text(
                                  '月曜日',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontSize: 16,
                                      fontFamily: 'NotoSansJP'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset('assets/images_gps/clock.svg',
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  height: 25,
                                  width: 25),
                              SizedBox(width: 5),
                              Text(
                                '10:30 ～ 11:30',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'NotoSansJP'),
                              ),
                              SizedBox(width: 3),
                              new Text(
                                '60分',
                                style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: 16,
                                    fontFamily: 'NotoSansJP'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          NavigationRouter.switchToUserChooseDate(context);
                        },
                        child: CircleAvatar(
                          maxRadius: 38,
                          backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                          child: CircleAvatar(
                            maxRadius: 38,
                            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                            child: SvgPicture.asset(
                              'assets/images_gps/calendar.svg',
                              height: 20,
                              width: 20,
                              color: Color.fromRGBO(200, 217, 33, 1),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images_gps/warning.svg',
                  ),
                  Text(
                    '選択した日時で既に予約が入っているので、日時を変更してください',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: proceedToPayment(),
    );
  }

  Widget proceedToPayment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.065,
        child: RaisedButton(
          child: Text(
            '予約に進む',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'NotoSansJP',
                fontSize: 18),
          ),
          color: Color.fromRGBO(255, 0, 0, 1),
          onPressed: () {
            NavigationRouter.switchToServiceUserFinalConfirmBookingScreen(
                context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class CauroselWithIndicatorSearchPage extends StatefulWidget {
  @override
  _CauroselWithIndicatorSearchPageState createState() =>
      _CauroselWithIndicatorSearchPageState();
}

class _CauroselWithIndicatorSearchPageState
    extends State<CauroselWithIndicatorSearchPage> {
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
                  Navigator.pop(context);
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
                  child: HealingMatchConstants.isUserRegistrationSkipped
                      ? GestureDetector(
                          onTap: () {
                            return;
                          },
                          child: SvgPicture.asset(
                            'assets/images_gps/heart_wo_color.svg',
                            width: 25,
                            height: 25,
                            color: Colors.grey[400],
                          ),
                        )
                      : FavoriteButton(
                          iconSize: 40,
                          iconColor: Colors.red,
                          valueChanged: (_isFavorite) {
                            print('Is Favorite : $_isFavorite');
                          }),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                InkWell(
                  onTap: () {
                    DialogHelper.openReportBlockUserDialog(context);
                  },
                  child: CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
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
            children: HealingMatchConstants.userBannerImages.map((url) {
              int index = HealingMatchConstants.userBannerImages.indexOf(url);
              return Expanded(
                child: Container(
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
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = HealingMatchConstants.userBannerImages
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
