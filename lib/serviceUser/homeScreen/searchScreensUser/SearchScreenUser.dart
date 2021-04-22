import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customradiobutton.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/models/customModels/userSearchAddAddress.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
List<AddUserSearchAddress> otherUserAddress = new List<AddUserSearchAddress>();
int _addressType = 0;

class SearchScreenUser extends StatefulWidget {
  @override
  _SearchScreenUserState createState() => _SearchScreenUserState();
}

class _SearchScreenUserState extends State<SearchScreenUser> {
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Placemark userAddedAddressPlaceMark;
  int _value = 0;
  var _pageNumber = 1;
  var _pageSize = 10;
  bool _isVisible = true;
  bool _addAddressVisible = false;

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

  String addressTypeValue,
      massageServiceTypeValue,
      keyWordSearchValue,
      userPlaceForMassage;
  String userID;

  bool isAllAddressCategoryAvailable = false;

  var searchAddressLatitude, searchAddressLongitude;

  List<Addresses> constantUserAddressValuesList = new List<Addresses>();
  var constantUserAddressSize = new List();
  GlobalKey<ScaffoldState> _searchKey = new GlobalKey<ScaffoldState>();
  var differenceInTime;

  void initState() {
    super.initState();
    getValidSearchFields();

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
      key: _searchKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
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
                          elevation: 4.0,
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
                                          _searchKey.currentState
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                ColorConstants.snackBarColor,
                                            duration: Duration(seconds: 3),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      '検索に有効なキーワードを入力してください。',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NotoSansJP')),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    _searchKey.currentState
                                                        .hideCurrentSnackBar();
                                                  },
                                                  child: Text('はい',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'NotoSansJP',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                ),
                                              ],
                                            ),
                                          ));
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
                        Visibility(
                          visible: constantUserAddressSize.length < 4,
                          child: Column(
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
                                    highlightColor: Color.fromRGBO(0, 0, 0, 1),
                                    iconSize: 35,
                                    onPressed: () {
                                      if (HealingMatchConstants
                                                  .isUserRegistrationSkipped !=
                                              null &&
                                          HealingMatchConstants
                                              .isUserRegistrationSkipped) {
                                        return;
                                      } else {
                                        NavigationRouter
                                            .switchToServiceUserViewProfileScreen(
                                                context);
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
                        SizedBox(width: 5),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: constantUserAddressValuesList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: constantUserAddressValuesList[
                                                        index]
                                                    .userPlaceForMassage !=
                                                null &&
                                            constantUserAddressValuesList[index]
                                                .userPlaceForMassage
                                                .contains('自宅'),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // BoxShape.circle or BoxShape.retangle
                                              //color: const Color(0xFF66BB6A),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset.zero,
                                                  color: _addressType == 1 &&
                                                          HealingMatchConstants
                                                                  .searchUserAddress !=
                                                              null
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                                  blurRadius: 7.0,
                                                ),
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _addressType = 1;
                                                    HealingMatchConstants
                                                            .searchUserAddress =
                                                        constantUserAddressValuesList[
                                                                index]
                                                            .address;
                                                  });
                                                  print(
                                                      'User address home : ${HealingMatchConstants.searchUserAddress}');
                                                },
                                                child: CircleAvatar(
                                                  maxRadius: 32,
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  child: SvgPicture.asset(
                                                      'assets/images_gps/house.svg',
                                                      placeholderBuilder:
                                                          (context) {
                                                    return SpinKitDoubleBounce(
                                                        color: Colors
                                                            .lightGreenAccent);
                                                  },
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                HealingMatchConstants
                                                    .searchHomeIconTxt,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1),
                                      Visibility(
                                        visible: constantUserAddressValuesList[
                                                        index]
                                                    .userPlaceForMassage !=
                                                null &&
                                            constantUserAddressValuesList[index]
                                                .userPlaceForMassage
                                                .contains('オフィス'),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // BoxShape.circle or BoxShape.retangle
                                              //color: const Color(0xFF66BB6A),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset.zero,
                                                  color: _addressType == 2 &&
                                                          HealingMatchConstants
                                                                  .searchUserAddress !=
                                                              null
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                                  blurRadius: 7.0,
                                                ),
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _addressType = 2;
                                                    HealingMatchConstants
                                                            .searchUserAddress =
                                                        constantUserAddressValuesList[
                                                                index]
                                                            .address;
                                                  });
                                                  print(
                                                      'User address office : ${HealingMatchConstants.searchUserAddress}');
                                                },
                                                child: CircleAvatar(
                                                  maxRadius: 32,
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  child: SvgPicture.asset(
                                                      'assets/images_gps/office.svg',
                                                      placeholderBuilder:
                                                          (context) {
                                                    return SpinKitDoubleBounce(
                                                        color: Colors
                                                            .lightGreenAccent);
                                                  },
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                HealingMatchConstants
                                                    .searchOfficeIconTxt,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1),
                                      Visibility(
                                        visible: constantUserAddressValuesList[
                                                        index]
                                                    .userPlaceForMassage !=
                                                null &&
                                            constantUserAddressValuesList[index]
                                                .userPlaceForMassage
                                                .contains('実家'),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // BoxShape.circle or BoxShape.retangle
                                              //color: const Color(0xFF66BB6A),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset.zero,
                                                  color: _addressType == 3 &&
                                                          HealingMatchConstants
                                                                  .searchUserAddress !=
                                                              null
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                                  blurRadius: 7.0,
                                                ),
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _addressType = 3;
                                                    HealingMatchConstants
                                                            .searchUserAddress =
                                                        constantUserAddressValuesList[
                                                                index]
                                                            .address;
                                                  });
                                                  print(
                                                      'User address parents house : ${HealingMatchConstants.searchUserAddress}');
                                                },
                                                child: CircleAvatar(
                                                  maxRadius: 32,
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  child: SvgPicture.asset(
                                                      'assets/images_gps/parents_house.svg',
                                                      placeholderBuilder:
                                                          (context) {
                                                    return SpinKitDoubleBounce(
                                                        color: Colors
                                                            .lightGreenAccent);
                                                  },
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                HealingMatchConstants
                                                    .searchPHomeIconTxt,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 1),
                                      Visibility(
                                        visible: constantUserAddressValuesList[
                                                        index]
                                                    .userPlaceForMassage !=
                                                null &&
                                            constantUserAddressValuesList[index]
                                                .userPlaceForMassage
                                                .contains('その他'),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // BoxShape.circle or BoxShape.retangle
                                              //color: const Color(0xFF66BB6A),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset.zero,
                                                  color: _addressType == 4 &&
                                                          HealingMatchConstants
                                                                  .searchUserAddress !=
                                                              null
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                                  blurRadius: 7.0,
                                                ),
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _addressType = 4;
                                                    HealingMatchConstants
                                                            .searchUserAddress =
                                                        constantUserAddressValuesList[
                                                                index]
                                                            .address;
                                                  });
                                                  print(
                                                      'User address other : ${HealingMatchConstants.searchUserAddress}');
                                                },
                                                child: CircleAvatar(
                                                  maxRadius: 32,
                                                  backgroundColor:
                                                      Colors.grey[100],
                                                  child: SvgPicture.asset(
                                                      'assets/images_gps/others.svg',
                                                      placeholderBuilder:
                                                          (context) {
                                                    return SpinKitDoubleBounce(
                                                        color: Colors
                                                            .lightGreenAccent);
                                                  },
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      height: 30,
                                                      width: 30),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                HealingMatchConstants
                                                    .searchOtherIconTxt,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
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
                                  HealingMatchConstants.serviceType = 1;
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
                                  HealingMatchConstants.serviceType = 2;
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
                              //onTap: () => setState(() => _value = 2),
                              onTap: () {
                                setState(() {
                                  _value = 3;
                                  HealingMatchConstants.serviceType = 3;
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
                              //onTap: () => setState(() => _value = 3),
                              onTap: () {
                                setState(() {
                                  _value = 4;
                                  HealingMatchConstants.serviceType = 4;
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
                        HealingMatchConstants.isLocationCriteria = value;
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
                                      displayDay = DateTime(
                                          _cyear, _cmonth, _currentDay);
                                      daysToDisplay =
                                          totalDays(_cmonth, _cyear);
                                    });
                                  },
                                  value: yearString,
                                  onChanged: (value) {
                                    yearString = value;
                                    _cyear = int.parse(value);
                                    _currentDay = 1;
                                    setState(() {
                                      displayDay = DateTime(
                                          _cyear, _cmonth, _currentDay);

                                      daysToDisplay =
                                          totalDays(_cmonth, _cyear);
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
                                      enabled: _isVisible,
                                      fillColor:
                                          Color.fromRGBO(255, 255, 255, 1),
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
                                          daysToDisplay =
                                              totalDays(_cmonth, _cyear);
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
                                          daysToDisplay =
                                              totalDays(_cmonth, _cyear);
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
            top: 500.0,
            bottom: 100.0,
            right: 20.0,
            left: 0.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Color.fromRGBO(200, 217, 33, 1),
                    child: IconButton(
                      onPressed: () {
                        proceedToSearchResults();
                      },
                      icon: Image.asset(
                        "assets/images_gps/search.png",
                        height: 25,
                        width: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                  minutesInterval: 15,
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
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    setState(() {
                      _dateTime = time;
                      print('Selected Date and Time : $_dateTime');
                      HealingMatchConstants.dateTime = _dateTime;
                      timeDurationSinceDate(HealingMatchConstants.dateTime);
                    });
                  },
                )),
          ),
        ],
      ),
    );
  }

  timeDurationSinceDate(var dateString, {bool numericDates = true}) {
    final date2 = DateTime.now();
    differenceInTime = date2.difference(dateString);
    print('Converted Date and Time  : ${differenceInTime.inMinutes}');
    if (differenceInTime.inMinutes >= 1) {
      print('PAST TIME');
    }
    if (differenceInTime.inMinutes.floor() < 1) {
      print('FUTURE TIME');
    }
    if (differenceInTime.inMinutes.floor() == 30) {
      print('30 MINUTES IN PRIOR');
    }
  }

  getValidSearchFields() async {
    showOverlayLoader();
    _sharedPreferences.then((value) {
      if (value != null) {
        var userDetails = ServiceUserAPIProvider.getUserDetails(
            context, HealingMatchConstants.serviceUserID);
        userDetails.then((value) {
          setState(() {
            constantUserAddressValuesList = value.data.addresses;
            for (var category in constantUserAddressValuesList) {
              print(
                  'List length search : ${constantUserAddressValuesList.length}');

              var categoryData = category.userPlaceForMassage;
              constantUserAddressSize.add(categoryData);
              print(
                  'Size of list category : ${constantUserAddressSize.length} && $categoryData');
              hideLoader();
            }
          });
        }).catchError((onError) {
          hideLoader();
          print('Catch error search : $onError');
        });
      }
    }).catchError((onError) {
      hideLoader();
      print('S_Pref Exception : $onError');
    });
  }

  _getLatLngFromAddress(String userAddress) async {
    try {
      List<Placemark> address =
          await geoLocator.placemarkFromAddress(userAddress);

      userAddedAddressPlaceMark = address[0];
      Position addressPosition = userAddedAddressPlaceMark.position;

      searchAddressLatitude = addressPosition.latitude;
      searchAddressLongitude = addressPosition.longitude;

      HealingMatchConstants.searchAddressLatitude = searchAddressLatitude;
      HealingMatchConstants.searchAddressLongitude = searchAddressLongitude;

      print(
          'Address location points : $searchAddressLatitude && $searchAddressLongitude');
      if (HealingMatchConstants.searchAddressLatitude != null &&
          HealingMatchConstants.searchAddressLongitude != null) {
        _getSearchResults();
      } else {
        hideLoader();
        _searchKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('検索に有効な住所を選択してください。',
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
        return;
      }
    } catch (e) {
      e.toString();
    }
  }

  proceedToSearchResults() async {
    try {
      showOverlayLoader();
      print(
          'User address proceed : ${HealingMatchConstants.searchUserAddress}');
      if (HealingMatchConstants.searchUserAddress != null) {
        _getLatLngFromAddress(HealingMatchConstants.searchUserAddress);
      } else {
        hideLoader();
        _searchKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('有効なさがすすエリアを選択してください。',
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
        return;
      }
    } catch (e) {
      hideLoader();
      print('Exception in search criteria : ${e.toString()}');
    }
  }

  _getKeywordResults() {
    ServiceUserAPIProvider.getTherapistSearchResults(
            context, _pageNumber, _pageSize)
        .then((value) {
      if (value != null &&
          value.status != null &&
          value.data.searchList != null &&
          value.data.searchList.length != 0) {
        HealingMatchConstants.searchList = value.data.searchList;
        print(
            'Search List Length : ${HealingMatchConstants.searchList.length}');
        NavigationRouter.switchToUserSearchResult(context);
      } else {
        hideLoader();
        _searchKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 7),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('検索結果が見つかりません！他の値の入力で再試行してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
      }
    }).catchError((onError) {
      hideLoader();
      print('Search catch error : ${onError.toString()}');
    });
  }

  _getSearchResults() {
    ServiceUserAPIProvider.getTherapistSearchResults(
            context, _pageNumber, _pageSize)
        .then((value) {
      if (value != null &&
          value.status != null &&
          value.data.searchList != null &&
          value.data.searchList.length != 0) {
        HealingMatchConstants.searchList = value.data.searchList;
        print(
            'Search List Length : ${HealingMatchConstants.searchList.length}');
        NavigationRouter.switchToUserSearchResult(context);
      } else {
        hideLoader();
        _searchKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 7),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('検索結果が見つかりません！他の値の入力で再試行してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
      }
    }).catchError((onError) {
      hideLoader();
      print('Search catch error : ${onError.toString()}');
    });
  }

  showOverlayLoader() {
    Loader.show(
      context,
      progressIndicator: SpinKitThreeBounce(color: Colors.lime),
    );
  }

  hideLoader() {
    Future.delayed(Duration(seconds: 0), () {
      Loader.hide();
    });
  }
}
