import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/firebaseNotificationTherapistListModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationList> requestBookingDetailsList = List<NotificationList>();
  int status = 0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;

  @override
  void initState() {
    super.initState();
    ServiceProviderApi.getProviderNotifications(_pageNumber, _pageSize)
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
          : LazyLoadScrollView(
              isLoading: isLoading,
              onEndOfPage: () => _getMoreData(),
              child: SingleChildScrollView(
                primary: true,
                child: ListView.builder(
                    primary: false,
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: requestBookingDetailsList.length,
                    itemBuilder: (context, index) {
                      return requestBookingDetailsList[index].adminInfoId ==
                              null
                          ? buildNotificationCard(
                              index, requestBookingDetailsList[index])
                          : buildAdminCard(
                              index, requestBookingDetailsList[index]);
                    }),
              ),
            ),
    );
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
                      child: SvgPicture.asset(
                          'assets/images_gps/profile_pic_user.svg',
                          height: 35,
                          width: 35,
                          color: Colors.black),
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
    String sTime = requestBookingDetailsList.bookingDetail.newStartTime == null
        ? DateFormat('kk:mm')
            .format(requestBookingDetailsList.bookingDetail.startTime.toLocal())
        : DateFormat('kk:mm').format(
            requestBookingDetailsList.bookingDetail.newStartTime.toLocal());
    String eTime = requestBookingDetailsList.bookingDetail.newEndTime == null
        ? DateFormat('kk:mm')
            .format(requestBookingDetailsList.bookingDetail.endTime.toLocal())
        : DateFormat('kk:mm').format(
            requestBookingDetailsList.bookingDetail.newEndTime.toLocal());
    String dateFormat = DateFormat('MM月dd')
        .format(requestBookingDetailsList.bookingDetail.startTime.toLocal());
    var serviceDifference = requestBookingDetailsList.bookingDetail.endTime
        .difference(requestBookingDetailsList.bookingDetail.startTime.toLocal())
        .inMinutes;
    var notifiationDifference = DateTime.now()
        .difference(requestBookingDetailsList.createdAt.toLocal())
        .inHours;
    String name =
        requestBookingDetailsList.bookingDetail.bookingUserId.userName.length >
                10
            ? requestBookingDetailsList.bookingDetail.bookingUserId.userName
                    .substring(0, 10) +
                "..."
            : requestBookingDetailsList.bookingDetail.bookingUserId.userName;

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
              if (requestBookingDetailsList.bookingStatus == 0) {
                requestBookingDetailsList.isReadStatus = true;
                NavigationRouter.switchToAcceptBookingScreen(
                    context, requestBookingDetailsList);
              } else if (requestBookingDetailsList.bookingStatus == 5 ||
                  requestBookingDetailsList.bookingStatus == 7 ||
                  requestBookingDetailsList.bookingStatus == 8) {
                requestBookingDetailsList.isReadStatus = true;
                NavigationRouter.switchToOfferCancelScreen(
                    context, requestBookingDetailsList);
              } else if (requestBookingDetailsList.bookingStatus == 6) {
                requestBookingDetailsList.isReadStatus = true;
                NavigationRouter.switchToOfferConfirmedScreen(
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
            //  crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipOval(
                      child: requestBookingDetailsList.bookingDetail
                                  .bookingUserId.uploadProfileImgUrl !=
                              null
                          ? CachedNetworkImage(
                              width: 35.0,
                              height: 35.0,
                              fit: BoxFit.cover,
                              imageUrl: requestBookingDetailsList.bookingDetail
                                  .bookingUserId.uploadProfileImgUrl,
                              placeholder: (context, url) => SpinKitWave(
                                  size: 20.0,
                                  color: ColorConstants.buttonColor),
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
                  ? Column(
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
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        requestBookingDetailsList.bookingStatus == 7 ||
                                requestBookingDetailsList.bookingStatus == 8
                            ? Text(
                                '設定した希望時間が締め切れましたので、$nameさんのご\n予約は自動的にキャンセルされました。',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    '$name さん',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  requestBookingDetailsList.bookingStatus == 0
                                      ? Text(
                                          'からご予約依頼がありました。',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        )
                                      : requestBookingDetailsList
                                                  .bookingStatus ==
                                              5
                                          ? Text(
                                              'がご予約をキャンセルしました。',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            )
                                          : Text(
                                              'はご予約を確定しました。',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                              ),
                                            ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
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
      ),
    );
  }

  _getMoreData() async {
    try {
      if (!isLoading) {
        isLoading = true;
        _pageNumber++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        FirebaseNotificationTherapistListModel therapistDetailsModel =
            await ServiceProviderApi.getProviderNotifications(
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
