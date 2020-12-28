import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_massageapp/utils/dropdown.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

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
  int _currentDay;
  var now = DateTime.now();
  int _lastday;

  void initState() {
    super.initState();
    yearString = '';
    monthString = '';
    dateString = '';

    _cyear = DateTime.now().year;
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
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: yearKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.38,
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
                                    });
                                  },
                                  value: yearString,
                                  onChanged: (value) {
                                    setState(() {
                                      yearString = value;
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "display": "普通",
                                      "value": "普通",
                                    },
                                    {
                                      "display": "当座",
                                      "value": "当座",
                                    },
                                    {
                                      "display": "貯蓄",
                                      "value": "貯蓄",
                                    },
                                  ],
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.38,
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
                                        });
                                      },
                                      value: monthString,
                                      onChanged: (value) {
                                        setState(() {
                                          monthString = value;
                                        });
                                      },
                                      dataSource: [
                                        {
                                          "display": "普通",
                                          "value": "普通",
                                        },
                                        {
                                          "display": "当座",
                                          "value": "当座",
                                        },
                                        {
                                          "display": "貯蓄",
                                          "value": "貯蓄",
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
                  ],
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
}
