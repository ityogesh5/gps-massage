import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/notification/firebaseNotificationUserListModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';

class TherapistAcceptNotification extends StatefulWidget {
  final NotificationList requestBookingDetailsList;

  TherapistAcceptNotification(this.requestBookingDetailsList);

  @override
  _TherapistAcceptNotificationState createState() =>
      _TherapistAcceptNotificationState();
}

class _TherapistAcceptNotificationState
    extends State<TherapistAcceptNotification> {
  int _state = 0;
  bool isPriceAdded = false;
  bool isDateChanged = false;
  bool isOtherSelected = false;
  final _cancelReasonController = new TextEditingController();
  bool isCancelSelected = false;
  ScrollController scrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> _formData = {
    'text': null,
    'category': null,
    'date': null,
    'time': null,
  };
  var selectedBuildingType;

  @override
  void initState() {
    super.initState();
    ServiceProviderApi.updateNotificationStatus(
        widget.requestBookingDetailsList.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 0 && isCancelSelected) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _state = 1;
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
    return Scaffold(
      key: _scaffoldKey,
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
        controller: scrollController,
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
                widget.requestBookingDetailsList.bookingStatus == 1
                    ? "セラピストがご予約を承認しました。"
                    : 'セラピストからリクエストがありました。',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              buildBookingCard(widget.requestBookingDetailsList),
              SizedBox(
                height: 6.0,
              ),
              widget.requestBookingDetailsList.bookingStatus == 2
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '  リクエストの詳細',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: widget.requestBookingDetailsList.bookingStatus == 2
                    ? 6.0
                    : 0.0,
              ),
              widget.requestBookingDetailsList.bookingStatus == 2
                  ? buildConditionAppliedDetails(
                      context, widget.requestBookingDetailsList)
                  : Container(),
              SizedBox(
                height: 18.0,
              ),
              widget.requestBookingDetailsList.bookingStatus ==
                      widget
                          .requestBookingDetailsList.bookingDetail.bookingStatus
                  ? buildButtons(context)
                  : Container(),
              SizedBox(height: 15),
              Visibility(
                  visible: isCancelSelected,
                  child: massageBuildTypeDisplayContent())
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.35,
            child: CustomToggleButton(
              elevation: 0,
              height: 55.0,
              width: MediaQuery.of(context).size.width * 0.40,
              autoWidth: false,
              buttonColor: Color.fromRGBO(217, 217, 217, 1),
              enableShape: true,
              customShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.transparent)),
              buttonLables: ["キャンセルする", "支払に進む"],
              fontSize: 16.0,
              buttonValues: [
                "Y",
                "N",
              ],
              radioButtonValue: (value) {
                if (value == 'Y') {
                  setState(() {
                    isCancelSelected = !isCancelSelected;
                  });
                } else {
                  setState(() {
                    isCancelSelected = false;
                  });
                  HealingMatchConstants.bookingIdPay =
                      widget.requestBookingDetailsList.bookingDetail.id;
                  HealingMatchConstants.therapistIdPay = widget
                      .requestBookingDetailsList.bookingDetail.therapistId;
                  HealingMatchConstants.confServiceCost =
                      widget.requestBookingDetailsList.bookingDetail.totalCost;
                  print('bookingId: ${HealingMatchConstants.bookingIdPay}');
                  HealingMatchConstants.initiatePayment(context);
                }
                print('Radio value : $isCancelSelected');
              },
              selectedColor: Color.fromRGBO(200, 217, 33, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookingCard(NotificationList requestBookingDetailsList) {
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

    return Stack(
      children: [
        Card(
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
                        requestBookingDetailsList.bookingDetail
                                    .bookingTherapistId.uploadProfileImgUrl !=
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
                                    errorWidget: (context, url, error) =>
                                        Column(
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
                          requestBookingDetailsList
                                      .bookingDetail.locationType ==
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
                          width: 8,
                        ),
                        Text(
                          '¥${requestBookingDetailsList.bookingDetail.priceOfService + requestBookingDetailsList.bookingDetail.travelAmount}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        requestBookingDetailsList.bookingDetail.travelAmount > 0
                            ? Flexible(
                                child: Text(
                                  ' (${requestBookingDetailsList.bookingDetail.addedPrice}込み- ￥ ${requestBookingDetailsList.bookingDetail.travelAmount}) ',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                  ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
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
        ),
        Positioned(
          top: 140.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              ProgressDialogBuilder.showCommonProgressDialog(context);
              getChatDetails(requestBookingDetailsList
                  .bookingDetail.bookingTherapistId.firebaseUdid);
            },
            child: Card(
              elevation: 4.0,
              shape: CircleBorder(),
              margin: EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  "assets/images_gps/providerChat.svg",
                  height: 15.0,
                  width: 15.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildConditionAppliedDetails(
      BuildContext context, NotificationList requestBookingDetailsList) {
    bool isDateChanged = false;
    bool isPriceAdded = false;
    String sTime = DateFormat('kk:mm')
        .format(requestBookingDetailsList.bookingDetail.startTime.toLocal());
    String eTime = DateFormat('kk:mm')
        .format(requestBookingDetailsList.bookingDetail.endTime.toLocal());
    String nSTime;
    String nEndTime;

    if (requestBookingDetailsList.bookingDetail.newStartTime != null) {
      isDateChanged = true;
      nSTime = DateFormat('kk:mm').format(
          requestBookingDetailsList.bookingDetail.newStartTime.toLocal());
      nEndTime = DateFormat('kk:mm')
          .format(requestBookingDetailsList.bookingDetail.newEndTime.toLocal());
    }

    if (requestBookingDetailsList.bookingDetail.travelAmount != 0) {
      isPriceAdded = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
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
                            requestBookingDetailsList
                                        .bookingDetail.addedPrice !=
                                    null
                                ? "${requestBookingDetailsList.bookingDetail.addedPrice}  "
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
                                "¥${requestBookingDetailsList.bookingDetail.priceOfService}  ",
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
                            "¥${requestBookingDetailsList.bookingDetail.priceOfService}",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "¥${requestBookingDetailsList.bookingDetail.travelAmount}",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "¥${requestBookingDetailsList.bookingDetail.priceOfService + requestBookingDetailsList.bookingDetail.travelAmount}",
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

  Widget massageBuildTypeDisplayContent() {
    bool newChoosenVal = false;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: new Text(
              'キャンセルする理由を選択してください',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: 'NotoSansJP'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: BuildingCategories.initial()
                .categories
                .map((BuildingCategory category) {
              final bool selected =
                  _formData['category']?.name == category.name;
              return Container(
                height: 40.0,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.all(0.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 7.0),
                    child: Align(
                      //alignment: Alignment(-1.2, 0),
                      alignment: Alignment.topLeft,
                      child: new Text('${category.name}',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'NotoSansJP')),
                    ),
                  ),
                  leading: CustomRadioButton(
                      color: Colors.black,
                      selected: selected,
                      onChange: (newVal) {
                        newChoosenVal = newVal;
                        _handleCategoryChange(newChoosenVal, category);
                        if (category.name.contains('その他')) {
                          print(
                              'SELECTED VALUE IF ON CHANGE : ${category.name}');

                          setState(() {
                            isOtherSelected = true;
                          });
                        } else {
                          _handleCategoryChange(true, category);
                          print(
                              'SELECTED VALUE ELSE ON CHANGE : ${category.name}');
                          setState(() {
                            isOtherSelected = false;
                          });
                        }
                      }),
                  onTap: () {
                    _handleCategoryChange(true, category);
                    if (category.name.contains('その他')) {
                      print('SELECTED VALUE IF ON TAP : ${category.name}');
                      setState(() {
                        isOtherSelected = true;
                      });
                    } else {
                      _handleCategoryChange(true, category);
                      print('SELECTED VALUE ELSE ON TAP : ${category.name}');
                      setState(() {
                        isOtherSelected = false;
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
          Visibility(
            visible: isOtherSelected,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: TextField(
                        controller: _cancelReasonController,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        decoration: new InputDecoration(
                            filled: false,
                            fillColor: Colors.white,
                            hintText: 'キャシセルする理由を記入ください',
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    ),
                    /*  Positioned(
                      top: 95,
                      left: 300,
                      right: 10,
                      bottom: 5,
                      child: CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Colors.grey[300],
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 20.0,
                          child: IconButton(
                            icon: Icon(Icons.send, color: Colors.lime),
                            iconSize: 25.0,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            child: RaisedButton(
              child: Text(
                'キャンセルする',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.red,
              onPressed: () {
                cancelBooking();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  cancelBooking() {
    String otherCategory = _cancelReasonController.text;
    String cancelReason =
        selectedBuildingType == "その他" ? otherCategory : selectedBuildingType;
    if ((cancelReason == null || cancelReason == '') &&
        selectedBuildingType == "その他") {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセルの理由を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (cancelReason == null || cancelReason == '') {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセルの理由を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    try {
      ServiceUserAPIProvider.removeEvent(
              widget.requestBookingDetailsList.bookingDetail.eventId, context)
          .then((value) {
        if (value) {
          ServiceUserAPIProvider.updateBookingCompeted(
              widget.requestBookingDetailsList.bookingDetail.id, cancelReason);
        }
      });
      var cancelBooking = DialogHelper.showUserBookingCancelDialog(context);
    } catch (e) {
      print('cancelException : ${e.toString()}');
    }
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

  void _handleCategoryChange(bool newVal, BuildingCategory category) {
    setState(() {
      if (newVal) {
        _formData['category'] = category;
        selectedBuildingType = category.name;
        print('Chosen value : $newVal : name : $selectedBuildingType');
      } else {
        _formData['category'] = null;
      }
    });
  }
}

class BuildingCategory {
  final String name;

  BuildingCategory({this.name});
}

class BuildingCategories {
  final List<BuildingCategory> categories;

  BuildingCategories(this.categories);

  factory BuildingCategories.initial() {
    return BuildingCategories(
      <BuildingCategory>[
        BuildingCategory(name: '都合が悪くなったため'),
        BuildingCategory(name: '提案のあった追加料金が高かったため'),
        BuildingCategory(name: '提案のあった時間は都合が悪いため'),
        BuildingCategory(name: 'その他'),
      ],
    );
  }
}
