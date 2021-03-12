import 'dart:convert';

import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/customradiobutton.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:gps_massageapp/models/customModels/searchAddAddress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreenUser extends StatefulWidget {
  @override
  _SearchScreenUserState createState() => _SearchScreenUserState();
}

class _SearchScreenUserState extends State<SearchScreenUser> {
  int _value = 0;
  String val = "S";
  String values = "D";
  bool _isVisible = true;

  NumberPicker dayPicker;
  int _cyear;
  int _cmonth;
  int _currentDay;
  int daysToDisplay;
  DateTime today = DateTime.now();
  int _lastday;

  DateTime displayDay;
  int _counter = 0;
  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();

  bool readonly = false;
  var yearString, monthString, dateString;

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
    setState(() {
      print(daysToDisplay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          color: Colors.black,
        ),
        title: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextFormField(
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: HealingMatchConstants.searchKeyword,
                suffixIcon: Image.asset("assets/images_gps/search.png",
                    color: Color.fromRGBO(225, 225, 225, 1)),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(225, 225, 225, 1),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(7),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HealingMatchConstants.searchAreaTxt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 32,
                            backgroundColor: Color.fromRGBO(200, 217, 33, 1),
                            child: SvgPicture.asset(
                                'assets/images_gps/current_location.svg',
                                color: Color.fromRGBO(255, 255, 255, 1),
                                height: 30,
                                width: 30),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            HealingMatchConstants.searchGpsIconTxt,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 32,
                            backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                            child: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: new Icon(Icons.add),
                                highlightColor: Color.fromRGBO(0, 0, 0, 1),
                                iconSize: 35,
                                onPressed: () {
                                  /*NavigationRouter.switchToUserAddAddressScreen(context);*/
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '地点を追加',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              maxRadius: 32,
                              backgroundColor: Colors.grey[200],
                              child: SvgPicture.asset(
                                  'assets/images_gps/house.svg',
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  height: 30,
                                  width: 30),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            HealingMatchConstants.searchHomeIconTxt,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              maxRadius: 32,
                              backgroundColor: Colors.grey[200],
                              child: SvgPicture.asset(
                                  'assets/images_gps/office.svg',
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  height: 30,
                                  width: 30),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            HealingMatchConstants.searchOfficeIconTxt,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              maxRadius: 32,
                              backgroundColor: Colors.grey[200],
                              child: SvgPicture.asset(
                                  'assets/images_gps/parents_house.svg',
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  height: 30,
                                  width: 30),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            HealingMatchConstants.searchPHomeIconTxt,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(HealingMatchConstants.searchServiceSelTxt,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _value = 0),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 0
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 0
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeOne.svg',
                              color: _value == 0
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                              height: 25,
                              width: 25,
                            ),
                          ),
                          Text(
                            HealingMatchConstants.searchEsteticTxt,
                            style: TextStyle(
                              color: _value == 0
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _value = 1),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 1
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 1
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeTwo.svg',
                              color: _value == 1
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                              height: 25,
                              width: 25,
                            ),
                          ),
                          Text(
                            HealingMatchConstants.searchOsthepaticTxt,
                            style: TextStyle(
                              color: _value == 1
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _value = 2),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 2
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 2
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeThree.svg',
                              color: _value == 2
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                              height: 25,
                              width: 25,
                            ),
                          ),
                          Text(
                            HealingMatchConstants.searchRelaxationTxt,
                            style: TextStyle(
                              color: _value == 2
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _value = 3),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _value == 3
                                  ? Color.fromRGBO(242, 242, 242, 1)
                                  : Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: _value == 3
                                    ? Color.fromRGBO(102, 102, 102, 1)
                                    : Color.fromRGBO(228, 228, 228, 1),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images_gps/serviceTypeFour.svg',
                              color: _value == 3
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            HealingMatchConstants.searchFitnessTxt,
                            style: TextStyle(
                              color: _value == 3
                                  ? Color.fromRGBO(0, 0, 0, 1)
                                  : Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  // height: 50,
                  color: Color.fromRGBO(236, 236, 236, 1),
                ),
                Text(
                  HealingMatchConstants.searchTravelTxt,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: CustomRadioButton(
                    padding: 5.0,
                    elevation: 0,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.40,
                    buttonColor: Theme.of(context).canvasColor,
                    enableShape: true,
                    customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black38)),
                    buttonLables: ["店舗に行く", "来てもらう"],
                    fontSize: 13.0,
                    buttonValues: [
                      "S",
                      "R",
                    ],
                    radioButtonValue: (value) {
                      print(value);
                      setState(() {
                        val = value;
                      });
                      print(val);
                    },
                    selectedColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  HealingMatchConstants.searchDateTxt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: CustomRadioButton(
                    padding: 5.0,
                    elevation: 0,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.40,
                    buttonColor: Theme.of(context).canvasColor,
                    enableShape: true,
                    customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black38)),
                    buttonLables: ["受けたい日時でさがす", "セラピストをさがす"],
                    fontSize: 12.0,
                    buttonValues: [
                      "D",
                      "T",
                    ],
                    radioButtonValue: (value) {
                      // print(value);
                      setState(() {
                        values = value;
                        print(values);
                        if (values != null && values.contains('T')) {
                          _isVisible = false;
                        } else if (values != null && values.contains('D')) {
                          _isVisible = true;
                        }
                      });
                    },
                    selectedColor: Colors.grey,
                  ),
                ),
                Container(
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
                              color: Color.fromRGBO(255, 255, 255, 1),
                              child: DropDownFormField(
                                enabled: _isVisible,
                                fillColor: values == 'T'
                                    ? Color.fromRGBO(242, 242, 242, 1)
                                    : Color.fromRGBO(255, 255, 255, 1),
                                borderColor: Color.fromRGBO(228, 228, 228, 1),
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
                                    displayDay =
                                        DateTime(_cyear, _cmonth, _currentDay);

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
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  color: Colors.transparent,
                                  child: DropDownFormField(
                                    enabled: _isVisible,
                                    fillColor: values == 'T'
                                        ? Color.fromRGBO(242, 242, 242, 1)
                                        : Color.fromRGBO(255, 255, 255, 1),
                                    borderColor:
                                        Color.fromRGBO(228, 228, 228, 1),
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
                buildDayPicker(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: RaisedButton(
                    child: Text(
                      'さがす',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'NotoSansJP',
                          fontSize: 18),
                    ),
                    color: Color.fromRGBO(200, 217, 33, 1),
                    onPressed: () {
                      NavigationRouter.switchToUserSearchResult(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDayPicker() {
    dayPicker = NumberPicker.horizontal(
      currentDate: DateTime.now(),
      selectedYear: _cyear,
      ismonth: true,
      numberToDisplay: 7,
      selectedMonth: _cmonth,
      eventDates: [
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day),
        DateTime(today.year, today.month, today.day + 1),
        DateTime(today.year, today.month, today.day + 1)
      ],
      zeroPad: false,
      initialValue: _currentDay,
      minValue: 1,
      maxValue: daysToDisplay,
      onChanged: (newValue) => setState(() {
        if ((newValue != _currentDay)) {
          changeDay(newValue);
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
