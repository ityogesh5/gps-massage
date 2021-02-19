import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

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
            children: [
              Text(
                'セラビストの承認待ちの予約',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.95,
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
                                          Text('1.5km圏内'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                          height: 5,
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
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ratingsValue.toString(),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '予約日時：10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('10:30~11:30')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'セラピストから追加の要望があった予約',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.95,
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
                                          Text('1.5km圏内'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                          height: 5,
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
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ratingsValue.toString(),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      // height: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.cancel_rounded),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                      ),
                                      onPressed: () {})
                                ]),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '予約日時：10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('10:30~11:30')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'セラビストから承認された予約',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.95,
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
                                          Text('1.5km圏内'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                          height: 5,
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
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ratingsValue.toString(),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      // height: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.cancel_rounded),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(
                                        Icons.chat_bubble_outline,
                                      ),
                                      onPressed: () {}),
                                ]),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '予約日時：10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('10:30~11:30')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '確定した予約（支払い完了）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.95,
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
                                          Text('1.5km圏内'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                          height: 5,
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
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ratingsValue.toString(),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      // height: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.chat_outlined),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(
                                        Icons.cancel_rounded,
                                      ),
                                      onPressed: () {})
                                ]),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '予約日時：10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('10:30~11:30')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'キャンセルされた予約',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.95,
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
                                          Text('1.5km圏内'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
                                          height: 5,
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
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ratingsValue.toString(),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 5,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                                setState(() {
                                                  ratingsValue = rating;
                                                });
                                                print(ratingsValue);
                                              },
                                            ),
                                            Text('(1518)'),
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
                                Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '予約日時：10月17',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('10:30~11:30')
                                  ],
                                )
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
