import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProviderHomeScreen extends StatefulWidget {
  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();
  List<Meeting> meetings;
  CalendarController calendarController = CalendarController();
  bool readonly = false;

  var yearString, monthString, dateString;

  NumberPicker dayPicker;
  int _cyear;
  int _cmonth;
  int _currentDay;
  var now = DateTime.now();
  int _lastday;
  int _counter = 0;
  int daysToDisplay;

  void initState() {
    super.initState();

    dateString = '';

    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(now.year, now.month + 1, 0).day;
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
    setState(() {
      print(daysToDisplay);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    return Scaffold(
      body: SingleChildScrollView(
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
                      side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading:
                            /*CircleAvatar(
                          backgroundColor: Colors.grey[400].withOpacity(0.4),
                          child: Icon(FontAwesomeIcons.user,
                              color: Colors.grey, size: 20),
                        ),*/
                            ClipOval(
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images_gps/logo.png',
                              fit: BoxFit.cover,
                              width: 90.0,
                              height: 90.0,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              'お店名',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        ' エステ ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        ' フィットネス ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        ' リラクゼーション ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Text(
                                ' リラクゼーション ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      ' abcde ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      ' fghijk ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      ' lmnopqrs ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    '(3.0)',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => new SizedBox(
                                        height: 18.0,
                                        width: 18.0,
                                        child: new IconButton(
                                          onPressed: () {},
                                          padding: new EdgeInsets.all(0.0),
                                          color: Colors.black,
                                          icon:
                                              new Icon(Icons.star, size: 16.0),
                                        )),
                                    /*Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                            //size: 10.0,
                                        ),*/
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Text(
                                    '(1212)',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.all(4),
                                //color: Colors.white,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  //boxShadow: [BoxShadow(color: Colors.green, spreadRadius: 3),],
                                ),
                                child: Text(
                                  ' tuvwxyz ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(width: 1),
                                Text(
                                  ' 東京都須田町丁目 ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ],
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
                                  color: Colors.grey.shade200, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  color: Colors.grey.shade200, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  color: Colors.grey.shade200, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      MediaQuery.of(context).size.width * 0.3,
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
                                        daysToDisplay =
                                            totalDays(_cmonth, _cyear);
                                      });
                                    },
                                    value: yearString,
                                    onChanged: (value) {
                                      setState(() {
                                        yearString = value;
                                        _cyear = int.parse(value);
                                        _currentDay = 1;
                                        daysToDisplay =
                                            totalDays(_cmonth, _cyear);
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
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Form(
                                key: monthKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
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
                                            daysToDisplay =
                                                totalDays(_cmonth, _cyear);
                                            _currentDay = 1;
                                            _incrementCounter();
                                          });
                                        },
                                        value: monthString,
                                        onChanged: (value) {
                                          setState(() {
                                            monthString = value;
                                            _cmonth = int.parse(value);
                                            daysToDisplay =
                                                totalDays(_cmonth, _cyear);
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
                                  initialTime:
                                      const HourMinute(hour: 8, minute: 55),
                                  minimumTime: HourMinute(hour: 8, minute: 55),
                                  maximumTime: HourMinute(hour: 17, minute: 10),
                                  date: now,
                                  inScrollableWidget: true,
                                  hoursColumnStyle:
                                      HoursColumnStyle(color: Colors.grey[200]),
                                  style: DayViewStyle(
                                      backgroundColor: Colors.grey[200],
                                      currentTimeCircleColor:
                                          Colors.transparent,
                                      backgroundRulesColor: Colors.transparent,
                                      currentTimeRuleColor: Colors.transparent,
                                      headerSize: 0.0),
                                  events: [
                                    FlutterWeekViewEvent(
                                      title: 'An event 1',
                                      description: 'A description 1',
                                      start: date.add(const Duration(hours: 9)),
                                      margin: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          shape: BoxShape
                                              .rectangle /* (
                                                                 borderRadius: new BorderRadius.circular(10.0)), */
                                          ),
                                      end: date.add(
                                        const Duration(hours: 10, minutes: 00),
                                      ),
                                      /* eventTextBuilder: (event, a, b, c, d) {
                                                                                         return Text('a');
                                                                                       } */
                                    ),
                                    FlutterWeekViewEvent(
                                      title: 'An event 2',
                                      description: 'A description 2',
                                      start:
                                          date.add(const Duration(hours: 13)),
                                      end: date.add(const Duration(hours: 14)),
                                    ),
                                    FlutterWeekViewEvent(
                                      title: 'An event 3',
                                      description: 'A description 3',
                                      start: date.add(const Duration(
                                          hours: 13, minutes: 30)),
                                      end: date.add(const Duration(
                                          hours: 15, minutes: 30)),
                                    ),
                                    FlutterWeekViewEvent(
                                      title: 'An event 4',
                                      description: 'A description 4',
                                      start:
                                          date.add(const Duration(hours: 15)),
                                      end: date.add(const Duration(hours: 16)),
                                    ),
                                    FlutterWeekViewEvent(
                                      title: 'An event 5',
                                      description: 'A description 5',
                                      start:
                                          date.add(const Duration(hours: 15)),
                                      end: date.add(const Duration(hours: 16)),
                                    ),
                                    FlutterWeekViewEvent(
                                      title: 'An event 6',
                                      description: 'A description 6',
                                      start:
                                          date.add(const Duration(hours: 16)),
                                      end: date.add(const Duration(hours: 17)),
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
      selectedMonth: 1,
      eventDates: [
        DateTime(2021, 1, 29),
        DateTime(2021, 1, 29),
        DateTime(2021, 1, 29),
        DateTime(2021, 1, 27),
      ],
      zeroPad: false,
      initialValue: _currentDay,
      minValue: 1,
      maxValue: daysToDisplay,
      onChanged: (newValue) => setState(() {
        if ((newValue != _currentDay)) {
          changeMonth(newValue);
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

  changeMonth(int selectedmonth) {
    setState(() {
      _currentDay = selectedmonth;
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
