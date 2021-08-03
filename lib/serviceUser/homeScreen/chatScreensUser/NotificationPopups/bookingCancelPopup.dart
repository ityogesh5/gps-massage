import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/notification/firebaseNotificationUserListModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';

class BookingCancelPopup extends StatefulWidget {
  final NotificationList requestBookingDetailsList;

  BookingCancelPopup(this.requestBookingDetailsList);

  @override
  _BookingCancelPopupState createState() => _BookingCancelPopupState();
}

class _BookingCancelPopupState extends State<BookingCancelPopup> {
  @override
  void initState() {
    super.initState();
    ServiceProviderApi.updateNotificationStatus(
        widget.requestBookingDetailsList.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: DottedBorder(
                  dashPattern: [3, 3],
                  strokeWidth: 1,
                  color: Color.fromRGBO(232, 232, 232, 1),
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.Circle,
                  radius: Radius.circular(5),
                  child: CircleAvatar(
                    maxRadius: 55,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    child: SvgPicture.asset(
                        'assets/images_gps/cancel_popup.svg',
                        height: 45,
                        width: 45,
                        color: Color.fromRGBO(255, 0, 0, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                widget.requestBookingDetailsList.bookingStatus == 4
                    ? 'セラピストがご予約をキャンセルしました。'
                    : widget.requestBookingDetailsList.bookingStatus == 8
                        ? "期限内に支払いが完了しなかった為、\n 予約はキャンセルされました"
                        : "期限内にセラピストに \n よる予約の承認がされなかった為、 \n　予約はキャンセルされました",
                style: TextStyle(
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18.0,
              ),
              buildBookingCard(widget.requestBookingDetailsList),
              widget.requestBookingDetailsList.bookingStatus == 4
                  ? buildConditionReason(context)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Card buildBookingCard(NotificationList requestBookingDetailsList) {
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
    DateTime createdAtTime = requestBookingDetailsList.createdAt.toLocal();
    String nTime = DateFormat('kk:mm').format(createdAtTime);
    String dateFormat = DateFormat('MM月dd')
        .format(requestBookingDetailsList.bookingDetail.startTime.toLocal());
    var serviceDifference = requestBookingDetailsList.bookingDetail.endTime
        .difference(requestBookingDetailsList.bookingDetail.startTime.toLocal())
        .inMinutes;

    String name =
        requestBookingDetailsList.bookingDetail.bookingTherapistId.isShop
            ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.storeName.length >
                    10
                ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.storeName
                        .substring(0, 10) +
                    "..."
                : requestBookingDetailsList
                    .bookingDetail.bookingTherapistId.storeName
            : requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.userName.length >
                    10
                ? requestBookingDetailsList
                        .bookingDetail.bookingTherapistId.userName
                        .substring(0, 10) +
                    "..."
                : requestBookingDetailsList
                    .bookingDetail.bookingTherapistId.userName;

    return Card(
      // margin: EdgeInsets.all(8.0),
      elevation: 0.0,
      color: Color.fromRGBO(242, 242, 242, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    requestBookingDetailsList.bookingDetail.bookingTherapistId
                                .uploadProfileImgUrl !=
                            null
                        ? ClipOval(
                            child: CachedNetworkImage(
                                width: 25.0,
                                height: 25.0,
                                fit: BoxFit.cover,
                                imageUrl: requestBookingDetailsList
                                    .bookingDetail
                                    .bookingTherapistId
                                    .uploadProfileImgUrl,
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
                                    )),
                          )
                        : SvgPicture.asset(
                            'assets/images_gps/profile_pic_user.svg',
                            height: 18,
                            width: 18,
                            color: Colors.black),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '$name',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '$nTime 時',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                    ),
                    Text(
                      requestBookingDetailsList.bookingDetail.locationType ==
                              "店舗"
                          ? '店舗'
                          : "出張",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(102, 102, 102, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                Row(
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
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                      width: 8,
                    ),
                    Text(
                      '¥${requestBookingDetailsList.bookingDetail.totalCost}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    requestBookingDetailsList.bookingDetail.travelAmount > 0
                        ? Text(
                            ' (${requestBookingDetailsList.bookingDetail.addedPrice}込み  - ¥${requestBookingDetailsList.bookingDetail.travelAmount}) ',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Color.fromRGBO(102, 102, 102, 1),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(
                  // height: 50,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images_gps/gps.svg",
                      height: 14.77,
                      width: 16.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '施術を受ける場所',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 4.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          '${requestBookingDetailsList.bookingDetail.locationType}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        '${requestBookingDetailsList.bookingDetail.location}',
                        style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildConditionReason(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 12.0,
            bottom: 4.0,
          ),
          child: Text(
            " キャンセルの理由",
            style: TextStyle(fontSize: 14.0),
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
                Text(
                  "${widget.requestBookingDetailsList.bookingDetail.cancellationReason}",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
