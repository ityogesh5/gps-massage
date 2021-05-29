import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/therapistBookingHistoryResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/history/BookingCancelPopup.dart';
import 'package:intl/intl.dart';

class ProviderRequestScreen extends StatefulWidget {
  @override
  _ProviderRequestScreenState createState() => _ProviderRequestScreenState();
}

class _ProviderRequestScreenState extends State<ProviderRequestScreen> {
  List<BookingDetailsList> requestBookingDetailsList =
      List<BookingDetailsList>();
  int status = 0;

  @override
  void initState() {
    super.initState();
    ServiceProviderApi.getBookingRequests().then((value) {
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
        : SingleChildScrollView(
            primary: true,
            child: Container(
              padding: EdgeInsets.all(8.0),
              //  margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "サービス利用者からリクエストのあった予約",
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
          );
  }

  Card buildBookingCard(int index) {
    String jaName = DateFormat('EEEE', 'ja_JP')
        .format(requestBookingDetailsList[index].startTime);
   
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
                      '${requestBookingDetailsList[index].bookingUserId.userName}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(男性)',
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
                      '${requestBookingDetailsList[index].startTime.month}月${requestBookingDetailsList[index].startTime.day}',
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
                      '${requestBookingDetailsList[index].startTime.hour}: ${requestBookingDetailsList[index].startTime.minute} ~ ${requestBookingDetailsList[index].endTime.hour}: ${requestBookingDetailsList[index].endTime.minute}',
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
                  height: 4,
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
                    Text(
                      '${requestBookingDetailsList[index].location}',
                      style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontSize: 17,
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              top: 8.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  print('abc');
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        "assets/images_gps/calendar.svg",
                        height: 18.0,
                        width: 28.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 92.0,
              right: 55.0,
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
            Positioned(
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
            ),
          ],
        ),
      ),
    );
  }

  String getJaDayName(String day) {
    switch (day) {
      case 'Monday':
        return '月曜日';
        break;
      case 'Tuesday':
        return '火曜日';
        break;
      case 'Wednesday':
        return '水曜日';
        break;
      case 'Thursday':
        return '木曜日';
        break;
      case 'Friday':
        return '金曜日';
        break;
      case 'Saturday':
        return '土曜日';
        break;
      case 'Sunday':
        return '日曜日';
        break;
    }
  }
}
