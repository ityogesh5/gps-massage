import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class BookingApproveThirdScreen extends StatefulWidget {
  final int therapistId;
  BookingApproveThirdScreen(this.therapistId);
  @override
  State createState() {
    return _BookingApproveThirdScreenState();
  }
}

class _BookingApproveThirdScreenState extends State<BookingApproveThirdScreen> {
  TherapistByIdModel therapistDetails;
  int status = 0;
  bool isPriceAdded = false;
  bool isDateChanged = false;
  bool isOtherSelected = false;
  final _cancelReasonController = new TextEditingController();
  Map<String, dynamic> _formData = {
    'text': null,
    'category': null,
    'date': null,
    'time': null,
  };
  var selectedBuildingType;
  bool isCancelSelected = false;
  ScrollController scrollController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _state = 0;

  @override
  void initState() {
    super.initState();
    getProviderInfo();
  }

  getProviderInfo() async {
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      therapistDetails = await ServiceUserAPIProvider.getTherapistDetails(
          context, widget.therapistId);
      HealingMatchConstants.therapistProfileDetails = therapistDetails;
      //append all Service Types for General View

      setState(() {
        status = 1;
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Therapist details fetch Exception : ${e.toString()}');
    }
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
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: status == 0
          ? SpinKitThreeBounce(color: Colors.lime)
          : buildBodyCard(),
    );
  }

