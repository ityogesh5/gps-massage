import 'dart:convert';

import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProviderHomeScreen extends StatefulWidget {
  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();
  List<Meeting> meetings;
  DayViewController dayViewController = DayViewController();
  bool readonly = false;
  Data userData;
  Map<int, String> childrenMeasure;
  var certificateUpload;
  Map<String, String> certificateImages = Map<String, String>();
  var userQulaification;
  GlobalKey key = new GlobalKey();

  var yearString, monthString, dateString;

  NumberPicker dayPicker;
  int _cyear;
  int _cmonth;
  int _currentDay;
  DateTime today = DateTime.now();
  DateTime displayDay;
  int _lastday;
  int _counter = 0;
  int daysToDisplay;

  int status = 0;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  void initState() {
    super.initState();
    getProviderDetails();
    dateString = '';
    displayDay = today;
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(today.year, today.month + 1, 0).day;
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
    setState(() {
      print(daysToDisplay);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(today.year, today.month, today.day);
    DateTime next = DateTime(today.year, today.month, today.day + 1);

    return Scaffold(
      body: status == 0
          ? Container(color: Colors.white)
          : SingleChildScrollView(
              child: SafeArea(
              child: Container(
                //  color: Colors.grey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.shade200, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ClipOval(
                                      child: CircleAvatar(
                                        radius: 32.0,
                                        backgroundColor: Colors.white,
                                        child: Image.network(
                                          userData
                                              .uploadProfileImgUrl, //User Profile Pic
                                          fit: BoxFit.cover,
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 8.0, bottom: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              userData.userName, //User Name
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 10.0),
                                            InkWell(
                                              onTap: () {
                                                showToolTip(userData.storeType);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                      Icons
                                                          .shopping_bag_rounded,
                                                      key: key,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              userData.businessForm != null ||
                                                      userData.businessTrip !=
                                                          null ||
                                                      userData.coronaMeasure !=
                                                          null
                                                  ? 10.0
                                                  : 0.0,
                                        ),
                                        Row(
                                          children: [
                                            (userData.businessForm ==
                                                        "施術店舗あり 施術従業員あり" ||
                                                    userData.businessForm ==
                                                        "施術店舗あり 施術従業員なし（個人経営）")
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0.0,
                                                            top: 0.0,
                                                            right: 8.0,
                                                            bottom: 0.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: boxDecoration,
                                                      child: Text(
                                                        '店舗', //Store
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            (userData.businessTrip)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 0.0,
                                                            right: 8.0,
                                                            bottom: 0.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: boxDecoration,
                                                      child: Text(
                                                        '出張', //Business Trip
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            (userData.coronaMeasure)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 0.0,
                                                            right: 8.0,
                                                            bottom: 0.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: boxDecoration,
                                                      child: Text(
                                                        'コロ才対策実施', //Corona Measure
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              userData.genderOfService != null
                                                  ? 10.0
                                                  : 0.0,
                                        ),
                                        userData.genderOfService != null
                                            ? Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: boxDecoration,
                                                child: userData
                                                            .genderOfService ==
                                                        "男性女性両方"
                                                    ? Text(
                                                        '男性と女性の両方が予約できます', //both men and women can book
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    : userData.genderOfService ==
                                                            "女性のみ"
                                                        ? Text(
                                                            '女性のみ予約可', //only women
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : Text(
                                                            '男性のみ予約可能', //only men
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: childrenMeasure.length != 0
                                              ? 6.0
                                              : 0.0,
                                        ),
                                        Container(
                                          height: 45.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              130.0, //200.0,
                                          child: ListView.builder(
                                              itemCount: childrenMeasure.length,
                                              padding: EdgeInsets.all(0.0),
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: index == 0
                                                      ? const EdgeInsets.only(
                                                          left: 0.0,
                                                          top: 4.0,
                                                          right: 4.0,
                                                          bottom: 4.0)
                                                      : const EdgeInsets.all(
                                                          4.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: boxDecoration,
                                                    child: Text(
                                                      childrenMeasure[
                                                          index], //Children Measure
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0,
                                              top: 10.0,
                                              right: 8.0,
                                              bottom: 0.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '(4.0)',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.black,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(0, -3))
                                                    ],
                                                    fontSize: 14,
                                                    color: Colors.transparent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(width: 5.0),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 24.0,
                                                itemPadding:
                                                    new EdgeInsets.only(
                                                        bottom: 3.0),
                                                itemBuilder: (context, _) =>
                                                    new SizedBox(
                                                        height: 20.0,
                                                        width: 18.0,
                                                        child: new IconButton(
                                                          onPressed: () {},
                                                          padding:
                                                              new EdgeInsets
                                                                  .all(0.0),
                                                          color: Colors.black,
                                                          icon: new Icon(
                                                              Icons.star,
                                                              size: 20.0),
                                                        )),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                '(1518)',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.black,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(0, -3))
                                                    ],
                                                    fontSize: 14,
                                                    color: Colors.transparent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: certificateImages.length != 0
                                              ? 6.0
                                              : 0.0,
                                        ),
                                        Container(
                                          height: 45.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              130.0, //200.0,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  certificateImages.length,
                                              itemBuilder: (context, index) {
                                                String key = certificateImages
                                                    .keys
                                                    .elementAt(index);
                                                return Padding(
                                                  padding: index == 0
                                                      ? const EdgeInsets.only(
                                                          left: 0.0,
                                                          top: 4.0,
                                                          right: 4.0,
                                                          bottom: 4.0)
                                                      : const EdgeInsets.all(
                                                          4.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: boxDecoration,
                                                    child: Text(
                                                      getQualififcationJaWords(
                                                          key), //Qualififcation
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey),
                              Row(children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  userData.addresses[0].address,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 120,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          size: 30, color: Colors.black),
                                      /*Image.asset(
                                          'assets/images_gps/car.jpg',
                                          width: 15.0,
                                          height: 15.0,
                                          fit: BoxFit.fill,
                                        ),*/
                                      Text('今週の売り上げ'),
                                      Text('¥150,00'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 120,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 30, color: Colors.black),
                                      Text('今月の売り上げ'),
                                      Text('¥ 500,000'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 120,
                              color: Colors.white,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.calendar_today_sharp,
                                          size: 30, color: Colors.black),
                                      Text('本年度の売り上げ'),
                                      Text('¥10,876,68'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Form(
                                  key: yearKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        color: Colors.transparent,
                                        child: DropDownFormField(
                                          titleText: null,
                                          hintText: readonly
                                              ? yearString
                                              : HealingMatchConstants
                                                  .registrationBankAccountType,
                                          onSaved: (value) {
                                            setState(() {
                                              yearString = value;
                                              _cyear = int.parse(value);
                                              _currentDay = 1;
                                              displayDay = DateTime(
                                                  _cyear, _cmonth, _currentDay);
                                              /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
                                            });
                                          },
                                          value: yearString,
                                          onChanged: (value) {
                                            yearString = value;
                                            _cyear = int.parse(value);
                                            _currentDay = 1;
                                            setState(() {
                                              displayDay = DateTime(
                                                  _cyear, _cmonth, _currentDay);

                                              /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "2020",
                                              "value": "2020",
                                            },
                                            {
                                              "display": "2021",
                                              "value": "2021",
                                            },
                                            {
                                              "display": "2022",
                                              "value": "2022",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Form(
                                      key: monthKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38,
                                            color: Colors.transparent,
                                            child: DropDownFormField(
                                              titleText: null,
                                              hintText: readonly
                                                  ? monthString
                                                  : HealingMatchConstants
                                                      .registrationBankAccountType,
                                              onSaved: (value) {
                                                setState(() {
                                                  monthString = value;
                                                  _cmonth = int.parse(value);
                                                  displayDay = DateTime(_cyear,
                                                      _cmonth, _currentDay);
                                                  /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
                                                  _currentDay = 1;
                                                  _incrementCounter();
                                                });
                                              },
                                              value: monthString,
                                              onChanged: (value) {
                                                monthString = value;
                                                _cmonth = int.parse(value);
                                                displayDay = DateTime(_cyear,
                                                    _cmonth, _currentDay);
                                                setState(() {
                                                  /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
                                                  _currentDay = 1;
                                                  _incrementCounter();
                                                });
                                              },
                                              dataSource: [
                                                {
                                                  "display": "1月",
                                                  "value": "1",
                                                },
                                                {
                                                  "display": "2月",
                                                  "value": "2",
                                                },
                                                {
                                                  "display": "3月",
                                                  "value": "3",
                                                },
                                                {
                                                  "display": "4月",
                                                  "value": "4",
                                                },
                                                {
                                                  "display": "5月",
                                                  "value": "5",
                                                },
                                                {
                                                  "display": "6月",
                                                  "value": "6",
                                                },
                                                {
                                                  "display": "7月",
                                                  "value": "7",
                                                },
                                                {
                                                  "display": "8月",
                                                  "value": "8",
                                                },
                                                {
                                                  "display": "9月",
                                                  "value": "9",
                                                },
                                                {
                                                  "display": "10月",
                                                  "value": "10",
                                                },
                                                {
                                                  "display": "11月",
                                                  "value": "11",
                                                },
                                                {
                                                  "display": "12月",
                                                  "value": "12",
                                                },
                                              ],
                                              textField: 'display',
                                              valueField: 'value',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 35.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    buildDayPicker(),
                    //  SizedBox(height: 20),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.transparent,
                              )),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    color: Colors.grey[300],
                                    border: Border.all(
                                      color: Colors.transparent,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    "営業時間 - 09: 00~17: 00",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  /*  Row(
                                                                                     children: [
                                                                                       Container(
                                                                                         width: 70.0,
                                                                                         child: Padding(
                                                                                           padding: const EdgeInsets.only(
                                                                                               top: 13.0, right: 8.0),
                                                                                           child: Text("09:00",
                                                                                               textAlign: TextAlign.right,
                                                                                               style:
                                                                                                   TextStyle(color: Colors.grey[500])),
                                                                                         ),
                                                                                       ),
                                                                                     ],
                                                                                   ), */
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 15.0),
                                    child: Container(
                                      height: 250.0,
                                      child: DayView(
                                        controller: dayViewController,
                                        initialTime: const HourMinute(
                                            hour: 8, minute: 55),
                                        minimumTime:
                                            HourMinute(hour: 8, minute: 55),
                                        maximumTime:
                                            HourMinute(hour: 17, minute: 10),
                                        date: displayDay,
                                        inScrollableWidget: true,
                                        hoursColumnStyle: HoursColumnStyle(
                                            color: Colors.grey[200]),
                                        style: DayViewStyle(
                                            backgroundColor: Colors.grey[200],
                                            currentTimeCircleColor:
                                                Colors.transparent,
                                            backgroundRulesColor:
                                                Colors.transparent,
                                            currentTimeRuleColor:
                                                Colors.transparent,
                                            headerSize: 0.0),
                                        events: [
                                          FlutterWeekViewEvent(
                                            title: 'User 1',
                                            description: '0',
                                            start: date
                                                .add(const Duration(hours: 9)),
                                            margin: EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                shape: BoxShape
                                                    .rectangle /* (
                                                                         borderRadius: new BorderRadius.circular(10.0)), */
                                                ),
                                            end: date.add(
                                              const Duration(
                                                  hours: 10, minutes: 00),
                                            ),
                                            /* eventTextBuilder: (event, a, b, c, d) {
                                                                                                 return Text('a');
                                                                                               } */
                                          ),
                                          FlutterWeekViewEvent(
                                            title: 'User 2',
                                            description: '1',
                                            start: date
                                                .add(const Duration(hours: 13)),
                                            end: date
                                                .add(const Duration(hours: 14)),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                shape: BoxShape
                                                    .rectangle /* (
                                                                         borderRadius: new BorderRadius.circular(10.0)), */
                                                ),
                                          ),
                                          /*  FlutterWeekViewEvent(
                                              title: 'An event 3',
                                              description: 'A description 3',
                                              start: date.add(const Duration(
                                                  hours: 13, minutes: 30)),
                                              end: date.add(const Duration(
                                                  hours: 15, minutes: 30)),
                                            ),
                                             */
                                          FlutterWeekViewEvent(
                                            title: 'User 4',
                                            description: '1',
                                            start: date
                                                .add(const Duration(hours: 15)),
                                            end: date
                                                .add(const Duration(hours: 16)),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                shape: BoxShape
                                                    .rectangle /* (
                                                                         borderRadius: new BorderRadius.circular(10.0)), */
                                                ),
                                          ),
                                          FlutterWeekViewEvent(
                                            title: 'User 5',
                                            description: '0',
                                            start: next
                                                .add(const Duration(hours: 13)),
                                            end: next
                                                .add(const Duration(hours: 14)),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                shape: BoxShape
                                                    .rectangle /* (
                                                                         borderRadius: new BorderRadius.circular(10.0)), */
                                                ),
                                          ),
                                          FlutterWeekViewEvent(
                                            title: 'User 6',
                                            description: '1',
                                            start: next
                                                .add(const Duration(hours: 10)),
                                            end: next
                                                .add(const Duration(hours: 12)),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                shape: BoxShape
                                                    .rectangle /* (
                                                                         borderRadius: new BorderRadius.circular(10.0)), */
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /*  Positioned(
                                                                                     top: 0,
                                                                                     left: 0,
                                                                                     width: 70.0,
                                                                                     child: Padding(
                                                                                       padding:
                                                                                           const EdgeInsets.only(top: 13.0, right: 8.0),
                                                                                       child: Text("09:00",
                                                                                           textAlign: TextAlign.right,
                                                                                           style: TextStyle(color: Colors.grey[500])),
                                                                                     ),
                                                                                   ),
                                                                                 */
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  Card buildAppointmentDetails() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10),
              Text(
                "日付を選",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Text(
                    ' 日付を選択し日付を選択し ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  )),
              Row(
                children: [
                  Icon(Icons.access_time_rounded,
                      size: 20, color: Colors.yellow),
                  Text(
                    '今月',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 20,
              ),
              Text(
                '日付を選日付を選',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  '日付を選日付を選',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20),
              Text(
                '日付を選日付を選',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  changeMonthPickerVal(int focusedMonth) {
    // setState(() {
    _currentDay = focusedMonth;
    // print("Focused Month: $focusedMonth");
    dayPicker.animateInt(focusedMonth);
    // });
  }

  buildDayPicker() {
    dayPicker = NumberPicker.horizontal(
      currentDate: DateTime.now(),
      selectedYear: _cyear,
      ismonth: true,
      numberToDisplay: 7,
      selectedMonth: _cmonth,
      eventDates: [
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day + 1),
        DateTime(today.year, today.month, today.day + 1)
      ],
      zeroPad: false,
      initialValue: _currentDay,
      minValue: 1,
      maxValue: daysToDisplay,
      onChanged: (newValue) => setState(() {
        if ((newValue != _currentDay)) {
          changeDay(newValue);
        }
      }),
    );
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        height: 95.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dayPicker,
            ],
          ),
        ),
      ),
    );
  }

  changeDay(int selectedDay) {
    setState(() {
      _currentDay = selectedDay;
      displayDay = DateTime(_cyear, _cmonth, selectedDay);
      //dayViewController.

      // dayPicker.animateInt(_currentDay);
    });
    // print("Changed month: _currentDay");
  }

  void _incrementCounter() {
    var dateUtility = DateUtil();
    var day1 = dateUtility.daysInMonth(_cmonth, _cyear);
    print(day1);
    //var day2 = dateUtility.daysInMonth(2, 2018);
    //print(day2);

    setState(() {
      _counter++;
    });
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }

  int totalDays(int month, int year) {
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      return 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else if (month == 2) {
      return year % 4 == 0 ? 29 : 28;
    }
  }

  void getProviderDetails() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userData =
        Data.fromJson(json.decode(sharedPreferences.getString("userData")));
    HealingMatchConstants.userData = userData;
    if (userData.childrenMeasure != null) {
      var split = userData.childrenMeasure.split(',');
      childrenMeasure = {for (int i = 0; i < split.length; i++) i: split[i]};
      certificateUpload = userData.certificationUploads[0].toJson();
      certificateUpload.remove('id');
      certificateUpload.remove('userId');
      certificateUpload.remove('createdAt');
      certificateUpload.remove('updatedAt');
      certificateUpload.forEach((key, value) async {
        if (certificateUpload[key] != null) {
          certificateImages[key] = value;
        }
      });
    }
    setState(() {
      status = 1;
    });
    ProgressDialogBuilder.hideCommonProgressDialog(context);
  }

  void showToolTip(String text) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: 180,
        width: 180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  String getQualififcationJaWords(String key) {
    switch (key) {
      case 'acupuncturist':
        return 'はり師';
        break;
      case 'moxibutionist':
        return 'きゅう師';
        break;
      case 'acupuncturistAndMoxibustion':
        return '鍼灸師';
        break;
      case 'anmaMassageShiatsushi':
        return 'あん摩マッサージ指圧師';
        break;
      case 'judoRehabilitationTeacher':
        return '柔道整復師';
        break;
      case 'physicalTherapist':
        return '理学療法士';
        break;
      case 'acquireNationalQualifications':
        return '国家資格取得予定（学生）';
        break;
      case 'privateQualification1':
        return '民間資格';
      case 'privateQualification2':
        return '民間資格';
      case 'privateQualification3':
        return '民間資格';
      case 'privateQualification4':
        return '民間資格';
      case 'privateQualification5':
        return '民間資格';
        break;
    }
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
