import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/notification/firebaseNotificationUserListModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class NotificationHistoryScreen extends StatefulWidget {
  @override
  _NotificationHistoryScreenState createState() =>
      _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  List<NotificationList> requestBookingDetailsList = List<NotificationList>();
  int status = 0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;

  @override
  void initState() {
    super.initState();
    ServiceUserAPIProvider.getUserNotifications(_pageNumber, _pageSize)
        .then((value) {
      setState(() {
        requestBookingDetailsList.addAll(value.data.notificationList);
        status = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: status == 0
            ? Center(child: CircularProgressIndicator())
            : requestBookingDetailsList.length != 0
                ? LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () => _getMoreData(),
                    child: SingleChildScrollView(
                      primary: true,
                      child: Column(
                        children: [
                          ListView.builder(
                              primary: false,
                              padding: EdgeInsets.all(0.0),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: requestBookingDetailsList.length,
                              itemBuilder: (context, index) {
                                return requestBookingDetailsList[index]
                                            .adminInfoId ==
                                        null
                                    ? buildNotificationCard(
                                        index, requestBookingDetailsList[index])
                                    : buildAdminCard(index,
                                        requestBookingDetailsList[index]);
                              }),
                          SizedBox(
                              height: requestBookingDetailsList.length > 4
                                  ? 50.0
                                  : 0.0),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Column(
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
                                    /* Row(
                                children: [
                                  Text(
                                    'ユーザーチャットの情報！',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NotoSansJP',
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),*/
                                    Row(
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
                                        SizedBox(width: 20),
                                        Flexible(
                                          child: Text(
                                            'お知らせはありません。',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'NotoSansJP',
                                                fontWeight: FontWeight.bold),
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
                      ],
                    ),
                  ));
  }

  buildAdminCard(int index, NotificationList requestBookingDetailsList) {
    var notifiationDifference = DateTime.now()
        .difference(requestBookingDetailsList.createdAt.toLocal())
        .inHours;
    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: !requestBookingDetailsList.isReadStatus
            ? Color.fromRGBO(251, 251, 251, 1)
            : Colors.white,
        border: Border(
          left: BorderSide(
            color: !requestBookingDetailsList.isReadStatus
                ? Color.fromRGBO(200, 217, 33, 1)
                : Colors.white,
            width: 6,
          ),
          bottom: BorderSide(color: Colors.grey[200]),
        ),
        //  borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: InkWell(
          onTap: () {
            HealingMatchConstants.adminMessage =
                requestBookingDetailsList.information.infoMessage;
            HealingMatchConstants.notificationId = requestBookingDetailsList.id;
            requestBookingDetailsList.isReadStatus = true;
            NavigationRouter.switchToAdminNotificationScreen(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipOval(
                      child: Image.asset('assets/images_gps/logo.png',
                          height: 35, width: 35),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Center(
                    child: Text(
                      '$notifiationDifference時',
                      style: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '管理者',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    requestBookingDetailsList.information.infoMessage.length >
                            15
                        ? requestBookingDetailsList.information.infoMessage
                                .substring(0, 15) +
                            "..."
                        : requestBookingDetailsList.information.infoMessage,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(242, 242, 242, 1),
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildNotificationCard(int index, NotificationList requestBookingDetailsList) {
    String jaName = DateFormat('EEEE', 'ja_JP')
        .format(requestBookingDetailsList.bookingDetail.startTime.toLocal());
    DateTime localStartTime =
        requestBookingDetailsList.bookingDetail.newStartTime == null
            ? requestBookingDetailsList.bookingDetail.startTime.toLocal()
            : requestBookingDetailsList.bookingDetail.newStartTime.toLocal();
    DateTime localEndTime =
        requestBookingDetailsList.bookingDetail.newEndTime == null
            ? requestBookingDetailsList.bookingDetail.endTime.toLocal()
            : requestBookingDetailsList.bookingDetail.newEndTime.toLocal();
    String sTime = localStartTime.hour == 0
        ? DateFormat('KK:mm').format(localStartTime)
        : DateFormat('kk:mm').format(localStartTime);
    String eTime = DateFormat('kk:mm').format(localEndTime);
    String dateFormat = DateFormat('MM月dd')
        .format(requestBookingDetailsList.bookingDetail.startTime.toLocal());
    var serviceDifference = requestBookingDetailsList.bookingDetail.endTime
        .difference(requestBookingDetailsList.bookingDetail.startTime.toLocal())
        .inMinutes;
    var notifiationDifference = DateTime.now()
        .difference(requestBookingDetailsList.createdAt.toLocal())
        .inHours;
    String name =
        requestBookingDetailsList.bookingDetail.bookingTherapistId.isShop
            ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.storeName.length >
                    16
                ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.storeName
                        .substring(0, 15) +
                    "..."
                : requestBookingDetailsList
                    .bookingDetail.bookingTherapistId.storeName
            : requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.userName.length >
                    16
                ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.userName
                        .substring(0, 15) +
                    "..."
                : requestBookingDetailsList
                    .bookingDetail.bookingTherapistId.userName;

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: !requestBookingDetailsList.isReadStatus
            ? Color.fromRGBO(251, 251, 251, 1)
            : Colors.white,
        border: Border(
          left: BorderSide(
            color: !requestBookingDetailsList.isReadStatus
                ? Color.fromRGBO(200, 217, 33, 1)
                : Colors.white,
            width: 6,
          ),
          bottom: BorderSide(color: Colors.grey[200]),
        ),
        //  borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: InkWell(
          onTap: () {
            if (requestBookingDetailsList.adminInfoId == null) {
              if (requestBookingDetailsList.bookingStatus == 1 ||
                  requestBookingDetailsList.bookingStatus == 2) {
                requestBookingDetailsList.isReadStatus = true;
                NavigationRouter.switchToUserTherapistAcceptNotification(
                    context, requestBookingDetailsList);
              } else if (requestBookingDetailsList.bookingStatus == 4 ||
                  requestBookingDetailsList.bookingStatus == 7 ||
                  requestBookingDetailsList.bookingStatus == 8) {
                requestBookingDetailsList.isReadStatus = true;
                NavigationRouter.switchToUserTherapistCancelNotification(
                    context, requestBookingDetailsList);
              }
            } else {
              HealingMatchConstants.adminMessage =
                  requestBookingDetailsList.information.infoMessage;
              HealingMatchConstants.notificationId =
                  requestBookingDetailsList.id;
              requestBookingDetailsList.isReadStatus = true;
              NavigationRouter.switchToAdminNotificationScreen(context);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: requestBookingDetailsList.bookingDetail
                                .bookingTherapistId.uploadProfileImgUrl !=
                            null
                        ? CachedNetworkImage(
                            width: 35.0,
                            height: 35.0,
                            fit: BoxFit.cover,
                            imageUrl: requestBookingDetailsList.bookingDetail
                                .bookingTherapistId.uploadProfileImgUrl,
                            placeholder: (context, url) => SpinKitWave(
                                size: 20.0, color: ColorConstants.buttonColor),
                            errorWidget: (context, url, error) => Column(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/profile_pic_user.svg',
                                        height: 18,
                                        width: 18,
                                        color: Colors.black),
                                  ],
                                ))
                        : SvgPicture.asset(
                            'assets/images_gps/profile_pic_user.svg',
                            height: 35,
                            width: 35,
                            color: Colors.black),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Center(
                    child: Text(
                      '$notifiationDifference時',
                      style: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: 10.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              requestBookingDetailsList.adminInfoId != null
                  ? Expanded(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '管理者',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                requestBookingDetailsList
                                            .information.infoMessage.length >
                                        15
                                    ? requestBookingDetailsList
                                            .information.infoMessage
                                            .substring(0, 15) +
                                        "..."
                                    : requestBookingDetailsList
                                        .information.infoMessage,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(242, 242, 242, 1),
                            size: 20.0,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$name',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              requestBookingDetailsList.bookingStatus == 7
                                  ? Text(
                                      '承認が期限内にされなかったため 予約はキャンセルされました',
                                      style: TextStyle(
                                        fontSize: 9.0,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                    )
                                  : requestBookingDetailsList.bookingStatus == 8
                                      ? Text(
                                          '支払いが時間通りに行われなかった 予約はキャンセルされました',
                                          style: TextStyle(
                                            fontSize: 9.0,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        )
                                      : requestBookingDetailsList
                                                      .bookingStatus ==
                                                  2 ||
                                              requestBookingDetailsList
                                                      .bookingStatus ==
                                                  1
                                          ? Text(
                                              'セラピストが予約を承認しました',
                                              style: TextStyle(
                                                fontSize: 9.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            )
                                          : Text(
                                              'セラピストが予約をキャンセルしました',
                                              style: TextStyle(
                                                fontSize: 9.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images_gps/calendar.svg",
                                    height: 14.77,
                                    width: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '$dateFormat',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ' $jaName ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
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
                                    '$sTime ~ $eTime',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' $serviceDifference分 ',
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '${requestBookingDetailsList.bookingDetail.nameOfService}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(242, 242, 242, 1),
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _getMoreData() async {
    try {
      if (!isLoading) {
        isLoading = true;
        _pageNumber++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        FirebaseNotificationUserListModel therapistDetailsModel =
            await ServiceUserAPIProvider.getUserNotifications(
                _pageNumber, _pageSize);

        if (therapistDetailsModel.data.notificationList.isEmpty) {
          setState(() {
            isLoading = false;
            print(
                'TherapistList data count is Zero : ${therapistDetailsModel.data.notificationList.length}');
          });
        } else {
          print(
              'TherapistList data Size : ${therapistDetailsModel.data.notificationList.length}');
          setState(() {
            isLoading = false;
            if (this.mounted) {
              requestBookingDetailsList
                  .addAll(therapistDetailsModel.data.notificationList);
            }
          });
        }
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }
}
