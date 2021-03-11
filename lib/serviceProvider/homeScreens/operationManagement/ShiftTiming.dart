import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customSwitch/custom_switch.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/lazyTable/lazy_data_table.dart';

class ShiftTiming extends StatefulWidget {
  @override
  _ShiftTimingState createState() => _ShiftTimingState();
}

class _ShiftTimingState extends State<ShiftTiming> {
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
  List<String> time = List<String>();
  Map<String, DateTime> schedule = Map<String, DateTime>();
  int min;
  bool status = false;
  GlobalKey key = new GlobalKey();

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
    time.add(startTime.toString() + ": " + "00");
    getTime();
  }

  getTime() {
    for (int i = 0; i < 60; i++) {
      /*  int y = int.tryParse(startTime.toStringAsFixed(2).split('.')[1]);
      if (y == 45) {
        startTime = startTime + 0.55;
      } else {
        startTime = startTime + 0.15;
      }
 */

      if (min == 45) {
        min = 0;
        startTime = startTime + 1;
      } else {
        min = min + 15;
      }
      time.add(startTime.toString() + ": " + min.toString());
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
                  fontSize: 12.0, color: Color.fromRGBO(102, 102, 102, 1)),
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
                        width: MediaQuery.of(context).size.width * 0.2,
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
                        width: MediaQuery.of(context).size.width * 0.2,
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
                            displayDay = DateTime(_cyear, _cmonth, _currentDay);
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
                        rows: 45,
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
                            child: Text(
                              "${time[i]}",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(158, 158, 158, 1),
                              ),
                            ),
                          );
                        },
                        dataCellBuilder: (i, j) {
                          if ((schedule.containsKey(time[i])) &&
                              schedule[time[i]] ==
                                  DateTime(_cyear, _cmonth, j)) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    schedule.remove(time[i]);
                                  });
                                },
                                child: Center(
                                    child: Text(
                                  "X",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(193, 193, 193, 1),
                                  ),
                                )));
                          } else {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  schedule[time[i]] =
                                      DateTime(_cyear, _cmonth, j);
                                });
                              },
                              child: Center(
                                child: Text(
                                  "O",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            );
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
    bool timePicker = false;
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
                                setState(() {
                                  timePicker = !timePicker;
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                        timePicker
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 50.0),
                                            CustomPaint(
                                              size: Size(15.0, 10.0),
                                              painter: TrianglePainter(
                                                  isDownArrow: false,
                                                  color: Colors.grey[100]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomPaint(
                                              size: Size(15.0, 10.0),
                                              painter: TrianglePainter(
                                                  isDownArrow: false,
                                                  color: Colors.white),
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
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                              )
                            : Container(),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("火曜日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("木曜日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("金曜日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("土曜日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("日曜 日"),
                            InkWell(
                              onTap: () {
                                /* setState(() {
                                  timePicker = true;
                                }); */
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
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("12:30")),
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
                                    fontWeight: FontWeight.w800,
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