  buildBodyCard() {
    DateTime startTime = HealingMatchConstants
        .therapistProfileDetails.bookingDataResponse[0].startTime
        .toLocal();
    DateTime endTime = HealingMatchConstants
        .therapistProfileDetails.bookingDataResponse[0].endTime
        .toLocal();
    String date = DateFormat('MM月d').format(startTime);
    String sTime = DateFormat('kk:mm').format(startTime);
    String eTime = DateFormat('kk:mm').format(endTime);
    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
    String nSTime;
    String nEndTime;
    if (HealingMatchConstants
            .therapistProfileDetails.bookingDataResponse[0].newStartTime !=
        null) {
      isDateChanged = true;
      nSTime = DateFormat('kk:mm').format(DateTime.parse(HealingMatchConstants
              .therapistProfileDetails.bookingDataResponse[0].newStartTime)
          .toLocal());
      nEndTime = DateFormat('kk:mm').format(DateTime.parse(HealingMatchConstants
              .therapistProfileDetails.bookingDataResponse[0].newEndTime)
          .toLocal());
    }
    if (HealingMatchConstants
            .therapistProfileDetails.bookingDataResponse[0].travelAmount !=
        0) {
      isPriceAdded = true;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DottedBorder(
                      dashPattern: [2, 2],
                      strokeWidth: 1,
                      color: Color.fromRGBO(232, 232, 232, 1),
                      strokeCap: StrokeCap.round,
                      borderType: BorderType.Circle,
                      radius: Radius.circular(5),
                      child: CircleAvatar(
                        maxRadius: 55,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        child: SvgPicture.asset(
                            'assets/images_gps/calendar.svg',
                            height: 45,
                            width: 45,
                            color: Colors.lime),
                      )),
                  SizedBox(height: 10),
                  Text(
                    'セラピストからリクエストがありました。',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'NotoSansJP'),
                  ),
                  SizedBox(height: 10),
                  buildBookingDetails(context),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Text(
                'リクエストの詳細',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 7),
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
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                HealingMatchConstants
                                            .therapistProfileDetails
                                            .bookingDataResponse[0]
                                            .addedPrice !=
                                        null
                                    ? "${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].addedPrice}  "
                                    : '交通費',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "合計",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
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
                                    '¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].priceOfService} ',
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
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].priceOfService}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].travelAmount}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].priceOfService + HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].travelAmount}",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
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
            SizedBox(height: 15),
            Padding(
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
                            isCancelSelected = !isCancelSelected;
                          });
                          HealingMatchConstants.initiatePayment(context);
                        }
                        print('Radio value : $isCancelSelected');
                      },
                      selectedColor: Color.fromRGBO(200, 217, 33, 1),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Visibility(
                visible: isCancelSelected,
                child: massageBuildTypeDisplayContent())
          ],
        ),
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

  Widget massageBuildTypeDisplayContent() {
    bool newChoosenVal = false;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Text(
            'キャンセルする理由を選択してください',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                fontFamily: 'NotoSansJP'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: BuildingCategories.initial()
                .categories
                .map((BuildingCategory category) {
              final bool selected =
                  _formData['category']?.name == category.name;
              return ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: new Text('${category.name}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'NotoSansJP')),
                    ),
                  ],
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomRadioButton(
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
                ),
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
    if ((selectedBuildingType == "その他") &&
        (otherCategory == null || otherCategory == '')) {
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
    if ((selectedBuildingType == "その他") && (otherCategory.length > 125)) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセル理由を125以内で入力してください。',
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
              HealingMatchConstants
                  .therapistProfileDetails.bookingDataResponse[0].eventId,
              context)
          .then((value) {
        if (value) {
          ServiceUserAPIProvider.updateBookingCompeted(
              HealingMatchConstants
                  .therapistProfileDetails.bookingDataResponse[0].id,
              selectedBuildingType);
          DialogHelper.showUserBookingCancelDialog(context);
        }
      });
    } catch (e) {
      print('cancelException : ${e.toString()}');
    }
  }

  buildBookingDetails(BuildContext context) {
    DateTime startTime = HealingMatchConstants
        .therapistProfileDetails.bookingDataResponse[0].startTime
        .toLocal();
    DateTime endTime = HealingMatchConstants
        .therapistProfileDetails.bookingDataResponse[0].endTime
        .toLocal();
    String date = DateFormat('MM月d').format(startTime);

    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 92.0,
                bottom: 12,
                right: 5.0,
                child: InkWell(
                  onTap: () {
                    ProgressDialogBuilder.showCommonProgressDialog(context);
                    getChatDetails(HealingMatchConstants
                        .therapistProfileDetails.data.firebaseUdid);
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HealingMatchConstants.therapistProfileDetails.data
                                    .uploadProfileImgUrl !=
                                null
                            ? CachedNetworkImage(
                                imageUrl: HealingMatchConstants
                                    .therapistProfileDetails
                                    .data
                                    .uploadProfileImgUrl,
                                filterQuality: FilterQuality.high,
                                fadeInCurve: Curves.easeInSine,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 25.0,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    SpinKitDoubleBounce(
                                        color: Colors.lightGreenAccent),
                                errorWidget: (context, url, error) => Container(
                                  width: 25.0,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black12),
                                    image: DecorationImage(
                                        image: new AssetImage(
                                            'assets/images_gps/placeholder_image.png'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: Image.asset(
                                  'assets/images_gps/placeholder_image.png',
                                  height: 25,
                                  color: Colors.black,
                                  fit: BoxFit.cover,
                                ),
                                radius: 35,
                                backgroundColor: Colors.white,
                              ),
                        SizedBox(
                          width: 8,
                        ),
                        HealingMatchConstants.therapistProfileDetails.data
                                        .storeName !=
                                    "" &&
                                HealingMatchConstants.therapistProfileDetails
                                        .data.storeName !=
                                    null
                            ? Text(
                                '${HealingMatchConstants.therapistProfileDetails.data.storeName}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansJP'),
                              )
                            : Text(
                                '${HealingMatchConstants.therapistProfileDetails.data.userName}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansJP'),
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
                              ' ${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].nameOfService} ',
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
                          "¥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].priceOfService + HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].travelAmount}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        HealingMatchConstants.therapistProfileDetails
                                    .bookingDataResponse[0].travelAmount >
                                0
                            ? Flexible(
                                child: Text(
                                  "(${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].addedPrice}込み- ￥${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].travelAmount})",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Divider(
                            // height: 50,
                            color: Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                        Expanded(
                          child: Text(''),
                        )
                      ],
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
                              '${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].locationType}',
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
                            '${HealingMatchConstants.therapistProfileDetails.bookingDataResponse[0].location} ',
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
            ],
          ),
        ),
      ],
    );
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
