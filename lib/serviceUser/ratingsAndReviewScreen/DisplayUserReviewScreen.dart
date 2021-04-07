import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayUserReview extends StatefulWidget {
  @override
  _DisplayUserReviewState createState() => _DisplayUserReviewState();
}

class _DisplayUserReviewState extends State<DisplayUserReview> {
  List<UserList> ratingListValues = List();
  UserReviewListById ratingListResponseModel;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;
  int status = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _providerRatingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          '評価とレビュー',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'NotoSansJP'),
        ),
        centerTitle: true,
      ),
      body: status == 0
          ? buildLoading()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '店舗についてのレビュー',
                                style: TextStyle(
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(${ratingListResponseModel.userData.totalElements})",
                                style: TextStyle(
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 12,
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        /*   Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(242, 242, 242, 1),
                              Color.fromRGBO(242, 242, 242, 1),
                            ]),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white54),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    unratedColor: Colors.grey[200],
                                    glow: true,
                                    glowColor: Colors.lime,
                                    glowRadius: 2,
                                    initialRating: ratingListValues[0]
                                        .ratingsCount
                                        .toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${ratingListValues[0].ratingsCount.toDouble()}",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    "${ratingListValues[0].reviewComment}",
                                    style: TextStyle(
                                        fontFamily: 'NotoSansJP',
                                        fontSize: 14,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),*/
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ratingListValues.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${ratingListValues[index].userName}",
                                          style: TextStyle(
                                              fontFamily: 'NotoSansJP',
                                              fontSize: 14,
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " ${DateFormat("MM月dd").format(ratingListValues[index].createdAt).toString()}",
                                          style: TextStyle(
                                              fontFamily: 'NotoSansJP',
                                              fontSize: 12,
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        unratedColor: Colors.grey[200],
                                        glow: true,
                                        glowColor: Colors.lime,
                                        ignoreGestures: true,
                                        glowRadius: 2,
                                        initialRating: ratingListValues[index]
                                            .ratingsCount
                                            .toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          size: 5,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                          setState(() {
                                            ratingsValue =
                                                ratingListValues[index]
                                                    .ratingsCount
                                                    .toDouble();
                                          });
                                          print(ratingsValue);
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '(${ratingListValues[index].ratingsCount.toDouble()})',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${ratingListValues[index].reviewComment}",
                                            style: TextStyle(
                                                fontFamily: 'NotoSansJP',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                        child: Divider(
                                            color: Colors.grey[300],
                                            height: 1)),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SpinKitPulse(color: Colors.lime),
            //buildLoadingIndicator()
          ],
        ),
      ),
    );
  }

  _providerRatingList() async {
    try {
      // ProgressDialogBuilder.showCommonProgressDialog(context);
      final url = HealingMatchConstants.RATING_PROVIDER_LIST_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": "4",
          }));
      print(response.body);
      if (response.statusCode == 200) {
        ratingListResponseModel =
            UserReviewListById.fromJson(json.decode(response.body));
        setState(() {
          ratingListValues = ratingListResponseModel.userData.userList;
          status = 1;
        });

        /* for (var ratingList in ratingListResponseModel.userData.userList) {
          ratingListValues.add(ratingList.ratingsCount);
        }*/
        // ProgressDialogBuilder.hideCommonProgressDialog(context);
      }

      print('Status code : ${response.statusCode}');
    } catch (e) {
      // ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }
}
