import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customradiobutton.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/models/customModels/userSearchAddAddress.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
List<AddUserSearchAddress> otherUserAddress = new List<AddUserSearchAddress>();

class SearchScreenUser extends StatefulWidget {
  @override
  _SearchScreenUserState createState() => _SearchScreenUserState();
}

class _SearchScreenUserState extends State<SearchScreenUser> {
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  GlobalKey<ScaffoldState> _searchKey = new GlobalKey<ScaffoldState>();
  Placemark userAddedAddressPlaceMark;
  NumberPicker dayPicker;
  int _value = 0;
  int addressTypeValues = 0;
  int _cyear;
  int _cmonth;
  int _currentDay;
  int daysToDisplay;
  int _lastday;
  int _selectedYearIndex = 0;
  int _selectedMonthIndex = 0;
  int _yearChangedNumber = 0;
  int _monthChangedNumber = 0;
  int _state = 0;
  int bookingAddressId;
  bool _isVisible = true;
  bool readonly = false;
  bool _loading = false;
  bool isLocationCriteria = true;
  bool _addAddressVisible = false;
  bool isAllAddressCategoryAvailable = false;
  String _currentAddress = '';
  String massageServiceTypeValue,
      keyWordSearchValue,
      userAddress,
      addressTypeName,
      addressIcon;
  String userID;
  String address;
  Placemark currentLocationPlaceMark;
  Position _currentPosition;
  DateTime today = DateTime.now();
  DateTime displayDay;
  bool isGPSLoading = false;
  final keywordController = new TextEditingController();
  var stopLoading;
  var currentLoading;
  var dateString;
  var constantUserAddressSize = new List();
  var differenceInTime;
  var gpsColor = 0;
  var searchAddressLatitude, searchAddressLongitude;
  List<UserAddresses> constantUserAddressValuesList = new List<UserAddresses>();
  Map<int, String> addressName = Map<int, String>();
  List<String> yearDropDownValues = List<String>();
  List<String> monthDropDownValues = List<String>();
  List<String> addressDropDownValues = ["自宅", "オフィス", "実家", "その他（直接入力）"];
  TextEditingController yearController = new TextEditingController();
  TextEditingController monthController = TextEditingController();

