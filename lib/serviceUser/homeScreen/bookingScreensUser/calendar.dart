import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/controller/day_view.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();
  DayViewController dayViewController = DayViewController();
  bool readonly = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'カレンダー',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                          displayDay = DateTime(
                                              _cyear, _cmonth, _currentDay);
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
                                        displayDay = DateTime(
                                            _cyear, _cmonth, _currentDay);
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
                ],
              ),
            )
          ],
        ),
      ),
    );
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
}
