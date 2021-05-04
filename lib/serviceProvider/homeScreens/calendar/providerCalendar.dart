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
  String yearString, monthString, dateString;
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
  int calendarStatus = 0;
  int _initialProcess = 0;
  DateTime vdate;
  List<FlutterWeekViewEvent> events = List<FlutterWeekViewEvent>();
  Map<DateTime, List<dynamic>> eventDotHandler;

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
    HealingMatchConstants.isProviderHomePage = false;

    ServiceProviderApi.getCalEvents().then((value) {
      events.addAll(value);
      setState(() {
        status = 1;
      });
    });
    _calendarController = CalendarController();
    dateString = '';
    displayDay = DateTime(today.year, today.month, today.day);
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
    return WillPopScope(
      onWillPop: () {
        setState(() {
          HealingMatchConstants.isProviderHomePage = true;
        });
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              setState(() {
                HealingMatchConstants.isProviderHomePage = true;
              });
              Navigator.pop(context);
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
                                              displayDay = DateTime(
                                                  _cyear, _cmonth, _currentDay);
                                              _calendarController
                                                  .setFocusedDay(displayDay);
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
                                              _calendarController
                                                  .setFocusedDay(displayDay);
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
                                                  _calendarController
                                                      .setFocusedDay(
                                                          displayDay);
                                                });
                                              },
                                              value: monthString,
                                              onChanged: (value) {
                                                monthString = value;
                                                _cmonth = int.parse(value);
                                                displayDay = DateTime(_cyear,
                                                    _cmonth, _currentDay);
                                                _calendarController
                                                    .setFocusedDay(displayDay);

                                                setState(() {
                                                  /*    daysToDisplay =
                                                          totalDays(_cmonth, _cyear); */
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
                      elevation: 1.0,
                      color: Colors.white,
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        // side: BorderSide(width: 5, color: Colors.green),
                      ),
                      // margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  _calendarController.previousPage();
                                  var _cfocus = _calendarController.focusedDay;
                                  _cmonth = _cfocus.month;
                                  _cyear = _cfocus.year;
                                  setState(() {
                                    monthString = _cmonth.toString();
                                    yearString = _cyear.toString();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 0.0, top: 4.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TableCalendar(
                                  rowHeight: 40.0,
                                  locale: "ja_JP",
                                  calendarController: _calendarController,
                                  headerVisible: false,
                                  initialSelectedDay: displayDay,
                                  initialCalendarFormat: CalendarFormat.month,
                                  startingDayOfWeek: StartingDayOfWeek.sunday,
                                  events: eventBuilder(),
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                      weekdayStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "NotoSansJP"),
                                      weekendStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "NotoSansJP")),
                                  availableGestures:
                                      AvailableGestures.horizontalSwipe,
                                  onDaySelected: (date, list1, list2) {
                                    _currentDay = date.day;
                                    setState(() {
                                      displayDay = date;
                                    });
                                  },
                                  builders: CalendarBuilders(
                                    singleMarkerBuilder:
                                        (context, date, event) {
                                      var eventDate = DateTime(
                                          date.year, date.month, date.day);
                                      var currentDate = DateTime(
                                          _cyear, _cmonth, _currentDay);
                                      return Container(
                                        width: 4.0,
                                        height: 4.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0.3),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: eventDate.compareTo(
                                                        currentDate) ==
                                                    0
                                                ? Colors.white
                                                : Colors.black),
                                      );
                                    },
                                  ),
                                  onVisibleDaysChanged:
                                      (date1, date2, cformat) {
                                    //When calendar is swiped this logic is used to change the month and year picker Value
                                    if (_initialProcess == 1 &&
                                        vdate != date1) {
                                      vdate = date1;
                                      //  print("1 :$date1");
                                      //print("2  :$date2");
                                      if (date1.year == date2.year) //same year
                                      {
                                        if (date1.year != _cyear) {
                                          changeYearVal(date1.year);
                                        }
                                        if (date1.month == date2.month - 1) {
                                          if (date1.day == 1) {
                                            changeMonthVal(date1.month);
                                          } else {
                                            changeMonthVal(date2.month);
                                          }
                                        } else if (date1.month ==
                                            date2.month - 2) {
                                          changeMonthVal(date1.month + 1);
                                        } else if (date1.month == date2.month) {
                                          changeMonthVal(date1.month);
                                        }
                                      } else {
                                        if (date1.month == 11) {
                                          changeYearVal(date1.year);
                                          changeMonthVal(date1.month + 1);
                                        } else {
                                          if (date1.month == 12 &&
                                              date1.day == 1) {
                                            changeYearVal(date1.year);
                                            changeMonthVal(date1.month);
                                          } else if (date1.month == 12 &&
                                              date1.day != 1) {
                                            changeYearVal(date2.year);
                                            changeMonthVal(1);
                                          } else if (date1.month == 1) {
                                            changeYearVal(date2.year);
                                            changeMonthVal(1);
                                          }
                                        }
                                      }
                                    } else {
                                      _initialProcess = 1;
                                    }
                                  },
                                  calendarStyle: CalendarStyle(
                                    // markersColor: ,
                                    markersPositionBottom: 5.0,

                                    todayColor: Colors.white,
                                    selectedColor: Colors.lime,
                                    outsideDaysVisible: true,
                                    todayStyle: TextStyle(
                                        color: Colors.lime,
                                        fontFamily: "NotoSansJP"),
                                    outsideStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "NotoSansJP"),
                                    outsideWeekendStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "NotoSansJP"),
                                    weekendStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "NotoSansJP"),
                                    holidayStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "NotoSansJP"),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _calendarController.nextPage();
                                  var _cfocus = _calendarController.focusedDay;
                                  _cmonth = _cfocus.month;
                                  _cyear = _cfocus.year;
                                  setState(() {
                                    monthString = _cmonth.toString();
                                    yearString = _cyear.toString();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 8.0, top: 4.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          calendarStatus == 0
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      calendarStatus = 1;
                                      _calendarController.setCalendarFormat(
                                          CalendarFormat.week);
                                    });
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 25.0,
                                    color: Colors.grey,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      calendarStatus = 0;
                                      _calendarController.setCalendarFormat(
                                          CalendarFormat.month);
                                    });
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 25.0,
                                    color: Colors.grey,
                                  ),
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
                                        height: calendarStatus == 0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                150.0, //350.0,
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
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
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
      ),
    );
  }

  changeMonthVal(int focusedMonth) {
    _cmonth = focusedMonth;
    setState(() {
      monthString = (_cmonth).toString();
    });
  }

  changeYearVal(int focusedYear) {
    _cyear = focusedYear;
    setState(() {
      yearString = (_cyear).toString();
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

  Map<DateTime, List<dynamic>> eventBuilder() {
    eventDotHandler = Map<DateTime, List<dynamic>>();
    for (var event in events) {
      DateTime eventDate = DateTime(event.events.start.dateTime.year,
          event.events.start.dateTime.month, event.events.start.dateTime.day);

      var value = eventDotHandler[eventDate];
      if (value == null) {
        eventDotHandler[eventDate] = [
          {event.events.summary}
        ];
      } else {
        eventDotHandler[eventDate] = List.from(value)
          ..addAll([event.events.summary]);
      }
    }
    return eventDotHandler;
  }
}