  void initState() {
    super.initState();
    dateString = '';
    displayDay = today;
    _cyear = DateTime.now().year;
    _cmonth = DateTime.now().month;
    _currentDay = DateTime.now().day;
    _lastday = DateTime(today.year, today.month + 1, 0).day;
    yearController.text = _cyear.toString();
    monthController.text = _cmonth.toString();
    daysToDisplay = totalDays(_cmonth, _cyear);
    buildYearDropDown();
    getValidSearchFields();
    setState(() {
      print(daysToDisplay);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _state = 1;
        if (HealingMatchConstants.isActive != null &&
            HealingMatchConstants.isActive == false) {
          DialogHelper.showUserBlockDialog(context);
        } else {
          return;
        }
      });
    }
    return Scaffold(
      key: _searchKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 8.0,
                          margin: EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(0.0),
                            padding: EdgeInsets.all(0.0),
                            height: 48.0,
                            //MediaQuery.of(context).size.height * 0.06,
                            child: TextFormField(
                              controller: keywordController,
                              autofocus: false,
                              textInputAction: TextInputAction.search,
                              decoration: new InputDecoration(
                                  hoverColor: Colors.grey,
                                  contentPadding: EdgeInsets.all(4.0),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:
                                      HealingMatchConstants.searchKeywordHint,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IconButton(
                                      onPressed: () {
                                        if (keywordController.text.isEmpty) {
                                          displaySnackBar(
                                              "キーワードを入力してから検索ボタンを押してください。");
                                        } else {
                                          HealingMatchConstants
                                                  .searchKeyWordValue =
                                              keywordController.text;
                                          _getKeywordResults();
                                        }
                                      },
                                      icon: Image.asset(
                                        "assets/images_gps/search.png",
                                        height: 30,
                                        width: 30,
                                        color: Color.fromRGBO(225, 225, 225, 1),
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(225, 225, 225, 1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0),
                                    borderRadius: BorderRadius.circular(6.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ArgonButton(
                              padding: EdgeInsets.all(0.0),
                              roundLoadingShape: true,
                              height: 65,
                              width: 65,
                              borderRadius: 30.0,
                              elevation: 0.0,
                              color: Colors.transparent,
                              child: CircleAvatar(
                                maxRadius: 32,
                                backgroundColor: gpsColor == 0
                                    ? Colors.grey[200]
                                    : Color.fromRGBO(200, 217, 33, 1),
                                child: SvgPicture.asset(
                                    'assets/images_gps/current_location.svg',
                                    color: gpsColor == 0
                                        ? Colors.black
                                        : Color.fromRGBO(255, 255, 255, 1),
                                    height: 30,
                                    width: 30),
                              ),
                              loader: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(200, 217, 33, 1),

                                  // borderRadius: BorderRadius.circular(25.0),
                                ),
                                padding: EdgeInsets.all(10),
                                child: SpinKitFadingCircle(
                                  color: Colors.white,
                                  // size: loaderWidth ,
                                ),
                              ),
                              onTap: (startLoading, stopLoading, btnState) {
                                if (btnState == ButtonState.Idle) {
                                  this.currentLoading = stopLoading;
                                  startLoading();
                                  setState(() {
                                    isGPSLoading = true;
                                    gpsColor = 1;
                                    addressTypeValues = 0;
                                    userAddress = "";
                                  });
                                  _getCurrentLocation(context);
                                }
                              },
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
                        Visibility(
                          visible: constantUserAddressSize.length < 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                margin: EdgeInsets.only(top: 3.5),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(102, 102, 102, 1))),
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: new Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    highlightColor: Color.fromRGBO(0, 0, 0, 1),
                                    iconSize: 35,
                                    onPressed: () {
                                      if (HealingMatchConstants
                                                  .isUserRegistrationSkipped !=
                                              null &&
                                          HealingMatchConstants
                                              .isUserRegistrationSkipped) {
                                        DialogHelper
                                            .showUserLoginOrRegisterDialog(
                                                context);
                                      } else {
                                        /*  NavigationRouter
                                            .switchToServiceUserBottomBarViewProfile(
                                                context); */
                                        NavigationRouter
                                            .switchToUserAddSearchAddressScreen(
                                                context,
                                                refreshPage,
                                                addressDropDownValues);
                                      }
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
                        ),
                        //  SizedBox(width: 4),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 95,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: constantUserAddressValuesList.length,
                                itemBuilder: (context, index) {
                                  int addressType = getAddressIconandName(
                                      constantUserAddressValuesList[index]
                                          .userPlaceForMassage,
                                      index);
                                  return buildUserRegisteredAddressCard(
                                      addressType, index);
                                }),
                          ),
                        ),
                      ],
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
                              //  onTap: () => setState(() => _value = 0),
                              onTap: () {
                                setState(() {
                                  _value = 1;
                                  /*   HealingMatchConstants.serviceType = 1; */
                                });
                              },
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
                                              : Color.fromRGBO(
                                                  228, 228, 228, 1),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/serviceTypeOne.svg',
                                          color: _value == 1
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          height: 29.81,
                                          width: 27.61,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //onTap: () => setState(() => _value = 1),
                              onTap: () {
                                setState(() {
                                  _value = 2;
                                });
                              },
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
                                              : Color.fromRGBO(
                                                  228, 228, 228, 1),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/serviceTypeTwo.svg',
                                          color: _value == 2
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          height: 33,
                                          width: 34,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //onTap: () => setState(() => _value = 2),
                              onTap: () {
                                setState(() {
                                  _value = 3;
                                  /*  HealingMatchConstants.serviceType = 3; */
                                });
                              },
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
                                              : Color.fromRGBO(
                                                  228, 228, 228, 1),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/serviceTypeThree.svg',
                                          color: _value == 3
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //onTap: () => setState(() => _value = 3),
                              onTap: () {
                                setState(() {
                                  _value = 4;
                                  /*  HealingMatchConstants.serviceType = 4; */
                                });
                              },
                              child: Column(
                                children: [
                                  Card(
                                    elevation: _value == 4 ? 4.0 : 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _value == 4
                                            ? Color.fromRGBO(242, 242, 242, 1)
                                            : Color.fromRGBO(255, 255, 255, 1),
                                        border: Border.all(
                                          color: _value == 4
                                              ? Color.fromRGBO(102, 102, 102, 1)
                                              : Color.fromRGBO(
                                                  228, 228, 228, 1),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          'assets/images_gps/serviceTypeFour.svg',
                                          color: _value == 4
                                              ? Color.fromRGBO(0, 0, 0, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          height: 35,
                                          width: 27,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                  color: _value == 1
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
                                  color: _value == 2
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
                                    color: _value == 3
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
                                  color: _value == 4
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
                        true,
                        false,
                      ],
                      radioButtonValue: (value) {
                        isLocationCriteria = value;
                        HealingMatchConstants.isLocationCriteria =
                            isLocationCriteria;
                        print(
                            'Location coming/not value : ${HealingMatchConstants.isLocationCriteria}');
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
                      buttonLables: ["受けたい日時でさがす", "セラピストをさがす"],
                      fontSize: 12.0,
                      buttonValues: [
                        true,
                        false,
                      ],
                      radioButtonValue: (value) {
                        setState(() {
                          HealingMatchConstants.isTimeCriteria = value;
                          print(
                              'Time there/not value : ${HealingMatchConstants.isLocationCriteria}');
                          if (HealingMatchConstants.isTimeCriteria) {
                            _isVisible = true;
                          } else {
                            _isVisible = false;
                          }
                        });
                      },
                      selectedColor: Color.fromRGBO(242, 242, 242, 1),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
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
                  SizedBox(
                    height: 15,
                  ),
                  buildDayPicker(),
                  SizedBox(
                    height: 10,
                  ),
                  _isVisible
                      ? Container(
                          child: buildTimeController(
                              HealingMatchConstants.dateTime),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            //  top: 600.0,
            bottom: 85.0,
            right: 20.0,
            left: 0.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Container(
                  child: ArgonButton(
                    roundLoadingShape: true,
                    height: 40,
                    width: 40,
                    borderRadius: 25.0,
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Color.fromRGBO(200, 217, 33, 1),
                      child: Image.asset(
                        "assets/images_gps/search.png",
                        height: 25,
                        width: 25,
                        color: Colors.white,
                      ),
                    ),
                    loader: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(200, 217, 33, 1),
                        // borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: EdgeInsets.all(10),
                      child: SpinKitRotatingCircle(
                        color: Colors.white,
                        // size: loaderWidth ,
                      ),
                    ),
                    onTap: (startLoading, stopLoading, btnState) {
                      if (btnState == ButtonState.Idle && !isGPSLoading) {
                        this.stopLoading = stopLoading;
                        startLoading();
                        if (keywordController.text == "" ||
                            keywordController.text == null) {
                          timeDurationSinceDate(DateTime(
                              _cyear,
                              _cmonth,
                              _currentDay,
                              HealingMatchConstants.dateTime.hour,
                              HealingMatchConstants.dateTime.minute));
                        } else {
                          getAddressType();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildUserRegisteredAddressCard(int addressType, int index) {
    return Container(
      margin: EdgeInsets.only(left: 6.0, right: 4.0),
      /*  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          offset: Offset.zero,
          color: addressTypeValues == addressType && userAddress != null
              ? Colors.grey[200]
              : Colors.white,
          blurRadius: 7.0,
        ),
      ]), */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              if (!isGPSLoading) {
                saveSelectedAddress(addressType, index);
              }
            },
            child: Card(
              margin: EdgeInsets.all(0.0),
              elevation: addressTypeValues == addressType && userAddress != null
                  ? 4.0
                  : 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(
                      color: addressTypeValues == addressType &&
                              userAddress != null
                          ? Color.fromRGBO(102, 102, 102, 1)
                          : Colors.transparent)),
              child: CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.grey[100],
                child: SvgPicture.asset('$addressIcon',
                    placeholderBuilder: (context) {
                  return SpinKitDoubleBounce(color: Colors.lightGreenAccent);
                }, color: Color.fromRGBO(0, 0, 0, 1), height: 30, width: 30),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${addressName[index]}",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          )
        ],
      ),
    );
  }

  refreshPage() {
    setState(() {});
  }

  void saveSelectedAddress(int addressType, int index) {
    setState(() {
      gpsColor = 0;
      addressTypeValues = addressType;
      addressTypeName = addressName[index];
      searchAddressLatitude = constantUserAddressValuesList[index].lat;
      searchAddressLongitude = constantUserAddressValuesList[index].lon;
      userAddress = constantUserAddressValuesList[index].address;
      bookingAddressId = constantUserAddressValuesList[index].id;
    });
    print('User address $addressType $addressTypeName : $userAddress');
  }

  _showLoadingIndicator(BuildContext context, String loadingText) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images_gps/logo.png"),
              ),
            ),
          ), */
          SpinKitFadingCircle(
            color: ColorConstants.buttonColor,
            size: 50.0,
          ),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("$loadingText")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                      if ((_cyear == today.year &&
                          _cmonth == today.month &&
                          _currentDay == today.day)) {
                        dayPicker.animateIntToIndex(0);
                      } else {
                        dayPicker.animateInt(_currentDay);
                      }
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

                      if ((_cyear == today.year &&
                          _cmonth == today.month &&
                          _currentDay == today.day)) {
                        dayPicker.animateIntToIndex(0);
                      } else {
                        dayPicker.animateInt(_currentDay);
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  buildDayPicker() {
    dayPicker = NumberPicker.horizontal(
      currentDate: DateTime.now(),
      selectedYear: _cyear,
      enabled: _isVisible,
      ismonth: true,
      numberToDisplay: 7,
      selectedMonth: _cmonth,
      eventDates: [],
      //getEventDateTime(),
      zeroPad: false,
      initialValue: _currentDay,
      minValue:
          (_cyear == today.year) && (_cmonth == today.month) ? today.day : 1,
      maxValue: daysToDisplay,
      onChanged: (newValue) => setState(() {
        if ((newValue != _currentDay)) {
          changeDay(newValue);
        }
      }),
    );
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        height: 95.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 34.0,
                child: InkWell(
                  onTap: () {
                    if (_isVisible &&
                        !(_cyear == today.year &&
                            _cmonth == today.month &&
                            _currentDay == today.day)) {
                      var dateUtility = DateUtil();
                      if (_currentDay != 1) {
                        _currentDay = _currentDay - 1;
                        dayPicker.animateInt(_currentDay);
                        changeDay(_currentDay);
                      } else if (_currentDay == 1 && _cmonth != 1) {
                        var day1 = dateUtility.daysInMonth(_cmonth - 1, _cyear);
                        daysToDisplay = day1;
                        _currentDay = day1;
                        _cmonth = _cmonth - 1;
                        monthController.text = _cmonth.toString();

                        changeDay(_currentDay);
                        dayPicker.animateInt(_currentDay);
                      } else {
                        var day1 = dateUtility.daysInMonth(12, _cyear - 1);
                        daysToDisplay = day1;
                        _currentDay = day1;
                        _cmonth = 12;
                        monthController.text = _cmonth.toString();
                        _cyear = _cyear - 1;
                        yearController.text = _cyear.toString();
                        dayPicker.animateInt(_currentDay);
                        changeDay(_currentDay);
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15.0,
                        color: _isVisible ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: dayPicker, //Daypicker Build here
                ),
              ),
              Positioned(
                right: 0,
                top: 34.0,
                child: InkWell(
                  onTap: () {
                    if (_isVisible) {
                      var dateUtility = DateUtil();
                      var day1 = dateUtility.daysInMonth(_cmonth, _cyear);
                      if (_currentDay != day1) {
                        _currentDay = _currentDay + 1;
                        dayPicker.animateInt(_currentDay);
                        changeDay(_currentDay);
                      } else if (_currentDay == day1 && _cmonth != 12) {
                        day1 = dateUtility.daysInMonth(_cmonth + 1, _cyear);
                        daysToDisplay = day1;
                        _currentDay = 1;
                        _cmonth = _cmonth + 1;
                        monthController.text = _cmonth.toString();
                        dayPicker.animateInt(_currentDay);
                        changeDay(_currentDay);
                      } else {
                        day1 = dateUtility.daysInMonth(1, _cyear + 1);
                        daysToDisplay = day1;
                        _currentDay = 1;
                        _cmonth = 1;
                        monthController.text = _cmonth.toString();
                        _cyear = _cyear + 1;
                        yearController.text = _cyear.toString();
                        dayPicker.animateInt(_currentDay);
                        changeDay(_currentDay);
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.0,
                        color: _isVisible ? Colors.black : Colors.grey,
                      ),
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

  changeDay(int selectedDay) {
    setState(() {
      _currentDay = selectedDay;
      displayDay = DateTime(_cyear, _cmonth, selectedDay);
    });
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
      child: Stack(
        children: [
          Container(
              height: 120.0,
              padding: EdgeInsets.all(6.0),
              margin: EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 6.0,
                      spreadRadius: 10.0,
                      offset: Offset(
                        0.0,
                        0.0,
                      ),
                    ),
                  ]),
              child: TimePickerSpinner(
                alignment: Alignment.topCenter,
                is24HourMode: true,
                minutesInterval: 15,
                time: _dateTime,
                normalTextStyle: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(217, 217, 217, 1), //Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                highlightedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                spacing: 50,
                itemHeight: 40,
                itemWidth: 70.0,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    _dateTime = time;
                    print('Selected Date and Time : $_dateTime');
                    HealingMatchConstants.dateTime = _dateTime;
                    /* timeDurationSinceDate(HealingMatchConstants.dateTime); */
                  });
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: Size(20.0, 12.0),
                painter:
                    TrianglePainter(isDownArrow: false, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
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
      _selectedMonthIndex = _cmonth - 1;
    }

    for (int i = _cyear == today.year ? today.month : 1; i <= 12; i++) {
      monthDropDownValues.add(i.toString());
    }
    setState(() {});
  }

  timeDurationSinceDate(var dateString, {bool numericDates = true}) {
    if (_isVisible) {
      final date2 = DateTime.now();
      differenceInTime = date2.difference(dateString);
      print('Converted Date and Time  : ${differenceInTime.inMinutes}');
      if (differenceInTime.inMinutes > -30) {
        print('PAST TIME');
        showInValidTimeError();
      } else if (differenceInTime.inMinutes.floor() <= -30) {
        print('FUTURE TIME');
        proceedToSearchResults();
      }
    } else {
      proceedToSearchResults();
    }
  }

  void showInValidTimeError() {
    displaySnackBar("予約の時間を現在の時間より30分後にする必要があります。");
    return;
  }

  getValidSearchFields() async {
    ProgressDialogBuilder.showOverlayLoader(context);
    if (HealingMatchConstants.isUserRegistrationSkipped != null &&
        HealingMatchConstants.isUserRegistrationSkipped) {
      ProgressDialogBuilder.hideLoader(context);
      return;
    } else {
      _sharedPreferences.then((value) {
        if (value != null) {
          var userDetails = ServiceUserAPIProvider.getUserDetails(
              context, HealingMatchConstants.serviceUserID);
          userDetails.then((value) {
            setState(() {
              HealingMatchConstants.searchDistanceRadius =
                  value.data.userSearchRadiusDistance != null
                      ? value.data.userSearchRadiusDistance
                      : 10.0;
              constantUserAddressValuesList = value.data.addresses;
              for (var category in constantUserAddressValuesList) {
                print(
                    'List length search : ${constantUserAddressValuesList.length}');

                var categoryData = category.userPlaceForMassage;
                constantUserAddressSize.add(categoryData);
                print(
                    'Size of list category : ${constantUserAddressSize.length} && $categoryData');

                ProgressDialogBuilder.hideLoader(context);
              }
            });
          }).catchError((onError) {
            ProgressDialogBuilder.hideLoader(context);
            print('Catch error search : $onError');
          });
        }
      }).catchError((onError) {
        ProgressDialogBuilder.hideLoader(context);
        print('S_Pref Exception : $onError');
      });
    }
  }

  // Get current address from Latitude Longitude
  _getCurrentLocation(BuildContext context) async {
    bool isGPSEnabled = await geoLocator.isLocationServiceEnabled();
    print('GPS Enabled : $isGPSEnabled');
    if (HealingMatchConstants.isUserRegistrationSkipped && !isGPSEnabled) {
      currentLoading();
      isGPSLoading = false;
      displaySnackBar("場所を取得するには、GPSをオンにしてください。");
      return;
    } else {
      print('GPS Enabled : $isGPSEnabled');
      geoLocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        isGPSLoading = false;
        _currentPosition = position;
        print('Current lat : ${_currentPosition.latitude}');
        HealingMatchConstants.currentLatitude = _currentPosition.latitude;
        HealingMatchConstants.currentLongitude = _currentPosition.longitude;
        _getAddressFromLatLng(context);
      }).catchError((e) {
        currentLoading();
        isGPSLoading = false;
        print('Current Location exception : ${e.toString()}');
      });
    }
  }

  _getAddressFromLatLng(BuildContext context) async {
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      currentLocationPlaceMark = p[0];

      searchAddressLatitude = _currentPosition.latitude;
      searchAddressLongitude = _currentPosition.longitude;
      addressTypeValues = 5;
      addressTypeName = "現在地";
      bookingAddressId = 0;
      HealingMatchConstants.locality = currentLocationPlaceMark.locality;

      _currentAddress =
          '${currentLocationPlaceMark.locality},${currentLocationPlaceMark.subAdministrativeArea},${currentLocationPlaceMark.administrativeArea},${currentLocationPlaceMark.postalCode}'
          ',${currentLocationPlaceMark.country}';
      if (_currentAddress != null && _currentAddress.isNotEmpty) {
        setState(() {
          userAddress = _currentAddress;
        });

        print('Current Search address : $userAddress : '
            '$searchAddressLatitude && '
            '$searchAddressLongitude');
        currentLoading();
        /*  timeDurationSinceDate(DateTime(
            _cyear,
            _cmonth,
            _currentDay,
            HealingMatchConstants.dateTime.hour,
            HealingMatchConstants.dateTime.minute)); */
        //proceedToSearchResults();
      } else {
        currentLoading();
      }
    } catch (e) {
      currentLoading();
      print(e);
    }
  }

  proceedToSearchResults() async {
    try {
      print(
          'User address proceed : ${HealingMatchConstants.searchUserAddress}');
      if (keywordController.text == "" || keywordController.text == null) {
        if (userAddress == null || userAddress.isEmpty) {
          displaySnackBar("さがすエリアを選択してください。");
          return;
        }
      }
      if (keywordController.text == "" || keywordController.text == null) {
        if (_value == 0) {
          displaySnackBar("受けたい施術を選択してください。");
          return;
        }
        if (_value == 0) {
          displaySnackBar("有効なマッサージサービスの種類を選択してください。");
          return;
        }
      }
      getAddressType();
    } catch (e) {
      print('Exception in search criteria : ${e.toString()}');
    }
  }

  void displaySnackBar(String errorText) {
    _searchKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text('$errorText',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontFamily: 'NotoSansJP')),
          ),
          InkWell(
            onTap: () {
              _searchKey.currentState.hideCurrentSnackBar();
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

    stopLoading();
  }

  getAddressType() {
    if (keywordController.text == "" || keywordController.text == null) {
      if (isLocationCriteria == true) {
        HealingMatchConstants.addressTypeValues = 0;
        HealingMatchConstants.searchUserAddressType = '店舗';
      } else {
        HealingMatchConstants.addressTypeValues = addressTypeValues;
        HealingMatchConstants.searchUserAddressType = addressTypeName;
        HealingMatchConstants.bookingAddressId = bookingAddressId;
        HealingMatchConstants.searchUserAddress = userAddress;
      }
      HealingMatchConstants.isLocationCriteria = isLocationCriteria;
      HealingMatchConstants.serviceType = _getCategoryId(_value);
      HealingMatchConstants.searchType = 0;
    } else {
      HealingMatchConstants.searchKeyWordValue = keywordController.text;
      HealingMatchConstants.searchType = 1;
    }
    HealingMatchConstants.dateTime = DateTime(
        HealingMatchConstants.dateTime.year,
        _cmonth,
        _currentDay,
        HealingMatchConstants.dateTime.hour,
        HealingMatchConstants.dateTime.minute,
        HealingMatchConstants.dateTime.second);
    print(HealingMatchConstants.dateTime.toString());
    HealingMatchConstants.searchAddressLatitude = searchAddressLatitude;
    HealingMatchConstants.searchAddressLongitude = searchAddressLongitude;
    ServiceUserAPIProvider.searchProviderUnavailableEventByTime(
            HealingMatchConstants.dateTime,
            DateTime(
                HealingMatchConstants.dateTime.year,
                _cmonth,
                _currentDay,
                HealingMatchConstants.dateTime.hour,
                HealingMatchConstants.dateTime.minute + 15,
                HealingMatchConstants.dateTime.second))
        .then((value) => _getSearchResults());
  }

  _getKeywordResults() {
    HealingMatchConstants.searchType = 1;
    NavigationRouter.switchToUserSearchResult(context);
  }

  /*  1	エステ
2	フィットネス
3	接骨・整体
4	リラクゼーション */

//assigned based on cID on Db
  int _getCategoryId(int val) {
    int cId;
    switch (val) {
      case 0:
        cId = 0;
        break;
      case 1:
        cId = 1;
        break;
      case 2:
        cId = 3;
        break;
      case 3:
        cId = 4;
        break;
      case 4:
        cId = 2;
        break;
    }
    return cId;
  }

  _getSearchResults() {
    try {
      stopLoading();

      NavigationRouter.switchToUserSearchResult(context);
    } catch (e) {
      print('Search Exception before bloc : ${e.toString()}');
    }
  }

  int getAddressIconandName(String userPlaceForMassage, int index) {
    int addressType;
    if (userPlaceForMassage != null) {
      switch (userPlaceForMassage) {
        case '自宅':
          addressType = 1;
          addressIcon = "assets/images_gps/house.svg";
          addressName[index] = HealingMatchConstants.searchHomeIconTxt;
          addressDropDownValues.remove("自宅");
          break;
        case 'オフィス':
          addressType = 2;
          addressIcon = "assets/images_gps/office.svg";
          addressName[index] = HealingMatchConstants.searchOfficeIconTxt;
          addressDropDownValues.remove("オフィス");
          break;
        case '実家':
          addressType = 3;
          addressIcon = "assets/images_gps/parents_house.svg";
          addressName[index] = HealingMatchConstants.searchPHomeIconTxt;
          addressDropDownValues.remove("実家");
          break;
        default:
          addressType = 4;
          addressIcon = "assets/images_gps/others.svg";
          addressName[index] = HealingMatchConstants.searchOtherIconTxt;
          addressDropDownValues.remove("その他（直接入力）");
          break;
      }
    }
    return addressType;
  }
}
