import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/BookingCompletedList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class PastReservations extends StatefulWidget {
  @override
  _PastReservationsState createState() => _PastReservationsState();
}

class _PastReservationsState extends State<PastReservations> {
  double ratingsValue = 3.0;
  String accessToken;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int count = 0;
  List<BookingDetailsList> bookingDetailsList;
  List<GlobalKey> _formKeyList = List<GlobalKey>();
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );
  int status = 0;

  @override
  void initState() {
    super.initState();
    Loader.show(context,
        progressIndicator: SpinKitThreeBounce(color: Colors.lime));
    getRecommendedList();
    Future.delayed(Duration(seconds: 2), () {
      Loader.hide();
    });
  }

  getRecommendedList() async {
    var getFavourite =
        ServiceUserAPIProvider.getBookingCompletedList(_pageNumber, _pageSize);
    getFavourite.then((value) {
      if (this.mounted) {
        setState(() {
          bookingDetailsList = value.data.bookingDetailsList;
          count = value.data.count;
          status = 1;
        });
      }
      getSearchResults(bookingDetailsList);
    });
  }

  getSearchResults(List<BookingDetailsList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          _formKeyList.addAll(List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>('Fav$index')));
          for (int i = 0; i < favouriteUserList.length; i++) {
            Map<String, String> certificateUploaded = Map<String, String>();
            if (favouriteUserList[i]
                        .bookingTherapistId
                        .qulaificationCertImgUrl !=
                    null &&
                favouriteUserList[i]
                        .bookingTherapistId
                        .qulaificationCertImgUrl !=
                    '') {
              var split = favouriteUserList[i]
                  .bookingTherapistId
                  .qulaificationCertImgUrl
                  .split(',');

              for (int i = 0; i < split.length; i++) {
                String jKey = split[i];
                if (jKey == "はり師" ||
                    jKey == "きゅう師" ||
                    jKey == "鍼灸師" ||
                    jKey == "あん摩マッサージ指圧師" ||
                    jKey == "柔道整復師" ||
                    jKey == "理学療法士") {
                  certificateUploaded["国家資格保有"] = "国家資格保有";
                } else if (jKey == "国家資格取得予定（学生）") {
                  certificateUploaded["国家資格取得予定（学生）"] = "国家資格取得予定（学生）";
                } else if (jKey == "民間資格") {
                  certificateUploaded["民間資格保有"] = "民間資格保有";
                } else if (jKey == "無資格") {
                  certificateUploaded["無資格"] = "無資格";
                }
              }
              if (certificateUploaded.length > 0) {
                certificateUploadList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadList.add(certificateUploaded);
            }
            /* if (certificateImages.length == 0) {
              certificateImages["無資格"] = "無資格";
            }
            print('certificateImages data : $certificateImages'); */

          }
        });
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  _getMoreDataByType() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          // call fetch more method here
          _pageNumber++;
          print('Page number : $_pageNumber Page Size : $_pageSize');
          var providerListApiProvider =
              ServiceUserAPIProvider.getBookingCompletedList(
                  _pageNumber, _pageSize);
          providerListApiProvider.then((value) {
            if (value.data.bookingDetailsList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.data.bookingDetailsList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.data.bookingDetailsList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  bookingDetailsList.addAll(value.data.bookingDetailsList);
                }
                getSearchResults(value.data.bookingDetailsList);
              });
            }
          });
        });
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Center(child: SpinKitThreeBounce(color: Colors.lime))
        : LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => _getMoreDataByType(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: bookingDetailsList != null && bookingDetailsList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.40,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: bookingDetailsList.length,
                                  itemBuilder: (context, index) {
                                    DateTime startTime =
                                        bookingDetailsList[index]
                                                    .newStartTime !=
                                                null
                                            ? DateTime.parse(
                                                    bookingDetailsList[index]
                                                        .newStartTime)
                                                .toLocal()
                                            : bookingDetailsList[index]
                                                .startTime
                                                .toLocal();
                                    DateTime endTime =
                                        bookingDetailsList[index].newEndTime !=
                                                null
                                            ? DateTime.parse(
                                                    bookingDetailsList[index]
                                                        .newEndTime)
                                                .toLocal()
                                            : bookingDetailsList[index]
                                                .endTime
                                                .toLocal();
                                    String date =
                                        DateFormat('MM月dd').format(startTime);
                                    String sTime =
                                        DateFormat('kk:mm').format(startTime);
                                    String eTime =
                                        DateFormat('kk:mm').format(endTime);
                                    String jaName = DateFormat('EEEE', 'ja_JP')
                                        .format(startTime);
                                    return Container(
                                      // height: MediaQuery.of(context).size.height * 0.22,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: WidgetAnimator(
                                        InkWell(
                                          onTap: () {
                                            HealingMatchConstants
                                                    .serviceDistanceRadius =
                                                double.parse(
                                                    bookingDetailsList[index]
                                                        .locationDistance);
                                            NavigationRouter
                                                .switchToServiceUserBookingDetailsCompletedScreenOne(
                                                    context,
                                                    bookingDetailsList[index]
                                                        .therapistId);
                                          },
                                          child: new Card(
                                            color: Colors.grey[200],
                                            semanticContainer: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 8,
                                                  bottom: 3),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            bookingDetailsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .uploadProfileImgUrl !=
                                                                    null
                                                                ? CachedNetworkImage(
                                                                    imageUrl: bookingDetailsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .uploadProfileImgUrl,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    fadeInCurve:
                                                                        Curves
                                                                            .easeInSine,
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      width:
                                                                          65.0,
                                                                      height:
                                                                          65.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        SpinKitDoubleBounce(
                                                                            color:
                                                                                Colors.lightGreenAccent),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Container(
                                                                      width:
                                                                          56.0,
                                                                      height:
                                                                          56.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black12),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                new AssetImage('assets/images_gps/placeholder_image.png'),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : CircleAvatar(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images_gps/placeholder_image.png',
                                                                      height:
                                                                          70,
                                                                      color: Colors
                                                                          .black,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    radius: 35,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            FittedBox(
                                                              child: bookingDetailsList[
                                                                              index]
                                                                          .locationDistance !=
                                                                      null
                                                                  ? Text(
                                                                      '${bookingDetailsList[index].locationDistance}km圏内',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            1),
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      '0.0km圏内',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            1),
                                                                      ),
                                                                    ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                bookingDetailsList[index].bookingTherapistId.storeName !=
                                                                            null &&
                                                                        bookingDetailsList[index].bookingTherapistId.storeName !=
                                                                            ''
                                                                    ? Text(
                                                                        bookingDetailsList[index].bookingTherapistId.storeName.length > 10
                                                                            ? bookingDetailsList[index].bookingTherapistId.storeName.substring(0, 10) +
                                                                                "..."
                                                                            : bookingDetailsList[index].bookingTherapistId.storeName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        bookingDetailsList[index].bookingTherapistId.userName.length > 10
                                                                            ? bookingDetailsList[index].bookingTherapistId.userName.substring(0, 10) +
                                                                                "..."
                                                                            : bookingDetailsList[index].bookingTherapistId.userName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      showToolTipForFav(
                                                                          bookingDetailsList[index]
                                                                              .bookingTherapistId
                                                                              .storeType,
                                                                          _formKeyList[
                                                                              index]);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      /*    key: _formKeyList[
                                                                          index], */
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: [
                                                                              Colors.white,
                                                                              Colors.white
                                                                            ]),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.grey[400],
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "assets/images_gps/info.svg",
                                                                          height:
                                                                              10.0,
                                                                          width:
                                                                              10.0,
                                                                          key: _formKeyList[
                                                                              index],
                                                                          color:
                                                                              Colors.black,
                                                                        ), /* Icon(
                                                            Icons
                                                                  .shopping_bag_rounded,
                                                            key: key,
                                                            color: Colors.black ), */
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                FavoriteButton(
                                                                    isFavorite:
                                                                        bookingDetailsList[index].favouriteToTherapist ==
                                                                            1,
                                                                    iconSize:
                                                                        40,
                                                                    iconColor:
                                                                        Colors
                                                                            .red,
                                                                    valueChanged:
                                                                        (_isFavorite) {
                                                                      print(
                                                                          'Is Favorite : $_isFavorite');
                                                                      print(
                                                                          'Is Favorite : $_isFavorite');
                                                                      if (_isFavorite !=
                                                                              null &&
                                                                          _isFavorite) {
                                                                        // call favorite therapist API
                                                                        ServiceUserAPIProvider.favouriteTherapist(
                                                                            bookingDetailsList[index].therapistId);
                                                                      } else {
                                                                        // call un-favorite therapist API
                                                                        ServiceUserAPIProvider.unFavouriteTherapist(
                                                                            bookingDetailsList[index].therapistId);
                                                                      }
                                                                    }),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            FittedBox(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Visibility(
                                                                    visible: bookingDetailsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .isShop,
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                              Colors.white,
                                                                              Colors.white,
                                                                            ]),
                                                                            shape: BoxShape.rectangle,
                                                                            border: Border.all(
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.grey[200]),
                                                                        padding: EdgeInsets.all(4),
                                                                        child: Text(
                                                                          '店舗',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  bookingDetailsList[
                                                                              index]
                                                                          .bookingTherapistId
                                                                          .isShop
                                                                      ? SizedBox(
                                                                          width:
                                                                              5,
                                                                        )
                                                                      : SizedBox
                                                                          .shrink(),
                                                                  Visibility(
                                                                    visible: bookingDetailsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .businessTrip,
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(4),
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                              Colors.white,
                                                                              Colors.white,
                                                                            ]),
                                                                            shape: BoxShape.rectangle,
                                                                            border: Border.all(
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.grey[200]),
                                                                        child: Text(
                                                                          '出張',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  bookingDetailsList[
                                                                              index]
                                                                          .bookingTherapistId
                                                                          .businessTrip
                                                                      ? SizedBox(
                                                                          width:
                                                                              5,
                                                                        )
                                                                      : SizedBox
                                                                          .shrink(),
                                                                  Visibility(
                                                                    visible: bookingDetailsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .coronaMeasure,
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(4),
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                              Colors.white,
                                                                              Colors.white,
                                                                            ]),
                                                                            shape: BoxShape.rectangle,
                                                                            border: Border.all(
                                                                              color: Colors.grey[300],
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.grey[200]),
                                                                        child: Text(
                                                                          'コロナ対策実施',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            certificateUploadList[index]
                                                                            .length !=
                                                                        0 &&
                                                                    certificateUploadList[index]
                                                                            .keys
                                                                            .elementAt(0) !=
                                                                        "無資格"
                                                                ? Container(
                                                                    height:
                                                                        38.0,
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5.0),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        130.0, //200.0,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: certificateUploadList[index].length,
                                                                        itemBuilder: (context, subindex) {
                                                                          String
                                                                              key =
                                                                              certificateUploadList[index].keys.elementAt(subindex);
                                                                          return WidgetAnimator(
                                                                            Wrap(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: index == 0 ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0) : const EdgeInsets.all(4.0),
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(5),
                                                                                    decoration: boxDecoration,
                                                                                    child: Text(
                                                                                      key,
                                                                                      //Qualififcation
                                                                                      style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
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
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images_gps/calendar.svg',
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          height: 20,
                                                          width: 20),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${date}',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${jaName}',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images_gps/clock.svg',
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          height: 20,
                                                          width: 20),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${sTime}~${eTime}',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${bookingDetailsList[index].totalMinOfService}分',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              102, 102, 102, 1),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images_gps/cost.svg',
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          height: 20,
                                                          width: 20),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                          child: Text(
                                                            '${bookingDetailsList[index].nameOfService}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          bookingDetailsList[index]
                                                                          .travelAmount ==
                                                                      0 ||
                                                                  bookingDetailsList[
                                                                              index]
                                                                          .travelAmount ==
                                                                      null
                                                              ? '¥${bookingDetailsList[index].priceOfService}'
                                                              : '¥${bookingDetailsList[index].priceOfService + bookingDetailsList[index].travelAmount} (${bookingDetailsList[index].addedPrice} - ¥${bookingDetailsList[index].travelAmount})',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  bookingDetailsList[index]
                                                              .bookingStatus ==
                                                          9
                                                      ? Row(children: <Widget>[
                                                          Expanded(
                                                            child: Divider(
                                                              // height: 50,

                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      1),
                                                            ),
                                                          ),
                                                          bookingDetailsList[index]
                                                                          .bookingStatus ==
                                                                      9 &&
                                                                  bookingDetailsList[
                                                                              index]
                                                                          .userReviewStatus ==
                                                                      1
                                                              ? InkWell(
                                                                  onTap: () {},
                                                                  child: Card(
                                                                    elevation:
                                                                        4.0,
                                                                    shape:
                                                                        CircleBorder(),
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "assets/images_gps/givenReview.svg",
                                                                          height:
                                                                              15.0,
                                                                          width:
                                                                              15.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    HealingMatchConstants.serviceProviderUserName = bookingDetailsList[index].bookingTherapistId.storeName !=
                                                                                null &&
                                                                            bookingDetailsList[index].bookingTherapistId.storeName !=
                                                                                ''
                                                                        ? bookingDetailsList[index]
                                                                            .bookingTherapistId
                                                                            .storeName
                                                                        : bookingDetailsList[index]
                                                                            .bookingTherapistId
                                                                            .userName;
                                                                    HealingMatchConstants
                                                                        .therapistRatingID = bookingDetailsList[
                                                                            index]
                                                                        .therapistId;
                                                                    HealingMatchConstants
                                                                            .bookingId =
                                                                        bookingDetailsList[index]
                                                                            .id;
                                                                    NavigationRouter.switchToServiceUserRatingsAndReviewScreen(
                                                                        context,
                                                                        bookingDetailsList[
                                                                            index]);
                                                                    print(
                                                                        accessToken);
                                                                    print(
                                                                        'bookindId:${HealingMatchConstants.bookingId = bookingDetailsList[index].id}');
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        3,
                                                                    shape:
                                                                        CircleBorder(),
                                                                    child: CircleAvatar(
                                                                        maxRadius:
                                                                            20,
                                                                        backgroundColor: Color.fromRGBO(
                                                                            253,
                                                                            253,
                                                                            253,
                                                                            1),
                                                                        child: SvgPicture.asset(
                                                                            'assets/images_gps/giveRating.svg',
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                20)),
                                                                  ),
                                                                )
                                                        ])
                                                      : Container(),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/images_gps/gps.svg',
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          height: 20,
                                                          width: 20),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '施術を受ける場所',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                        Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                      ]),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      200]),
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          child: Text(
                                                            '${bookingDetailsList[index].locationType}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${bookingDetailsList[index].location}',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    102,
                                                                    102,
                                                                    102,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 1)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: new Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new AssetImage(
                                                          'assets/images_gps/appIcon.png')),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Text(
                                              '今までに受けたサービスは\nまだありません。',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'NotoSansJP',
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
  }

  void showToolTipForFav(String text, GlobalObjectKey<FormState> _formKeyList) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: _formKeyList,
    );
  }

/*getId() async {
    // ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      ProgressDialogBuilder.showCommonProgressDialog(context);
      _sharedPreferences.then((value) {
        accessToken = value.getString('accessToken');
        ProgressDialogBuilder.hideCommonProgressDialog(context);

        setState(() {
          HealingMatchConstants.uAccessToken = accessToken;
        });
      });
    } catch (e) {}
  }*/
}
