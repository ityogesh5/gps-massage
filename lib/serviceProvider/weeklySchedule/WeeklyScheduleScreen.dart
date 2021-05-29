import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/therapistBookingHistoryResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/history/BookingCancelPopup.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class WeeklySchedule extends StatefulWidget {
  @override
  _WeeklyScheduleState createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> {
  List<BookingDetailsList> requestBookingDetailsList =
      List<BookingDetailsList>();
  int status = 0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int day = 0;
  int month = 0;
  int year = 0;
  DateTime oldStartTime;
  DateTime oldEndTime;

  @override
  void initState() {
    super.initState();
    getConfirmedDetails();
  }

  void getConfirmedDetails() {
    ServiceProviderApi.getWeeklyBookingCardDetails(_pageNumber, _pageSize)
        .then((value) {
      setState(() {
        requestBookingDetailsList.addAll(value.data.bookingDetailsList);
        status = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0.0,
          leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            '一週間のスケジュール',
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'NotoSansJP',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: status == 0
            ? Center(child: CircularProgressIndicator())
            : LazyLoadScrollView(
                isLoading: isLoading,
                onEndOfPage: () => _getMoreData(),
                child: SingleChildScrollView(
                  primary: true,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    //  margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: requestBookingDetailsList.length,
                            itemBuilder: (context, index) {
                              return buildBookingCard(index);
                            }),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Widget buildBookingCard(int index) {
    DateTime startTime = requestBookingDetailsList[index].newStartTime != null
        ? DateTime.parse(requestBookingDetailsList[index].newStartTime)
            .toLocal()
        : requestBookingDetailsList[index].startTime.toLocal();
    DateTime endTime = requestBookingDetailsList[index].newEndTime != null
        ? DateTime.parse(requestBookingDetailsList[index].newEndTime).toLocal()
        : requestBookingDetailsList[index].endTime.toLocal();
    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
    bool dayChange = false;
    bool timeChange = false;

    if (day != startTime.day ||
        month != startTime.month ||
        year != startTime.year) {
      day = startTime.day;
      month = startTime.month;
      year = startTime.year;
      dayChange = true;
    }

    if ((oldStartTime != startTime && oldEndTime != endTime) || (index == 1)) {
      oldStartTime = startTime;
      oldEndTime = endTime;
      timeChange = true;
    }

    return Column(
      children: [
        dayChange
            ? Column(children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Divider(
                          // height: 50,
                          color: Colors.grey,
                        )),
                  ),
                  Text(
                    "$year-$month-$day 月",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Colors.grey,
                          // height: 50,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 10.0,
                ),
              ])
            : Container(),
        timeChange
            ? Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        startTime.hour < 10
                            ? " 0${startTime.hour}"
                            : " ${startTime.hour}",
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
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            : Container(),
        Card(
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
                        Text(
                          '${requestBookingDetailsList[index].bookingUserId.userName}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(${requestBookingDetailsList[index].bookingUserId.gender})',
                          style: TextStyle(
                            fontSize: 12.0,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              requestBookingDetailsList[index].locationType ==
                                      "店舗"
                                  ? '店舗'
                                  : '出張',
                              style: TextStyle(
                                fontSize: 9.0,
                                color: Colors.black,
                              ),
                            )),
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
                          '${startTime.month}月${startTime.day}',
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
                          ' ${requestBookingDetailsList[index].totalMinOfService}分 ',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: EdgeInsets.all(4),
                          child: Text(
                            '${requestBookingDetailsList[index].nameOfService}',
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
                    Row(
                      children: [
                        Expanded(
                          flex: index == 0 ? 2 : 4,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              '${requestBookingDetailsList[index].locationType}',
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
                        Text(
                          '${requestBookingDetailsList[index].location}',
                          style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 92.0,
                  right: 55.0,
                  child: InkWell(
                    onTap: () {
                      requestBookingDetailsList[index].bookingStatus == 0
                          ? NavigationRouter.switchToReceiveBookingScreen(
                              context, requestBookingDetailsList[index])
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: CancelBooking(
                                      requestBookingDetailsList[index]),
                                );
                              });
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: CircleBorder(),
                      margin: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "assets/images_gps/cancel.svg",
                            color: Color.fromRGBO(217, 217, 217, 1),
                            height: 15.0,
                            width: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                requestBookingDetailsList[index].bookingStatus == 6
                    ? Positioned(
                        top: 85.0, //88.0
                        right: 10.0,
                        child: InkWell(
                          onTap: () {
                            ServiceProviderApi.updateBookingCompeted(
                                    requestBookingDetailsList[index])
                                .then((value) {
                              NavigationRouter.switchToServiceProviderBottomBar(
                                  context);
                            });
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: CircleBorder(),
                            margin: EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/images_gps/mark_completed.svg",
                                height: 20.0,
                                width: 20.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                requestBookingDetailsList[index].bookingStatus == 0
                    ? Positioned(
                        top: 92.0,
                        right: 10.0,
                        child: InkWell(
                          onTap: () {
                            NavigationRouter.switchToReceiveBookingScreen(
                                context, requestBookingDetailsList[index]);
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: CircleBorder(),
                            margin: EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/images_gps/accept.svg",
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                requestBookingDetailsList[index].bookingStatus == 1 ||
                        requestBookingDetailsList[index].bookingStatus == 2 ||
                        requestBookingDetailsList[index].bookingStatus == 3
                    ? Positioned(
                        top: 92.0,
                        right: 5.0,
                        child: InkWell(
                          onTap: () {
                            ProgressDialogBuilder.showCommonProgressDialog(
                                context);
                            getChatDetails(requestBookingDetailsList[index]
                                .bookingUserId
                                .firebaseUdid);
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
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _getMoreData() async {
    try {
      if (!isLoading) {
        isLoading = true;
        _pageNumber++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        TherapistBookingHistoryResponseModel
            therapistBookingHistoryResponseModel =
            await ServiceProviderApi.getWeeklyBookingCardDetails(
                _pageNumber, _pageSize);

        if (therapistBookingHistoryResponseModel
            .data.bookingDetailsList.isEmpty) {
          setState(() {
            isLoading = false;
            print(
                'TherapistList data count is Zero : ${therapistBookingHistoryResponseModel.data.bookingDetailsList.length}');
          });
        } else {
          print(
              'TherapistList data Size : ${therapistBookingHistoryResponseModel.data.bookingDetailsList.length}');
          setState(() {
            isLoading = false;
            if (this.mounted) {
              requestBookingDetailsList.addAll(
                  therapistBookingHistoryResponseModel.data.bookingDetailsList);
            }
          });
        }
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
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
}
