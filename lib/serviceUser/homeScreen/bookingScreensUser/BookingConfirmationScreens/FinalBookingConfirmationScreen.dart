import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

double ratingsValue = 4.0;
final _queriesAskController = new TextEditingController();

class ConfirmBookingScreen extends StatefulWidget {
  @override
  State createState() {
    return _ConfirmBookingScreenState();
  }
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          '予約確認',
          style: TextStyle(
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              '予約の詳細',
              style: TextStyle(
                  fontFamily: 'Oxygen',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Container(
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
              height: MediaQuery.of(context).size.height * 0.29,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: new AssetImage(
                                    'assets/images_gps/logo.png'),
                              ),
                            )),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '店舗名',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 16,
                                  child: IconButton(
                                    // remove default padding here
                                    padding: EdgeInsets.zero,
                                    icon:
                                        Icon(Icons.notifications_none_outlined),
                                    color: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ),
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
                                      color: Colors.white,
                                      child: Text('店舗')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('出張')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('コロナ対策実施有無')),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    color: Colors.white,
                                    child: Text('コロナ対策実施')),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Expanded(child: Divider()),
                    ]),
                    SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on_outlined, size: 30),
                          Text(
                            '埼玉県浦和区高砂4丁目4',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'oxygen'),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                '５Ｋｍ圏内',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontFamily: 'oxygen'),
                              ),
                            ],
                          )
                        ])
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[200], Colors.grey[200]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[400],
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 25),
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
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.alarm, size: 25),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.blur_circular,
                            color: Colors.black26, size: 25),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "\t\t施術を受ける場所",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[300], Colors.grey[300]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.white30, Colors.white30]),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Text(
                            '${HealingMatchConstants.selectedBookingPlace}')),
                    Text(
                      "\t\t\t\t埼玉県浦和区高砂4丁目4",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.82,
              child: TextField(
                controller: _queriesAskController,
                autofocus: false,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                decoration: new InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    hintText: '質問、要望などメッセージがあれば入力してください。',
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.start,
              text: new TextSpan(
                text: '*\t\t',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  new TextSpan(
                      text:
                      '${HealingMatchConstants.additionalDistanceCost}',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.grey[300],
                          fontFamily: 'Oxygen',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100)),
                ],
              ),
            ),
            SizedBox(height: 20),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.06,
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  //side: BorderSide(color: Colors.black),
                ),
                color: Colors.red,
                onPressed: () {
                  _updateUserBookingDetails();
                },
                child: new Text(
                  '予約する',
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
      ),
    );
  }

  _updateUserBookingDetails() {
    print('API ACCESS');
  }
}