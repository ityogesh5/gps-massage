import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/lazyTable/lazy_data_table.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/event.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';

class ChooseDate extends StatefulWidget {
  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool readonly = false;
  String yearString, monthString, dateString;
  DateTime today = DateTime.now();
  DateTime displayDay;
  DateTime selectedTime;
  int _cyear;
  int _cmonth;
  int _currentDay;
  int _lastday;
  int daysToDisplay;
  int startTime;
  int endTime;
  int loadingStatus = 0;
  int selectedMin;
  int startingDay = 0;
  int state = 0;
  int _selectedYearIndex = 0;
  int _selectedMonthIndex = 0;
  int _yearChangedNumber = 0;
  int _monthChangedNumber = 0;
  bool _isVisible = true;
  TextEditingController yearController = new TextEditingController();
  TextEditingController monthController = TextEditingController();
  List<DateTime> timeRow = List<DateTime>();
  List<String> dayNames = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];
  List<StoreServiceTiming> storeServiceTime = List<StoreServiceTiming>();
  List<FlutterWeekViewEvent> calendarEvents = List<FlutterWeekViewEvent>();
  Map<DateTime, List<int>> bookEvents = Map<DateTime, List<int>>();
  Map<DateTime, List<int>> events = Map<DateTime, List<int>>();
  List<String> yearDropDownValues = List<String>();
  List<String> monthDropDownValues = List<String>();
  bool status = false;
  bool isSeleted = false;
  GlobalKey key = new GlobalKey();
  Size buttonSize;
  Offset buttonPosition;
  LazyDataTable lazyDataTable;

  @override
  void initState() {
    super.initState();
    startTime = 0;
    startingDay = today.day;
    endTime = 23;
    dateString = '';
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    yearController.text = _cyear.toString();
    monthController.text = _cmonth.toString();
    buildYearDropDown();
    getSelectedDate();
    daysToDisplay = totalDays(_cmonth, _cyear);
    timeBuilder(_cyear, _cmonth);
    selectedMin = HealingMatchConstants.selectedMin;
    ServiceUserAPIProvider.getProviderCalEvents().then((value) {
      calendarEvents.addAll(value);
      getEvents();
    });
  }

  getSelectedDate() {
    if (HealingMatchConstants.selectedDateTime != null) {
      selectedTime = HealingMatchConstants.selectedDateTime;
      _cyear = selectedTime.year;
      _cmonth = selectedTime.month;
      _currentDay = selectedTime.day;
      _lastday = DateTime(selectedTime.year, selectedTime.month + 1, 0).day;
      bookEvents[DateTime(
          _cyear, _cmonth, 1, selectedTime.hour, selectedTime.minute)] = [
        _currentDay - 1
      ];
      isSeleted = true;
    } else {
      displayDay = today;
      _cyear = DateTime.now().year;
      _cmonth = DateTime.now().month;
      _currentDay = DateTime.now().day;
      _lastday = DateTime(today.year, today.month + 1, 0).day;
    }
    yearString = _cyear.toString();
    monthString = _cmonth.toString();
  }

  findButton(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  getEvents() {
    calendarEvents.addAll(HealingMatchConstants.userEvents);
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
        DateTime(year, month, 1, startTime, 0); //1st day is mentioned as dummy
    if (timeRow != null) {
      timeRow.clear();
    }
    while (start.hour <= endTime && start.day == 1) {
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

  buildYearDropDown() {
    for (int i = today.year; i <= today.year + 1; i++) {
      yearDropDownValues.add(i.toString());
    }
    buildMonthDropDown(today.year);
  }

  buildMonthDropDown(int _cyear) {
    monthDropDownValues.clear();
    if (_cyear == today.year && _cmonth <= today.month) {
      monthController.text = today.month.toString();
      _cmonth = today.month;
      _selectedMonthIndex = 0;
    } else {
      _cmonth = 1;
      _selectedMonthIndex = _cmonth - 1;
    }

    for (int i = _cyear == today.year ? today.month : 1; i <= 12; i++) {
      monthDropDownValues.add(i.toString());
    }

    setState(() {});
  }

  Future buildYearPicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    "キャンセル",
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: CupertinoPicker(
                      scrollController: new FixedExtentScrollController(
                        initialItem: _selectedYearIndex,
                      ),
                      itemExtent: 32.0,
                      // magnification: 0.0,
                      backgroundColor: Colors.white,
                      onSelectedItemChanged: (int index) {
                        _yearChangedNumber = index;
                      },
                      children: new List<Widget>.generate(
                          yearDropDownValues.length, (int index) {
                        return new Center(
                          child: new Text('${yearDropDownValues[index]}'),
                        );
                      })),
                ),
                CupertinoButton(
                  child: Text("完了", style: TextStyle(fontSize: 12.0)),
                  onPressed: () {
                    setState(() {
                      _selectedYearIndex = _yearChangedNumber;
                      yearController.text =
                          yearDropDownValues[_selectedYearIndex];
                      _cyear = int.parse(yearController.text);
                      buildMonthDropDown(_cyear);
                      _currentDay =
                          (_cyear == today.year) && (_cmonth == today.month)
                              ? today.day
                              : 1;
                      displayDay = DateTime(_cyear, _cmonth, _currentDay);
                      daysToDisplay = totalDays(_cmonth, _cyear);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future buildMonthPicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    "キャンセル",
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: CupertinoPicker(
                      scrollController: new FixedExtentScrollController(
                        initialItem: _selectedMonthIndex,
                      ),
                      itemExtent: 32.0,
                      backgroundColor: Colors.white,
                      onSelectedItemChanged: (int index) {
                        _monthChangedNumber = index;
                      },
                      children: new List<Widget>.generate(
                          monthDropDownValues.length, (int index) {
                        return new Center(
                          child: new Text('${monthDropDownValues[index]}月'),
                        );
                      })),
                ),
                CupertinoButton(
                  child: Text("完了", style: TextStyle(fontSize: 12.0)),
                  onPressed: () {
                    setState(() {
                      _selectedMonthIndex = _monthChangedNumber;
                      monthController.text =
                          monthDropDownValues[_selectedMonthIndex];
                      _cmonth = int.parse(monthController.text);

                      _currentDay =
                          (_cyear == today.year) && (_cmonth == today.month)
                              ? today.day
                              : 1;
                      displayDay = DateTime(_cyear, _cmonth, _currentDay);
                      daysToDisplay = totalDays(_cmonth, _cyear);
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state == 0 && lazyDataTable != null) {
        lazyDataTable.jumpToCell(startingDay - 1, 0);
        state = 1;
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: loadingStatus == 0
          ? Container(
              color: Colors.white,
              child: Center(child: SpinKitThreeBounce(color: Colors.lime)),
            )
          : Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 51.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            if (_isVisible) {
                              buildYearPicker(context);
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: yearController,
                            style: _isVisible
                                ? HealingMatchConstants.formTextStyle
                                : HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 7.0, top: 5.0, bottom: 5.0, right: 5.0),
                              focusedBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              disabledBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              enabledBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              suffixIcon: IconButton(
                                  padding: EdgeInsets.only(left: 8.0),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30.0,
                                    color: _isVisible
                                        ? Colors.black
                                        : Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Container(
                        height: 51.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            if (_isVisible) {
                              buildMonthPicker(context);
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: monthController,
                            style: _isVisible
                                ? HealingMatchConstants.formTextStyle
                                : HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 7.0, top: 5.0, bottom: 5.0, right: 5.0),
                              focusedBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              disabledBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              enabledBorder: HealingMatchConstants
                                  .datePickerTextFormInputBorder,
                              suffixIcon: IconButton(
                                  padding: EdgeInsets.only(left: 8.0),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30.0,
                                    color: _isVisible
                                        ? Colors.black
                                        : Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
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
                            child: buildLazyDataTable(),
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          if (selectedTime != null) {
            HealingMatchConstants.selectedDateTime = selectedTime;
            HealingMatchConstants.callBack(selectedTime);
          }

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
    );
  }

  LazyDataTable buildLazyDataTable() {
    lazyDataTable = LazyDataTable(
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
      columnHeaderBuilder: (i) {
        String dayName =
            DateFormat('E', 'ja_JP').format(DateTime(_cyear, _cmonth, i + 1));
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${i + 1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "$dayName",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0),
              ),
            ],
          ),
        );
      },
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
                timeRow[i].minute == 0 ? ": 00" : ": ${timeRow[i].minute}",
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
      dataCellBuilder: (i, j) {
        String dayName =
            DateFormat('EEEE').format(DateTime(_cyear, _cmonth, j + 1));
        //Get Japanese Day Name
        int dayIndex = getJaIndex(dayName);
        DateTime startTime = storeServiceTime[dayIndex].startTime.toLocal();
        DateTime endTime = storeServiceTime[dayIndex].endTime.toLocal();
        int endHour = endTime.hour == 0 ? 24 : endTime.hour;
        bool checkStartMinute = true;
        bool checkEndMinute = true;

        if ((timeRow[i].hour == startTime.hour)) {
          checkStartMinute = timeRow[i].minute >= startTime.minute;
        }
        if ((timeRow[i].hour == endHour)) {
          checkEndMinute = timeRow[i].minute <= endTime.minute;
        }

        if (storeServiceTime[dayIndex].shopOpen &&
            ((timeRow[i].hour >= startTime.hour) &&
                (timeRow[i].hour <= endHour)) &&
            checkStartMinute &&
            checkEndMinute) {
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
                bool isTimeAvailable =
                    checkTimeAvailable(i, j, startTime, endTime);

                if (/* !isSeleted && */ isTimeAvailable) {
                  bookEvents.clear();

                  saveSelectedTime(j, i);
                }
                /* else if (isSeleted) {
                  showAlreadySelectedTimeError();
                }  */
                else if (!isTimeAvailable) {
                  showProviderTimeUnavailble();
                }
              },
              child: Center(
                  child: SvgPicture.asset(
                isSeleted
                    ? "assets/images_gps/greyO.svg"
                    : "assets/images_gps/O.svg",
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
    );
    return lazyDataTable;
  }

  void saveSelectedTime(int j, int i) {
    bool isValid = timeDurationSinceDate(DateTime(_cyear, _cmonth, j + 1,
        timeRow[i].hour, timeRow[i].minute, timeRow[i].second));
    if (isValid) {
      setState(() {
        bookEvents[timeRow[i]] = [j];
        isSeleted = true;
        selectedTime = DateTime(_cyear, _cmonth, j + 1, timeRow[i].hour,
            timeRow[i].minute, timeRow[i].second);
      });
    } else {
      showInvalidTimeError();
    }
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

  bool checkTimeAvailable(
    int i,
    int j,
    DateTime startTime,
    DateTime endTime,
  ) {
    // bookEvents[timeRow[i]] = [j];
    int iterationLength = selectedMin ~/ 15;
    int endHour = endTime.hour == 0 ? 24 : endTime.hour;

    try {
      for (int k = 1; k < iterationLength; k++) {
        if (events.containsKey(timeRow[i + k]) &&
            events[timeRow[i + k]].contains(j)) {
          return false;
        }
        bool checkStartMinute = true;
        bool checkEndMinute = true;
        if ((timeRow[i + k].hour == startTime.hour)) {
          checkStartMinute = timeRow[i + k].minute >= startTime.minute;
        }
        if ((timeRow[i + k].hour == endHour)) {
          checkEndMinute = timeRow[i + k].minute <= endTime.minute;
        }
        if (!(((timeRow[i + k].hour >= startTime.hour) &&
                (timeRow[i + k].hour <= endHour)) &&
            checkStartMinute &&
            checkEndMinute)) {
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  bool timeDurationSinceDate(var dateString, {bool numericDates = true}) {
    final date2 = DateTime.now();
    var differenceInTime = date2.difference(dateString);
    print('Converted Date and Time  : ${differenceInTime.inMinutes}');
    if (differenceInTime.inMinutes > -30) {
      print('PAST TIME');
      return false;
    } else if (differenceInTime.inMinutes.floor() <= -30) {
      print('FUTURE TIME');
      return true;
    }
  }

  showAlreadySelectedTimeError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text('時間を変更する場合は、選択中の時間をタップしてから再度選択しなおしてください',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontFamily: 'NotoSansJP')),
          ),
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            child: Text('はい',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline)),
          ),
        ],
      ),
    ));
    return;
  }

  showProviderTimeUnavailble() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
                'ご選択の予約時間以内にはセラピストに予約不可(X)とマークされたところもありますので、ほかの時間をお選びください。',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontFamily: 'NotoSansJP')),
          ),
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            child: Text('はい',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline)),
          ),
        ],
      ),
    ));
    return;
  }

  showInvalidTimeError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text('予約の時間を現在の時間より30分後にする必要があります。',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontFamily: 'NotoSansJP')),
          ),
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            child: Text('はい',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline)),
          ),
        ],
      ),
    ));
    return;
  }
}
