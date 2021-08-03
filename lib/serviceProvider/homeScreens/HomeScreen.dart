import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_util/date_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/providerHomeCardToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/numberpicker.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/ProviderDetailsResponseModel.dart'
    as providerDetails;
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderHomeScreen extends StatefulWidget {
  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  final yearKey = new GlobalKey<FormState>();
  final monthKey = new GlobalKey<FormState>();
  DayViewController dayViewController = DayViewController();
  bool readonly = false;
  Data userData;
  var yearString, monthString, dateString;
  var certificateUpload;
  var userQulaification;
  GlobalKey key = new GlobalKey();

  providerDetails.ProviderDetailsResponseModel therapistDetails =
      providerDetails.ProviderDetailsResponseModel();

  DateTime today = DateTime.now();
  DateTime displayDay;

  NumberPicker dayPicker;
  int _state = 0;
  int _cyear;
  int _cmonth;
  int _currentDay;
  int _lastday;
  int _counter = 0;
  int daysToDisplay;
  int status = 0;
  String startTime = "00:00";
  String endTime = "24:00";
  Map<int, String> childrenMeasure;
  Map<String, String> certificateImages = Map<String, String>();
  List<String> yearDropDownValues = List<String>();
  List<FlutterWeekViewEvent> flutterWeekEvents = List<FlutterWeekViewEvent>();
  List<DateTime> eventDateTime = List<DateTime>();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  void initState() {
    super.initState();

    HealingMatchConstants.isProvider = true;
    HealingMatchConstants.isProviderHomePage = true;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    HealingMatchConstants.fbUserId = firebaseAuth.currentUser.uid;
    buildYearDropDown();
    getProviderDetails();

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

  buildYearDropDown() {
    for (int i = today.year; i <= today.year + 1; i++) {
      yearDropDownValues.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _state = 1;
        if (HealingMatchConstants.isActive != null &&
            HealingMatchConstants.isActive == false) {
          DialogHelper.showProviderBlockDialog(context);
        } else {
          return;
        }
      });
    }
    return Scaffold(
      body: status != 3
          ? Container(
              color: Colors.white,
              child: Center(child: SpinKitThreeBounce(color: Colors.lime)),
            )
          : therapistDetails == null
              ? Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    "管理者の承認を待っています！",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  )),
                )
              : SingleChildScrollView(
                  child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            color: Colors.grey[200],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade200, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ClipOval(
                                          child: CircleAvatar(
                                            radius: 32.0,
                                            backgroundColor: Colors.white,
                                            child:
                                                /*  Image.network(
                                          userData.uploadProfileImgUrl,
                                          //User Profile Pic
                                          fit: BoxFit.cover,
                                          width: 100.0,
                                          height: 100.0,
                                        ), */
                                                CachedNetworkImage(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                    imageUrl: userData
                                                        .uploadProfileImgUrl,
                                                    placeholder: (context,
                                                            url) =>
                                                        SpinKitWave(
                                                            size: 20.0,
                                                            color: ColorConstants
                                                                .buttonColor),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Column(
                                                          children: [
                                                            new IconButton(
                                                              icon: Icon(
                                                                  Icons
                                                                      .refresh_sharp,
                                                                  size: 40),
                                                              onPressed: () {
                                                                /* _getBannerImages(); */
                                                              },
                                                            ),
                                                          ],
                                                        )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 8.0,
                                            bottom: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  userData.storeName != null &&
                                                          userData.storeName !=
                                                              ""
                                                      ? userData.storeName
                                                                  .length >
                                                              10
                                                          ? userData.storeName
                                                                  .substring(
                                                                      0, 10) +
                                                              "..."
                                                          : userData.storeName
                                                      : userData.userName.length >
                                                              10
                                                          ? userData.userName
                                                                  .substring(
                                                                      0, 10) +
                                                              "..."
                                                          : userData
                                                              .userName, //User Name
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: () {
                                                    showToolTip(
                                                        userData.storeType);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey[400],
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SvgPicture.asset(
                                                        "assets/images_gps/info.svg",
                                                        height: 10.0,
                                                        width: 10.0,
                                                        key: key,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  userData.businessForm !=
                                                              null ||
                                                          userData.businessTrip !=
                                                              null ||
                                                          userData.coronaMeasure !=
                                                              null
                                                      ? 10.0
                                                      : 0.0,
                                            ),
                                            Row(
                                              children: [
                                                (userData.businessForm ==
                                                            "施術店舗あり 施術従業員あり" ||
                                                        userData.businessForm ==
                                                            "施術店舗あり 施術従業員なし（個人経営）")
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0.0,
                                                                top: 0.0,
                                                                right: 8.0,
                                                                bottom: 0.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          decoration:
                                                              boxDecoration,
                                                          child: Text(
                                                            '店舗', //Store
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                                (userData.businessTrip)
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 0.0,
                                                                right: 8.0,
                                                                bottom: 0.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              boxDecoration,
                                                          child: Text(
                                                            '出張', //Business Trip
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                                (userData.coronaMeasure)
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 0.0,
                                                                right: 8.0,
                                                                bottom: 0.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              boxDecoration,
                                                          child: Text(
                                                            'コロナ対策実施', //Corona Measure
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: userData.genderOfService !=
                                                          null &&
                                                      userData.genderOfService !=
                                                          ''
                                                  ? 10.0
                                                  : 0.0,
                                            ),
                                            userData.genderOfService != null &&
                                                    userData.genderOfService !=
                                                        ''
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    decoration: boxDecoration,
                                                    child: userData
                                                                .genderOfService ==
                                                            "男性女性両方"
                                                        ? Text(
                                                            '男性と女性の両方が予約できます',
                                                            //both men and women can book
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : userData.genderOfService ==
                                                                "女性のみ"
                                                            ? Text(
                                                                '女性のみ予約可', //only women
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            : Text(
                                                                '男性のみ予約可能', //only men
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height: childrenMeasure != null
                                                  ? 6.0
                                                  : 0.0,
                                            ),
                                            childrenMeasure != null
                                                ? Container(
                                                    height: 38.0,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            130.0, //200.0,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            childrenMeasure
                                                                .length,
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Padding(
                                                            padding: index == 0
                                                                ? const EdgeInsets
                                                                        .only(
                                                                    left: 0.0,
                                                                    top: 4.0,
                                                                    right: 4.0,
                                                                    bottom: 4.0)
                                                                : const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  boxDecoration,
                                                              child: Text(
                                                                childrenMeasure[
                                                                    index], //Children Measure
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                : Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0,
                                                  top: 10.0,
                                                  right: 8.0,
                                                  bottom: 0.0),
                                              child: InkWell(
                                                onTap: () {
                                                  NavigationRouter
                                                      .switchToProviderSelfReviewScreen(
                                                          context);
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '(${therapistDetails.reviewData.ratingAvg})',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.black,
                                                          shadows: [
                                                            Shadow(
                                                                color: Colors
                                                                    .black,
                                                                offset: Offset(
                                                                    0, -3))
                                                          ],
                                                          fontSize: 14,
                                                          color: Colors
                                                              .transparent,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    RatingBar.builder(
                                                      initialRating:
                                                          double.parse(
                                                              therapistDetails
                                                                  .reviewData
                                                                  .ratingAvg),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      unratedColor:
                                                          Colors.grey[400],
                                                      itemCount: 5,
                                                      itemSize: 24.0,
                                                      ignoreGestures: true,
                                                      itemPadding:
                                                          new EdgeInsets.only(
                                                              bottom: 3.0),
                                                      itemBuilder:
                                                          (context, index) {
                                                        double ratingAvg =
                                                            double.parse(
                                                                therapistDetails
                                                                    .reviewData
                                                                    .ratingAvg);
                                                        bool isDecimal =
                                                            isInteger(
                                                                (ratingAvg));
                                                        print("$isDecimal");
                                                        return SizedBox(
                                                            height: 20.0,
                                                            width: 18.0,
                                                            child:
                                                                new IconButton(
                                                              onPressed: () {},
                                                              padding:
                                                                  new EdgeInsets
                                                                      .all(0.0),
                                                              // color: Colors.white,
                                                              icon: index >
                                                                      (double.parse(therapistDetails.reviewData.ratingAvg))
                                                                              .ceilToDouble() -
                                                                          1
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      "assets/images_gps/star_2.svg",
                                                                      height:
                                                                          13.0,
                                                                      width:
                                                                          13.0,
                                                                    )
                                                                  : !isDecimal &&
                                                                          index ==
                                                                              ((double.parse(therapistDetails.reviewData.ratingAvg)).ceilToDouble() -
                                                                                  1)
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          "assets/images_gps/half_star.svg",
                                                                          height:
                                                                              13.0,
                                                                          width:
                                                                              13.0,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          "assets/images_gps/star_colour.svg",
                                                                          height:
                                                                              13.0,
                                                                          width:
                                                                              13.0,
                                                                          //color: Colors.black,
                                                                        ),
                                                            ));
                                                      },
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                      '(${therapistDetails.reviewData.noOfReviewsMembers})',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.black,
                                                          shadows: [
                                                            Shadow(
                                                                color: Colors
                                                                    .black,
                                                                offset: Offset(
                                                                    0, -3))
                                                          ],
                                                          fontSize: 10,
                                                          color: Colors
                                                              .transparent,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  certificateImages.length != 0
                                                      ? 6.0
                                                      : 0.0,
                                            ),
                                            certificateImages.length != 0
                                                ? Container(
                                                    height: 38.0,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            130.0, //200.0,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            certificateImages
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          String key =
                                                              certificateImages
                                                                  .keys
                                                                  .elementAt(
                                                                      index);
                                                          return Padding(
                                                            padding: index == 0
                                                                ? const EdgeInsets
                                                                        .only(
                                                                    left: 0.0,
                                                                    top: 4.0,
                                                                    right: 4.0,
                                                                    bottom: 4.0)
                                                                : const EdgeInsets
                                                                    .all(4.0),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  boxDecoration,
                                                              child: Text(
                                                                key, //Qualififcation
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey),
                                  Row(children: [
                                    SizedBox(width: 5.0),
                                    SvgPicture.asset(
                                      "assets/images_gps/gps.svg",
                                      height: 25.0,
                                      width: 25.0,
                                    ),
                                    SizedBox(width: 8.0),
                                    Flexible(
                                      child: Text(
                                        userData.addresses[0].address,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ]),
                                ],
                              ),
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
                                        side: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images_gps/c_weekly.svg",
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.black,
                                          ),
                                          FittedBox(
                                              child: Text(
                                            '今週の売り上げ',
                                            style: TextStyle(fontSize: 12),
                                          )),
                                          Text(
                                            therapistDetails.therapistProfit
                                                        .weeklyProfit ==
                                                    null
                                                ? "0.00"
                                                : '¥${therapistDetails.therapistProfit.weeklyProfit}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                        side: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images_gps/c_monthly.svg",
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.black,
                                          ),
                                          FittedBox(
                                              child: Text(
                                            '今月の売り上げ',
                                            style: TextStyle(fontSize: 12),
                                          )),
                                          Text(
                                            therapistDetails.therapistProfit
                                                        .monthlyProfit ==
                                                    null
                                                ? "0.00"
                                                : '¥ ${therapistDetails.therapistProfit.monthlyProfit}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                        side: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images_gps/c_yearly.svg",
                                            height: 30.0,
                                            width: 30.0,
                                            color: Colors.black,
                                          ),
                                          FittedBox(
                                              child: Text(
                                            '本年度の売り上げ',
                                            style: TextStyle(fontSize: 12),
                                          )),
                                          Text(
                                            therapistDetails.therapistProfit
                                                        .yearlyProfit ==
                                                    null
                                                ? "0.00"
                                                : '¥ ${therapistDetails.therapistProfit.yearlyProfit}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Form(
                                      key: yearKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 80.0,
                                            /* MediaQuery.of(context).size.width *
                                                0.2, */
                                            color: Colors.transparent,
                                            child: DropDownFormField(
                                              fillColor: Colors.white,
                                              borderColor: Color.fromRGBO(
                                                  228, 228, 228, 1),
                                              titleText: null,
                                              hintText: readonly
                                                  ? yearString
                                                  : HealingMatchConstants
                                                      .registrationBankAccountType,
                                              onSaved: (value) {
                                                var dateUtility = DateUtil();

                                                setState(() {
                                                  yearString = value;
                                                  _cyear = int.parse(value);
                                                  //To resolve the currentDay selected error from other month of greater than 28
                                                  if (_cmonth == 2) {
                                                    if (_currentDay > 28) {
                                                      _currentDay = 28;
                                                    }
                                                  }

                                                  var day1 =
                                                      dateUtility.daysInMonth(
                                                          _cmonth, _cyear);

                                                  daysToDisplay = day1;

                                                  displayDay = DateTime(_cyear,
                                                      _cmonth, _currentDay);
                                                });
                                              },
                                              value: yearString,
                                              onChanged: (value) {
                                                yearString = value;
                                                _cyear = int.parse(value);
                                                //To resolve the currentDay selected error from other month of greater than 28
                                                if (_cmonth == 2) {
                                                  if (_currentDay > 28) {
                                                    _currentDay = 28;
                                                  }
                                                }

                                                var dateUtility = DateUtil();
                                                var day1 =
                                                    dateUtility.daysInMonth(
                                                        _cmonth, _cyear);

                                                setState(() {
                                                  daysToDisplay = day1;

                                                  displayDay = DateTime(_cyear,
                                                      _cmonth, _currentDay);
                                                });
                                              },
                                              dataSource: yearDropDownValues,
                                              isList: true,
                                              textField: 'display',
                                              valueField: 'value',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                        width: 80.0,
                                        /*   MediaQuery.of(context).size.width * 0.2, */
                                        child: Form(
                                          key: monthKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                color: Colors.transparent,
                                                child: DropDownFormField(
                                                  fillColor: Colors.white,
                                                  borderColor: Color.fromRGBO(
                                                      228, 228, 228, 1),
                                                  titleText: null,
                                                  hintText: readonly
                                                      ? monthString
                                                      : HealingMatchConstants
                                                          .registrationBankAccountType,
                                                  onSaved: (value) {
                                                    monthString = value;
                                                    var dateUtility =
                                                        DateUtil();
                                                    _cmonth = int.parse(value);
                                                    //To resolve the currentDay selected error from other month of greater than 28
                                                    if (_cmonth == 2) {
                                                      if (_currentDay > 28) {
                                                        _currentDay = 28;
                                                      }
                                                    }

                                                    var day1 =
                                                        dateUtility.daysInMonth(
                                                            _cmonth, _cyear);
                                                    setState(() {
                                                      daysToDisplay = day1;

                                                      displayDay = DateTime(
                                                          _cyear,
                                                          _cmonth,
                                                          _currentDay);
                                                    });
                                                  },
                                                  value: monthString,
                                                  onChanged: (value) {
                                                    monthString = value;
                                                    _cmonth = int.parse(value);
                                                    if (_cmonth == 2) {
                                                      if (_currentDay > 28) {
                                                        _currentDay = 28;
                                                      }
                                                    }

                                                    displayDay = DateTime(
                                                        _cyear,
                                                        _cmonth,
                                                        _currentDay);
                                                    var dateUtility =
                                                        DateUtil();
                                                    var day1 =
                                                        dateUtility.daysInMonth(
                                                            _cmonth, _cyear);

                                                    setState(() {
                                                      daysToDisplay = day1;
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
                              SizedBox(width: 20),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 8.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(228, 228, 228, 1),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              NavigationRouter
                                                  .switchToProviderCalendarScreen(
                                                      context);
                                            },
                                            child: SvgPicture.asset(
                                              "assets/images_gps/calendar.svg",
                                              height: 25.0,
                                              width: 25.0,
                                            ),
                                          ),
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

                        buildDayPicker(),

                        //  SizedBox(height: 20),
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey[200],
                                  border: Border.all(
                                    color: Colors.transparent,
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        color: Color.fromRGBO(233, 233, 233, 1),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        "営業時間 - $startTime ~ $endTime",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 15.0),
                                        child: InkWell(
                                          onTap: () => NavigationRouter
                                              .switchToWeeklySchedule(context),
                                          child: Container(
                                            height: 250.0,
                                            child: DayView(
                                              controller: dayViewController,
                                              initialTime: const HourMinute(
                                                  hour: 0, minute: 0),
                                              minimumTime: HourMinute(
                                                  hour: 0, minute: 0),
                                              maximumTime: HourMinute.MAX,
                                              date: displayDay,
                                              inScrollableWidget: true,
                                              hoursColumnStyle:
                                                  HoursColumnStyle(
                                                color: Color.fromRGBO(
                                                    242, 242, 242, 1),
                                                textStyle: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Color.fromRGBO(
                                                        158, 158, 158, 1)),
                                              ),
                                              style: DayViewStyle(
                                                  hourRowHeight: 85.0,
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          242, 242, 242, 1),
                                                  currentTimeCircleColor:
                                                      Colors.transparent,
                                                  backgroundRulesColor:
                                                      Colors.transparent,
                                                  currentTimeRuleColor:
                                                      Colors.transparent,
                                                  headerSize: 0.0),
                                              events: flutterWeekEvents,
                                            ),
                                          ),
                                        ),
                                      ),
                                      /*  Positioned(
                                                                                     top: 0,
                                                                                     left: 0,
                                                                                     width: 70.0,
                                                                                     child: Padding(
                                                                                       padding:
                                                                                           const EdgeInsets.only(top: 13.0, right: 8.0),
                                                                                       child: Text("09:00",
                                                                                           textAlign: TextAlign.right,
                                                                                           style: TextStyle(color: Colors.grey[500])),
                                                                                     ),
                                                                                   ),
                                                                                 */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }

  Card buildAppointmentDetails() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10),
              Text(
                "日付を選",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Text(
                    ' 日付を選択し日付を選択し ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  )),
              Row(
                children: [
                  Icon(Icons.access_time_rounded,
                      size: 20, color: Colors.yellow),
                  Text(
                    '今月',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 20,
              ),
              Text(
                '日付を選日付を選',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  '日付を選日付を選',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20),
              Text(
                '日付を選日付を選',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: Text(
                    ' 日付を選 ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  changeMonthPickerVal(int focusedMonth) {
    // setState(() {
    _currentDay = focusedMonth;
    // print("Focused Month: $focusedMonth");
    dayPicker.animateInt(focusedMonth);
    // });
  }

  List<DateTime> getEventDateTime() {
    eventDateTime.clear();
    for (var event in HealingMatchConstants.calEvents) {
      DateTime startTime = event.events.start.dateTime.toLocal();
      DateTime eventDate =
          DateTime(startTime.year, startTime.month, startTime.day);

      eventDateTime.add(eventDate);
    }
    return eventDateTime;
  }

  buildDayPicker() {
    dayPicker = NumberPicker.horizontal(
      currentDate: DateTime.now(),
      selectedYear: _cyear,
      enabled: true,
      ismonth: true,
      numberToDisplay: 7,
      selectedMonth: _cmonth,
      eventDates: getEventDateTime(),
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
                      monthString = _cmonth.toString();
                      dayPicker.animateInt(_currentDay);
                      changeDay(_currentDay);
                    } else {
                      var day1 =
                          dateUtility.daysInMonth(_cmonth - 1, _cyear - 1);
                      daysToDisplay = day1;
                      _currentDay = day1;
                      _cmonth = 12;
                      monthString = _cmonth.toString();
                      _cyear = _cyear + 1;
                      yearString = _cyear.toString();
                      dayPicker.animateInt(_currentDay);
                      changeDay(_currentDay);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: dayPicker, //Daypicker Build here
              ),
              Positioned(
                right: 0,
                top: 34.0,
                child: InkWell(
                  onTap: () {
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
                      monthString = _cmonth.toString();
                      dayPicker.animateInt(_currentDay);
                      changeDay(_currentDay);
                    } else {
                      day1 = dateUtility.daysInMonth(_cmonth + 1, _cyear + 1);
                      daysToDisplay = day1;
                      _currentDay = 1;
                      _cmonth = 1;
                      monthString = _cmonth.toString();
                      _cyear = _cyear + 1;
                      yearString = _cyear.toString();
                      dayPicker.animateInt(_currentDay);
                      changeDay(_currentDay);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.0,
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
      //dayViewController.

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

  void getProviderDetails() async {
    // showOverlayLoader();

    DateTime minSTime;
    DateTime minETime;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isProviderRegister', true);
    userData =
        Data.fromJson(json.decode(sharedPreferences.getString("userData")));
    HealingMatchConstants.accessToken =
        sharedPreferences.getString("accessToken");
    // HealingMatchConstants.isActive = sharedPreferences.getBool("isActive");
    HealingMatchConstants.userData = userData;

    HealingMatchConstants.userId = userData.id;
    HealingMatchConstants.serviceProviderEmailAddress = userData.email;

    HealingMatchConstants.providerName =
        userData.storeName != null && userData.storeName != ''
            ? userData.storeName
            : userData.userName;
    HealingMatchConstants.numberOfEmployeeRegistered = userData.numberOfEmp;

    if (userData.childrenMeasure != null && userData.childrenMeasure != '') {
      var split = userData.childrenMeasure.split(',');
      childrenMeasure = {for (int i = 0; i < split.length; i++) i: split[i]};
    }
    certificateUpload = userData.certificationUploads[0].toJson();
    certificateUpload.remove('id');
    certificateUpload.remove('userId');
    certificateUpload.remove('createdAt');
    certificateUpload.remove('updatedAt');
    certificateUpload.forEach((key, value) async {
      if (certificateUpload[key] != null) {
        String jKey = getQualififcationJaWords(key);
        if (jKey == "はり師" ||
            jKey == "きゅう師" ||
            jKey == "鍼灸師" ||
            jKey == "あん摩マッサージ指圧師" ||
            jKey == "柔道整復師" ||
            jKey == "理学療法士") {
          certificateImages["国家資格保有"] = "国家資格保有";
        } else if (jKey == "国家資格取得予定（学生）") {
          certificateImages["国家資格取得予定（学生）"] = "国家資格取得予定（学生）";
        } else if (jKey == "民間資格") {
          certificateImages["民間資格保有"] = "民間資格保有";
        } else if (jKey == "無資格") {
          certificateImages["無資格"] = "無資格";
        }
      }
    });
    if (certificateImages.length == 0) {
      certificateImages["無資格"] = "無資格";
    }

    setState(() {
      status = status + 1;
    });

    ServiceProviderApi.getProfitandRatingApi().then((value) {
      therapistDetails = value;

      HealingMatchConstants.isActive = value.data.isActive;

      if (therapistDetails.data.storeServiceTimes.isNotEmpty) {
        for (int i = 0;
            i < therapistDetails.data.storeServiceTimes.length;
            i++) {
          if (therapistDetails.data.storeServiceTimes[i].shopOpen) {
            DateTime startTime =
                therapistDetails.data.storeServiceTimes[i].startTime.toLocal();
            DateTime endTime =
                therapistDetails.data.storeServiceTimes[i].endTime.toLocal();
            DateTime currentSTime = DateTime(startTime.year, startTime.month, 1,
                startTime.hour, startTime.minute, startTime.second);
            DateTime currentETime = endTime.hour == 0
                ? DateTime(endTime.year, endTime.month, 2, endTime.hour,
                    endTime.minute, endTime.second)
                : DateTime(endTime.year, endTime.month, 1, endTime.hour,
                    endTime.minute, endTime.second);
            if (i == 0) {
              minSTime = currentSTime;
              minETime = currentETime;
            } else {
              if (currentSTime.compareTo(minSTime) < 0) {
                minSTime = currentSTime;
              }
              if (currentETime.compareTo(minETime) > 0) {
                minETime = currentETime;
              }
            }
          }
        }
        if (minSTime != null && minETime != null) {
          this.startTime = minSTime.hour == 0
              ? DateFormat('KK:mm').format(minSTime)
              : DateFormat('kk:mm').format(minSTime);
          this.endTime = DateFormat('kk:mm').format(minETime);
        }
      }

      setState(() {
        status = status + 1;
      });
    });

    ServiceProviderApi.getCalEvents().then((value) {
      flutterWeekEvents.addAll(value);

      setState(() {
        status = status + 1;
      });
    });

    ServiceProviderApi.getTherapistDetails(context).then((value) {
      if (value.status == 'success') {
        print(
            'User Stripe Verification status : ${value.data.isStripeVerified} !!');
      } else {
        print('This User is not Stripe Verified !!');
        return;
      }
    }).catchError((onError) {
      print('Get Therapist Details Exception : $onError');
    });
    // hideLoader();
  }

  void showToolTip(String text) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: 130,
        width: 180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  String getQualififcationJaWords(String key) {
    switch (key) {
      case 'acupuncturist':
        return 'はり師';
        break;
      case 'moxibutionist':
        return 'きゅう師';
        break;
      case 'acupuncturistAndMoxibustion':
        return '鍼灸師';
        break;
      case 'anmaMassageShiatsushi':
        return 'あん摩マッサージ指圧師';
        break;
      case 'judoRehabilitationTeacher':
        return '柔道整復師';
        break;
      case 'physicalTherapist':
        return '理学療法士';
        break;
      case 'acquireNationalQualifications':
        return '国家資格取得予定（学生）';
        break;
      case 'privateQualification1':
        return '民間資格';
      case 'privateQualification2':
        return '民間資格';
      case 'privateQualification3':
        return '民間資格';
      case 'privateQualification4':
        return '民間資格';
      case 'privateQualification5':
        return '民間資格';
        break;
    }
  }

  bool isInteger(num value) => (value % 1) == 0;
}
