import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/BookingStatus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';

class ReservationStatus extends StatefulWidget {
  @override
  _ReservationStatusState createState() => _ReservationStatusState();
}

class _ReservationStatusState extends State<ReservationStatus> {
  double ratingsValue = 3.0;
  List<GlobalObjectKey<FormState>> formKeyList;
  List<BookingDetailsList> bookingDetailsList = List(); //mainList
  List<BookingDetailsList> waitingForApprovalList = List(); //bookingStatus =0
  List<Map<String, String>> certificateUploadWfaList =
      List<Map<String, String>>();
  List<BookingDetailsList> approvedWithConditionsList =
      List(); //bookingStatus =2
  List<Map<String, String>> certificateUploadAprWtConList =
      List<Map<String, String>>();
  List<BookingDetailsList> approvedList = List(); //bookingStatus =1,3
  List<Map<String, String>> certificateUploadAprvdList =
      List<Map<String, String>>();
  List<BookingDetailsList> confirmedPaymentList = List(); //bookingStatus = 6
  List<BookingDetailsList> CanceledReservationList =
      List(); //bookingStatus = 4,5,7,8
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );
  GlobalKey<FormState> _formKeyUsersByType;

  @override
  void initState() {
    super.initState();
    Loader.show(context,
        progressIndicator: SpinKitThreeBounce(color: Colors.lime));
    getFavoriteList();
    Future.delayed(Duration(seconds: 2), () {
      Loader.hide();
    });
  }

  getFavoriteList() async {
    var getFavourite = ServiceUserAPIProvider.getBookingStatus();
    getFavourite.then((value) {
      if (this.mounted) {
        setState(() {
          bookingDetailsList = value.data.bookingDetailsList;
          print('bookingDetails:${bookingDetailsList.length}');
          getStatusValue();
        });
      }
    });
  }

  getStatusValue() {
    for (int i = 0; i < bookingDetailsList.length; i++) {
      int bookingStatusVal = bookingDetailsList[i].bookingStatus;
      if (bookingStatusVal == 0) {
        waitingForApprovalList.add(bookingDetailsList[i]);
        print('status1:${waitingForApprovalList}');
      } else if (bookingStatusVal == 2) {
        approvedWithConditionsList.add(bookingDetailsList[i]);
      } else if (bookingStatusVal == 1 || bookingStatusVal == 3) {
        approvedList.add(bookingDetailsList[i]);
      } else if (bookingStatusVal == 6) {
        confirmedPaymentList.add(bookingDetailsList[i]);
      } else {
        CanceledReservationList.add(bookingDetailsList[i]);
      }
    }
    getWaitgFrAprv(waitingForApprovalList);
    getAprvdWthCnd(approvedWithConditionsList);
    getAprvd(approvedList);
  }

  getWaitgFrAprv(List<BookingDetailsList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          formKeyList = List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>(index));
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
                  certificateUploaded["民間資格"] = "民間資格";
                } else if (jKey == "無資格") {
                  certificateUploaded["無資格"] = "無資格";
                }
              }
              if (certificateUploaded.length > 0) {
                certificateUploadWfaList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadWfaList.add(certificateUploaded);
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

  getAprvdWthCnd(List<BookingDetailsList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          formKeyList = List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>(index));
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
                  certificateUploaded["民間資格"] = "民間資格";
                } else if (jKey == "無資格") {
                  certificateUploaded["無資格"] = "無資格";
                }
              }
              if (certificateUploaded.length > 0) {
                certificateUploadAprWtConList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadAprWtConList.add(certificateUploaded);
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

  getAprvd(List<BookingDetailsList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          formKeyList = List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>(index));
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
                  certificateUploaded["民間資格"] = "民間資格";
                } else if (jKey == "無資格") {
                  certificateUploaded["無資格"] = "無資格";
                }
              }
              if (certificateUploaded.length > 0) {
                certificateUploadAprvdList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadAprvdList.add(certificateUploaded);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              waitingForApprovalList.length != 0
                  ? Text(
                      'セラビストの承認待ちの予約',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    )
                  : SizedBox.shrink(),
              waitingForApprovalList.length != 0
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox.shrink(),
              waitingForApprovalList.length != 0
                  ? Container(
                      // height: MediaQuery.of(context).size.height * 0.37,
                      height: 255,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: GestureDetector(
                        onTap: () {
                          NavigationRouter
                              .switchToServiceUserWaitingForApprovalScreen(
                                  context);
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: waitingForApprovalList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.32,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: WidgetAnimator(
                                  new Card(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        waitingForApprovalList[
                                                                        index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: waitingForApprovalList[
                                                                        index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                                fadeInCurve: Curves
                                                                    .easeInSine,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  width: 65.0,
                                                                  height: 65.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    SpinKitDoubleBounce(
                                                                        color: Colors
                                                                            .lightGreenAccent),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Container(
                                                                  width: 56.0,
                                                                  height: 56.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    image: DecorationImage(
                                                                        image: new AssetImage(
                                                                            'assets/images_gps/placeholder_image.png'),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images_gps/placeholder_image.png',
                                                                  height: 70,
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
                                                          child: waitingForApprovalList[
                                                                          index]
                                                                      .locationDistance !=
                                                                  null
                                                              ? Text(
                                                                  '${waitingForApprovalList[index].locationDistance}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
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
                                                                    color: Color
                                                                        .fromRGBO(
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
                                                              waitingForApprovalList[
                                                                              index]
                                                                          .bookingTherapistId
                                                                          .storeName !=
                                                                      null
                                                                  ? Text(
                                                                      '${waitingForApprovalList[index].bookingTherapistId.storeName}',
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
                                                                      '${waitingForApprovalList[index].bookingTherapistId.userName}',
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
                                                              InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment.bottomCenter,
                                                                        colors: [
                                                                          Colors
                                                                              .white,
                                                                          Colors
                                                                              .white
                                                                        ]),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      "assets/images_gps/info.svg",
                                                                      height:
                                                                          10.0,
                                                                      width:
                                                                          10.0,
                                                                      // key: key,
                                                                      color: Colors
                                                                          .black,
                                                                    ), /* Icon(
                                                              Icons
                                                                  .shopping_bag_rounded,
                                                              key: key,
                                                              color: Colors.black ), */
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              FavoriteButton(
                                                                  iconSize: 40,
                                                                  iconColor:
                                                                      Colors
                                                                          .red,
                                                                  valueChanged:
                                                                      (_isFavorite) {
                                                                    print(
                                                                        'Is Favorite : $_isFavorite');
                                                                  }),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          FittedBox(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                waitingForApprovalList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .isShop
                                                                    ? Container(
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
                                                                        ))
                                                                    : SizedBox.shrink(),
                                                                waitingForApprovalList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .isShop
                                                                    ? SizedBox(
                                                                        width:
                                                                            5,
                                                                      )
                                                                    : SizedBox
                                                                        .shrink(),
                                                                waitingForApprovalList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .businessTrip
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.all(4),
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
                                                                        ))
                                                                    : SizedBox.shrink(),
                                                                waitingForApprovalList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .businessTrip
                                                                    ? SizedBox(
                                                                        width:
                                                                            5,
                                                                      )
                                                                    : SizedBox
                                                                        .shrink(),
                                                                waitingForApprovalList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .coronaMeasure
                                                                    ? Container(
                                                                        padding:
                                                                            EdgeInsets.all(4),
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
                                                                        ))
                                                                    : SizedBox.shrink(),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '(${ratingsValue.toString()})',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            1),
                                                                  ),
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      3,
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  ignoreGestures:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemSize: 25,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    size: 5,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            217,
                                                                            0,
                                                                            1),
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    // print(rating);
                                                                    setState(
                                                                        () {
                                                                      ratingsValue =
                                                                          rating;
                                                                    });
                                                                    print(
                                                                        ratingsValue);
                                                                  },
                                                                ),
                                                                Text(
                                                                  '(1518)',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            153,
                                                                            153,
                                                                            153,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          certificateUploadWfaList[
                                                                              index]
                                                                          .length !=
                                                                      0 &&
                                                                  certificateUploadWfaList[
                                                                              index]
                                                                          .keys
                                                                          .elementAt(
                                                                              0) !=
                                                                      "無資格"
                                                              ? Container(
                                                                  height: 38.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5.0),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      130.0, //200.0,
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemCount: certificateUploadWfaList[index]
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, subindex) {
                                                                            String
                                                                                key =
                                                                                certificateUploadWfaList[index].keys.elementAt(subindex);
                                                                            return WidgetAnimator(
                                                                              Wrap(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: index == 0 ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0) : const EdgeInsets.all(4.0),
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.all(5),
                                                                                      decoration: boxDecoration,
                                                                                      child: Text(
                                                                                        key, //Qualififcation
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
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Divider(
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/gps.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 20,
                                                        width: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    '埼玉県浦和区高砂4丁目4',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          '${waitingForApprovalList[index].locationType}',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  FittedBox(
                                                      child: Text(
                                                    '${waitingForApprovalList[index].location}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          152, 152, 152, 1),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/calendar.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 20,
                                                        width: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      '予約日時：${waitingForApprovalList[index].monthOfBooking}月',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  FittedBox(
                                                      child: Text(
                                                    '予約日時：${waitingForApprovalList[index].startTime}~予約日時：${waitingForApprovalList[index].endTime}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                    ),
                                                  ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox.shrink(),
              waitingForApprovalList.length != 0
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox.shrink(),
              approvedWithConditionsList.length != null
                  ? Text(
                      'セラピストから追加の要望があった予約',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    )
                  : SizedBox.shrink(),
              approvedWithConditionsList.length != null
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox.shrink(),
              approvedWithConditionsList.length != null
                  ? Container(
                      // height: MediaQuery.of(context).size.height *
                      height: 274,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: GestureDetector(
                        onTap: () {
                          NavigationRouter
                              .switchToServiceUserConditionsApplyBookingScreen(
                                  context);
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: approvedWithConditionsList.length,
                            itemBuilder: (context, index) {
                              DateTime startTime =
                                  approvedWithConditionsList[index]
                                              .newStartTime !=
                                          null
                                      ? DateTime.parse(
                                              approvedWithConditionsList[index]
                                                  .newStartTime)
                                          .toLocal()
                                      : DateTime.parse(
                                              approvedWithConditionsList[index]
                                                  .startTime)
                                          .toLocal();
                              DateTime endTime =
                                  approvedWithConditionsList[index]
                                              .newEndTime !=
                                          null
                                      ? DateTime.parse(
                                              approvedWithConditionsList[index]
                                                  .newEndTime)
                                          .toLocal()
                                      : DateTime.parse(
                                              approvedWithConditionsList[index]
                                                  .endTime)
                                          .toLocal();
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: WidgetAnimator(
                                  new Card(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        approvedWithConditionsList[
                                                                        index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: approvedWithConditionsList[
                                                                        index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                                fadeInCurve: Curves
                                                                    .easeInSine,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  width: 65.0,
                                                                  height: 65.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    SpinKitDoubleBounce(
                                                                        color: Colors
                                                                            .lightGreenAccent),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Container(
                                                                  width: 56.0,
                                                                  height: 56.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    image: DecorationImage(
                                                                        image: new AssetImage(
                                                                            'assets/images_gps/placeholder_image.png'),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images_gps/placeholder_image.png',
                                                                  height: 70,
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
                                                          child: approvedWithConditionsList[
                                                                          index]
                                                                      .locationDistance !=
                                                                  null
                                                              ? Text(
                                                                  '${approvedWithConditionsList[index].locationDistance}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
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
                                                                    color: Color
                                                                        .fromRGBO(
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
                                                            approvedWithConditionsList[
                                                                            index]
                                                                        .bookingTherapistId
                                                                        .storeName !=
                                                                    null
                                                                ? Text(
                                                                    '${approvedWithConditionsList[index].bookingTherapistId.storeName}',
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
                                                                    '${approvedWithConditionsList[index].bookingTherapistId.userName}',
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
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment.bottomCenter,
                                                                      colors: [
                                                                        Colors
                                                                            .white,
                                                                        Colors
                                                                            .white
                                                                      ]),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images_gps/info.svg",
                                                                    height:
                                                                        10.0,
                                                                    width: 10.0,
                                                                    // key: key,
                                                                    color: Colors
                                                                        .black,
                                                                  ), /* Icon(
                                                              Icons
                                                                  .shopping_bag_rounded,
                                                              key: key,
                                                              color: Colors.black ), */
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            FavoriteButton(
                                                                iconSize: 40,
                                                                iconColor:
                                                                    Colors.red,
                                                                valueChanged:
                                                                    (_isFavorite) {
                                                                  print(
                                                                      'Is Favorite : $_isFavorite');
                                                                }),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        FittedBox(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              approvedWithConditionsList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .isShop
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              approvedWithConditionsList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .businessTrip
                                                                  ? Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              approvedWithConditionsList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .coronaMeasure
                                                                  ? Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '(${ratingsValue.toString()})',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                              ),
                                                            ),
                                                            RatingBar.builder(
                                                              initialRating: 3,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              ignoreGestures:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 25,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                // print(rating);
                                                                setState(() {
                                                                  ratingsValue =
                                                                      rating;
                                                                });
                                                                print(
                                                                    ratingsValue);
                                                              },
                                                            ),
                                                            Text(
                                                              '(1518)',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        certificateUploadAprWtConList[
                                                                            index]
                                                                        .length !=
                                                                    0 &&
                                                                certificateUploadAprWtConList[
                                                                            index]
                                                                        .keys
                                                                        .elementAt(
                                                                            0) !=
                                                                    "無資格"
                                                            ? Container(
                                                                height: 38.0,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    130.0, //200.0,
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemCount:
                                                                            certificateUploadAprWtConList[index]
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                subindex) {
                                                                          String
                                                                              key =
                                                                              certificateUploadAprWtConList[index].keys.elementAt(subindex);
                                                                          return WidgetAnimator(
                                                                            Wrap(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: index == 0 ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0) : const EdgeInsets.all(4.0),
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(5),
                                                                                    decoration: boxDecoration,
                                                                                    child: Text(
                                                                                      key, //Qualififcation
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
                                              Expanded(
                                                child: Row(children: <Widget>[
                                                  Expanded(
                                                    child: Divider(
                                                      // height: 50,

                                                      color: Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      NavigationRouter
                                                          .switchToServiceUserChatScreen(
                                                              context);
                                                    },
                                                    child: Card(
                                                      elevation: 3,
                                                      shape: CircleBorder(),
                                                      child: CircleAvatar(
                                                          maxRadius: 20,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/images_gps/chat.svg',
                                                              height: 15,
                                                              width: 15)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      NavigationRouter
                                                          .switchToUserBookingApprovedThirdScreen(
                                                              context);
                                                    },
                                                    child: Card(
                                                      elevation: 3,
                                                      shape: CircleBorder(),
                                                      child: CircleAvatar(
                                                          maxRadius: 20,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/images_gps/accept.svg',
                                                              height: 20,
                                                              width: 20)),
                                                    ),
                                                  ),
                                                ]),
                                              ),
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
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          '${approvedWithConditionsList[index].locationType}',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '  ${approvedWithConditionsList[index].location}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                    ),
                                                  ),
                                                ],
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
                                                    '予約日時：${approvedWithConditionsList[index].monthOfBooking}月17',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    '${startTime}~${endTime}',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox.shrink(),
              approvedWithConditionsList.length != null
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox.shrink(),
              Text(
                'セラビストから承認された予約',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              approvedList.length != null
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox.shrink(),
              approvedList.length != null
                  ? Container(
                      // height: MediaQuery.of(context).size.height * 0.39,
                      height: 274,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: GestureDetector(
                        onTap: () {
                          NavigationRouter
                              .switchToServiceUserBookingDetailsApprovedScreen(
                                  context);
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: approvedList.length,
                            itemBuilder: (context, index) {
                              DateTime startTime =
                                  approvedList[index].newStartTime != null
                                      ? DateTime.parse(
                                              approvedList[index].newStartTime)
                                          .toLocal()
                                      : DateTime.parse(
                                              approvedList[index].startTime)
                                          .toLocal();
                              DateTime endTime = approvedList[index]
                                          .newEndTime !=
                                      null
                                  ? DateTime.parse(
                                          approvedList[index].newEndTime)
                                      .toLocal()
                                  : DateTime.parse(approvedList[index].endTime)
                                      .toLocal();
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: WidgetAnimator(
                                  new Card(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        approvedList[index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: approvedList[
                                                                        index]
                                                                    .bookingTherapistId
                                                                    .uploadProfileImgUrl,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                                fadeInCurve: Curves
                                                                    .easeInSine,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  width: 65.0,
                                                                  height: 65.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    SpinKitDoubleBounce(
                                                                        color: Colors
                                                                            .lightGreenAccent),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Container(
                                                                  width: 56.0,
                                                                  height: 56.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    image: DecorationImage(
                                                                        image: new AssetImage(
                                                                            'assets/images_gps/placeholder_image.png'),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images_gps/placeholder_image.png',
                                                                  height: 70,
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
                                                        approvedList[index]
                                                                    .locationDistance !=
                                                                null
                                                            ? FittedBox(
                                                                child: Text(
                                                                    '${approvedList[index].locationDistance}km圏内',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                    )),
                                                              )
                                                            : Text('0.0km圏内',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                )),
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
                                                            approvedList[index]
                                                                        .bookingTherapistId
                                                                        .storeName !=
                                                                    null
                                                                ? Text(
                                                                    '${approvedList[index].bookingTherapistId.storeName}',
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
                                                                    '${approvedList[index].bookingTherapistId.userName}',
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
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment.bottomCenter,
                                                                      colors: [
                                                                        Colors
                                                                            .white,
                                                                        Colors
                                                                            .white
                                                                      ]),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images_gps/info.svg",
                                                                    height:
                                                                        10.0,
                                                                    width: 10.0,
                                                                    // key: key,
                                                                    color: Colors
                                                                        .black,
                                                                  ), /* Icon(
                                                              Icons
                                                                  .shopping_bag_rounded,
                                                              key: key,
                                                              color: Colors.black ), */
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            FavoriteButton(
                                                                iconSize: 40,
                                                                iconColor:
                                                                    Colors.red,
                                                                valueChanged:
                                                                    (_isFavorite) {
                                                                  print(
                                                                      'Is Favorite : $_isFavorite');
                                                                }),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        FittedBox(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              approvedList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .isShop
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                              approvedList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .isShop
                                                                  ? SizedBox(
                                                                      width: 5,
                                                                    )
                                                                  : SizedBox
                                                                      .shrink(),
                                                              approvedList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .businessTrip
                                                                  ? Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                              approvedList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .businessTrip
                                                                  ? SizedBox(
                                                                      width: 5,
                                                                    )
                                                                  : SizedBox
                                                                      .shrink(),
                                                              approvedList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .coronaMeasure
                                                                  ? Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                            Colors.white,
                                                                            Colors.white,
                                                                          ]),
                                                                          shape: BoxShape.rectangle,
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey[300],
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
                                                                      ))
                                                                  : SizedBox.shrink(),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '(${ratingsValue.toString()})',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                              ),
                                                            ),
                                                            RatingBar.builder(
                                                              initialRating: 3,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              ignoreGestures:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 25,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                // print(rating);
                                                                setState(() {
                                                                  ratingsValue =
                                                                      rating;
                                                                });
                                                                print(
                                                                    ratingsValue);
                                                              },
                                                            ),
                                                            Text(
                                                              '(1518)',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        certificateUploadAprvdList[
                                                                            index]
                                                                        .length !=
                                                                    0 &&
                                                                certificateUploadAprvdList[
                                                                            index]
                                                                        .keys
                                                                        .elementAt(
                                                                            0) !=
                                                                    "無資格"
                                                            ? Container(
                                                                height: 38.0,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    130.0, //200.0,
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemCount:
                                                                            certificateUploadAprvdList[index]
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                subindex) {
                                                                          String
                                                                              key =
                                                                              certificateUploadAprvdList[index].keys.elementAt(subindex);
                                                                          return WidgetAnimator(
                                                                            Wrap(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: index == 0 ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0) : const EdgeInsets.all(4.0),
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(5),
                                                                                    decoration: boxDecoration,
                                                                                    child: Text(
                                                                                      key, //Qualififcation
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
                                              Expanded(
                                                child: Row(children: <Widget>[
                                                  Expanded(
                                                    child: Divider(
                                                      // height: 50,
                                                      color: Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      NavigationRouter
                                                          .switchToServiceUserChatScreen(
                                                              context);
                                                    },
                                                    child: Card(
                                                      elevation: 3,
                                                      shape: CircleBorder(),
                                                      child: CircleAvatar(
                                                          maxRadius: 20,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/images_gps/chat.svg',
                                                              height: 15,
                                                              width: 15)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Card(
                                                    shape: CircleBorder(),
                                                    elevation: 3,
                                                    child: CircleAvatar(
                                                        maxRadius: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: SvgPicture.asset(
                                                            'assets/images_gps/pay.svg',
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    193,
                                                                    7,
                                                                    1),
                                                            height: 20,
                                                            width: 20)),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      NavigationRouter
                                                          .switchToServiceUserBookingCancelScreen(
                                                              context);
                                                    },
                                                    child: Card(
                                                      elevation: 3,
                                                      shape: CircleBorder(),
                                                      child: CircleAvatar(
                                                          maxRadius: 20,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/images_gps/cancel.svg',
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      1),
                                                              height: 15,
                                                              width: 15)),
                                                    ),
                                                  ),
                                                ]),
                                              ),
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
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ]),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '${approvedList[index].locationType}',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${approvedList[index].location}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                    ),
                                                  ),
                                                ],
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
                                                    '予約日時：${approvedList[index].monthOfBooking}月17',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    '${startTime}~${endTime}',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          102, 102, 102, 1),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              Text(
                '確定した予約（支払い完了）',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.39,
                height: 274,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsConfirmedScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: WidgetAnimator(
                            new Card(
                              color: Color.fromRGBO(242, 242, 242, 1),
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                  'assets/images_gps/placeholder_image.png',
                                                  height: 70,
                                                  color: Colors.black,
                                                  fit: BoxFit.cover,
                                                ),
                                                radius: 35,
                                                backgroundColor: Colors.white,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '1.5km圏内',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
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
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '店舗名',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white
                                                            ]),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          "assets/images_gps/info.svg",
                                                          height: 10.0,
                                                          width: 10.0,
                                                          // key: key,
                                                          color: Colors.black,
                                                        ), /* Icon(
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          key: key,
                                                          color: Colors.black ), */
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  FavoriteButton(
                                                      iconSize: 40,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite : $_isFavorite');
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Text(
                                                          '店舗',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          '出張',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          'コロナ対策実施',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '(${ratingsValue.toString()})',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    ignoreGestures: true,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 25,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      size: 5,
                                                      color: Color.fromRGBO(
                                                          255, 217, 0, 1),
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      // print(rating);
                                                      setState(() {
                                                        ratingsValue = rating;
                                                      });
                                                      print(ratingsValue);
                                                    },
                                                  ),
                                                  Text(
                                                    '(1518)',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ]),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '国家資格保有',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(children: <Widget>[
                                        Expanded(
                                          child: Divider(
                                            // height: 50,

                                            color: Color.fromRGBO(
                                                217, 217, 217, 1),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            NavigationRouter
                                                .switchToServiceUserChatScreen(
                                                    context);
                                          },
                                          child: Card(
                                            elevation: 3,
                                            shape: CircleBorder(),
                                            child: CircleAvatar(
                                                maxRadius: 20,
                                                backgroundColor: Colors.white,
                                                child: SvgPicture.asset(
                                                    'assets/images_gps/chat.svg',
                                                    height: 15,
                                                    width: 15)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            NavigationRouter
                                                .switchToServiceUserBookingCancelScreen(
                                                    context);
                                          },
                                          child: Card(
                                            shape: CircleBorder(),
                                            elevation: 3,
                                            child: CircleAvatar(
                                                maxRadius: 20,
                                                backgroundColor: Colors.white,
                                                child: SvgPicture.asset(
                                                    'assets/images_gps/cancel.svg',
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                    height: 15,
                                                    width: 15)),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/gps.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '埼玉県浦和区高砂4丁目4',
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white,
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.grey[200]),
                                            child: Text(
                                              'オフィス',
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '東京都 墨田区 押上 1-1-2',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/calendar.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '予約日時：10月17',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '10:30~11:30',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'キャンセルされた予約',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.35,
                height: 255,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsCompletedScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: WidgetAnimator(
                            new Card(
                              color: Colors.grey[200],
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                  'assets/images_gps/placeholder_image.png',
                                                  height: 70,
                                                  color: Colors.black,
                                                  fit: BoxFit.cover,
                                                ),
                                                radius: 35,
                                                backgroundColor: Colors.white,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  '1.5km圏内',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
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
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '店舗名',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white
                                                            ]),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          "assets/images_gps/info.svg",
                                                          height: 10.0,
                                                          width: 10.0,
                                                          // key: key,
                                                          color: Colors.black,
                                                        ), /* Icon(
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          key: key,
                                                          color: Colors.black ), */
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  FavoriteButton(
                                                      iconSize: 40,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite : $_isFavorite');
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Text(
                                                          '店舗',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          '出張',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          'コロナ対策実施',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '(${ratingsValue.toString()})',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    ignoreGestures: true,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 20,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      size: 5,
                                                      color: Color.fromRGBO(
                                                          255, 217, 0, 1),
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      // print(rating);
                                                      setState(() {
                                                        ratingsValue = rating;
                                                      });
                                                      print(ratingsValue);
                                                    },
                                                  ),
                                                  Text(
                                                    '(1518)',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ]),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '国家資格保有',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/gps.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '埼玉県浦和区高砂4丁目4',
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white,
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.grey[200]),
                                            child: Text(
                                              'オフィス',
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '東京都 墨田区 押上 1-1-2',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images_gps/calendar.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '予約日時：10月17',
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '10:30~11:30',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showToolTipForType(String text) {
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
      widgetKey: _formKeyUsersByType,
    );
  }
}
