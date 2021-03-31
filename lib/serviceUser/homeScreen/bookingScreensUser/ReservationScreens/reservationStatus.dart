import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ReservationStatus extends StatefulWidget {
  @override
  _ReservationStatusState createState() => _ReservationStatusState();
}

class _ReservationStatusState extends State<ReservationStatus> {
  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'セラビストの承認待ちの予約',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.37,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserWaitingForApprovalScreen(context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: new Card(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: SvgPicture.asset(
                                                'assets/images_gps/gpsLogo.svg',
                                                height: 35,
                                                color: Colors.blue,
                                              ),
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                '1.5km圏内',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      153, 153, 153, 1),
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '店舗名',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  child: CircleAvatar(
                                                    maxRadius: 8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/info.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 15,
                                                        width: 15),
                                                  ),
                                                ),
                                                Spacer(),
                                                FavoriteButton(
                                                    iconSize: 40,
                                                    iconColor: Colors.red,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
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
                                                  Container(
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Text(
                                                        '店舗',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '出張',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        'コロナ対策実施',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '(${ratingsValue.toString()})',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 25,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      size: 5,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
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
                                                    '(1518)',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '国家資格保有',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Divider(
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      FittedBox(
                                        child: SvgPicture.asset(
                                            'assets/images_gps/gps.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        '埼玉県浦和区高砂4丁目4',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
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
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white,
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.grey[200]),
                                            child: Text(
                                              'オフィス',
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                          child: Text(
                                        '東京都 墨田区 押上 1-1-2',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(152, 152, 152, 1),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      FittedBox(
                                        child: SvgPicture.asset(
                                            'assets/images_gps/calendar.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 20,
                                            width: 20),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '予約日時：10月17',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      FittedBox(
                                          child: Text(
                                        '10:30~11:30',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'セラピストから追加の要望があった予約',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserConditionsApplyBookingScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: new Card(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: SvgPicture.asset(
                                                'assets/images_gps/gpsLogo.svg',
                                                height: 35,
                                                color: Colors.blue,
                                              ),
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                '1.5km圏内',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      153, 153, 153, 1),
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '店舗名',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  child: CircleAvatar(
                                                    maxRadius: 8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/info.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 15,
                                                        width: 15),
                                                  ),
                                                ),
                                                Spacer(),
                                                FavoriteButton(
                                                    iconSize: 40,
                                                    iconColor: Colors.red,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
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
                                                  Container(
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Text(
                                                        '店舗',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '出張',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        'コロナ対策実施',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '(${ratingsValue.toString()})',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 25,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 5,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
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
                                                  '(1518)',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white,
                                                            ]),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
                                                    child: Text(
                                                      '国家資格保有',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Divider(
                                          // height: 50,

                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToServiceUserChatScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/chat.svg',
                                                // color: Color.fromRGBO(255, 128, 0, 1),
                                                height: 30,
                                                width: 30)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToUserBookingApprovedThirdScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/accept.svg',
                                                height: 30,
                                                width: 30)),
                                      ),
                                    ]),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images_gps/gps.svg',
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '埼玉県浦和区高砂4丁目4',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
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
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white,
                                                    ]),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: Colors.grey[300],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Colors.grey[200]),
                                            child: Text(
                                              'オフィス',
                                              style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '東京都 墨田区 押上 1-1-2',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
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
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '予約日時：10月17',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '10:30~11:30',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'セラビストから承認された予約',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.39,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsApprovedScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: new Card(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: SvgPicture.asset(
                                                'assets/images_gps/gpsLogo.svg',
                                                height: 35,
                                                color: Colors.blue,
                                              ),
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text('1.5km圏内',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '店舗名',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  child: CircleAvatar(
                                                    maxRadius: 8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/info.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 15,
                                                        width: 15),
                                                  ),
                                                ),
                                                Spacer(),
                                                FavoriteButton(
                                                    iconSize: 40,
                                                    iconColor: Colors.red,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
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
                                                  Container(
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Text(
                                                        '店舗',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '出張',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        'コロナ対策実施',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '(${ratingsValue.toString()})',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 25,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 5,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
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
                                                  '(1518)',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white,
                                                            ]),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
                                                    child: Text(
                                                      '国家資格保有',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Divider(
                                          // height: 50,
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToServiceUserChatScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/chat.svg',
                                                // color: Color.fromRGBO(255, 128, 0, 1),
                                                height: 25,
                                                width: 25)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                          maxRadius: 20,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                              'assets/images_gps/pay.svg',
                                              color: Color.fromRGBO(
                                                  255, 193, 7, 1),
                                              height: 25,
                                              width: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToServiceUserBookingCancelScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/cancel.svg',
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1),
                                                height: 20,
                                                width: 20)),
                                      ),
                                    ]),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images_gps/gps.svg',
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '埼玉県浦和区高砂4丁目4',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ]),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: Colors.grey[300],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.grey[200]),
                                          child: Text(
                                            'オフィス',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '東京都 墨田区 押上 1-1-2',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
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
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '予約日時：10月17',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '10:30~11:30',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '確定した予約（支払い完了）',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.39,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsConfirmedScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: new Card(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: SvgPicture.asset(
                                                'assets/images_gps/gpsLogo.svg',
                                                height: 35,
                                                color: Colors.blue,
                                              ),
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                '1.5km圏内',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      153, 153, 153, 1),
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '店舗名',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  child: CircleAvatar(
                                                    maxRadius: 8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/info.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 15,
                                                        width: 15),
                                                  ),
                                                ),
                                                Spacer(),
                                                FavoriteButton(
                                                    iconSize: 40,
                                                    iconColor: Colors.red,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
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
                                                  Container(
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Text(
                                                        '店舗',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '出張',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        'コロナ対策実施',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '(${ratingsValue.toString()})',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 25,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 5,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
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
                                                  '(1518)',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white,
                                                            ]),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
                                                    child: Text(
                                                      '国家資格保有',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Divider(
                                          // height: 50,

                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToServiceUserChatScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/chat.svg',
                                                // color: Color.fromRGBO(255, 128, 0, 1),
                                                height: 25,
                                                width: 25)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationRouter
                                              .switchToServiceUserBookingCancelScreen(
                                                  context);
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                                'assets/images_gps/cancel.svg',
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1),
                                                height: 20,
                                                width: 20)),
                                      ),
                                    ]),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images_gps/gps.svg',
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '埼玉県浦和区高砂4丁目4',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ]),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: Colors.grey[300],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.grey[200]),
                                          child: Text(
                                            'オフィス',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '東京都 墨田区 押上 1-1-2',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
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
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '予約日時：10月17',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '10:30~11:30',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'キャンセルされた予約',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsCompletedScreen(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: new Card(
                            color: Colors.grey[200],
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              child: SvgPicture.asset(
                                                'assets/images_gps/gpsLogo.svg',
                                                height: 35,
                                                color: Colors.blue,
                                              ),
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                '1.5km圏内',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      153, 153, 153, 1),
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '店舗名',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  child: CircleAvatar(
                                                    maxRadius: 8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: SvgPicture.asset(
                                                        'assets/images_gps/info.svg',
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        height: 15,
                                                        width: 15),
                                                  ),
                                                ),
                                                Spacer(),
                                                FavoriteButton(
                                                    iconSize: 40,
                                                    iconColor: Colors.red,
                                                    valueChanged:
                                                        (_isFavorite) {
                                                      print(
                                                          'Is Favorite : $_isFavorite');
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
                                                  Container(
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Text(
                                                        '店舗',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        '出張',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
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
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Colors.grey[200]),
                                                      child: Text(
                                                        'コロナ対策実施',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '(${ratingsValue.toString()})',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 5,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
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
                                                  '(1518)',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white,
                                                            ]),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color:
                                                            Colors.grey[200]),
                                                    child: Text(
                                                      '国家資格保有',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images_gps/gps.svg',
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '埼玉県浦和区高砂4丁目4',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ]),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: Colors.grey[300],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.grey[200]),
                                          child: Text(
                                            'オフィス',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '東京都 墨田区 押上 1-1-2',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
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
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          height: 20,
                                          width: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '予約日時：10月17',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '10:30~11:30',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
