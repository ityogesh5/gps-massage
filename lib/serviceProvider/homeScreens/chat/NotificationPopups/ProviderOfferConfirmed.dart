import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/firebaseNotificationTherapistListModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';

class ProviderOfferConfirmed extends StatefulWidget {
  final NotificationList requestBookingDetailsList;

  ProviderOfferConfirmed(this.requestBookingDetailsList);

  @override
  _ProviderOfferConfirmedState createState() => _ProviderOfferConfirmedState();
}

class _ProviderOfferConfirmedState extends State<ProviderOfferConfirmed> {
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
                      'assets/images_gps/booking_confirmed.svg',
                      height: 45,
                      width: 45,
                      /*   color: Color.fromRGBO(255, 0, 0, 1) */
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                '利用者が支払いを完了し、予約が確定しました。',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              buildBookingCard(widget.requestBookingDetailsList),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '"支払い金額"',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '"¥${widget.requestBookingDetailsList.bookingDetail.totalCost}"',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
        requestBookingDetailsList.bookingDetail.bookingUserId.userName.length >
                10
            ? requestBookingDetailsList.bookingDetail.bookingUserId.userName
                    .substring(0, 10) +
                "..."
            : requestBookingDetailsList.bookingDetail.bookingUserId.userName;

    return Card(
      // margin: EdgeInsets.all(8.0),
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
                    requestBookingDetailsList.bookingDetail.bookingUserId
                                .uploadProfileImgUrl !=
                            null
                        ? ClipOval(
                            child: CachedNetworkImage(
                                width: 25.0,
                                height: 25.0,
                                fit: BoxFit.cover,
                                imageUrl: requestBookingDetailsList
                                    .bookingDetail
                                    .bookingUserId
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
                      '$name さん',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(${requestBookingDetailsList.bookingDetail.bookingUserId.gender})',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color.fromRGBO(181, 181, 181, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
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
                        requestBookingDetailsList.bookingDetail.locationType ==
                                "店舗"
                            ? '店舗'
                            : "出張",
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.black,
                        ),
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
                InkWell(
                  onTap: () {
                    HealingMatchConstants.serviceUserName = widget
                        .requestBookingDetailsList
                        .bookingDetail
                        .bookingUserId
                        .userName;
                    NavigationRouter.switchToProviderSideUserReviewScreen(
                        context,
                        requestBookingDetailsList
                            .bookingDetail.bookingUserId.id);
                  },
                  child: Row(
                    children: [
                      Text(
                        requestBookingDetailsList.reviewAvgData != null
                            ? '(${requestBookingDetailsList.reviewAvgData})'
                            : (0.0),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -3))
                            ],
                            fontSize: 14,
                            color: Colors.transparent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5.0),
                      RatingBar.builder(
                        initialRating: double.parse(
                            requestBookingDetailsList.reviewAvgData),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 24.0,
                        itemPadding: new EdgeInsets.only(bottom: 3.0),
                        itemBuilder: (context, index) => new SizedBox(
                            height: 20.0,
                            width: 18.0,
                            child: new IconButton(
                              onPressed: () {},
                              padding: new EdgeInsets.all(0.0),
                              // color: Colors.white,
                              icon: index >
                                      (double.parse(requestBookingDetailsList
                                                  .reviewAvgData))
                                              .ceilToDouble() -
                                          1
                                  ? SvgPicture.asset(
                                      "assets/images_gps/star_2.svg",
                                      height: 13.0,
                                      width: 13.0,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images_gps/star_colour.svg",
                                      height: 13.0,
                                      width: 13.0,
                                      //color: Colors.black,
                                    ),
                            )),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        '(  ${requestBookingDetailsList.noOfReviewsMembers} レビュー)',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -3))
                            ],
                            fontSize: 14,
                            color: Colors.transparent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                    )
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
}
