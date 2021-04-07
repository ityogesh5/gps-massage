import 'dart:convert';

import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customradiobutton.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/models/customModels/userSearchAddAddress.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
List<AddUserSearchAddress> otherUserAddress = new List<AddUserSearchAddress>();

class SearchScreenUser extends StatefulWidget {
  @override
  _SearchScreenUserState createState() => _SearchScreenUserState();
}

class _SearchScreenUserState extends State<SearchScreenUser> {
  int _value = 0;
  String val = "S";
  String values = "D";
  bool _isVisible = true;
  bool _addAddressVisible = true;

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
  final keywordController = new TextEditingController();

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
      /*   appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        leading:
        centerTitle: false,
      ),
     */
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      onPressed: () {
                        NavigationRouter.switchToServiceUserBottomBar(context);
                      },
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(0.0),
                          height:
                              48.0, //MediaQuery.of(context).size.height * 0.06,
                          child: TextFormField(
                            controller: keywordController,
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            decoration: new InputDecoration(
                                contentPadding: EdgeInsets.all(4.0),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: HealingMatchConstants.searchKeyword,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    "assets/images_gps/search.png",
                                    height: 22,
                                    width: 22,
                                    color: Color.fromRGBO(225, 225, 225, 1),
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(225, 225, 225, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(7),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        HealingMatchConstants.searchAreaTxt,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Container(
                              height: 60,
                              child: VerticalDivider(
                                  color: Color.fromRGBO(236, 236, 236, 1))),
                        ),
                        _addAddressVisible
                            ? Column(
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
                                        icon: new Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        highlightColor:
                                            Color.fromRGBO(0, 0, 0, 1),
                                        iconSize: 35,
                                        onPressed: () {
                                          NavigationRouter
                                              .switchToUserSearchAddAddressScreen(
                                                  context);
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
                              )
                            : SizedBox.shrink(),
                        SizedBox(width: _addAddressVisible ? 15 : 0.0),
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
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(HealingMatchConstants.searchServiceSelTxt,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _value = 0),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _value == 0 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeOne.svg',
                                        color: _value == 0
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 29.81,
                                        width: 27.61,
                                      ),
                                    ),
                                  ),
                                ),
                                /*    Text(
                                  HealingMatchConstants.searchEsteticTxt,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: _value == 0
                                        ? Color.fromRGBO(0, 0, 0, 1)
                                        : Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ),
                              */
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _value = 1),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _value == 1 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeTwo.svg',
                                        color: _value == 1
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 33,
                                        width: 34,
                                      ),
                                    ),
                                  ),
                                ),
                                /*  Text(
                                  HealingMatchConstants.searchOsthepaticTxt,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: _value == 1
                                        ? Color.fromRGBO(0, 0, 0, 1)
                                        : Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ), */
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _value = 2),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _value == 2 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeThree.svg',
                                        color: _value == 2
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
/*                                 Text(
                                  HealingMatchConstants.searchRelaxationTxt,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: _value == 2
                                        ? Color.fromRGBO(0, 0, 0, 1)
                                        : Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ), */
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _value = 3),
                            child: Column(
                              children: [
                                Card(
                                  elevation: _value == 3 ? 4.0 : 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        'assets/images_gps/serviceTypeFour.svg',
                                        color: _value == 3
                                            ? Color.fromRGBO(0, 0, 0, 1)
                                            : Color.fromRGBO(217, 217, 217, 1),
                                        height: 35,
                                        width: 27,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                /*   Text(
                                  HealingMatchConstants.searchFitnessTxt,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: _value == 3
                                        ? Color.fromRGBO(0, 0, 0, 1)
                                        : Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ), */
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchEsteticTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _value == 0
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchOsthepaticTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _value == 1
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                HealingMatchConstants.searchRelaxationTxt,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: _value == 2
                                      ? Color.fromRGBO(0, 0, 0, 1)
                                      : Color.fromRGBO(217, 217, 217, 1),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              HealingMatchConstants.searchFitnessTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _value == 3
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Color.fromRGBO(217, 217, 217, 1),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Color.fromRGBO(236, 236, 236, 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        HealingMatchConstants.searchTravelTxt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: CustomRadioButton(
                    padding: 0.0,
                    elevation: 4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.40,
                    buttonColor: Theme.of(context).canvasColor,
                    enableShape: true,
                    /*  customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black38)),
                    */
                    buttonLables: ["店舗に行く", "来てもらう"],
                    fontSize: 12.0,
                    buttonValues: [
                      "S",
                      "R",
                    ],
                    radioButtonValue: (value) {
                      val = value;
                      print(value);
                      setState(() {
                        if (val != null && val.contains('S')) {
                          _addAddressVisible = true;
                        } else if (val != null && val.contains('R')) {
                          _addAddressVisible = false;
                        }
                        print(_addAddressVisible);
                      });
                    },
                    selectedColor: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        HealingMatchConstants.searchDateTxt,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: CustomRadioButton(
                    padding: 0.0,
                    elevation: 4.0,
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.40,
                    buttonColor: Theme.of(context).canvasColor,
                    enableShape: true,
                    /*   customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black38)),
                   */
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
                    selectedColor: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                SizedBox(
                  height: 15.0,
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
                                fillColor: Color.fromRGBO(255, 255, 255, 1),
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
                                    fillColor: Color.fromRGBO(255, 255, 255, 1),
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
                SizedBox(
                  height: 15,
                ),
                buildDayPicker(),
                SizedBox(
                  height: 10,
                ),
                _isVisible
                    ? Container(
                        child: buildTimeController(DateTime.now()),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  margin: EdgeInsets.all(8.0),
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
      enabled: _isVisible,
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: dayPicker),
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

  buildTimeController(DateTime _dateTime) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: Size(25.0, 15.0),
                      painter: TrianglePainter(
                          isDownArrow: false, color: Colors.white),
                    ),
                  ],
                ),
              ),
              /*     Expanded(
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
        ), */
            ],
          ),
          Card(
            elevation: 10.0,
            child: Container(
                height: 120.0,
                padding: EdgeInsets.all(8.0),
                // margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
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
          ),
        ],
      ),
    );
  }
}

class AddAddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Geolocator addAddressgeoLocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _addAddressPosition;
  String _addedAddress = '';
  String _myAddedAddressInputType = '';
  String _myAddedPrefecture = '';
  String _myAddedCity = '';
  Placemark userGPSAddressPlaceMark;
  Placemark userManualAddressPlaceMark;
  final _addedAddressTypeKey = new GlobalKey<FormState>();
  final _addedPrefectureKey = new GlobalKey<FormState>();
  final _addedCityKey = new GlobalKey<FormState>();
  final additionalAddressController = new TextEditingController();
  final addedBuildingNameController = new TextEditingController();
  final addedUserAreaController = new TextEditingController();
  final addedRoomNumberController = new TextEditingController();
  List<dynamic> addedAddressStateDropDownValues = List();
  List<dynamic> addedAddressCityDropDownValues = List();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AddUserSearchAddress addUserAddress;

  StatesListResponseModel states;
  CitiesListResponseModel cities;
  var _addedAddressPrefId;
  bool _isAddedGPSLocation = false;
  bool _showRequiredFields = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: new AnimatedContainer(
            // Define how long the animation should take.
            duration: Duration(seconds: 3),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.bounceIn,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(16.0),
              color: Colors.grey[300],
              boxShadow: [
                new BoxShadow(
                    color: Colors.lime,
                    blurRadius: 3.0,
                    offset: new Offset(1.0, 1.0))
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Text(
                            '住所を追加する',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'NotoSansJP'),
                          ),
                        ),
                        SizedBox(height: 10),
                        Form(
                          key: _addedAddressTypeKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: DropDownFormField(
                                  hintText: '検索地点の登録',
                                  value: _myAddedAddressInputType,
                                  onSaved: (value) {
                                    setState(() {
                                      _myAddedAddressInputType = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myAddedAddressInputType = value;
                                      if (_myAddedAddressInputType != null &&
                                          _myAddedAddressInputType
                                              .contains('現在地を取得する')) {
                                        additionalAddressController.clear();
                                        addedBuildingNameController.clear();
                                        addedRoomNumberController.clear();
                                        _isAddedGPSLocation = true;
                                        // _additionalAddressCurrentLocation();
                                      } else if (_myAddedAddressInputType !=
                                              null &&
                                          _myAddedAddressInputType
                                              .contains('直接入力する')) {
                                        _isAddedGPSLocation = false;
                                        addedAddressCityDropDownValues.clear();
                                        addedAddressStateDropDownValues.clear();
                                        addedBuildingNameController.clear();
                                        addedRoomNumberController.clear();
                                        _myAddedPrefecture = '';
                                        _myAddedCity = '';
                                        _getAddedAddressStates();
                                      }
                                      print(
                                          'Added Address type : ${_myAddedAddressInputType.toString()}');
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "showDisplay": "現在地を取得する",
                                      "value": "現在地を取得する",
                                    },
                                    {
                                      "showDisplay": "直接入力する",
                                      "value": "直接入力する",
                                    },
                                  ],
                                  textField: 'showDisplay',
                                  valueField: 'value',
                                ),
                              ),
                              _myAddedAddressInputType.contains('現在地を取得する')
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Visibility(
                                          visible: _isAddedGPSLocation,
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: TextFormField(
                                              controller:
                                                  additionalAddressController,
                                              decoration: new InputDecoration(
                                                filled: true,
                                                fillColor: ColorConstants
                                                    .formFieldFillColor,
                                                hintText: '現在地を取得する',
                                                /*hintText: '現在地を取得する *',
                                        hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        ),*/
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.location_on,
                                                      size: 28),
                                                  onPressed: () {
                                                    _additionalAddressCurrentLocation();
                                                  },
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 14),
                                                focusColor: Colors.grey[100],
                                                border: HealingMatchConstants
                                                    .textFormInputBorder,
                                                focusedBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                disabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                enabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                              ),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              // validator: (value) => _validateEmail(value),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  // height: MediaQuery.of(context).size.height * 0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.39,
                                                  child: TextFormField(
                                                    //enableInteractiveSelection: false,
                                                    // keyboardType: TextInputType.number,
                                                    autofocus: false,
                                                    controller:
                                                        addedBuildingNameController,
                                                    decoration:
                                                        new InputDecoration(
                                                      filled: true,
                                                      fillColor: ColorConstants
                                                          .formFieldFillColor,
                                                      labelText: '建物名',
                                                      /*hintText: 'ビル名 *',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                ),*/
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily:
                                                              'NotoSansJP',
                                                          fontSize: 14),
                                                      focusColor:
                                                          Colors.grey[100],
                                                      border: HealingMatchConstants
                                                          .textFormInputBorder,
                                                      focusedBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      disabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      enabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                    ),
                                                    // validator: (value) => _validateEmail(value),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    // height: MediaQuery.of(context).size.height * 0.07,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                    child: TextFormField(
                                                      //enableInteractiveSelection: false,
                                                      autofocus: false,
                                                      maxLength: 4,
                                                      controller:
                                                          addedRoomNumberController,
                                                      decoration:
                                                          new InputDecoration(
                                                        counterText: '',
                                                        filled: true,
                                                        fillColor: ColorConstants
                                                            .formFieldFillColor,
                                                        labelText: '部屋番号',
                                                        /*hintText: '都、県選 *',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),*/
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontSize: 14),
                                                        focusColor:
                                                            Colors.grey[100],
                                                        border: HealingMatchConstants
                                                            .textFormInputBorder,
                                                        focusedBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                        disabledBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                        enabledBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                      ),
                                                      // validator: (value) => _validateEmail(value),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : _myAddedAddressInputType.contains('直接入力する')
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 10),
                                            Visibility(
                                              visible: _isAddedGPSLocation,
                                              child: Container(
                                                // height: MediaQuery.of(context).size.height * 0.07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                child: TextFormField(
                                                  controller:
                                                      additionalAddressController,
                                                  decoration:
                                                      new InputDecoration(
                                                    filled: true,
                                                    fillColor: ColorConstants
                                                        .formFieldFillColor,
                                                    hintText: '現在地を取得する',
                                                    /*hintText: '現在地を取得する *',
                                        hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        ),*/
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          Icons.location_on,
                                                          size: 28),
                                                      onPressed: () {
                                                        _additionalAddressCurrentLocation();
                                                      },
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 14),
                                                    focusColor:
                                                        Colors.grey[100],
                                                    border: HealingMatchConstants
                                                        .textFormInputBorder,
                                                    focusedBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    disabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    enabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  // validator: (value) => _validateEmail(value),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Form(
                                                key: _addedPrefectureKey,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Center(
                                                          child:
                                                              addedAddressStateDropDownValues !=
                                                                      null
                                                                  ? Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '府県',
                                                                          value: _myAddedPrefecture,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                            });
                                                                          },
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                              print('Prefecture value : ${_myAddedPrefecture.toString()}');
                                                                              _addedAddressPrefId = addedAddressStateDropDownValues.indexOf(value) + 1;
                                                                              print('prefID : ${_addedAddressPrefId.toString()}');
                                                                              addedAddressCityDropDownValues.clear();
                                                                              _myAddedCity = '';
                                                                              _getAddedAddressCities(_addedAddressPrefId);
                                                                            });
                                                                          },
                                                                          dataSource: addedAddressStateDropDownValues,
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )
                                                                  : Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '府県',
                                                                          value: _myAddedPrefecture,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                            });
                                                                          },
                                                                          dataSource: [],
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )),
                                                    ),
                                                    SizedBox(width: 3),
                                                    Expanded(
                                                      child: Form(
                                                          key: _addedCityKey,
                                                          child:
                                                              addedAddressCityDropDownValues !=
                                                                      null
                                                                  ? Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '市',
                                                                          value: _myAddedCity,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                            });
                                                                          },
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                              //print(_myBldGrp.toString());
                                                                            });
                                                                          },
                                                                          dataSource: addedAddressCityDropDownValues,
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )
                                                                  : Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '市',
                                                                          value: _myAddedCity,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                            });
                                                                          },
                                                                          dataSource: [],
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        // height: MediaQuery.of(context).size.height * 0.07,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                        child: TextFormField(
                                                          //enableInteractiveSelection: false,
                                                          autofocus: false,
                                                          controller:
                                                              addedUserAreaController,
                                                          decoration:
                                                              new InputDecoration(
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .formFieldFillColor,
                                                            labelText: '丁目, 番地',
                                                            /*hintText: '都、県選 *',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),*/
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    'NotoSansJP',
                                                                fontSize: 14),
                                                            focusColor: Colors
                                                                .grey[100],
                                                            border: HealingMatchConstants
                                                                .textFormInputBorder,
                                                            focusedBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            disabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            enabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                          ),
                                                          // validator: (value) => _validateEmail(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // height: MediaQuery.of(context).size.height * 0.07,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: TextFormField(
                                                        //enableInteractiveSelection: false,
                                                        // keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        controller:
                                                            addedBuildingNameController,
                                                        decoration:
                                                            new InputDecoration(
                                                          filled: true,
                                                          fillColor: ColorConstants
                                                              .formFieldFillColor,
                                                          labelText: '建物名',
                                                          /*hintText: 'ビル名 *',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                ),*/
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[400],
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontSize: 14),
                                                          focusColor:
                                                              Colors.grey[100],
                                                          border: HealingMatchConstants
                                                              .textFormInputBorder,
                                                          focusedBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                          disabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                          enabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                        ),
                                                        // validator: (value) => _validateEmail(value),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        // height: MediaQuery.of(context).size.height * 0.07,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                        child: TextFormField(
                                                          //enableInteractiveSelection: false,
                                                          autofocus: false,
                                                          maxLength: 4,
                                                          controller:
                                                              addedRoomNumberController,
                                                          decoration:
                                                              new InputDecoration(
                                                            counterText: '',
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .formFieldFillColor,
                                                            labelText: '部屋番号',
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    'NotoSansJP',
                                                                fontSize: 14),
                                                            focusColor: Colors
                                                                .grey[100],
                                                            border: HealingMatchConstants
                                                                .textFormInputBorder,
                                                            focusedBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            disabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            enabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                          ),
                                                          // validator: (value) => _validateEmail(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              _addUserAddress();
                            },
                            child: new Text(
                              '追加',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
              // child:
            )),
      ),
    );
  }

  // Get current address from Latitude Longitude
  _additionalAddressCurrentLocation() {
    ProgressDialogBuilder.showLocationProgressDialog(context);
    addAddressgeoLocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _addAddressPosition = position;
      });
      _getAdditionalAddressLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAdditionalAddressLatLng() async {
    try {
      List<Placemark> p = await addAddressgeoLocator.placemarkFromCoordinates(
          _addAddressPosition.latitude, _addAddressPosition.longitude);

      userGPSAddressPlaceMark = p[0];

      HealingMatchConstants.addedCurrentLatitude = _addAddressPosition.latitude;
      HealingMatchConstants.addedCurrentLongitude =
          _addAddressPosition.longitude;

      setState(() {
        _addedAddress =
            '${userGPSAddressPlaceMark.locality},${userGPSAddressPlaceMark.subAdministrativeArea},'
            '${userGPSAddressPlaceMark.administrativeArea},${userGPSAddressPlaceMark.postalCode}'
            ',${userGPSAddressPlaceMark.country}';
        if (_addedAddress != null && _addedAddress.isNotEmpty) {
          print(
              'Additional address GPS location : $_addedAddress : ${HealingMatchConstants.addedCurrentLatitude} && '
              '${HealingMatchConstants.addedCurrentLongitude}');
          additionalAddressController.value =
              TextEditingValue(text: _addedAddress);
          setState(() {
            _isAddedGPSLocation = true;
          });
          HealingMatchConstants.addedServiceUserCity =
              userGPSAddressPlaceMark.locality;
          HealingMatchConstants.addedServiceUserPrefecture =
              userGPSAddressPlaceMark.administrativeArea;
        } else {
          ProgressDialogBuilder.hideLocationProgressDialog(context);
          return null;
        }
      });
      ProgressDialogBuilder.hideLocationProgressDialog(context);
    } catch (e) {
      ProgressDialogBuilder.hideLocationProgressDialog(context);
      print(e);
    }
  }

  _getAddedAddressStates() async {
    await http.get(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesListResponseModel.fromJson(json.decode(response.body));
      print(states.toJson());
      for (var stateList in states.data) {
        setState(() {
          addedAddressStateDropDownValues.add(stateList.prefectureJa);
        });
      }
    });
  }

  // CityList cityResponse;
  _getAddedAddressCities(var prefId) async {
    ProgressDialogBuilder.showGetCitiesProgressDialog(context);
    await http.post(HealingMatchConstants.CITY_PROVIDER_URL,
        body: {'prefecture_id': prefId.toString()}).then((response) {
      cities = CitiesListResponseModel.fromJson(json.decode(response.body));
      print(cities.toJson());
      for (var cityList in cities.data) {
        setState(() {
          addedAddressCityDropDownValues
              .add(cityList.cityJa + cityList.specialDistrictJa);
        });
      }
      ProgressDialogBuilder.hideGetCitiesProgressDialog(context);
      print('Response City list : ${response.body}');
    });
  }

  _addUserAddress() async {
    if (_myAddedAddressInputType.isNotEmpty &&
        _myAddedAddressInputType.contains('現在地を取得する')) {
      if (addedRoomNumberController.text.isEmpty ||
          addedBuildingNameController.text.isEmpty) {
        print('Room number empty');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('必須値を入力してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ));
        return;
      } else {
        String gpsUserAddress =
            '${addedRoomNumberController.text.toString()},${addedBuildingNameController.text.toString() + ',' + _addedAddress}';
        print('GPS FINAL ADDRESS : $gpsUserAddress');

        if (otherUserAddress.length <= 2) {
          setState(() {
            print('Entering if...');
            addUserAddress = AddUserSearchAddress(
              gpsUserAddress,
              HealingMatchConstants.addedCurrentLatitude.toString(),
              HealingMatchConstants.addedCurrentLongitude.toString(),
              _myAddedAddressInputType,
              userGPSAddressPlaceMark.administrativeArea,
              userGPSAddressPlaceMark.subAdministrativeArea,
              addedRoomNumberController.text.toString(),
              addedBuildingNameController.text.toString(),
              userGPSAddressPlaceMark.locality,
            );

            Navigator.pop(context);
            /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UpdateServiceUserDetails()));*/
          });
        } else {
//メインの地点以外に3箇所まで地点登録ができます
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('メインの地点以外に3箇所まで地点登録ができます。',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontFamily: 'NotoSansJP')),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateServiceUserDetails()));*/
                    Navigator.pop(context);
                  },
                  child: Text('はい',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ));
          return;
        }
      }
    } else if (_myAddedAddressInputType.isNotEmpty &&
        _myAddedAddressInputType.contains('直接入力する')) {
      if (addedRoomNumberController.text.isEmpty ||
          addedBuildingNameController.text.isEmpty ||
          addedUserAreaController.text.isEmpty ||
          _myAddedCity.isEmpty ||
          _myAddedPrefecture.isEmpty) {
        print('Manual address empty fields');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('必須値を入力してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ));
        return;
      } else {
        String manualAddedAddress = addedRoomNumberController.text.toString() +
            ',' +
            addedBuildingNameController.text.toString() +
            ',' +
            addedUserAreaController.text.toString() +
            ',' +
            _myAddedCity +
            ',' +
            _myAddedPrefecture;
        print('USER MANUAL ADDRESS : $manualAddedAddress');
        List<Placemark> userManualAddress =
            await addAddressgeoLocator.placemarkFromAddress(manualAddedAddress);
        userManualAddressPlaceMark = userManualAddress[0];
        Position addressPosition = userManualAddressPlaceMark.position;
        HealingMatchConstants.manualAddressCurrentLatitude =
            addressPosition.latitude;
        HealingMatchConstants.manualAddressCurrentLongitude =
            addressPosition.longitude;
        HealingMatchConstants.serviceUserCity =
            userManualAddressPlaceMark.locality;
        HealingMatchConstants.serviceUserPrefecture =
            userManualAddressPlaceMark.administrativeArea;
        HealingMatchConstants.manualUserAddress = manualAddedAddress;

        print(
            'Manual Address lat lon : ${HealingMatchConstants.manualAddressCurrentLatitude} && '
            '${HealingMatchConstants.manualAddressCurrentLongitude}');
        print('Manual Place Json : ${userManualAddressPlaceMark.toJson()}');
        print('Manual Address : ${HealingMatchConstants.manualUserAddress}');

        if (otherUserAddress.length <= 2) {
          String city = _myAddedCity;
          setState(() {
            addUserAddress = AddUserSearchAddress(
              manualAddedAddress,
              HealingMatchConstants.manualAddressCurrentLatitude.toString(),
              HealingMatchConstants.manualAddressCurrentLongitude.toString(),
              _myAddedAddressInputType,
              _myAddedCity,
              _myAddedPrefecture,
              addedRoomNumberController.text.toString(),
              addedBuildingNameController.text.toString(),
              addedUserAreaController.text.toString(),
            );
            print(_myAddedAddressInputType);
            Navigator.pop(context);
            /*   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UpdateServiceUserDetails()));*/
          });
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('メインの地点以外に3箇所まで地点登録ができます。',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontFamily: 'NotoSansJP')),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    Navigator.pop(context);
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateServiceUserDetails()));*/
                  },
                  child: Text('はい',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ));
          return;
        }
      }
    } else {
      print('Address Type is Empty....');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('検索地点の登録を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return;
    }

    otherUserAddress.add(addUserAddress);
    _sharedPreferences.then((value) {
      value.setBool('isUserVerified', false);
    });
  }
}
