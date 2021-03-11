import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class PastReservations extends StatefulWidget {
  @override
  _PastReservationsState createState() => _PastReservationsState();
}

class _PastReservationsState extends State<PastReservations> {
  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
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
                                          SizedBox(
                                            height: 5,
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
                                                backgroundColor: Colors.black26,
                                                child: CircleAvatar(
                                                  maxRadius: 8,
                                                  backgroundColor: Colors.white,
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
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite : $_isFavorite');
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
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
                                                    padding: EdgeInsets.all(4),
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
                                            height: 10,
                                          ),
                                          FittedBox(
                                            child: Row(
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
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Color.fromRGBO(217, 217, 217, 1),
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
                                      '10月17',
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '月曜日出張',
                                      style: TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/clock.svg',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '10:00 ~11:00',
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '60分',
                                      style: TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/cost.svg',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Text(
                                          '足つぼ',
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '¥4,500',
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '(交通費込み-¥1,000)',
                                      style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                    )
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      // height: 50,

                                      color: Color.fromRGBO(217, 217, 217, 1),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigationRouter
                                          .switchToServiceUserRatingsAndReviewScreen(
                                              context);
                                    },
                                    child: CircleAvatar(
                                        maxRadius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(253, 253, 253, 1),
                                        child: SvgPicture.asset(
                                            'assets/images_gps/give_rating.svg',
                                            height: 30,
                                            width: 30)),
                                  ),
                                ]),
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
                                      '施術を受ける場所',
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
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ]),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.grey[200]),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '店舗',
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
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
