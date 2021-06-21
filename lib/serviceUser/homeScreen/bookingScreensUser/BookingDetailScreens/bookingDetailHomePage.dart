import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/bookingTimeToolTip/bookingTimeToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailCarouselWithIndicator.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailPeofileDetailsHome.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class BookingDetailHomePage extends StatefulWidget {
  final int id;

  BookingDetailHomePage(this.id);

  @override
  _BookingDetailHomePageState createState() => _BookingDetailHomePageState();
}

class _BookingDetailHomePageState extends State<BookingDetailHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TherapistByIdModel therapistDetails;
  int status = 0;
  int _value = 0;
  int serviceTypeVal = 0;
  int lastIndex = 999;
  var result;
  ItemScrollController scrollController = ItemScrollController();
  List<bool> visibility = List<bool>();
  List<TherapistList> allTherapistList = List<TherapistList>();
  List<GlobalKey> globalKeyList = List<GlobalKey>();
  List<String> bannerImages = List<String>();
  Map<String, Map<int, int>> serviceSelection = Map<String, Map<int, int>>();
  DateTime selectedTime, endTime;
  int min = 0;
  var serviceName, serviceDuration, serviceCostMap, serviceCost, subCategoryId;
  bool shopLocationSelected = false;
  var userPlaceForMassage, therapistAddress, userRegisteredAddress;
  GlobalKey<FormState> _userDetailsFormKey = new GlobalKey<FormState>();
  int serviceCId;
  int serviceSubId;
  var finalAmount;
  bool isLoading = false;

  String defaultBannerUrl =
      "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80";

  @override
  void initState() {
    HealingMatchConstants.bookingAddressId =
        HealingMatchConstants.userRegAddressId;
    getProviderInfo();
    super.initState();
  }

  getServiceType() async {
    print('typwe:${therapistDetails.data.storeType}');
    String serviceType = therapistDetails.data.storeType;
    var splilts = serviceType.split(',');
    final jsonListType = splilts.map((item) => jsonEncode(item)).toList();
    final uniqueJsonListType = jsonListType.toSet().toList();
    result = uniqueJsonListType.map((item) => jsonDecode(item)).toList();
  }

  getProviderInfo() async {
    try {
      HealingMatchConstants.selectedDateTime = null;
      ProgressDialogBuilder.showOverlayLoader(context);
      therapistDetails =
          await ServiceUserAPIProvider.getTherapistDetails(context, widget.id);
      HealingMatchConstants.therapistProfileDetails = therapistDetails;
      //append all Service Types for General View

      //add Banner Images
      if (therapistDetails.data.banners[0].bannerImageUrl1 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl1);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl2 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl2);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl3 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl3);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl4 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl4);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl5 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl5);
      }
      if (bannerImages.length == 0) {
        bannerImages.add(defaultBannerUrl);
      }

      if (this.mounted) {
        setState(() {
          userRegisteredAddress =
              HealingMatchConstants.userRegisteredAddressDetail;
          userPlaceForMassage = HealingMatchConstants.userPlaceForMassage;
          getServiceType();

          status = 1;
        });
      }
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Therapist details fetch Exception : ${e.toString()}');
    }
  }

  getSubType() {
    if (this.mounted) {
      setState(() {
        if (_value == 1) {
          allTherapistList.addAll(therapistDetails.therapistEstheticList);
        }
        if (_value == 2) {
          allTherapistList.addAll(therapistDetails.therapistOrteopathicList);
        }
        if (_value == 3) {
          allTherapistList.addAll(therapistDetails.therapistRelaxationList);
        }
        if (_value == 4) {
          allTherapistList.addAll(therapistDetails.therapistFitnessListList);
        }
      });
    }

    for (int i = 0; i < allTherapistList.length; i++) {
      visibility.add(false);
      globalKeyList.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Container()
        : Scaffold(
            key: _scaffoldKey,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: therapistDetails.bookingDataResponse.length !=
                        0 &&
                    (therapistDetails.bookingDataResponse[0].bookingStatus ==
                            1 ||
                        therapistDetails.bookingDataResponse[0].bookingStatus ==
                            2)
                ? InkWell(
                    onTap: () {
                      ProgressDialogBuilder.showCommonProgressDialog(context);
                      getChatDetails(therapistDetails.data.firebaseUdid);
                    },
                    child: Card(
                      elevation: 3,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset('assets/images_gps/chat.svg',
                              height: 15, width: 15)),
                    ),
                  )
                : Container(
                    height: 0.0,
                  ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailCarouselWithIndicator(therapistDetails, widget.id),
                    DetailPeofileDetailsHome(therapistDetails, widget.id),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 12.0, bottom: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "施術を受ける場所",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            /* decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 1),
                                      Color.fromRGBO(255, 255, 255, 1),
                                    ]),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey[300],
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.grey[200]),*/
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 50.0,
                            child: WidgetAnimator(
                              TextFormField(
                                //display the address
                                readOnly: true,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  hintText: HealingMatchConstants
                                      .userRegisteredAddressDetail,
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'NotoSansJP',
                                      color: Colors.black),
                                  focusColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/gps.svg'),
                                        SizedBox(width: 10),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                top: 4.0,
                                                bottom: 4.0,
                                                right: 8.0),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.grey[200]),
                                            child: shopLocationSelected
                                                ? Text(
                                                    '店舗',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'NotoSansJP',
                                                    ),
                                                  )
                                                : Text(
                                                    '$userPlaceForMassage',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'NotoSansJP',
                                                    ),
                                                  )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Flexible(
                                            child: shopLocationSelected
                                                ? new Text(
                                                    '${therapistDetails.data.addresses[0].address}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'NotoSansJP',
                                                        color:
                                                            Colors.grey[500]),
                                                  )
                                                : new Text(
                                                    '$userRegisteredAddress',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'NotoSansJP',
                                                        color:
                                                            Colors.grey[500]),
                                                  )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15),
                                        GestureDetector(
                                          onTap: () =>
                                              openUserLocationSelectionDialog(),
                                          child: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              size: 35,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    therapistDetails.bookingDataResponse.length != 0 &&
                            (therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    9 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    4 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    5 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    7 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    8)
                        ? buildOldBookingDetails(context)
                        : Container(),
                    therapistDetails.bookingDataResponse.length != 0 &&
                            !(therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    9 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    4 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    5 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    7 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    8)
                        ? buildBookingDetails(context)
                        : buildServiceTypeDatas(context),
                    // : buildServiceTypeDatas
                    therapistDetails.bookingDataResponse.length == 0 ||
                            (therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    9 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    4 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    5 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    7 ||
                                therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    8)
                        ? dateTimeInfoBuilder(context)
                        : Container()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: therapistDetails.bookingDataResponse.length ==
                    0
                ? book() //initial booking
                : therapistDetails.bookingDataResponse[0].bookingStatus == 0
                    ? waitingForApproval()
                    : therapistDetails.bookingDataResponse[0].bookingStatus ==
                                1 ||
                            therapistDetails
                                    .bookingDataResponse[0].bookingStatus ==
                                3
                        ? proceedToPayment()
                        : therapistDetails
                                    .bookingDataResponse[0].bookingStatus ==
                                2
                            ? acceptConditions()
                            : therapistDetails
                                        .bookingDataResponse[0].bookingStatus ==
                                    6
                                ? Container(
                                    height: 0.0,
                                  )
                                : bookAgain(),
          );
  }

  Widget book() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.red,
        onPressed: () {
          if (HealingMatchConstants.isUserRegistrationSkipped) {
            DialogHelper.showUserLoginOrRegisterDialog(context);
          } else {
            if (!isLoading) {
              setState(() {
                isLoading = true;
                validateFields();
              });
            }
          }
        },
        child: new Text(
          '予約に進む',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget acceptConditions() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.red,
        onPressed: () {},
        child: new Text(
          '受け入れて支払う',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget bookAgain() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.green,
        onPressed: () {
          if (HealingMatchConstants.isUserRegistrationSkipped) {
            DialogHelper.showUserLoginOrRegisterDialog(context);
          } else {
            if (!isLoading) {
              setState(() {
                isLoading = true;
                validateFields();
              });
            }
          }
        },
        child: new Text(
          'もう一度予約する',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget proceedToPayment() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.red,
        onPressed: () {},
        child: new Text(
          '支払いに進む',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget waitingForApproval() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images_gps/processing.svg",
              height: 20.0,
              width: 20.0,
              color: Colors.black,
            ),
            SizedBox(width: 4),
            Text(
              'セラピストの承認待ち',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  buildOldBookingDetails(BuildContext context) {
    DateTime startTime = therapistDetails.bookingDataResponse[0].newStartTime !=
            null
        ? DateTime.parse(therapistDetails.bookingDataResponse[0].newStartTime)
            .toLocal()
        : therapistDetails.bookingDataResponse[0].startTime.toLocal();
    DateTime endTime =
        therapistDetails.bookingDataResponse[0].newEndTime != null
            ? DateTime.parse(therapistDetails.bookingDataResponse[0].newEndTime)
                .toLocal()
            : therapistDetails.bookingDataResponse[0].endTime.toLocal();
    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
    String date = DateFormat('MM月dd').format(startTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 14.0,
            bottom: 4.0,
          ),
          child: Text(
            "以前の予約内容",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey[400]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/calendar.svg",
                      height: 14.77,
                      width: 15.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '$date',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' $jaName ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                    Text(
                      therapistDetails.bookingDataResponse[0].locationType ==
                              "店舗"
                          ? '店舗'
                          : '出張',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    therapistDetails.bookingDataResponse[0].bookingStatus == 9
                        ? Text(
                            '完了済み',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[400],
                            ),
                          )
                        : Text(
                            'キャンセル済み',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[400],
                            ),
                          )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/clock.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      startTime.hour < 10
                          ? "0${startTime.hour}"
                          : "${startTime.hour}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      startTime.minute < 10
                          ? ": 0${startTime.minute}"
                          : ": ${startTime.minute}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      endTime.hour < 10
                          ? " ~ 0${endTime.hour}"
                          : " ~ ${endTime.hour}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      endTime.minute < 10
                          ? ": 0${endTime.minute}"
                          : ": ${endTime.minute}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${therapistDetails.bookingDataResponse[0].totalMinOfService}分 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/cost.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${therapistDetails.bookingDataResponse[0].nameOfService} ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '¥${therapistDetails.bookingDataResponse[0].priceOfService}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Divider(
                  color: Color.fromRGBO(102, 102, 102, 1),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/location.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '施術をする場所',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${therapistDetails.bookingDataResponse[0].locationType} ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      child: Text(
                        '${therapistDetails.bookingDataResponse[0].location} ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildBookingDetails(BuildContext context) {
    DateTime startTime = therapistDetails.bookingDataResponse[0].newStartTime !=
            null
        ? DateTime.parse(therapistDetails.bookingDataResponse[0].newStartTime)
            .toLocal()
        : therapistDetails.bookingDataResponse[0].startTime.toLocal();
    DateTime endTime =
        therapistDetails.bookingDataResponse[0].newEndTime != null
            ? DateTime.parse(therapistDetails.bookingDataResponse[0].newEndTime)
                .toLocal()
            : therapistDetails.bookingDataResponse[0].endTime.toLocal();
    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
    String date = DateFormat('MM月dd').format(startTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 14.0,
            bottom: 4.0,
          ),
          child: Text(
            "予約の内容",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/calendar.svg",
                      height: 14.77,
                      width: 15.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '$date',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' $jaName ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                    Text(
                      therapistDetails.bookingDataResponse[0].locationType ==
                              "店舗"
                          ? '店舗'
                          : '出張',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        therapistDetails.bookingDataResponse[0].bookingStatus ==
                                0
                            ? NavigationRouter
                                .switchToServiceUserBookingCancelScreenPopup(
                                    context,
                                    therapistDetails.bookingDataResponse[0].id)
                            : NavigationRouter
                                .switchToServiceUserBookingCancelScreen(context,
                                    therapistDetails.bookingDataResponse[0].id);
                      },
                      child: Text(
                        "キャンセルする",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/clock.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      startTime.hour < 10
                          ? "0${startTime.hour}"
                          : "${startTime.hour}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      startTime.minute < 10
                          ? ": 0${startTime.minute}"
                          : ": ${startTime.minute}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      endTime.hour < 10
                          ? " ~ 0${endTime.hour}"
                          : " ~ ${endTime.hour}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      endTime.minute < 10
                          ? ": 0${endTime.minute}"
                          : ": ${endTime.minute}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${therapistDetails.bookingDataResponse[0].totalMinOfService}分 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/clock.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${therapistDetails.bookingDataResponse[0].nameOfService} ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      therapistDetails.bookingDataResponse[0].travelAmount ==
                                  0 ||
                              therapistDetails
                                      .bookingDataResponse[0].travelAmount ==
                                  null
                          ? '¥${therapistDetails.bookingDataResponse[0].priceOfService}'
                          : '¥${therapistDetails.bookingDataResponse[0].priceOfService + therapistDetails.bookingDataResponse[0].travelAmount} (交通費込み - ¥${therapistDetails.bookingDataResponse[0].travelAmount})',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Divider(
                  color: Color.fromRGBO(102, 102, 102, 1),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/location.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '施術をする場所',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${therapistDetails.bookingDataResponse[0].locationType} ',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      child: Text(
                        '${therapistDetails.bookingDataResponse[0].location} ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                therapistDetails.bookingDataResponse[0].therapistComments !=
                            null &&
                        therapistDetails
                                .bookingDataResponse[0].therapistComments !=
                            ''
                    ? Column(
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${therapistDetails.bookingDataResponse[0].therapistComments} ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        therapistDetails.bookingDataResponse[0].bookingStatus == 2 &&
                therapistDetails.bookingDataResponse[0].therapistComments !=
                    null &&
                therapistDetails.bookingDataResponse[0].therapistComments != ''
            ? buildConditionReason(context)
            : Container(),
        therapistDetails.bookingDataResponse[0].bookingStatus == 2
            ? buildConditionAppliedDetails(context)
            : Container(),
      ],
    );
  }

  buildConditionReason(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 14.0,
            bottom: 4.0,
          ),
          child: Text(
            "リクエストの理由",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                therapistDetails.bookingDataResponse[0].therapistComments !=
                        null
                    ? Text(
                        "${therapistDetails.bookingDataResponse[0].therapistComments}",
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildConditionAppliedDetails(BuildContext context) {
    bool isDateChanged = false;
    bool isPriceAdded = false;
    String sTime = DateFormat('kk:mm')
        .format(therapistDetails.bookingDataResponse[0].startTime.toLocal());
    String eTime = DateFormat('kk:mm')
        .format(therapistDetails.bookingDataResponse[0].endTime.toLocal());
    String nSTime;
    String nEndTime;

    if (therapistDetails.bookingDataResponse[0].newStartTime != null) {
      isDateChanged = true;
      nSTime = DateFormat('kk:mm').format(
          DateTime.parse(therapistDetails.bookingDataResponse[0].newStartTime)
              .toLocal());
      nEndTime = DateFormat('kk:mm').format(
          DateTime.parse(therapistDetails.bookingDataResponse[0].newEndTime)
              .toLocal());
    }

    if (therapistDetails.bookingDataResponse[0].travelAmount != 0) {
      isPriceAdded = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 14.0,
            bottom: 4.0,
          ),
          child: Text(
            "セラピストからのリクエスト内容",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.sp,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "提案時間",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          Text(
                            "サービス料金",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            HealingMatchConstants.therapistProfileDetails
                                        .bookingDataResponse[0].addedPrice !=
                                    null
                                ? "¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].addedPrice}  "
                                : '交通費',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "合計",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ]),
                    Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$sTime ~ $eTime  ",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: !isDateChanged
                                        ? Color.fromRGBO(242, 242, 242, 1)
                                        : Color.fromRGBO(153, 153, 153, 1),
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 10.0,
                                color: !isDateChanged
                                    ? Color.fromRGBO(242, 242, 242, 1)
                                    : Color.fromRGBO(153, 153, 153, 1),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Text(
                            "",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Text(
                                "¥0",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: !isPriceAdded
                                        ? Color.fromRGBO(242, 242, 242, 1)
                                        : Color.fromRGBO(153, 153, 153, 1),
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 10.0,
                                color: !isPriceAdded
                                    ? Color.fromRGBO(242, 242, 242, 1)
                                    : Color.fromRGBO(153, 153, 153, 1),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "¥${therapistDetails.bookingDataResponse[0].priceOfService}  ",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: !isPriceAdded
                                        ? Color.fromRGBO(242, 242, 242, 1)
                                        : Color.fromRGBO(153, 153, 153, 1),
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 10.0,
                                color: !isPriceAdded
                                    ? Color.fromRGBO(242, 242, 242, 1)
                                    : Color.fromRGBO(153, 153, 153, 1),
                              ),
                            ],
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isDateChanged
                                ? "$nSTime ~ $nEndTime"
                                : "$sTime ~ $eTime",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "¥${therapistDetails.bookingDataResponse[0].priceOfService}",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "¥${therapistDetails.bookingDataResponse[0].travelAmount}",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "¥${therapistDetails.bookingDataResponse[0].priceOfService + therapistDetails.bookingDataResponse[0].travelAmount}",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ]),
                  ],
                ),
                Positioned(
                  bottom: 20.0,
                  height: 10.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Divider(
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void openUserLocationSelectionDialog() {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.QUESTION,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      useRootNavigator: true,
      showCloseIcon: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'マッサージのためにセラピストの店舗に行きたいですか？',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP'),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.33,
                child: CustomToggleButton(
                  initialValue: 0,
                  elevation: 0,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.33,
                  autoWidth: false,
                  buttonColor: Color.fromRGBO(217, 217, 217, 1),
                  enableShape: true,
                  customShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent)),
                  buttonLables: ["はい", "いいえ"],
                  fontSize: 16.0,
                  buttonValues: [
                    "Y",
                    "N",
                  ],
                  radioButtonValue: (value) {
                    if (value == 'Y') {
                      if (therapistDetails.data.isShop == true) {
                        dialog.dissmiss();
                        setState(() {
                          shopLocationSelected = true;
                          HealingMatchConstants.bookingAddressId =
                              therapistDetails.data.addresses[0].id;
                        });
                      } else if (therapistDetails.data.isShop == false) {
                        Toast.show("このセラピストの方には店舗がありません。。", context,
                            duration: 3,
                            gravity: Toast.CENTER,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white);

                        return;
                      }
                    } else {
                      dialog.dissmiss();

                      getUserAddressValues();
                    }
                    print('Radio value : $value');
                  },
                  selectedColor: Color.fromRGBO(200, 217, 33, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    )..show();
  }

  getUserAddressValues() async {
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      var userListApiProvider = ServiceUserAPIProvider.getUserDetails(
          context, HealingMatchConstants.serviceUserID);
      userListApiProvider.then((value) {
        print('userProfileImage: ${value.data.uploadProfileImgUrl}');
        if (this.mounted) {
          setState(() {
            for (int i = 0; i < value.data.addresses.length; i++) {
              if (value.data.addresses[0].isDefault) {
                HealingMatchConstants.userAddressDetailsList =
                    value.data.addresses.cast<UserAddresses>();
                print(
                    'Address length loop : ${HealingMatchConstants.userAddressDetailsList.length}');
                HealingMatchConstants.userAddressDetailsList.removeAt(0);
                openAddressListDialog();
              } else {
                ProgressDialogBuilder.hideLoader(context);
                print('Is default false');
                return;
              }
            }
          });
        }
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Details Exception : ${e.toString()}');
      return;
    }
  }

  void openAddressListDialog() {
    print('Entering... ${HealingMatchConstants.userAddressDetailsList.length}');
    if (HealingMatchConstants.userAddressDetailsList.length != 0) {
      print(
          'Address length : ${HealingMatchConstants.userAddressDetailsList.length}');
      ProgressDialogBuilder.hideLoader(context);
      AwesomeDialog dialog;
      var address, placeForMassage;
      dialog = AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.INFO,
        keyboardAware: true,
        width: MediaQuery.of(context).size.width,
        useRootNavigator: true,
        dismissOnTouchOutside: true,
        showCloseIcon: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                '施術を受ける場所を選択してください。',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP'),
              ),
              SizedBox(height: 10),
              WidgetAnimator(
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        HealingMatchConstants.userAddressDetailsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return WidgetAnimator(
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              child: WidgetAnimator(
                                TextFormField(
                                  //display the address
                                  readOnly: true,
                                  autofocus: false,
                                  enableInteractiveSelection: true,
                                  initialValue: HealingMatchConstants
                                      .userAddressDetailsList[index].address,
                                  decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      hintText:
                                          '${HealingMatchConstants.userAddressDetailsList[index]}',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14),
                                      focusColor: Colors.grey[100],
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          print(
                                              'Address Type Container selected...');
                                          _userDetailsFormKey.currentState
                                              .save();
                                          if (this.mounted) {
                                            setState(() {
                                              address = HealingMatchConstants
                                                  .userAddressDetailsList[index]
                                                  .address;
                                              HealingMatchConstants
                                                      .bookingAddressId =
                                                  HealingMatchConstants
                                                      .userAddressDetailsList[
                                                          index]
                                                      .id;
                                              placeForMassage =
                                                  HealingMatchConstants
                                                      .userAddressDetailsList[
                                                          index]
                                                      .userPlaceForMassage;
                                              shopLocationSelected = false;
                                              userRegisteredAddress = address;
                                              userPlaceForMassage =
                                                  placeForMassage;
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[100],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                              child: Text(
                                                '${HealingMatchConstants.userAddressDetailsList[index].userPlaceForMassage}',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              )),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              size: 30),
                                          onPressed: () {
                                            if (this.mounted) {
                                              setState(() {
                                                address = HealingMatchConstants
                                                    .userAddressDetailsList[
                                                        index]
                                                    .address;
                                                placeForMassage =
                                                    HealingMatchConstants
                                                        .userAddressDetailsList[
                                                            index]
                                                        .userPlaceForMassage;

                                                print(
                                                    'Selected Place and Address : $address\n$placeForMassage');
                                              });
                                            }
                                          })),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedButton(
                  text: 'Ok',
                  pressEvent: () {
                    if (address != null && placeForMassage != null) {
                      if (this.mounted) {
                        setState(() {
                          shopLocationSelected = false;
                          userRegisteredAddress = address;
                          userPlaceForMassage = placeForMassage;
                        });
                      }

                      dialog.dissmiss();
                    } else {
                      Toast.show("有効な住所を選択してください。", context,
                          duration: 3,
                          gravity: Toast.CENTER,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                      if (this.mounted) {
                        setState(() {
                          address = null;
                          placeForMassage = null;
                        });
                      }

                      return;
                    }
                  })
            ],
          ),
        ),
      )..show();
    } else {
      print('Entering else !!');
      openNoAddressDialog(context);
    }
  }

  void openNoAddressDialog(BuildContext context) {
    ProgressDialogBuilder.hideLoader(context);
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      dialogBackgroundColor: Colors.red[200],
      context: context,
      animType: AnimType.RIGHSLIDE,
      dialogType: DialogType.WARNING,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      showCloseIcon: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '住所の情報！',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSansJP'),
          ),
          SizedBox(height: 10),
          Text(
            '住所の値が見つかりません。住所を追加してください。', //住所の情報！
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSansJP'),
          ),
          SizedBox(height: 10),
          AnimatedButton(
              text: 'Ok',
              pressEvent: () {
                dialog.dissmiss();
              })
        ],
      ),
    )..show();
  }

  dateTimeInfoBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        left: 14.0,
        bottom: 4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '施術を受ける日時',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ]),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[200]),
            width: MediaQuery.of(context).size.width * 0.90,
            height: 90.0,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12.0, bottom: 8.0, right: 8.0),
              child: Container(
                child: buildDateTimeDetails(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildServiceTypeDatas(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                left: 14.0,
                bottom: 4.0,
              ),
              child: Text(
                "受けたい施術を選んでください",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    if (allTherapistList != null &&
                        allTherapistList.isNotEmpty) {
                      allTherapistList.clear();
                      scrollController.jumpTo(index: 0);
                    }

                    _value = 1;
                    getSubType();
                  });
                }
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
                              : Color.fromRGBO(228, 228, 228, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeOne.svg',
                          color: _value == 1
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Color.fromRGBO(217, 217, 217, 1),
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
                if (this.mounted) {
                  setState(() {
                    if (allTherapistList != null &&
                        allTherapistList.isNotEmpty) {
                      allTherapistList.clear();
                      scrollController.jumpTo(index: 0);
                    }
                    _value = 2;
                    getSubType();
                  });
                }
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
                              : Color.fromRGBO(228, 228, 228, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeTwo.svg',
                          color: _value == 2
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Color.fromRGBO(217, 217, 217, 1),
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
                if (this.mounted) {
                  setState(() {
                    if (allTherapistList != null &&
                        allTherapistList.isNotEmpty) {
                      allTherapistList.clear();
                      scrollController.jumpTo(index: 0);
                    }
                    _value = 3;
                    getSubType();
                  });
                }
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
                              : Color.fromRGBO(228, 228, 228, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeThree.svg',
                          color: _value == 3
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Color.fromRGBO(217, 217, 217, 1),
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
                if (this.mounted) {
                  setState(() {
                    if (allTherapistList != null &&
                        allTherapistList.isNotEmpty) {
                      allTherapistList.clear();
                      scrollController.jumpTo(index: 0);
                    }
                    _value = 4;
                    getSubType();
                  });
                }
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
                              : Color.fromRGBO(228, 228, 228, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/images_gps/serviceTypeFour.svg',
                          color: _value == 4
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Color.fromRGBO(217, 217, 217, 1),
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
        ),
        _value != 0 ? buildServices(context) : Container(),
      ],
    );
  }

  Column buildServices(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                initialScrollIndex: 0,
                itemScrollController: scrollController,
                itemCount: allTherapistList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildScrollCard(allTherapistList[index], index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildScrollCard(TherapistList therapistListItem, int index) {
    String path =
        assignServiceIcon(therapistListItem.name, therapistListItem.categoryId);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          key: globalKeyList[index],
          onTap: () {
            serviceCId = therapistListItem.categoryId;
            serviceSubId = therapistListItem.subCategoryId;
            if (lastIndex == 999) {
              if (this.mounted) {
                setState(() {
                  visibility[index] = true;
                  lastIndex = index;
                });
              }

              scrollListandToolTipCall(index, therapistListItem);
            } else if (visibility[index]) {
              scrollListandToolTipCall(index, therapistListItem);
            } else {
              if (this.mounted) {
                setState(() {
                  serviceSelection.clear();
                  visibility[lastIndex] = false;
                  visibility[index] = true;
                  lastIndex = index;
                });
              }

              scrollListandToolTipCall(index, therapistListItem);
            }
          },
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: visibility[index]
                      ? Color.fromRGBO(242, 242, 242, 1)
                      : Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: visibility[index]
                        ? Color.fromRGBO(102, 102, 102, 1)
                        : Color.fromRGBO(228, 228, 228, 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    '$path',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                child: Center(
                  child: Text(
                    '${therapistListItem.name}',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: visibility[index]
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(102, 102, 102, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void scrollListandToolTipCall(int index, TherapistList therapistListItem) {
    if (index > 2 && index != allTherapistList.length - 1) {
      scrollController
          .scrollTo(
              index: index,
              alignment: 0.5,
              duration: Duration(milliseconds: 200))
          .whenComplete(() => showToolTip(
              globalKeyList[index], context, index, therapistListItem));
    } else {
      showToolTip(globalKeyList[index], context, index, therapistListItem);
    }
  }

  Container buildShiftPriceCard(int min, int price) {
    return Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: true //massageTipColor == 1
              ? Color.fromRGBO(242, 242, 242, 1)
              : Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images_gps/processing.svg',
                      height: 20, width: 20, color: Colors.black),
                  SizedBox(width: 5),
                  new Text(
                    '$min分',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            new Text(
              price == 0 ? "利用できません" : '\t¥$price',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: price == 0 ? Colors.grey : Colors.black,
                  fontSize: price == 0 ? 10 : 13,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  void showToolTip(var key, BuildContext context, int index,
      TherapistList therapistListItem) {
    var width = MediaQuery.of(context).size.width - 10.0;
    print(width);
    ShowToolTip popup = ShowToolTip(context, updateServiceSelection,
        index: index,
        therapistListItem: therapistListItem,
        timePrice: serviceSelection[allTherapistList[index].name],
        textStyle: TextStyle(color: Colors.black),
        height: 90,
        width: MediaQuery.of(context).size.width - 20.0,
        //180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  Widget buildDateTimeDetails() {
    String dateFormat;
    String jaName;

    if (selectedTime != null) {
      dateFormat = DateFormat('MM月dd').format(selectedTime);
      jaName = DateFormat('EEEE', 'ja_JP').format(selectedTime);
    }
    return Row(
      children: [
        selectedTime != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images_gps/calendar.svg',
                            height: 16, width: 16),
                        SizedBox(width: 10),
                        new Text(
                          '$dateFormat :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                        SizedBox(width: 5),
                        new Text(
                          "$jaName",
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images_gps/clock.svg',
                            height: 14, width: 14),
                        SizedBox(width: 7),
                        new Text(
                          '${selectedTime.hour}:${selectedTime.minute} ～ ${endTime.hour}:${endTime.minute}',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                        SizedBox(width: 5),
                        new Text(
                          '$min分',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                'サービスを受ける日時を \nカレンダーから選択してください',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontFamily: 'NotoSansJP'),
              ),
        Spacer(),
        HealingMatchConstants.isUserRegistrationSkipped
            ? InkWell(
                onTap: () {
                  return;
                },
                child: Card(
                  shape: CircleBorder(),
                  elevation: 8.0,
                  child: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                    child: CircleAvatar(
                      maxRadius: 38,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      child: SvgPicture.asset(
                        'assets/images_gps/calendar.svg',
                        height: 20,
                        width: 20,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  calendarNavigator();
                },
                child: Card(
                  shape: CircleBorder(),
                  elevation: 8.0,
                  child: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                    child: CircleAvatar(
                      maxRadius: 38,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      child: SvgPicture.asset(
                        'assets/images_gps/calendar.svg',
                        height: 20,
                        width: 20,
                        color: Color.fromRGBO(200, 217, 33, 1),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  void calendarNavigator() {
    if (serviceSelection.keys.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('受けたい施術と価格を選んでください。',
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

    HealingMatchConstants.callBack = updateDateTimeSelection;
    NavigationRouter.switchToUserChooseDate(context);
  }

  void updateDateTimeSelection(DateTime time) {
    if (this.mounted) {
      setState(() {
        selectedTime = time;
        endTime = DateTime(
            selectedTime.year,
            selectedTime.month,
            selectedTime.day,
            selectedTime.hour,
            selectedTime.minute + min,
            selectedTime.second);
      });
    }
  }

  //Method called from ShowtoolTip to refresh the page after TimePicker is Selected
  updateServiceSelection(int index, Map<int, int> timePriceSelection) {
    if (this.mounted) {
      setState(() {
        if (timePriceSelection.length != 0) {
          serviceSelection.clear();
          serviceSelection[allTherapistList[index].name] = timePriceSelection;

          min = timePriceSelection.keys.first;
          HealingMatchConstants.selectedMin = min;

          //
          serviceName = serviceSelection.keys.first;
          serviceDuration = min;
          serviceCostMap = serviceSelection[serviceName][serviceDuration];
          var originalAmount = '${serviceCostMap.toString()}';
          finalAmount = int.parse(originalAmount.replaceAll(',', ''));
          print('w/o comma amount : ${finalAmount.truncate()}');

          subCategoryId = serviceSelection[serviceName][index];
          // serviceCost = serviceCostMap[[serviceDuration]];
          subCategoryId = serviceSelection[serviceName][index];

          print(
              "serviceName:${serviceSelection[allTherapistList[index].name]}");

          selectedTime = null;
          endTime = null;
        } else {
          visibility[index] = false;
        }
      });
    }
  }

  String assignServiceIcon(String name, int cid) {
    //Esthetic
    if (cid == 1) {
      if (name.contains("ブライダル")) {
        return "assets/images_gps/subCategory/esthetic/bridal.svg";
      } else if (name.contains("ボディ")) {
        return "assets/images_gps/subCategory/esthetic/body.svg";
      } else if (name.contains("太もも・ヒップ")) {
        return "assets/images_gps/subCategory/esthetic/thighsHips.svg";
      } else if (name.contains("フェイシャル")) {
        return "assets/images_gps/subCategory/esthetic/facial.svg";
      } else if (name.contains("バストアップ")) {
        return "assets/images_gps/subCategory/esthetic/breastEnhancement.svg";
      } else if (name.contains("脱毛（女性")) {
        return "assets/images_gps/subCategory/esthetic/hairRemovalWomen.svg";
      } else if (name.contains("脱毛（男性")) {
        return "assets/images_gps/subCategory/esthetic/hairRemovalMen.svg";
      } else if (name.contains("アロマテラピー")) {
        return "assets/images_gps/subCategory/esthetic/aromatherapy.svg";
      } else if (name.contains("マタニティ")) {
        return "assets/images_gps/subCategory/esthetic/Maternity.svg";
      } else if (name.contains("ロミロミ")) {
        return "assets/images_gps/subCategory/esthetic/lomiLomiAndHotStone.svg";
      } else if (name.contains("ホットストーン")) {
        return "assets/images_gps/subCategory/esthetic/hotStone.svg";
      } else {
        return "assets/images_gps/subCategory/esthetic/estheticOthers.svg";
      }
    } //relaxation
    else if (cid == 4) {
      if (name.contains("もみほぐし")) {
        return "assets/images_gps/subCategory/relaxation/firLoosening.svg";
      } else if (name.contains("リンパ")) {
        return "assets/images_gps/subCategory/relaxation/lymph.svg";
      } else if (name.contains("カイロ")) {
        return "assets/images_gps/subCategory/relaxation/chiropractic.svg";
      } else if (name.contains("コルギ")) {
        return "assets/images_gps/subCategory/relaxation/Corgi.svg";
      } else if (name.contains("リフレクソロジー")) {
        return "assets/images_gps/subCategory/relaxation/reflexology.svg";
      } else if (name.contains("タイ古式")) {
        return "assets/images_gps/subCategory/relaxation/thaiTraditional.svg";
      } else if (name.contains("カッピング")) {
        return "assets/images_gps/subCategory/relaxation/cupping1.svg";
      } else {
        return "assets/images_gps/subCategory/relaxation/relaxationOther.svg";
      }
    }
    //treatment
    else if (cid == 3) {
      if (name.contains("はり")) {
        return "assets/images_gps/subCategory/osteopathic/needle.svg";
      } else if (name.contains("美容鍼（顔）")) {
        return "assets/images_gps/subCategory/osteopathic/beautyAcupunctureFace.svg";
      } else if (name.contains("きゅう")) {
        return "assets/images_gps/subCategory/osteopathic/Kyu.svg";
      } else if (name.contains("マッサージ")) {
        return "assets/images_gps/subCategory/osteopathic/Massage.svg";
      } else if (name.contains("ストレッチ")) {
        return "assets/images_gps/subCategory/osteopathic/stretch.svg";
      } else if (name.contains("矯正")) {
        return "assets/images_gps/subCategory/osteopathic/orthodontics.svg";
      } else if (name.contains("カッピング")) {
        return "assets/images_gps/subCategory/osteopathic/cupping.svg";
      } else if (name.contains("マタニティ")) {
        return "assets/images_gps/subCategory/osteopathic/maternity1.svg";
      } else if (name.contains("ベビーマッサージ")) {
        return "assets/images_gps/subCategory/osteopathic/babyMassage.svg";
      }
      //other fields
      else {
        return "assets/images_gps/subCategory/osteopathic/othersOrthopatic.svg";
      }
    }
    //fitness
    else if (cid == 2) {
      if (name.contains("ヨガ")) {
        return "assets/images_gps/subCategory/fitness/yoga.svg";
      } else if (name.contains("ホットヨガ")) {
        return "assets/images_gps/subCategory/fitness/hotYoga.svg";
      } else if (name.contains("ピラティス")) {
        return "assets/images_gps/subCategory/fitness/pilates.svg";
      } else if (name.contains("トレーニング")) {
        return "assets/images_gps/subCategory/fitness/training.svg";
      } else if (name.contains("エクササイズ")) {
        //check icon
        return "assets/images_gps/subCategory/fitness/exercise.svg";
      }
      //other fields
      else {
        return "assets/images_gps/subCategory/fitness/othersFitness.svg";
      }
    }
    return "";
  }

  void validateFields() {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    if (serviceSelection.keys.isEmpty ||
        selectedTime == null ||
        endTime == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('受けたいマッサージと日時を選択してください。',
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
      setState(() {
        isLoading = false;
      });
      ProgressDialogBuilder.hideCommonProgressDialog(context);
      return;
    }
    bookingConfirmField();
  }

  getChatDetails(String peerId) {
    DB db = DB();
    List<ChatData> chatData = List<ChatData>();
    List<UserDetail> contactList = List<UserDetail>();
    db.getUserDetilsOfContacts(['$peerId']).then((value) {
      contactList.addAll(value);
      Chat().fetchChats(contactList).then((value) {
        chatData.addAll(value);
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatItemScreen(chatData[0])));
      });
    });
  }

  bookingConfirmField() async {
    ProgressDialogBuilder.showOverlayLoader(context);
    if (this.mounted) {
      setState(() {
        HealingMatchConstants.confTherapistId = widget.id;
        HealingMatchConstants.confBooking = HealingMatchConstants
            .therapistProfileDetails.data.uploadProfileImgUrl;
        HealingMatchConstants.confShopName =
            HealingMatchConstants.therapistProfileDetails.data.storeName;
        HealingMatchConstants.confUserName =
            HealingMatchConstants.therapistProfileDetails.data.userName;
        HealingMatchConstants.confAddress = HealingMatchConstants
            .therapistProfileDetails.data.addresses[0].address;
        HealingMatchConstants.confServiceType =
            HealingMatchConstants.therapistProfileDetails.data.storeType;
        HealingMatchConstants.confBuisnessTrip =
            HealingMatchConstants.therapistProfileDetails.data.businessTrip;
        HealingMatchConstants.confShop =
            HealingMatchConstants.therapistProfileDetails.data.isShop;
        HealingMatchConstants.confCoronaMeasures =
            HealingMatchConstants.therapistProfileDetails.data.coronaMeasure;
        HealingMatchConstants.confRatingAvg =
            HealingMatchConstants.therapistProfileDetails.reviewData.ratingAvg;
        HealingMatchConstants.confNoOfReviewsMembers = HealingMatchConstants
            .therapistProfileDetails.reviewData.noOfReviewsMembers;
        HealingMatchConstants.confNoOfReviewsMembers = HealingMatchConstants
            .therapistProfileDetails.reviewData.noOfReviewsMembers;
        HealingMatchConstants.confCertificationUpload = HealingMatchConstants
            .therapistProfileDetails.data.certificationUploads;
        HealingMatchConstants.confSelectedDateTime = selectedTime;
        HealingMatchConstants.confEndDateTime = endTime;
        HealingMatchConstants.confServiceName = serviceName;
        HealingMatchConstants.confNoOfServiceDuration = serviceDuration;
        HealingMatchConstants.confServiceCost = finalAmount;
        shopLocationSelected
            ? HealingMatchConstants.confServiceAddressType = '店舗'
            : HealingMatchConstants.confServiceAddressType =
                userPlaceForMassage.toString();
        shopLocationSelected
            ? HealingMatchConstants.confServiceAddress =
                therapistDetails.data.addresses[0].address
            : HealingMatchConstants.confServiceAddress =
                userRegisteredAddress.toString();
        HealingMatchConstants.confserviceCId = serviceCId;
        HealingMatchConstants.confserviceSubId = serviceSubId;
      });
    }

    print('EndDateTime:${HealingMatchConstants.confEndDateTime.weekday}');
    print('EndDateTime:${HealingMatchConstants.confEndDateTime.hour}');
    print('subCategoryId:${subCategoryId}');
    ProgressDialogBuilder.hideLoader(context);
    NavigationRouter.switchToServiceUserBookingConfirmationScreen(context);
  }
}
