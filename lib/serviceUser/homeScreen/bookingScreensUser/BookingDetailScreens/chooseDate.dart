import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customSwitch/custom_switch.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/lazyTable/lazy_data_table.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/event.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';

class ChooseDate extends StatefulWidget {
  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  bool readonly = false;
  var yearString, monthString, dateString;
  int _cyear;
  int _cmonth;
  int _currentDay;
  DateTime today = DateTime.now();
  DateTime displayDay;
  int _lastday;
  int daysToDisplay;
  int startTime;
  int endTime;
  int loadingStatus = 0;
  List<DateTime> timeRow = List<DateTime>();
  List<String> dayNames = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];
  List<StoreServiceTiming> storeServiceTime = List<StoreServiceTiming>();
  List<FlutterWeekViewEvent> calendarEvents = List<FlutterWeekViewEvent>();
  Map<DateTime, List<int>> bookEvents = Map<DateTime, List<int>>();
  Map<DateTime, List<int>> events = Map<DateTime, List<int>>();
  int min;
  bool status = false;
  GlobalKey key = new GlobalKey();
  OverlayEntry _overlayEntry;
  Size buttonSize;
  Offset buttonPosition;
  bool isSeleted = false;

  @override
  void initState() {
    super.initState();
    startTime = 9;
    endTime = 20;
    min = 0;
    dateString = '';
    displayDay = today;
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(today.year, today.month + 1, 0).day;
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
    timeBuilder(_cyear, _cmonth);
    ServiceProviderApi.getCalEvents().then((value) {
      calendarEvents.addAll(value);
      getEvents();
    });
  }

  findButton(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  getEvents() {
    calendarEvents.addAll(HealingMatchConstants.events);
    for (var event in calendarEvents) {
      DateTime start = DateTime(event.start.year, event.start.month, 1,
          event.start.hour, event.start.minute);
      DateTime end = DateTime(event.start.year, event.start.month, 1,
          event.end.hour, event.end.minute);

      while (start.compareTo(end) < 0) {
        if (events[start] == null) {
          events[start] = [event.start.day - 1];
        } else if (!(events[start].contains([event.start.day - 1]))) {
          events[start].addAll([event.start.day - 1]);
        }
        start = start.add(Duration(minutes: 15));
      }
    }
    setState(() {
      loadingStatus = 1;
    });
  }

  timeBuilder(int year, int month) {
    DateTime start =
        DateTime(year, month, 1, 9, 0); //1st day is mentioned as dummy
    if (timeRow != null) {
      timeRow.clear();
    }
    while (start.hour != endTime) {
      timeRow.add(start);
      start = start.add(Duration(minutes: 15));
    }
    //get start and End Time from Api
    if (HealingMatchConstants.therapistProfileDetails.storeServiceTiming ==
            null ||
        HealingMatchConstants
                .therapistProfileDetails.storeServiceTiming.length ==
            0) {
      buildInitialTime();
    } else {
      converToLocalTime();
    }
  }

  converToLocalTime() {
    for (var serviceTime
        in HealingMatchConstants.therapistProfileDetails.storeServiceTiming) {
      serviceTime.startTime = serviceTime.startTime.toLocal();
      serviceTime.endTime = serviceTime.endTime.toLocal();
      storeServiceTime.add(serviceTime);
    }
  }

  buildInitialTime() {
    int i = 1;
    DateTime defaultStart = DateTime(_cyear, _cmonth, 1, 0, 0, 0);
    DateTime defaultEnd = DateTime(_cyear, _cmonth, 1, 23, 59, 0);
    for (var day in dayNames) {
      storeServiceTime.add(StoreServiceTiming(
        id: 0,
        userId: HealingMatchConstants.userId,
        weekDay: day,
        dayInNumber: i,
        startTime: defaultStart,
        endTime: defaultEnd,
        shopOpen: true,
      ));
      i = i + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: loadingStatus == 0
          ? Container(
              color: Colors.white,
              child: Center(child: SpinKitThreeBounce(color: Colors.lime)),
            )
          : Container(
              /*  height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       */
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  80.0, //MediaQuery.of(context).size.width * 0.2,
                              color: Colors.transparent,
                              child: DropDownFormField(
                                fillColor: Colors.white,
                                borderColor: Color.fromRGBO(228, 228, 228, 1),
                                contentPadding: EdgeInsets.all(1.0),
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
                                    displayDay =
                                        DateTime(_cyear, _cmonth, _currentDay);
                                    daysToDisplay = totalDays(_cmonth, _cyear);
                                  });
                                },
                                value: yearString,
                                onChanged: (value) {
                                  yearString = value;
                                  _cyear = int.parse(value);
                                  _currentDay = 1;
                                  setState(() {
                                    displayDay =
                                        DateTime(_cyear, _cmonth, _currentDay);

                                    daysToDisplay = totalDays(_cmonth, _cyear);
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
                            SizedBox(
                              width: 15.0,
                            ),
                            Container(
                              width:
                                  80.0, //MediaQuery.of(context).size.width * 0.2,
                              child: DropDownFormField(
                                fillColor: Colors.white,
                                borderColor: Color.fromRGBO(228, 228, 228, 1),
                                titleText: null,
                                hintText: readonly
                                    ? monthString
                                    : HealingMatchConstants
                                        .registrationBankAccountType,
                                onSaved: (value) {
                                  setState(() {
                                    monthString = value;
                                    _cmonth = int.parse(value);
                                    displayDay =
                                        DateTime(_cyear, _cmonth, _currentDay);
                                    daysToDisplay = totalDays(_cmonth, _cyear);
                                    _currentDay = 1;
                                  });
                                },
                                value: monthString,
                                onChanged: (value) {
                                  monthString = value;
                                  _cmonth = int.parse(value);
                                  displayDay =
                                      DateTime(_cyear, _cmonth, _currentDay);
                                  setState(() {
                                    daysToDisplay = totalDays(_cmonth, _cyear);
                                    _currentDay = 1;
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
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: LazyDataTable(
                              rows: 45,
                              columns: daysToDisplay,
                              tableTheme: LazyDataTableTheme(
                                columnHeaderColor:
                                    Color.fromRGBO(247, 247, 247, 1),
                                columnHeaderBorder: Border.fromBorderSide(
                                  BorderSide(color: Colors.transparent),
                                ),
                                rowHeaderBorder: Border.fromBorderSide(
                                  BorderSide(color: Colors.transparent),
                                ),
                                rowHeaderColor:
                                    Color.fromRGBO(247, 247, 247, 1),
                                cornerBorder: Border.fromBorderSide(
                                  BorderSide(color: Colors.transparent),
                                ),
                                cornerColor: Color.fromRGBO(247, 247, 247, 1),
                                cellBorder: Border.symmetric(
                                    horizontal: BorderSide.none,
                                    vertical: BorderSide(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                    )),
                                alternateCellBorder: Border.symmetric(
                                    horizontal: BorderSide.none,
                                    vertical: BorderSide(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                    )),
                                alternateCellColor: Colors.white,
                              ),
                              tableDimensions: LazyDataTableDimensions(
                                cellHeight: 50,
                                cellWidth: 50,
                                columnHeaderHeight: 50,
                                rowHeaderWidth: 50,
                              ),
                              columnHeaderBuilder: (i) => Center(
                                child: Text(
                                  "${i + 1}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              rowHeaderBuilder: (i) {
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        timeRow[i].hour < 10
                                            ? "0${timeRow[i].hour}"
                                            : "${timeRow[i].hour}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(158, 158, 158, 1),
                                        ),
                                      ),
                                      Text(
                                        timeRow[i].minute == 0
                                            ? ": 00"
                                            : ": ${timeRow[i].minute}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(158, 158, 158, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              dataCellBuilder: (i, j) {
                                String dayName = DateFormat('EEEE')
                                    .format(DateTime(_cyear, _cmonth, j + 1));
                                //Get Japanese Day Name
                                int dayIndex = getJaIndex(dayName);
                                if (storeServiceTime[dayIndex].shopOpen) {
                                  if (bookEvents.containsKey(timeRow[i]) &&
                                      bookEvents[timeRow[i]].contains(j)) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          bookEvents.remove(timeRow[i]);
                                          isSeleted = false;
                                        });
                                      },
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/images_gps/checkbox.svg",
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                      ),
                                    );
                                  } else if (events.containsKey(timeRow[i]) &&
                                      events[timeRow[i]].contains(j)) {
                                    return Center(
                                      child: SvgPicture.asset(
                                        "assets/images_gps/X.svg",
                                        height: 20.0,
                                        width: 20.0,
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        if (!isSeleted) {
                                          setState(() {
                                            bookEvents[timeRow[i]] = [j];
                                            isSeleted = true;
                                          });
                                        }
                                      },
                                      child: Center(
                                          child: SvgPicture.asset(
                                        "assets/images_gps/O.svg",
                                        height: 20.0,
                                        width: 20.0,
                                      )),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: SvgPicture.asset(
                                    "assets/images_gps/X.svg",
                                    height: 20.0,
                                    width: 20.0,
                                  ));
                                }
                              },
                              cornerWidget: Center(
                                child: Text(
                                  "日時",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(158, 158, 158, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  int getJaIndex(String day) {
    switch (day) {
      case 'Monday':
        return 0;
        break;
      case 'Tuesday':
        return 1;
        break;
      case 'Wednesday':
        return 2;
        break;
      case 'Thursday':
        return 3;
        break;
      case 'Friday':
        return 4;
        break;
      case 'Saturday':
        return 5;
        break;
      case 'Sunday':
        return 6;
        break;
    }
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

  setDayTiming() {
    bool monTimePicker = false;
    bool tueTimePicker = false;
    bool wedTimePicker = false;
    bool thuTimePicker = false;
    bool friTimePicker = false;
    bool satTimePicker = false;
    bool sunTimePicker = false;
    DateTime _dateTime = DateTime.now();
    return showDialog(
        context: context,
        builder: (context) {
          double width = MediaQuery.of(context).size.width;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 16,
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                size: 25.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Text(
                          "営業日時を設定してください。",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("月曜日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  monTimePicker = !monTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    "12:30",
                                    key: key,
                                  )),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  monTimePicker = !monTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        monTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("火曜日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  tueTimePicker = !tueTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  tueTimePicker = !tueTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        tueTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("水曜日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
                              },
                              child: InkWell(
                                onTap: () {
                                  findButton(key);
                                  setState(() {
                                    wedTimePicker = !wedTimePicker;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[400]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text("12:30")),
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  wedTimePicker = !wedTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        wedTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("木曜日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  thuTimePicker = !thuTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  thuTimePicker = !thuTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        thuTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("金曜日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  friTimePicker = !friTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  friTimePicker = !friTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        friTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("土曜日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  satTimePicker = !satTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  satTimePicker = !satTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        satTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("日曜 日"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  sunTimePicker = !sunTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                findButton(key);
                                setState(() {
                                  sunTimePicker = !sunTimePicker;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("12:30")),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: status,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        ),
                        sunTimePicker
                            ? Container(
                                child: buildTimeController(_dateTime),
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.90,
                          margin: EdgeInsets.all(8.0),
                          color: Colors.transparent,
                          child: RaisedButton(
                            elevation: 0.0,
                            textColor: Colors.white60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Color.fromRGBO(200, 217, 33, 1),
                            onPressed: () {
                              showConfirmDialog();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '保存',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  Stack buildTimeController(DateTime _dateTime) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50.0),
                        CustomPaint(
                          size: Size(15.0, 10.0),
                          painter: TrianglePainter(
                              isDownArrow: false, color: Colors.grey[100]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          size: Size(15.0, 10.0),
                          painter: TrianglePainter(
                              isDownArrow: false, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  height: 120.0,
                  padding: EdgeInsets.all(8.0),
                  // margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[100]),
                  child: TimePickerSpinner(
                    alignment: Alignment.topCenter,
                    is24HourMode: true,
                    normalTextStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    highlightedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                    spacing: 50,
                    itemHeight: 40,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        _dateTime = time;
                      });
                    },
                  )),
            ],
          ),
        ),
        /*     Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Container(
            color: Colors.red,
            height: 150.0,
            width: 100.0,
            child: CustomPaint(
              size: Size(15.0, 10.0),
              painter: TrianglePainter(
                  isDownArrow: false, color: Colors.red), //grey[100]),
            ),
          ),
        ), */
      ],
    );
  }

  showConfirmDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 16,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "全ての金曜日をXにします",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildButton()
                ],
              ),
            ),
          );
        });
  }

  buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            //  minWidth: MediaQuery.of(context).size.width * 0.38,
            // splashColor: Colors.grey,
            color: Color.fromRGBO(217, 217, 217, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'キャンセル',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            //   minWidth: MediaQuery.of(context).size.width * 0.38,
            color: Color.fromRGBO(200, 217, 33, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              'OK',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
