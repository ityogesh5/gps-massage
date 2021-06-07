import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/BookingStatus.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';

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
  List<Map<String, String>> certificateUploadConfdPayList =
      List<Map<String, String>>();
  List<BookingDetailsList> canceledReservationList =
      List(); //bookingStatus = 4,5,7,8
  List<Map<String, String>> certificateUploadCancelList =
      List<Map<String, String>>();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );
  GlobalKey<FormState> _formKeyUsersByType;
  int status = 0;

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
          bookingDetailsList = value.bookingDetailsList;
          print('bookingDetails:${bookingDetailsList.length}');
          status = 1;
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
        canceledReservationList.add(bookingDetailsList[i]);
      }
    }
    getWaitgFrAprv(waitingForApprovalList);
    getAprvdWthCnd(approvedWithConditionsList);
    getAprvd(approvedList);
    getConfdPay(confirmedPaymentList);
    getCancelList(canceledReservationList);
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

  getConfdPay(List<BookingDetailsList> favouriteUserList) async {
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
                certificateUploadConfdPayList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadConfdPayList.add(certificateUploaded);
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

  getCancelList(List<BookingDetailsList> favouriteUserList) async {
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
                certificateUploadCancelList.add(certificateUploaded);
              }
            }

            if (certificateUploaded.length == 0) {
              certificateUploaded["無資格"] = "無資格";
              certificateUploadCancelList.add(certificateUploaded);
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
    return status == 0
        ? Center(child: SpinKitThreeBounce(color: Colors.lime))
        : Scaffold(
            backgroundColor: Colors.white,
            body: bookingDetailsList != null && bookingDetailsList.isNotEmpty
                ? SingleChildScrollView(
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
                                  height: 275,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: waitingForApprovalList.length,
                                      itemBuilder: (context, index) {
                                        DateTime startTime =
                                            waitingForApprovalList[index]
                                                .startTime
                                                .toLocal();
                                        DateTime endTime =
                                            waitingForApprovalList[index]
                                                .endTime
                                                .toLocal();
                                        String date = DateFormat('MM月d')
                                            .format(startTime);
                                        String sTime = DateFormat('kk:mm')
                                            .format(startTime);
                                        String eTime =
                                            DateFormat('kk:mm').format(endTime);
                                        String jaName =
                                            DateFormat('EEEE', 'ja_JP')
                                                .format(startTime);
                                        return InkWell(
                                          onTap: () {
                                            NavigationRouter
                                                .switchToUserSearchDetailPageOne(
                                                    context,
                                                    waitingForApprovalList[
                                                            index]
                                                        .therapistId);
                                          },
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.32,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: WidgetAnimator(
                                              new Card(
                                                color: Color.fromRGBO(
                                                    242, 242, 242, 1),
                                                semanticContainer: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  children: [
                                                                    waitingForApprovalList[index].bookingTherapistId.uploadProfileImgUrl !=
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                waitingForApprovalList[index].bookingTherapistId.uploadProfileImgUrl,
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                            fadeInCurve:
                                                                                Curves.easeInSine,
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              width: 65.0,
                                                                              height: 65.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                SpinKitDoubleBounce(color: Colors.lightGreenAccent),
                                                                            errorWidget: (context, url, error) =>
                                                                                Container(
                                                                              width: 56.0,
                                                                              height: 56.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(color: Colors.black12),
                                                                                image: DecorationImage(image: new AssetImage('assets/images_gps/placeholder_image.png'), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : CircleAvatar(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images_gps/placeholder_image.png',
                                                                              height: 70,
                                                                              color: Colors.black,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            radius:
                                                                                35,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    FittedBox(
                                                                      child: waitingForApprovalList[index].locationDistance !=
                                                                              null
                                                                          ? Text(
                                                                              '${waitingForApprovalList[index].locationDistance}',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              '0.0km圏内',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
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
                                                                          waitingForApprovalList[index].bookingTherapistId.storeName != null
                                                                              ? Text(
                                                                                  '${waitingForApprovalList[index].bookingTherapistId.storeName}',
                                                                                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                                )
                                                                              : Text(
                                                                                  '${waitingForApprovalList[index].bookingTherapistId.userName}',
                                                                                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                                ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                  Colors.white,
                                                                                  Colors.white
                                                                                ]),
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(
                                                                                  color: Colors.grey[400],
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
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
                                                                              isFavorite: waitingForApprovalList[index].favouriteToTherapist == 1,
                                                                              iconSize: 40,
                                                                              iconColor: Colors.red,
                                                                              valueChanged: (_isFavorite) {
                                                                                print('Is Favorite : $_isFavorite');
                                                                                print('Is Favorite : $_isFavorite');
                                                                                if (_isFavorite != null && _isFavorite) {
                                                                                  // call favorite therapist API
                                                                                  ServiceUserAPIProvider.favouriteTherapist(waitingForApprovalList[index].therapistId);
                                                                                } else {
                                                                                  // call un-favorite therapist API
                                                                                  ServiceUserAPIProvider.unFavouriteTherapist(waitingForApprovalList[index].therapistId);
                                                                                }
                                                                              }),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      FittedBox(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            waitingForApprovalList[index].bookingTherapistId.isShop
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
                                                                                      style: TextStyle(
                                                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                                                      ),
                                                                                    ))
                                                                                : SizedBox.shrink(),
                                                                            waitingForApprovalList[index].bookingTherapistId.isShop
                                                                                ? SizedBox(
                                                                                    width: 5,
                                                                                  )
                                                                                : SizedBox.shrink(),
                                                                            waitingForApprovalList[index].bookingTherapistId.businessTrip
                                                                                ? Container(
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
                                                                                      style: TextStyle(
                                                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                                                      ),
                                                                                    ))
                                                                                : SizedBox.shrink(),
                                                                            waitingForApprovalList[index].bookingTherapistId.businessTrip
                                                                                ? SizedBox(
                                                                                    width: 5,
                                                                                  )
                                                                                : SizedBox.shrink(),
                                                                            waitingForApprovalList[index].bookingTherapistId.coronaMeasure
                                                                                ? Container(
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
                                                                                      style: TextStyle(
                                                                                        color: Color.fromRGBO(0, 0, 0, 1),
                                                                                      ),
                                                                                    ))
                                                                                : SizedBox.shrink(),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      FittedBox(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              '(${waitingForApprovalList[index].reviewAvgData})',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            ),
                                                                            RatingBar.builder(
                                                                              initialRating: double.parse(waitingForApprovalList[index].reviewAvgData),
                                                                              minRating: 1,
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: true,
                                                                              ignoreGestures: true,
                                                                              itemCount: 5,
                                                                              itemSize: 25,
                                                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                              itemBuilder: (context, _) => Icon(
                                                                                Icons.star,
                                                                                size: 5,
                                                                                color: Color.fromRGBO(255, 217, 0, 1),
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
                                                                              '(${waitingForApprovalList[index].noOfReviewsMembers})',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      certificateUploadWfaList[index].length != 0 &&
                                                                              certificateUploadWfaList[index].keys.elementAt(0) != "無資格"
                                                                          ? Container(
                                                                              height: 38.0,
                                                                              padding: EdgeInsets.only(top: 5.0),
                                                                              width: MediaQuery.of(context).size.width - 130.0,
                                                                              //200.0,
                                                                              child: ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  itemCount: certificateUploadWfaList[index].length,
                                                                                  itemBuilder: (context, subindex) {
                                                                                    String key = certificateUploadWfaList[index].keys.elementAt(subindex);
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
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Divider(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        217,
                                                                        217,
                                                                        217,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              FittedBox(
                                                                child: SvgPicture.asset(
                                                                    'assets/images_gps/gps.svg',
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    height: 20,
                                                                    width: 20),
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text(
                                                                '施術を受ける場所',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                FittedBox(
                                                                  child: Container(
                                                                      padding: EdgeInsets.all(4),
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
                                                                        '${waitingForApprovalList[index].locationType}',
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
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                FittedBox(
                                                                    child: Text(
                                                                  '${waitingForApprovalList[index].location}',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            152,
                                                                            152,
                                                                            152,
                                                                            1),
                                                                  ),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              FittedBox(
                                                                child: SvgPicture.asset(
                                                                    'assets/images_gps/calendar.svg',
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    height: 20,
                                                                    width: 20),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              FittedBox(
                                                                child: Text(
                                                                  '予約日時：${date}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              FittedBox(
                                                                  child: Text(
                                                                '${sTime}~${eTime}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
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
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                          waitingForApprovalList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          approvedWithConditionsList.length != 0
                              ? Text(
                                  'セラピストから追加の要望があった予約',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                )
                              : SizedBox.shrink(),
                          approvedWithConditionsList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          approvedWithConditionsList.length != 0
                              ? Container(
                                  // height: MediaQuery.of(context).size.height *
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          approvedWithConditionsList.length,
                                      itemBuilder: (context, index) {
                                        DateTime startTime =
                                            approvedWithConditionsList[index]
                                                        .newStartTime !=
                                                    null
                                                ? approvedWithConditionsList[
                                                        index]
                                                    .newStartTime
                                                    .toLocal()
                                                : approvedWithConditionsList[
                                                        index]
                                                    .startTime
                                                    .toLocal();
                                        DateTime endTime =
                                            approvedWithConditionsList[index]
                                                        .newEndTime !=
                                                    null
                                                ? approvedWithConditionsList[
                                                        index]
                                                    .newEndTime
                                                    .toLocal()
                                                : approvedWithConditionsList[
                                                        index]
                                                    .endTime
                                                    .toLocal();
                                        String date = DateFormat('MM月d')
                                            .format(startTime);
                                        String sTime = DateFormat('kk:mm')
                                            .format(startTime);
                                        String eTime =
                                            DateFormat('kk:mm').format(endTime);
                                        String jaName =
                                            DateFormat('EEEE', 'ja_JP')
                                                .format(startTime);
                                        return InkWell(
                                          onTap: () {
                                            HealingMatchConstants.bookingIdPay =
                                                approvedWithConditionsList[
                                                        index]
                                                    .id;

                                            HealingMatchConstants
                                                    .therapistIdPay =
                                                approvedWithConditionsList[
                                                        index]
                                                    .therapistId;
                                            HealingMatchConstants
                                                    .confServiceCost =
                                                approvedWithConditionsList[
                                                        index]
                                                    .priceOfService;
                                            print(
                                                'bookingId: ${HealingMatchConstants.bookingIdPay}');

                                            NavigationRouter
                                                .switchToUserSearchDetailPageOne(
                                                    context,
                                                    approvedWithConditionsList[
                                                            index]
                                                        .therapistId);
                                          },
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.22,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: WidgetAnimator(
                                              new Card(
                                                color: Color.fromRGBO(
                                                    242, 242, 242, 1),
                                                semanticContainer: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  children: [
                                                                    approvedWithConditionsList[index].bookingTherapistId.uploadProfileImgUrl !=
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                approvedWithConditionsList[index].bookingTherapistId.uploadProfileImgUrl,
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                            fadeInCurve:
                                                                                Curves.easeInSine,
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              width: 65.0,
                                                                              height: 65.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                SpinKitDoubleBounce(color: Colors.lightGreenAccent),
                                                                            errorWidget: (context, url, error) =>
                                                                                Container(
                                                                              width: 56.0,
                                                                              height: 56.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(color: Colors.black12),
                                                                                image: DecorationImage(image: new AssetImage('assets/images_gps/placeholder_image.png'), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : CircleAvatar(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images_gps/placeholder_image.png',
                                                                              height: 70,
                                                                              color: Colors.black,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            radius:
                                                                                35,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    FittedBox(
                                                                      child: approvedWithConditionsList[index].locationDistance !=
                                                                              null
                                                                          ? Text(
                                                                              '${approvedWithConditionsList[index].locationDistance}',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              '0.0km圏内',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(153, 153, 153, 1),
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
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
                                                                        approvedWithConditionsList[index].bookingTherapistId.storeName !=
                                                                                null
                                                                            ? Text(
                                                                                '${approvedWithConditionsList[index].bookingTherapistId.storeName}',
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                              )
                                                                            : Text(
                                                                                '${approvedWithConditionsList[index].bookingTherapistId.userName}',
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                Colors.white,
                                                                                Colors.white
                                                                              ]),
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: Colors.grey[400],
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
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
                                                                            isFavorite: approvedWithConditionsList[index].favouriteToTherapist ==
                                                                                1,
                                                                            iconSize:
                                                                                40,
                                                                            iconColor:
                                                                                Colors.red,
                                                                            valueChanged: (_isFavorite) {
                                                                              print('Is Favorite : $_isFavorite');
                                                                              if (_isFavorite != null && _isFavorite) {
                                                                                // call favorite therapist API
                                                                                ServiceUserAPIProvider.favouriteTherapist(approvedWithConditionsList[index].therapistId);
                                                                              } else {
                                                                                // call un-favorite therapist API
                                                                                ServiceUserAPIProvider.unFavouriteTherapist(approvedWithConditionsList[index].therapistId);
                                                                              }
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    FittedBox(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          approvedWithConditionsList[index].bookingTherapistId.isShop
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox.shrink(),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          approvedWithConditionsList[index].bookingTherapistId.businessTrip
                                                                              ? Container(
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox.shrink(),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          approvedWithConditionsList[index].bookingTherapistId.coronaMeasure
                                                                              ? Container(
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
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
                                                                          '(${approvedWithConditionsList[index].reviewAvgData})',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              double.parse(approvedWithConditionsList[index].reviewAvgData),
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              25,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 4.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            size:
                                                                                5,
                                                                            color: Color.fromRGBO(
                                                                                255,
                                                                                217,
                                                                                0,
                                                                                1),
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            // print(rating);
                                                                            setState(() {
                                                                              ratingsValue = rating;
                                                                            });
                                                                            print(ratingsValue);
                                                                          },
                                                                        ),
                                                                        Text(
                                                                          '(${approvedWithConditionsList[index].noOfReviewsMembers})',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
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
                                                                    certificateUploadAprWtConList[index].length !=
                                                                                0 &&
                                                                            certificateUploadAprWtConList[index].keys.elementAt(0) !=
                                                                                "無資格"
                                                                        ? Container(
                                                                            height:
                                                                                38.0,
                                                                            padding:
                                                                                EdgeInsets.only(top: 5.0),
                                                                            width:
                                                                                MediaQuery.of(context).size.width - 130.0,
                                                                            //200.0,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: certificateUploadAprWtConList[index].length,
                                                                                itemBuilder: (context, subindex) {
                                                                                  String key = certificateUploadAprWtConList[index].keys.elementAt(subindex);
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
                                                          Expanded(
                                                            child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Divider(
                                                                      // height: 50,

                                                                      color: Color.fromRGBO(
                                                                          217,
                                                                          217,
                                                                          217,
                                                                          1),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      ProgressDialogBuilder
                                                                          .showCommonProgressDialog(
                                                                              context);
                                                                      getChatDetails(approvedWithConditionsList[
                                                                              index]
                                                                          .bookingTherapistId
                                                                          .firebaseUdid);
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          CircleBorder(),
                                                                      child: CircleAvatar(
                                                                          maxRadius:
                                                                              20,
                                                                          backgroundColor: Colors
                                                                              .white,
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
                                                                      HealingMatchConstants
                                                                          .bookingIdPay = approvedWithConditionsList[
                                                                              index]
                                                                          .id;
                                                                      HealingMatchConstants
                                                                          .therapistIdPay = approvedWithConditionsList[
                                                                              index]
                                                                          .therapistId;
                                                                      HealingMatchConstants
                                                                          .confServiceCost = approvedWithConditionsList[
                                                                              index]
                                                                          .totalCost;
                                                                      NavigationRouter.switchToUserBookingApprovedThirdScreen(
                                                                          context,
                                                                          approvedWithConditionsList[index]
                                                                              .therapistId);
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          CircleBorder(),
                                                                      child: CircleAvatar(
                                                                          maxRadius:
                                                                              20,
                                                                          backgroundColor: Colors
                                                                              .white,
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
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  height: 20,
                                                                  width: 20),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '施術を受ける場所',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
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
                                                              FittedBox(
                                                                child: Container(
                                                                    padding: EdgeInsets.all(4),
                                                                    decoration: BoxDecoration(
                                                                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                          Colors
                                                                              .white,
                                                                          Colors
                                                                              .white,
                                                                        ]),
                                                                        shape: BoxShape.rectangle,
                                                                        border: Border.all(
                                                                          color:
                                                                              Colors.grey[300],
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                        color: Colors.grey[200]),
                                                                    child: Text(
                                                                      '${approvedWithConditionsList[index].locationType}',
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
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '  ${approvedWithConditionsList[index].location}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
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
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  height: 20,
                                                                  width: 20),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '予約日時：${date}',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                '${sTime}~${eTime}',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            102,
                                                                            102,
                                                                            102,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                          approvedWithConditionsList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          approvedList.length != 0
                              ? Text(
                                  'セラビストから承認された予約',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 0, 0, 1)),
                                )
                              : SizedBox.shrink(),
                          approvedList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          approvedList.length != 0
                              ? Container(
                                  // height: MediaQuery.of(context).size.height * 0.39,
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: approvedList.length,
                                      itemBuilder: (context, index) {
                                        DateTime startTime =
                                            approvedList[index].newStartTime !=
                                                    null
                                                ? approvedList[index]
                                                    .newStartTime
                                                    .toLocal()
                                                : approvedList[index]
                                                    .startTime
                                                    .toLocal();
                                        DateTime endTime =
                                            approvedList[index].newEndTime !=
                                                    null
                                                ? approvedList[index]
                                                    .newEndTime
                                                    .toLocal()
                                                : approvedList[index]
                                                    .endTime
                                                    .toLocal();
                                        String date = DateFormat('MM月d')
                                            .format(startTime);
                                        String sTime = DateFormat('kk:mm')
                                            .format(startTime);
                                        String eTime =
                                            DateFormat('kk:mm').format(endTime);
                                        String jaName =
                                            DateFormat('EEEE', 'ja_JP')
                                                .format(startTime);
                                        return InkWell(
                                          onTap: () {
                                            HealingMatchConstants.bookingIdPay =
                                                approvedList[index].id;
                                            NavigationRouter
                                                .switchToUserSearchDetailPageOne(
                                                    context,
                                                    approvedList[index]
                                                        .therapistId);
                                          },
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.22,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: WidgetAnimator(
                                              new Card(
                                                color: Color.fromRGBO(
                                                    242, 242, 242, 1),
                                                semanticContainer: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  children: [
                                                                    approvedList[index].bookingTherapistId.uploadProfileImgUrl !=
                                                                            null
                                                                        ? CachedNetworkImage(
                                                                            imageUrl:
                                                                                approvedList[index].bookingTherapistId.uploadProfileImgUrl,
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                            fadeInCurve:
                                                                                Curves.easeInSine,
                                                                            imageBuilder: (context, imageProvider) =>
                                                                                Container(
                                                                              width: 65.0,
                                                                              height: 65.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                            placeholder: (context, url) =>
                                                                                SpinKitDoubleBounce(color: Colors.lightGreenAccent),
                                                                            errorWidget: (context, url, error) =>
                                                                                Container(
                                                                              width: 56.0,
                                                                              height: 56.0,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(color: Colors.black12),
                                                                                image: DecorationImage(image: new AssetImage('assets/images_gps/placeholder_image.png'), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : CircleAvatar(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images_gps/placeholder_image.png',
                                                                              height: 70,
                                                                              color: Colors.black,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            radius:
                                                                                35,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    approvedList[index].locationDistance !=
                                                                            null
                                                                        ? FittedBox(
                                                                            child: Text('${approvedList[index].locationDistance}km圏内',
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(153, 153, 153, 1),
                                                                                )),
                                                                          )
                                                                        : Text(
                                                                            '0.0km圏内',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            )),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
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
                                                                        approvedList[index].bookingTherapistId.storeName !=
                                                                                null
                                                                            ? Text(
                                                                                '${approvedList[index].bookingTherapistId.storeName}',
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                              )
                                                                            : Text(
                                                                                '${approvedList[index].bookingTherapistId.userName}',
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                Colors.white,
                                                                                Colors.white
                                                                              ]),
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: Colors.grey[400],
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
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
                                                                            isFavorite: approvedList[index].favouriteToTherapist ==
                                                                                1,
                                                                            iconSize:
                                                                                40,
                                                                            iconColor:
                                                                                Colors.red,
                                                                            valueChanged: (_isFavorite) {
                                                                              print('Is Favorite : $_isFavorite');
                                                                              print('Is Favorite : $_isFavorite');
                                                                              if (_isFavorite != null && _isFavorite) {
                                                                                // call favorite therapist API
                                                                                ServiceUserAPIProvider.favouriteTherapist(approvedList[index].therapistId);
                                                                              } else {
                                                                                // call un-favorite therapist API
                                                                                ServiceUserAPIProvider.unFavouriteTherapist(approvedList[index].therapistId);
                                                                              }
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    FittedBox(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          approvedList[index].bookingTherapistId.isShop
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox.shrink(),
                                                                          approvedList[index].bookingTherapistId.isShop
                                                                              ? SizedBox(
                                                                                  width: 5,
                                                                                )
                                                                              : SizedBox.shrink(),
                                                                          approvedList[index].bookingTherapistId.businessTrip
                                                                              ? Container(
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox.shrink(),
                                                                          approvedList[index].bookingTherapistId.businessTrip
                                                                              ? SizedBox(
                                                                                  width: 5,
                                                                                )
                                                                              : SizedBox.shrink(),
                                                                          approvedList[index].bookingTherapistId.coronaMeasure
                                                                              ? Container(
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
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(0, 0, 0, 1),
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
                                                                          '(${approvedList[index].reviewAvgData})',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              double.parse(approvedList[index].reviewAvgData),
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              25,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 4.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            size:
                                                                                5,
                                                                            color: Color.fromRGBO(
                                                                                255,
                                                                                217,
                                                                                0,
                                                                                1),
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            // print(rating);
                                                                            setState(() {
                                                                              ratingsValue = rating;
                                                                            });
                                                                            print(ratingsValue);
                                                                          },
                                                                        ),
                                                                        Text(
                                                                          '(${approvedList[index].noOfReviewsMembers})',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
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
                                                                    certificateUploadAprvdList[index].length !=
                                                                                0 &&
                                                                            certificateUploadAprvdList[index].keys.elementAt(0) !=
                                                                                "無資格"
                                                                        ? Container(
                                                                            height:
                                                                                38.0,
                                                                            padding:
                                                                                EdgeInsets.only(top: 5.0),
                                                                            width:
                                                                                MediaQuery.of(context).size.width - 130.0,
                                                                            //200.0,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: certificateUploadAprvdList[index].length,
                                                                                itemBuilder: (context, subindex) {
                                                                                  String key = certificateUploadAprvdList[index].keys.elementAt(subindex);
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
                                                          Expanded(
                                                            child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Divider(
                                                                      // height: 50,
                                                                      color: Color.fromRGBO(
                                                                          217,
                                                                          217,
                                                                          217,
                                                                          1),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      ProgressDialogBuilder
                                                                          .showCommonProgressDialog(
                                                                              context);
                                                                      getChatDetails(approvedList[
                                                                              index]
                                                                          .bookingTherapistId
                                                                          .firebaseUdid);
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          CircleBorder(),
                                                                      child: CircleAvatar(
                                                                          maxRadius:
                                                                              20,
                                                                          backgroundColor: Colors
                                                                              .white,
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
                                                                      HealingMatchConstants
                                                                          .bookingIdPay = approvedList[
                                                                              index]
                                                                          .id;
                                                                      HealingMatchConstants
                                                                          .therapistIdPay = approvedList[
                                                                              index]
                                                                          .therapistId;
                                                                      HealingMatchConstants
                                                                          .confServiceCost = approvedList[
                                                                              index]
                                                                          .totalCost;
                                                                      print(
                                                                          'bookingId: ${HealingMatchConstants.bookingIdPay}');

                                                                      HealingMatchConstants
                                                                          .initiatePayment(
                                                                              context);
                                                                    },
                                                                    child: Card(
                                                                      shape:
                                                                          CircleBorder(),
                                                                      elevation:
                                                                          3,
                                                                      child: CircleAvatar(
                                                                          maxRadius:
                                                                              20,
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images_gps/pay.svg',
                                                                              color: Color.fromRGBO(255, 193, 7, 1),
                                                                              height: 20,
                                                                              width: 20)),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      HealingMatchConstants
                                                                          .bookingIdPay = approvedList[
                                                                              index]
                                                                          .id;
                                                                      NavigationRouter
                                                                          .switchToServiceUserBookingCancelScreen(
                                                                              context);
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          CircleBorder(),
                                                                      child: CircleAvatar(
                                                                          maxRadius:
                                                                              20,
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images_gps/cancel.svg',
                                                                              color: Color.fromRGBO(217, 217, 217, 1),
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
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  height: 20,
                                                                  width: 20),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '施術を受ける場所',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  decoration: BoxDecoration(
                                                                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                        Colors
                                                                            .white,
                                                                        Colors
                                                                            .white,
                                                                      ]),
                                                                      shape: BoxShape.rectangle,
                                                                      border: Border.all(
                                                                        color: Colors
                                                                            .grey[300],
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                      color: Colors.grey[200]),
                                                                  child: Text(
                                                                    '${approvedList[index].locationType}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${approvedList[index].location}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
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
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                  height: 20,
                                                                  width: 20),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '予約日時：${date}',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                '${sTime}~${eTime}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          102,
                                                                          102,
                                                                          102,
                                                                          1),
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
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                          confirmedPaymentList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          confirmedPaymentList.length != 0
                              ? Text(
                                  '確定した予約（支払い完了）',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                )
                              : SizedBox.shrink(),
                          confirmedPaymentList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          confirmedPaymentList.length != 0
                              ? Container(
                                  // height: MediaQuery.of(context).size.height * 0.39,
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: confirmedPaymentList.length,
                                      itemBuilder: (context, index) {
                                        DateTime startTime =
                                            confirmedPaymentList[index]
                                                        .newStartTime !=
                                                    null
                                                ? confirmedPaymentList[index]
                                                    .newStartTime
                                                    .toLocal()
                                                : confirmedPaymentList[index]
                                                    .startTime
                                                    .toLocal();
                                        DateTime endTime =
                                            confirmedPaymentList[index]
                                                        .newEndTime !=
                                                    null
                                                ? confirmedPaymentList[index]
                                                    .newEndTime
                                                    .toLocal()
                                                : confirmedPaymentList[index]
                                                    .endTime
                                                    .toLocal();
                                        String date = DateFormat('MM月d')
                                            .format(startTime);
                                        String sTime = DateFormat('kk:mm')
                                            .format(startTime);
                                        String eTime =
                                            DateFormat('kk:mm').format(endTime);
                                        String jaName =
                                            DateFormat('EEEE', 'ja_JP')
                                                .format(startTime);
                                        return InkWell(
                                          onTap: () {
                                            HealingMatchConstants.bookingIdPay =
                                                confirmedPaymentList[index].id;
                                            NavigationRouter
                                                .switchToUserSearchDetailPageOne(
                                                    context,
                                                    confirmedPaymentList[index]
                                                        .therapistId);
                                          },
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.22,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: WidgetAnimator(
                                              new Card(
                                                color: Color.fromRGBO(
                                                    242, 242, 242, 1),
                                                semanticContainer: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                              children: [
                                                                confirmedPaymentList[index]
                                                                            .bookingTherapistId
                                                                            .uploadProfileImgUrl !=
                                                                        null
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: confirmedPaymentList[index]
                                                                            .bookingTherapistId
                                                                            .uploadProfileImgUrl,
                                                                        filterQuality:
                                                                            FilterQuality.high,
                                                                        fadeInCurve:
                                                                            Curves.easeInSine,
                                                                        imageBuilder:
                                                                            (context, imageProvider) =>
                                                                                Container(
                                                                          width:
                                                                              65.0,
                                                                          height:
                                                                              65.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                SpinKitDoubleBounce(color: Colors.lightGreenAccent),
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
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(color: Colors.black12),
                                                                            image:
                                                                                DecorationImage(image: new AssetImage('assets/images_gps/placeholder_image.png'), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : CircleAvatar(
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images_gps/placeholder_image.png',
                                                                          height:
                                                                              70,
                                                                          color:
                                                                              Colors.black,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        radius:
                                                                            35,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ),
                                                                FittedBox(
                                                                  child: confirmedPaymentList[index]
                                                                              .locationDistance !=
                                                                          null
                                                                      ? Text(
                                                                          '${confirmedPaymentList[index].locationDistance}km圏内',
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
                                                                    confirmedPaymentList[index].bookingTherapistId.storeName !=
                                                                            null
                                                                        ? Text(
                                                                            '${confirmedPaymentList[index].bookingTherapistId.storeName}',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        : Text(
                                                                            '${confirmedPaymentList[index].bookingTherapistId.userName}',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                              begin: Alignment.topCenter,
                                                                              end: Alignment.bottomCenter,
                                                                              colors: [
                                                                                Colors.white,
                                                                                Colors.white
                                                                              ]),
                                                                          shape:
                                                                              BoxShape.circle,
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
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "assets/images_gps/info.svg",
                                                                            height:
                                                                                10.0,
                                                                            width:
                                                                                10.0,
                                                                            // key: key,
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
                                                                    Spacer(),
                                                                    FavoriteButton(
                                                                        isFavorite:
                                                                            confirmedPaymentList[index].favouriteToTherapist ==
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
                                                                          if (_isFavorite != null &&
                                                                              _isFavorite) {
                                                                            // call favorite therapist API
                                                                            ServiceUserAPIProvider.favouriteTherapist(confirmedPaymentList[index].therapistId);
                                                                          } else {
                                                                            // call un-favorite therapist API
                                                                            ServiceUserAPIProvider.unFavouriteTherapist(confirmedPaymentList[index].therapistId);
                                                                          }
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
                                                                      confirmedPaymentList[index]
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                                                ),
                                                                              ))
                                                                          : SizedBox.shrink(),
                                                                      confirmedPaymentList[index]
                                                                              .bookingTherapistId
                                                                              .isShop
                                                                          ? SizedBox(
                                                                              width: 5,
                                                                            )
                                                                          : SizedBox
                                                                              .shrink(),
                                                                      confirmedPaymentList[index]
                                                                              .bookingTherapistId
                                                                              .businessTrip
                                                                          ? Container(
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                                                ),
                                                                              ))
                                                                          : SizedBox.shrink(),
                                                                      confirmedPaymentList[index]
                                                                              .bookingTherapistId
                                                                              .businessTrip
                                                                          ? SizedBox(
                                                                              width: 5,
                                                                            )
                                                                          : SizedBox
                                                                              .shrink(),
                                                                      confirmedPaymentList[index]
                                                                              .bookingTherapistId
                                                                              .coronaMeasure
                                                                          ? Container(
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
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
                                                                    confirmedPaymentList[index].reviewAvgData !=
                                                                            null
                                                                        ? Text(
                                                                            '(${confirmedPaymentList[index].reviewAvgData})',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            '(0.0)',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          ),
                                                                    RatingBar
                                                                        .builder(
                                                                      initialRating:
                                                                          double.parse(
                                                                              confirmedPaymentList[index].reviewAvgData),
                                                                      minRating:
                                                                          1,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      ignoreGestures:
                                                                          true,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          25,
                                                                      itemPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 4.0),
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: 5,
                                                                        color: Color.fromRGBO(
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
                                                                    confirmedPaymentList[index].noOfReviewsMembers !=
                                                                            null
                                                                        ? Text(
                                                                            '(${confirmedPaymentList[index].noOfReviewsMembers})',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            '(0)',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                certificateUploadConfdPayList[index].length !=
                                                                            0 &&
                                                                        certificateUploadConfdPayList[index].keys.elementAt(0) !=
                                                                            "無資格"
                                                                    ? Container(
                                                                        height:
                                                                            38.0,
                                                                        padding:
                                                                            EdgeInsets.only(top: 5.0),
                                                                        width: MediaQuery.of(context).size.width -
                                                                            130.0, //200.0,
                                                                        child: ListView.builder(
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.horizontal,
                                                                            itemCount: certificateUploadConfdPayList[index].length,
                                                                            itemBuilder: (context, subindex) {
                                                                              String key = certificateUploadConfdPayList[index].keys.elementAt(subindex);
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
                                                      Expanded(
                                                        child: Row(
                                                            children: <Widget>[
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
                                                              InkWell(
                                                                onTap: () {
                                                                  ProgressDialogBuilder
                                                                      .showCommonProgressDialog(
                                                                          context);
                                                                  getChatDetails(confirmedPaymentList[
                                                                          index]
                                                                      .bookingTherapistId
                                                                      .firebaseUdid);
                                                                },
                                                                child: Card(
                                                                  elevation: 3,
                                                                  shape:
                                                                      CircleBorder(),
                                                                  child: CircleAvatar(
                                                                      maxRadius:
                                                                          20,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      child: SvgPicture.asset(
                                                                          'assets/images_gps/chat.svg',
                                                                          height:
                                                                              15,
                                                                          width:
                                                                              15)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  HealingMatchConstants
                                                                          .bookingIdPay =
                                                                      confirmedPaymentList[
                                                                              index]
                                                                          .id;
                                                                  NavigationRouter
                                                                      .switchToServiceUserBookingCancelScreen(
                                                                          context);
                                                                },
                                                                child: Card(
                                                                  shape:
                                                                      CircleBorder(),
                                                                  elevation: 3,
                                                                  child: CircleAvatar(
                                                                      maxRadius:
                                                                          20,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      child: SvgPicture.asset(
                                                                          'assets/images_gps/cancel.svg',
                                                                          color: Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1),
                                                                          height:
                                                                              15,
                                                                          width:
                                                                              15)),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/images_gps/gps.svg',
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              height: 20,
                                                              width: 20),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '施術を受ける場所',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
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
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      4),
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey[300],
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      color: Colors
                                                                              .grey[
                                                                          200]),
                                                              child: Text(
                                                                '${confirmedPaymentList[index].locationType}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '${confirmedPaymentList[index].location}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1),
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
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              height: 20,
                                                              width: 20),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '予約日時：${date}',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        102,
                                                                        102,
                                                                        102,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${sTime}~${eTime}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                          canceledReservationList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          canceledReservationList.length != 0
                              ? Text(
                                  'キャンセルされた予約',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                )
                              : SizedBox.shrink(),
                          canceledReservationList.length != 0
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox.shrink(),
                          canceledReservationList.length != 0
                              ? Container(
                                  // height: MediaQuery.of(context).size.height * 0.35,
                                  height: 275,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: canceledReservationList.length,
                                      itemBuilder: (context, index) {
                                        DateTime startTime =
                                            canceledReservationList[index]
                                                        .newStartTime !=
                                                    null
                                                ? canceledReservationList[index]
                                                    .newStartTime
                                                    .toLocal()
                                                : canceledReservationList[index]
                                                    .startTime
                                                    .toLocal();
                                        DateTime endTime =
                                            canceledReservationList[index]
                                                        .newEndTime !=
                                                    null
                                                ? canceledReservationList[index]
                                                    .newEndTime
                                                    .toLocal()
                                                : canceledReservationList[index]
                                                    .endTime
                                                    .toLocal();
                                        String date = DateFormat('MM月d')
                                            .format(startTime);
                                        String sTime = DateFormat('kk:mm')
                                            .format(startTime);
                                        String eTime =
                                            DateFormat('kk:mm').format(endTime);
                                        String jaName =
                                            DateFormat('EEEE', 'ja_JP')
                                                .format(startTime);
                                        return InkWell(
                                          onTap: () {
                                            NavigationRouter
                                                .switchToUserSearchDetailPageOne(
                                                    context,
                                                    canceledReservationList[
                                                            index]
                                                        .therapistId);
                                          },
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.22,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: WidgetAnimator(
                                              new Card(
                                                color: Colors.grey[200],
                                                semanticContainer: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                              children: [
                                                                canceledReservationList[index]
                                                                            .bookingTherapistId
                                                                            .uploadProfileImgUrl !=
                                                                        null
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: canceledReservationList[index]
                                                                            .bookingTherapistId
                                                                            .uploadProfileImgUrl,
                                                                        filterQuality:
                                                                            FilterQuality.high,
                                                                        fadeInCurve:
                                                                            Curves.easeInSine,
                                                                        imageBuilder:
                                                                            (context, imageProvider) =>
                                                                                Container(
                                                                          width:
                                                                              65.0,
                                                                          height:
                                                                              65.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                SpinKitDoubleBounce(color: Colors.lightGreenAccent),
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
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border:
                                                                                Border.all(color: Colors.black12),
                                                                            image:
                                                                                DecorationImage(image: new AssetImage('assets/images_gps/placeholder_image.png'), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : CircleAvatar(
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images_gps/placeholder_image.png',
                                                                          height:
                                                                              70,
                                                                          color:
                                                                              Colors.black,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        radius:
                                                                            35,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ),
                                                                FittedBox(
                                                                  child: canceledReservationList[index]
                                                                              .locationDistance !=
                                                                          null
                                                                      ? Text(
                                                                          '${canceledReservationList[index].locationDistance}圏内',
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
                                                                          '0.0圏内',
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
                                                                    canceledReservationList[index].bookingTherapistId.storeName !=
                                                                            null
                                                                        ? Text(
                                                                            '${canceledReservationList[index].bookingTherapistId.storeName}',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        : Text(
                                                                            '${canceledReservationList[index].bookingTherapistId.userName}',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color.fromRGBO(0, 0, 0, 1),
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                              begin: Alignment.topCenter,
                                                                              end: Alignment.bottomCenter,
                                                                              colors: [
                                                                                Colors.white,
                                                                                Colors.white
                                                                              ]),
                                                                          shape:
                                                                              BoxShape.circle,
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
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "assets/images_gps/info.svg",
                                                                            height:
                                                                                10.0,
                                                                            width:
                                                                                10.0,
                                                                            // key: key,
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
                                                                    Spacer(),
                                                                    FavoriteButton(
                                                                        isFavorite: canceledReservationList[index].favouriteToTherapist ==
                                                                                1
                                                                            ? true
                                                                            : false,
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
                                                                          if (_isFavorite != null &&
                                                                              _isFavorite) {
                                                                            // call favorite therapist API

                                                                            ServiceUserAPIProvider.favouriteTherapist(canceledReservationList[index].therapistId);
                                                                          } else {
                                                                            // call un-favorite therapist API
                                                                            ServiceUserAPIProvider.unFavouriteTherapist(canceledReservationList[index].therapistId);
                                                                          }
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
                                                                      canceledReservationList[index]
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                                                ),
                                                                              ))
                                                                          : SizedBox.shrink(),
                                                                      canceledReservationList[index]
                                                                              .bookingTherapistId
                                                                              .isShop
                                                                          ? SizedBox(
                                                                              width: 5,
                                                                            )
                                                                          : SizedBox
                                                                              .shrink(),
                                                                      canceledReservationList[index]
                                                                              .bookingTherapistId
                                                                              .businessTrip
                                                                          ? Container(
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
                                                                                ),
                                                                              ))
                                                                          : SizedBox.shrink(),
                                                                      canceledReservationList[index]
                                                                              .bookingTherapistId
                                                                              .businessTrip
                                                                          ? SizedBox(
                                                                              width: 5,
                                                                            )
                                                                          : SizedBox
                                                                              .shrink(),
                                                                      canceledReservationList[index]
                                                                              .bookingTherapistId
                                                                              .coronaMeasure
                                                                          ? Container(
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
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(0, 0, 0, 1),
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
                                                                    canceledReservationList[index].reviewAvgData !=
                                                                            null
                                                                        ? Text(
                                                                            '(${canceledReservationList[index].reviewAvgData})',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            '(0.0)',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(153, 153, 153, 1),
                                                                            ),
                                                                          ),
                                                                    RatingBar
                                                                        .builder(
                                                                      initialRating:
                                                                          double.parse(
                                                                              canceledReservationList[index].reviewAvgData),
                                                                      minRating:
                                                                          1,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      ignoreGestures:
                                                                          true,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          20,
                                                                      itemPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 4.0),
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: 5,
                                                                        color: Color.fromRGBO(
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
                                                                      '(${canceledReservationList[index].noOfReviewsMembers})',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromRGBO(
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
                                                                certificateUploadCancelList[index].length !=
                                                                            0 &&
                                                                        certificateUploadCancelList[index].keys.elementAt(0) !=
                                                                            "無資格"
                                                                    ? Container(
                                                                        height:
                                                                            38.0,
                                                                        padding:
                                                                            EdgeInsets.only(top: 5.0),
                                                                        width: MediaQuery.of(context).size.width -
                                                                            130.0, //200.0,
                                                                        child: ListView.builder(
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.horizontal,
                                                                            itemCount: certificateUploadCancelList[index].length,
                                                                            itemBuilder: (context, subindex) {
                                                                              String key = certificateUploadCancelList[index].keys.elementAt(subindex);
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
                                                      Expanded(
                                                        child: Divider(
                                                          color: Color.fromRGBO(
                                                              217, 217, 217, 1),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/images_gps/gps.svg',
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              height: 20,
                                                              width: 20),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '施術を受ける場所',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
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
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      4),
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey[300],
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      color: Colors
                                                                              .grey[
                                                                          200]),
                                                              child: Text(
                                                                '${canceledReservationList[index].locationType}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          1),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '${canceledReservationList[index].location}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1),
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
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              height: 20,
                                                              width: 20),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '予約日時：${date}',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${sTime}~${eTime}',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      102,
                                                                      102,
                                                                      102,
                                                                      1),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            width: 30,
                          )
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
                                      color: Color.fromRGBO(217, 217, 217, 1)),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                '予約はありません。',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'NotoSansJP',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
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
          );
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
