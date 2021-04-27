import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          'おすすめ',
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            NavigationRouter
                .switchToServiceUserBookingDetailsCompletedScreenOne(context);
          },
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  height: 152,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: WidgetAnimator(new Card(
                      elevation: 0.0,
                      color: Color.fromRGBO(242, 242, 242, 1),
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      'assets/images_gps/placeholder_image.png',
                                      height: 70,
                                      color: Colors.black,
                                      fit: BoxFit.cover,
                                    ),
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      '1.5km園内',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(153, 153, 153, 1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '店舗名',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
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
                                              '出張',
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
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
                                              'コロナ対策実施',
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 1),
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
                                        ratingsValue.toString(),
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          size: 5,
                                          color: Color.fromRGBO(255, 217, 0, 1),
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
                                          color: Color.fromRGBO(153, 153, 153, 1),
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
                                            '国家資格保有',
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          )),
                                      Spacer(),
                                      Text(
                                        '¥4,500',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 19),
                                      ),
                                      Text(
                                        '/60分',
                                        style: TextStyle(
                                          color: Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
