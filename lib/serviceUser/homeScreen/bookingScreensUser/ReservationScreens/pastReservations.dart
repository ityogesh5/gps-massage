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
                            padding: const EdgeInsets.all(5.0),
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
                                          Text(
                                            '1.5km圏内',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Column(
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
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45),
                                            FittedBox(
                                              child: FavoriteButton(
                                                  iconSize: 40,
                                                  iconColor: Colors.red,
                                                  valueChanged: (_isFavorite) {
                                                    print(
                                                        'Is Favorite : $_isFavorite');
                                                  }),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                  padding: EdgeInsets.all(4),
                                                  child: Text('店舗')),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                  child: Text('出張')),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                  child: Text('コロナ対策実施')),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Text('国家資格保有')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/calendar.svg',
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '月曜日出張',
                                      style: TextStyle(color: Colors.grey),
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
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '10:00 ~11:00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '60分',
                                      style: TextStyle(color: Colors.grey),
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
                                        child: Text('足つぼ')),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '¥4,500',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('(交通費込み-¥1,000)')
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      // height: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.filter_alt_outlined),
                                    onPressed: () {
                                      NavigationRouter
                                          .switchToServiceUserRatingsAndReviewScreen(
                                              context);
                                    },
                                  ),
                                ]),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/gps.svg',
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '埼玉県浦和区高砂4丁目4',
                                      style: TextStyle(
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
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Text('オフィス')),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('東京都 墨田区 押上 1-1-2'),
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
