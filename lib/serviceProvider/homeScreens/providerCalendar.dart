import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/controller/day_view.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';

class ProviderCalendar extends StatefulWidget {
  @override
  _ProviderCalendarState createState() => _ProviderCalendarState();
}

class _ProviderCalendarState extends State<ProviderCalendar> {
  CalendarController _calendarController;
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
  int status = 0;
  List<FlutterWeekViewEvent> events = List<FlutterWeekViewEvent>();

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

  @override
  void initState() {
    super.initState();
      ServiceProviderApi.getCalEvents().then((value) {
      events.addAll(value);
      setState(() {
        status = 1;
      });
    });
    events.addAll(HealingMatchConstants.events);
    _calendarController = CalendarController();
    dateString = '';
    displayDay = today;
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(today.year, today.month + 1, 0).day;
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(today.year, today.month, today.day);
    DateTime next = DateTime(today.year, today.month, today.day + 1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          'カレンダー',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: status == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                      width: 80.0,
                                      /* MediaQuery.of(context).size.width *
                                                0.2, */
                                      color: Colors.transparent,
                                      child: DropDownFormField(
                                        fillColor: Colors.white,
                                        borderColor:
                                            Color.fromRGBO(228, 228, 228, 1),
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
                              SizedBox(width: 20),
                              Container(
                                  width: 80.0,
                                  /*   MediaQuery.of(context).size.width * 0.2, */
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
                                            fillColor: Colors.white,
                                            borderColor: Color.fromRGBO(
                                                228, 228, 228, 1),
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      // side: BorderSide(width: 5, color: Colors.green),
                    ),
                    elevation: 5.0,
                    // margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 0,
                            child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: null)),
                        Expanded(
                          flex: 4,
                          child: TableCalendar(
                            locale: "ja_JP",
                            calendarController: _calendarController,
                            headerVisible: false,
                            initialCalendarFormat: CalendarFormat.month,
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(color: Colors.grey),
                                weekendStyle: TextStyle(color: Colors.grey)),
                            availableGestures:
                                AvailableGestures.horizontalSwipe,
                            calendarStyle: CalendarStyle(
                              todayColor: Colors.lime,
                              selectedColor: Colors.lime,
                              outsideDaysVisible: true,
                              outsideStyle: TextStyle(color: Colors.grey),
                              outsideWeekendStyle:
                                  TextStyle(color: Colors.grey),
                              weekendStyle: TextStyle(color: Colors.black),
                              holidayStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: null),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // height: 800,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.transparent,
                            )),
                        child: Column(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      left: 5.0,
                                      right: 5.0,
                                      bottom: 15.0),
                                  child: InkWell(
                                    // onTap: () => NavigationRouter
                                    //     .switchToWeeklySchedule(context),
                                    child: Container(
                                      height: 350.0,
                                      child: DayView(
                                        
                                        controller: dayViewController,
                                        initialTime: const HourMinute(
                                            hour: 2, minute: 55),
                                        minimumTime:
                                            HourMinute(hour: 2, minute: 55),
                                        maximumTime:
                                            HourMinute(hour: 17, minute: 10),
                                        date: displayDay,
                                        inScrollableWidget: true,
                                        hoursColumnStyle: HoursColumnStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          textStyle: TextStyle(
                                              fontSize: 10.0,
                                              color: Color.fromRGBO(
                                                  158, 158, 158, 1)),
                                        ),
                                        style: DayViewStyle(
                                            hourRowHeight: 80.0,
                                            backgroundColor: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            currentTimeCircleColor:
                                                Colors.transparent,
                                            backgroundRulesColor:
                                                Colors.transparent,
                                            currentTimeRuleColor:
                                                Colors.transparent,
                                            headerSize: 0.0),
                                        events: events,
                                      ),
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

   changeDay(int selectedDay) {
    setState(() {
      _currentDay = selectedDay;
      displayDay = DateTime(_cyear, _cmonth, selectedDay);
      //dayViewController.

      // dayPicker.animateInt(_currentDay);
    });
    // print("Changed month: _currentDay");
  }
}
