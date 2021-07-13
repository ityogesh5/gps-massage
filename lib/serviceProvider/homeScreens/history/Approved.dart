import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/therapistBookingHistoryResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProviderApprovedScreen extends StatefulWidget {
  @override
  _ProviderApprovedScreenState createState() => _ProviderApprovedScreenState();
}

class _ProviderApprovedScreenState extends State<ProviderApprovedScreen> {
  List<BookingDetailsList> requestBookingDetailsList =
      List<BookingDetailsList>();
  int status = 0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;

  @override
  void initState() {
    super.initState();
    ServiceProviderApi.getBookingApprovedDetails(_pageNumber, _pageSize)
        .then((value) {
      setState(() {
        requestBookingDetailsList.addAll(value.data.bookingDetailsList);
        status = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Center(child: CircularProgressIndicator())
        : requestBookingDetailsList.length > 0
            ? LazyLoadScrollView(
                isLoading: isLoading,
                onEndOfPage: () => _getMoreData(),
                child: SingleChildScrollView(
                  primary: true,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    //  margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "サービス利用者からのリクエストにすでに回答した予約",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontSize: 12.0,
                              fontFamily: 'NotoSansJP',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          border: Border.all(
                              color: Color.fromRGBO(217, 217, 217, 1)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: new Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
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
                                        '利用者の支払い待ちの予約リクエストはありません。',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold),
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
              );
  }

  Card buildBookingCard(int index) {
    DateTime startTime = requestBookingDetailsList[index].newStartTime != null
        ? DateTime.parse(requestBookingDetailsList[index].newStartTime)
            .toLocal()
        : requestBookingDetailsList[index].startTime.toLocal();
    DateTime endTime = requestBookingDetailsList[index].newEndTime != null
        ? DateTime.parse(requestBookingDetailsList[index].newEndTime).toLocal()
        : requestBookingDetailsList[index].endTime.toLocal();
    String jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
    String dateFormat = DateFormat('MM月dd').format(startTime);

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
                    Text(
                      requestBookingDetailsList[index]
                                  .bookingUserId
                                  .userName
                                  .length >
                              10
                          ? requestBookingDetailsList[index]
                                  .bookingUserId
                                  .userName
                                  .substring(0, 9) +
                              "..."
                          : '${requestBookingDetailsList[index].bookingUserId.userName}',
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.all(4),
                        child: Text(
                          requestBookingDetailsList[index].locationType == "店舗"
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
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                      flex: 4,
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
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                    Flexible(
                      child: Text(
                        '${requestBookingDetailsList[index].location}',
                        style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              top: 88.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  ProgressDialogBuilder.showCommonProgressDialog(context);
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
            ),
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

  _getMoreData() async {
    try {
      if (!isLoading) {
        isLoading = true;
        _pageNumber++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        TherapistBookingHistoryResponseModel
            therapistBookingHistoryResponseModel =
            await ServiceProviderApi.getBookingApprovedDetails(
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
}
