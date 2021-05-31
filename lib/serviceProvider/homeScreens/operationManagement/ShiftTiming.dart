import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/timeSpinnerToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customSwitch/custom_switch.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/lazyTable/lazy_data_table.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/ProviderDetailsResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';

class ShiftTiming extends StatefulWidget {
  @override
  _ShiftTimingState createState() => _ShiftTimingState();
}

class _ShiftTimingState extends State<ShiftTiming> {
  bool readonly = false;
  var yearString, monthString;
  int _cyear;
  int _cmonth;
  int _currentDay;
  DateTime today = DateTime.now();
  DateTime displayDay;
  int _lastday;
  int daysToDisplay;
  int startTime;
  int endTime;
  Map<DateTime, List<int>> events = Map<DateTime, List<int>>();
  List<DateTime> timeRow = List<DateTime>();
  List<FlutterWeekViewEvent> calendarEvents = List<FlutterWeekViewEvent>();
  List<String> eventID = List<String>();
  Map<DateTime, String> scheduleEventId = Map<DateTime, String>();
  bool status = false;
  var refreshState;
  GlobalKey sundayStartKey = new GlobalKey();
  GlobalKey sundayEndKey = new GlobalKey();
  GlobalKey mondayStartkey = new GlobalKey();
  GlobalKey mondayEndKey = new GlobalKey();
  GlobalKey tuesdayStartKey = new GlobalKey();
  GlobalKey tuesdayEndKey = new GlobalKey();
  GlobalKey wednedayStartKey = new GlobalKey();
  GlobalKey wednesdayEndKey = new GlobalKey();
  GlobalKey thursdayStartKey = new GlobalKey();
  GlobalKey thursdayEndKey = new GlobalKey();
  GlobalKey fridayStartKey = new GlobalKey();
  GlobalKey fridayEndKey = new GlobalKey();
  GlobalKey saturdayStartKey = new GlobalKey();
  GlobalKey saturdayEndKey = new GlobalKey();
  Size buttonSize;
  Offset buttonPosition;
  List<String> dayNames = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];
  List<StoreServiceTime> _storeServiceTime = List<StoreServiceTime>();

  @override
  void initState() {
    super.initState();
    startTime = 9;
    endTime = 20;
    displayDay = today;
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(today.year, today.month + 1, 0).day;
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
    timeBuilder(_cyear, _cmonth);
    getEvents();
  }

  findButton(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
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

    HealingMatchConstants.therapistDetails = List<StoreServiceTime>.from(json
        .decode(HealingMatchConstants.storeServiceTime)
        .map((x) => StoreServiceTime.fromJson(x)));

    //get start and End Time from Api
    if (HealingMatchConstants.therapistDetails == null ||
        HealingMatchConstants.therapistDetails.length == 0) {
      buildInitialTime();
    } else {
      /*   storeServiceTime.addAll(HealingMatchConstants.therapistDetails);
    */
      converToLocalTime();
    }
  }

  converToLocalTime() {
    for (var serviceTime in HealingMatchConstants.therapistDetails) {
      serviceTime.startTime = serviceTime.startTime.toLocal();
      serviceTime.endTime = serviceTime.endTime.toLocal();
      _storeServiceTime.add(serviceTime);
    }
  }

  buildInitialTime() {
    int i = 1;
    DateTime defaultStart = DateTime(_cyear, _cmonth, 1, 0, 0, 0);
    DateTime defaultEnd = DateTime(_cyear, _cmonth, 1, 24, 0, 0);
    for (var day in dayNames) {
      _storeServiceTime.add(StoreServiceTime(
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
        scheduleEventId[DateTime(start.year, start.month, event.start.day - 1,
            start.hour, start.minute, start.second)] = event.events.id;
        start = start.add(Duration(minutes: 15));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*  height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       */
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "営業日時を自由に組むことができます。",
              style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(102, 102, 102, 1),
                  fontFamily: 'NotoSansJP'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.0, //MediaQuery.of(context).size.width * 0.2,
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
                              timeBuilder(_cyear, _cmonth);
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
                              timeBuilder(_cyear, _cmonth);
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
                        width: 80.0, //MediaQuery.of(context).size.width * 0.2,
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
                              timeBuilder(_cyear, _cmonth);
                            });
                          },
                          value: monthString,
                          onChanged: (value) {
                            monthString = value;
                            _cmonth = int.parse(value);
                            displayDay = DateTime(_cyear, _cmonth, _currentDay);
                            setState(() {
                              daysToDisplay = totalDays(_cmonth, _cyear);
                              _currentDay = 1;
                              timeBuilder(_cyear, _cmonth);
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
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/images_gps/settings.svg",
                    height: 25.0,
                    width: 25.0,
                  ),
                  onPressed: () {
                    setDayTiming();
                  },
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
                        rows: timeRow.length,
                        columns: daysToDisplay,
                        tableTheme: LazyDataTableTheme(
                          columnHeaderColor: Color.fromRGBO(247, 247, 247, 1),
                          columnHeaderBorder: Border.fromBorderSide(
                            BorderSide(color: Colors.transparent),
                          ),
                          rowHeaderBorder: Border.fromBorderSide(
                            BorderSide(color: Colors.transparent),
                          ),
                          rowHeaderColor: Color.fromRGBO(247, 247, 247, 1),
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
                                    color: Color.fromRGBO(158, 158, 158, 1),
                                  ),
                                ),
                                Text(
                                  timeRow[i].minute == 0
                                      ? ": 00"
                                      : ": ${timeRow[i].minute}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(158, 158, 158, 1),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        /*      (timeRow[i].hour >= startTime.hour &&
                                      timeRow[i].minute >= startTime.minute) &&
                                  (timeRow[i].hour < endTime.hour &&
                                      timeRow[i].minute < endTime.minute)) */
                        dataCellBuilder: (i, j) {
                          String dayName = DateFormat('EEEE')
                              .format(DateTime(_cyear, _cmonth, j + 1));
                          //Get Japanese Day Name
                          int dayIndex = getJaIndex(dayName);
                          DateTime startTime =
                              _storeServiceTime[dayIndex].startTime.toLocal();
                          DateTime endTime =
                              _storeServiceTime[dayIndex].endTime.toLocal();
                          int endHour = endTime.hour == 0 ? 24 : endTime.hour;
                          bool checkStartMinute = true;
                          bool checkEndMinute = true;

                          if ((timeRow[i].hour == startTime.hour)) {
                            checkStartMinute =
                                timeRow[i].minute >= startTime.minute;
                          }
                          if ((timeRow[i].hour == endHour)) {
                            checkStartMinute =
                                timeRow[i].minute <= endTime.minute;
                          }

                          if (_storeServiceTime[dayIndex].shopOpen &&
                              ((timeRow[i].hour >= startTime.hour) &&
                                  (timeRow[i].hour <= endHour)) &&
                              checkStartMinute &&
                              checkEndMinute) {
                            if (events.containsKey(timeRow[i]) &&
                                events[timeRow[i]].contains(j)) {
                              return InkWell(
                                  onTap: () {
                                    var eventId = scheduleEventId[DateTime(
                                        timeRow[i].year,
                                        timeRow[i].month,
                                        j + 1,
                                        timeRow[i].hour,
                                        timeRow[i].minute,
                                        timeRow[i].second)];
                                    setState(() {
                                      if (events[timeRow[i]].length == 1) {
                                        events.remove(timeRow[i]);
                                      } else {
                                        events[timeRow[i]].remove(j);
                                      }
                                    });
                                    if (eventId != null) {
                                      ProgressDialogBuilder
                                          .showCommonProgressDialog(context);
                                      ServiceProviderApi.removeEvent(
                                          eventId, context);
                                    }
                                  },
                                  child: Center(
                                      child: SvgPicture.asset(
                                    "assets/images_gps/X.svg",
                                    height: 20.0,
                                    width: 20.0,
                                  )));
                            } else {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (events[timeRow[i]] == null) {
                                      events[timeRow[i]] = [j];
                                    } else {
                                      events[timeRow[i]].addAll([j]);
                                    }
                                    ProgressDialogBuilder
                                        .showCommonProgressDialog(context);
                                    ServiceProviderApi.createEvent(
                                            DateTime(
                                                timeRow[i].year,
                                                timeRow[i].month,
                                                j + 1,
                                                timeRow[i].hour,
                                                timeRow[i].minute,
                                                timeRow[i].second),
                                            context)
                                        .then((value) {
                                      scheduleEventId[DateTime(
                                          timeRow[i].year,
                                          timeRow[i].month,
                                          j + 1,
                                          timeRow[i].hour,
                                          timeRow[i].minute,
                                          timeRow[i].second)] = value.id;
                                      ProgressDialogBuilder
                                          .hideCommonProgressDialog(context);
                                    });
                                  });
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
    TextStyle hourTextStyle = TextStyle(fontSize: 12.0);
    TextStyle disabledHourTextStyle =
        TextStyle(fontSize: 12.0, color: Colors.grey);
    Color containerColor = Colors.grey[100];

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            refreshState = setState;
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 16,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        containerColor, //Colors.grey[100],//Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: Color.fromRGBO(0, 0, 0, 0.16),
                  ),
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
                                _storeServiceTime.clear();
                                HealingMatchConstants.therapistDetails =
                                    List<StoreServiceTime>.from(json
                                        .decode(HealingMatchConstants
                                            .storeServiceTime)
                                        .map((x) =>
                                            StoreServiceTime.fromJson(x)));

                                //get start and End Time from Api
                                if (HealingMatchConstants.therapistDetails ==
                                        null ||
                                    HealingMatchConstants
                                            .therapistDetails.length ==
                                        0) {
                                  buildInitialTime();
                                } else {
                                  /*   storeServiceTime.addAll(HealingMatchConstants.therapistDetails);
    */
                                  converToLocalTime();
                                }

                                /*    _storeServiceTime = List<StoreServiceTime>.from(
                                    json
                                        .decode(HealingMatchConstants
                                            .storeServiceTime)
                                        .map((x) =>
                                            StoreServiceTime.fromJson(x))); */

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
                            Text("${_storeServiceTime[0].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[0].shopOpen) {
                                  showToolTip(
                                      sundayStartKey,
                                      _storeServiceTime[0].startTime,
                                      context,
                                      0,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: sundayStartKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[0].startTime.hour < 10
                                            ? "0${_storeServiceTime[0].startTime.hour}"
                                            : "${_storeServiceTime[0].startTime.hour}",
                                        style: _storeServiceTime[0].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[0].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[0].startTime.minute}"
                                            : ":${_storeServiceTime[0].startTime.minute}",
                                        style: _storeServiceTime[0].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[0].shopOpen) {
                                  showToolTip(
                                      sundayEndKey,
                                      _storeServiceTime[0].endTime,
                                      context,
                                      0,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: sundayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[0].endTime.hour < 10
                                            ? "0${_storeServiceTime[0].endTime.hour}"
                                            : "${_storeServiceTime[0].endTime.hour}",
                                        style: _storeServiceTime[0].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[0].endTime.minute < 10
                                            ? ":0${_storeServiceTime[0].endTime.minute}"
                                            : ":${_storeServiceTime[0].endTime.minute}",
                                        style: _storeServiceTime[0].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[0].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[0].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(0);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[1].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[1].shopOpen) {
                                  showToolTip(
                                      mondayStartkey,
                                      _storeServiceTime[1].startTime,
                                      context,
                                      1,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: mondayStartkey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[1].startTime.hour < 10
                                            ? "0${_storeServiceTime[1].startTime.hour}"
                                            : "${_storeServiceTime[1].startTime.hour}",
                                        style: _storeServiceTime[1].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[1].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[1].startTime.minute}"
                                            : ":${_storeServiceTime[1].startTime.minute}",
                                        style: _storeServiceTime[1].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[1].shopOpen) {
                                  showToolTip(
                                      mondayEndKey,
                                      _storeServiceTime[1].endTime,
                                      context,
                                      1,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: mondayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[1].endTime.hour < 10
                                            ? "0${_storeServiceTime[1].endTime.hour}"
                                            : "${_storeServiceTime[1].endTime.hour}",
                                        style: _storeServiceTime[1].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[1].endTime.minute < 10
                                            ? ":0${_storeServiceTime[1].endTime.minute}"
                                            : ":${_storeServiceTime[1].endTime.minute}",
                                        style: _storeServiceTime[1].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[1].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[1].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(1);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[2].weekDay}"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
                              },
                              child: InkWell(
                                onTap: () {
                                  if (_storeServiceTime[2].shopOpen) {
                                    showToolTip(
                                        tuesdayStartKey,
                                        _storeServiceTime[2].startTime,
                                        context,
                                        2,
                                        true);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: containerColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      key: tuesdayStartKey,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _storeServiceTime[2].startTime.hour <
                                                  10
                                              ? "0${_storeServiceTime[2].startTime.hour}"
                                              : "${_storeServiceTime[2].startTime.hour}",
                                          style: _storeServiceTime[2].shopOpen
                                              ? hourTextStyle
                                              : disabledHourTextStyle,
                                        ),
                                        Text(
                                          _storeServiceTime[2]
                                                      .startTime
                                                      .minute <
                                                  10
                                              ? ":0${_storeServiceTime[2].startTime.minute}"
                                              : ":${_storeServiceTime[2].startTime.minute}",
                                          style: _storeServiceTime[2].shopOpen
                                              ? hourTextStyle
                                              : disabledHourTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[2].shopOpen) {
                                  showToolTip(
                                      tuesdayEndKey,
                                      _storeServiceTime[2].endTime,
                                      context,
                                      2,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: tuesdayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[2].endTime.hour < 10
                                            ? "0${_storeServiceTime[2].endTime.hour}"
                                            : "${_storeServiceTime[2].endTime.hour}",
                                        style: _storeServiceTime[2].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[2].endTime.minute < 10
                                            ? ":0${_storeServiceTime[2].endTime.minute}"
                                            : ":${_storeServiceTime[2].endTime.minute}",
                                        style: _storeServiceTime[2].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[2].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[2].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(2);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[3].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[3].shopOpen) {
                                  showToolTip(
                                      wednedayStartKey,
                                      _storeServiceTime[3].startTime,
                                      context,
                                      3,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: wednedayStartKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[3].startTime.hour < 10
                                            ? "0${_storeServiceTime[3].startTime.hour}"
                                            : "${_storeServiceTime[3].startTime.hour}",
                                        style: _storeServiceTime[3].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[3].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[3].startTime.minute}"
                                            : ":${_storeServiceTime[3].startTime.minute}",
                                        style: _storeServiceTime[3].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[3].shopOpen) {
                                  showToolTip(
                                      wednesdayEndKey,
                                      _storeServiceTime[3].endTime,
                                      context,
                                      3,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: wednesdayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[3].endTime.hour < 10
                                            ? "0${_storeServiceTime[3].endTime.hour}"
                                            : "${_storeServiceTime[3].endTime.hour}",
                                        style: _storeServiceTime[3].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[3].endTime.minute < 10
                                            ? ":0${_storeServiceTime[3].endTime.minute}"
                                            : ":${_storeServiceTime[3].endTime.minute}",
                                        style: _storeServiceTime[3].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[3].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[3].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(3);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[4].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[4].shopOpen) {
                                  showToolTip(
                                      thursdayStartKey,
                                      _storeServiceTime[4].startTime,
                                      context,
                                      4,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: thursdayStartKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[4].startTime.hour < 10
                                            ? "0${_storeServiceTime[4].startTime.hour}"
                                            : "${_storeServiceTime[4].startTime.hour}",
                                        style: _storeServiceTime[4].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[4].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[4].startTime.minute}"
                                            : ":${_storeServiceTime[4].startTime.minute}",
                                        style: _storeServiceTime[4].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[4].shopOpen) {
                                  showToolTip(
                                      thursdayEndKey,
                                      _storeServiceTime[4].endTime,
                                      context,
                                      4,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: thursdayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[4].endTime.hour < 10
                                            ? "0${_storeServiceTime[4].endTime.hour}"
                                            : "${_storeServiceTime[4].endTime.hour}",
                                        style: _storeServiceTime[4].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[4].endTime.minute < 10
                                            ? ":0${_storeServiceTime[4].endTime.minute}"
                                            : ":${_storeServiceTime[4].endTime.minute}",
                                        style: _storeServiceTime[4].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[4].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[4].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(4);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[5].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[5].shopOpen) {
                                  showToolTip(
                                      fridayStartKey,
                                      _storeServiceTime[5].startTime,
                                      context,
                                      5,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: fridayStartKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[5].startTime.hour < 10
                                            ? "0${_storeServiceTime[5].startTime.hour}"
                                            : "${_storeServiceTime[5].startTime.hour}",
                                        style: _storeServiceTime[5].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[5].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[5].startTime.minute}"
                                            : ":${_storeServiceTime[5].startTime.minute}",
                                        style: _storeServiceTime[5].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[5].shopOpen) {
                                  showToolTip(
                                      fridayEndKey,
                                      _storeServiceTime[5].endTime,
                                      context,
                                      5,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: fridayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[5].endTime.hour < 10
                                            ? "0${_storeServiceTime[5].endTime.hour}"
                                            : "${_storeServiceTime[5].endTime.hour}",
                                        style: _storeServiceTime[5].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[5].endTime.minute < 10
                                            ? ":0${_storeServiceTime[5].endTime.minute}"
                                            : ":${_storeServiceTime[5].endTime.minute}",
                                        style: _storeServiceTime[5].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[5].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[5].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(5);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${_storeServiceTime[6].weekDay}"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[6].shopOpen) {
                                  showToolTip(
                                      saturdayStartKey,
                                      _storeServiceTime[6].startTime,
                                      context,
                                      6,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: saturdayStartKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[6].startTime.hour < 10
                                            ? "0${_storeServiceTime[6].startTime.hour}"
                                            : "${_storeServiceTime[6].startTime.hour}",
                                        style: _storeServiceTime[6].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[6].startTime.minute <
                                                10
                                            ? ":0${_storeServiceTime[6].startTime.minute}"
                                            : ":${_storeServiceTime[6].startTime.minute}",
                                        style: _storeServiceTime[6].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("~"),
                            InkWell(
                              onTap: () {
                                if (_storeServiceTime[6].shopOpen) {
                                  showToolTip(
                                      saturdayEndKey,
                                      _storeServiceTime[6].endTime,
                                      context,
                                      6,
                                      false);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: containerColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    key: saturdayEndKey,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _storeServiceTime[6].endTime.hour < 10
                                            ? "0${_storeServiceTime[6].endTime.hour}"
                                            : "${_storeServiceTime[6].endTime.hour}",
                                        style: _storeServiceTime[6].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                      Text(
                                        _storeServiceTime[6].endTime.minute < 10
                                            ? ":0${_storeServiceTime[6].endTime.minute}"
                                            : ":${_storeServiceTime[6].endTime.minute}",
                                        style: _storeServiceTime[6].shopOpen
                                            ? hourTextStyle
                                            : disabledHourTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CustomSwitch(
                              activeColor: Colors.lime,
                              value: _storeServiceTime[6].shopOpen,
                              onChanged: (value) {
                                print("VALUE : $value");
                                if (value) {
                                  refreshState(() {
                                    _storeServiceTime[6].shopOpen = value;
                                  });
                                } else {
                                  showConfirmDialog(6);
                                }
                              },
                            ),
                          ],
                        ),
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
                              ProgressDialogBuilder.showCommonProgressDialog(
                                  context);
                              ServiceProviderApi.saveShiftServiceTime(
                                  _storeServiceTime, context);
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
                    minutesInterval: 15,
                    normalTextStyle: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(217, 217, 217, 1), // Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    highlightedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                    spacing: 30,
                    itemHeight: 40,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        _dateTime = time;
                        print("$_dateTime");
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

  showConfirmDialog(int index) {
    String day = _storeServiceTime[index].weekDay;
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
                    "全ての$dayをXにします",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildButton(index)
                ],
              ),
            ),
          );
        });
  }

  //Method called from ShowtoolTip to refresh the page after TimePicker is Selected
  refreshPage(int index, DateTime newTime, bool isStart) {
    refreshState(() {
      isStart
          ? _storeServiceTime[index].startTime = newTime
          : _storeServiceTime[index].endTime = newTime;
    });
  }

  void showToolTip(
      var key, DateTime time, BuildContext context, int index, bool isStart) {
    var width = MediaQuery.of(context).size.width - 10.0;
    print(width);
    ShowToolTip popup = ShowToolTip(context, refreshPage,
        time: time,
        index: index,
        isStart: isStart,
        textStyle: TextStyle(color: Colors.black),
        height: 110,
        width: MediaQuery.of(context).size.width * 0.73, //180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
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

  buildButton(int index) {
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
              refreshState(() {
                _storeServiceTime[index].shopOpen = false;
              });
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
