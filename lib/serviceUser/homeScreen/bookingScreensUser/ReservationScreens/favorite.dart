import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  double ratingsValue = 3.0;

  @override
  void initState() {
    super.initState();
    Loader.show(context, progressIndicator: SpinKitThreeBounce(color: Colors.lime));
    Future.delayed(Duration(seconds: 2), () {
      Loader.hide();
    });
  }

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
                //height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width * 0.95,
                child: GestureDetector(
                  onTap: () {
                    NavigationRouter
                        .switchToServiceUserBookingDetailsCompletedScreenOne(
                            context);
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.30,
                          height: 190,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: WidgetAnimator(
                            new Card(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: SvgPicture.asset(
                                                  'assets/images_gps/gpsLogo.svg',
                                                  height: 40,
                                                  color: Colors.blue,
                                                ),
                                                radius: 40,
                                                backgroundColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 3,
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
                                                  SizedBox(width: 4),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.white,
                                                              Colors.white
                                                            ]),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          "assets/images_gps/info.svg",
                                                          height: 15.0,
                                                          width: 15.0,
                                                          // key: key,
                                                          color: Colors.black,
                                                        ), /* Icon(
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          key: key,
                                                          color: Colors.black ), */
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  /* FittedBox(
                                                    child: FavoriteButton(
                                                        iconSize: 40,
                                                        iconColor: Colors.red,
                                                        valueChanged:
                                                            (_isFavorite) {
                                                          print(
                                                              'Is Favorite : $_isFavorite');
                                                        }),
                                                  ),*/
                                                  SvgPicture.asset(
                                                      'assets/images_gps/recommendedHeart.svg',
                                                      width: 25,
                                                      height: 25),
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
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                      Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Text(
                                                          '店舗',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          '出張',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .white,
                                                                    ]),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .grey[200]),
                                                        child: Text(
                                                          'コロナ対策実施',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
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
                                                      "  (${ratingsValue.toString()})",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            153, 153, 153, 1),
                                                        /* decoration: TextDecoration
                                                            .underline,*/
                                                      ),
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: 3,
                                                      minRating: 1,
                                                      ignoreGestures: true,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        size: 5,
                                                        color: Color.fromRGBO(
                                                            255, 217, 0, 1),
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
                                              Row(
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images_gps/gps.svg',
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              height: 20,
                                              width: 20),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            '埼玉県浦和区高砂4丁目4',
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Text(
                                            '１.５ｋｍ圏内',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  153, 153, 153, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
