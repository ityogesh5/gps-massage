import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
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

  void initState() {
    super.initState();
    yearString = '';
    monthString = '';
    dateString = '';

    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(now.year, now.month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
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
                                        icon: new Icon(Icons.star, size: 16.0),
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
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                      _cyear = value;
                                    });
                                  },
                                  value: yearString,
                                  onChanged: (value) {
                                    setState(() {
                                      yearString = value;
                                      _cyear = value;
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
                                          _cmonth = value;
                                          _incrementCounter();
                                        });
                                      },
                                      value: monthString,
                                      onChanged: (value) {
                                        setState(() {
                                          monthString = value;
                                          _cmonth = value;
                                          _incrementCounter();
                                        });
                                      },
                                      dataSource: [
                                        {
                                          "display": "1",
                                          "value": "1",
                                        },
                                        {
                                          "display": "2",
                                          "value": "2",
                                        },
                                        {
                                          "display": "3",
                                          "value": "3",
                                        },
                                        {
                                          "display": "4",
                                          "value": "4",
                                        },
                                        {
                                          "display": "5",
                                          "value": "5",
                                        },
                                        {
                                          "display": "6",
                                          "value": "6",
                                        },
                                        {
                                          "display": "7",
                                          "value": "7",
                                        },
                                        {
                                          "display": "8",
                                          "value": "8",
                                        },
                                        {
                                          "display": "9",
                                          "value": "9",
                                        },
                                        {
                                          "display": "10",
                                          "value": "10",
                                        },
                                        {
                                          "display": "11",
                                          "value": "11",
                                        },
                                        {
                                          "display": "12",
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
                          Icons.calendar_today,
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
                            "09: 00~17: 00",
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
                                top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
                            child: SfCalendar(
                              controller: calendarController,
                              selectionDecoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.transparent, width: 0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                shape: BoxShape.rectangle,
                              ),
                              backgroundColor: Colors.grey[200],
                              view: CalendarView.day,
                              dataSource: MeetingDataSource(_getDataSource()),
                              timeSlotViewSettings: TimeSlotViewSettings(
                                timeFormat: 'HH: mm',
                                startHour: 9,
                                endHour: 17,
                                timeIntervalHeight: 100.0,
                                timelineAppointmentHeight: 130.0,
                                timeRulerSize: 70,
                                timeTextStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[500],
                                ),
                              ),
                              headerHeight: 0,
                              viewHeaderHeight: 0,
                              onTap: (a) {
                             
                              },
                              cellBorderColor: Colors.grey[200],
                              appointmentBuilder: (context, calendarDetails) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Text(
                                                ' 日付を選択し日付を選択し ',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_rounded,
                                                  size: 20,
                                                  color: Colors.yellow),
                                              Text(
                                                '今月',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.yellow,
                                                    fontWeight:
                                                        FontWeight.w800),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey),
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              child: Text(
                                                ' 日付を選 ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(width: 10),
                                          Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              child: Text(
                                                ' 日付を選 ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(width: 10),
                                          Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.black12,
                                              ),
                                              child: Text(
                                                ' 日付を選 ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              },
                              // by default the month appointment display mode set as Indicator, we can
                              // change the display mode as appointment using the appointment display
                              // mode property
                              monthViewSettings: MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment),
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
            /*  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.grey[200],
                elevation: 2,
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(color: Colors.grey.shade200, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(14.0),
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Text(
                              "日付を選択し日付を選択し日付を選択し日",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "09: 00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 60),
                              Text(
                                "10: 00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 60),
                              Text(
                                "11: 00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 60),
                              Text(
                                "12: 00",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 60),
                            ]),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 0.5),
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    Row(
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
                                        SizedBox(width: 10),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              ' 日付を選択し日付を選択し ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                        SizedBox(width: 10),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey),
                                          ),
                                          child: Text(
                                            '日付を選日付を選',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeight.bold),
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.black12,
                                            ),
                                            child: Text(
                                              ' 日付を選 ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.black12,
                                            ),
                                            child: Text(
                                              ' 日付を選 ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.black12,
                                            ),
                                            child: Text(
                                              ' 日付を選 ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: Colors.grey[200],
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey[200],
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
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
                                      ]),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
 */
            /*Center(
              child: HorizontalDatePickerWidget(
                startDate: now,
                endDate: now.add(Duration(days: 14)),
                selectedDate: now,
                widgetWidth: MediaQuery.of(context).size.width,
                datePickerController: DatePickerController(),
                onValueSelected: (date) {
                  print('selected = ${date.toIso8601String()}');
                },
              ),
            ),*/
          ],
        ),
      )),
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
      zeroPad: false,
      initialValue: _currentDay,
      minValue: 1,
      maxValue: 30,
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

/*
class _HomeScreenState extends State<HomeScreen> {

  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();

  bool readonly = false;

  var yearString, monthString, dateString;

  NumberPicker dayPicker;
  int _cyear;
  int _cmonth;
  int _currentDay;
  var now = DateTime.now();
  int _lastday;
  int _counter = 0;

  void initState() {
    super.initState();
    yearString = '';
    monthString = '';
    dateString = '';

    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(now.year, now.month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    color: Colors.grey[200],
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            /*       child: Image.asset(
                              'assets/images/car.jpg',
                              fit: BoxFit.fitHeight,
                            ),*/
                          ),
                          title: Row(
                            children: [
                              Text('お店名'),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('エステ'),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('フィットネス'),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/car.jpg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text('リラクゼーション'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('ijfv')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('okdesu')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: Text('coronavirus')),
                                ],
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      '4.0',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Text('fgj5756'),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  color: Colors.white,
                                  child: Text('ftdghy')),
                              Text('♪101-0041東京都須田町2丁目-25号'),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
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
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
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
                        height: 100,
                        color: Colors.white,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/car.jpg',
                                  width: 15.0,
                                  height: 15.0,
                                  fit: BoxFit.fill,
                                ),
                                Text('本年度の売り上げ'),
                                Text('¥10,876,68'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
*/
