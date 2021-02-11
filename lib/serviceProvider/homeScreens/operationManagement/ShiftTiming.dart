import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

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
  double startTime;
  double endTime;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      body: Container(
        /*  height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       */
        padding: EdgeInsets.all(8.0),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.transparent,
                  child: DropDownFormField(
                    contentPadding: EdgeInsets.all(1.0),
                    titleText: null,
                    hintText: readonly
                        ? yearString
                        : HealingMatchConstants.registrationBankAccountType,
                    onSaved: (value) {
                      setState(() {
                        yearString = value;
                        _cyear = int.parse(value);
                        _currentDay = 1;
                        displayDay = DateTime(_cyear, _cmonth, _currentDay);
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
                        displayDay = DateTime(_cyear, _cmonth, _currentDay);

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
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.38,
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
                                displayDay =
                                    DateTime(_cyear, _cmonth, _currentDay);
                                /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
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
                                /*    daysToDisplay =
                                                        totalDays(_cmonth, _cyear); */
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
                        rows: 15,
                        columns: daysToDisplay,
                        tableTheme: LazyDataTableTheme(
                          columnHeaderColor: Colors.grey[200],
                          columnHeaderBorder: Border.fromBorderSide(
                            BorderSide(color: Colors.transparent),
                          ),
                          rowHeaderBorder: Border.fromBorderSide(
                            BorderSide(color: Colors.transparent),
                          ),
                          rowHeaderColor: Colors.grey[200],
                          cornerBorder: Border.fromBorderSide(
                            BorderSide(color: Colors.transparent),
                          ),
                          cornerColor: Colors.grey[200],
                          cellBorder: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide(color: Colors.grey[400])),
                          alternateCellBorder: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide(color: Colors.grey[400])),
                          alternateCellColor: Colors.white,
                        ),
                        tableDimensions: LazyDataTableDimensions(
                          cellHeight: 50,
                          cellWidth: 50,
                          columnHeaderHeight: 50,
                          rowHeaderWidth: 50,
                        ),
                        columnHeaderBuilder: (i) =>
                            Center(child: Text("${i + 1}")),
                        rowHeaderBuilder: (i) =>
                            Center(child: Text("${i + 1}")),
                        dataCellBuilder: (i, j) => Center(child: Text("X")),
                        cornerWidget: Center(child: Text("日時")),
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
}
