import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:date_util/date_util.dart';

class ProviderHome extends StatefulWidget {
  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
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
                Image.asset(
                  'assets/images_gps/homeTop.png',
                  height: 100.0,
                  //width: 30,
                ),
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
                              CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images_gps/car.jpg',
                              fit: BoxFit.fitHeight,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            icon: new Icon(Icons.star,
                                                size: 16.0),
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
                              Text(
                                ' 東京都須田町丁目 ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images_gps/car.jpg',
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
                          height: 120,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images_gps/car.jpg',
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
                          height: 120,
                          color: Colors.white,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade200, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images_gps/car.jpg',
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
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                      SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {

                            },
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
            )
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
}
