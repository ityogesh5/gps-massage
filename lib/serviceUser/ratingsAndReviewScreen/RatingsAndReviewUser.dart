import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

class RatingsAndReviewUser extends StatefulWidget {
  @override
  _RatingsAndReviewUserState createState() => _RatingsAndReviewUserState();
}

class _RatingsAndReviewUserState extends State<RatingsAndReviewUser> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;
  String rUserID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          '評価とレビュー',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'NotoSansJP'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Column(
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
                      '（052レビュー）',
                      style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 12,
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Text(
                      'セラピストを5段階で評価してください',
                      style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 12,
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white]),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Color.fromRGBO(200, 217, 33, 1),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                    child: Divider(
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                        height: 1)),
                              ),
                              SizedBox(height: 2),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: TextField(
                                    controller: reviewController,
                                    scrollController: _scroll,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 8,
                                    autofocus: false,
                                    focusNode: _focus,
                                    decoration: new InputDecoration(
                                      filled: false,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      hintText: '良かった点、気づいた点などをご記入ください',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontFamily: 'NotoSansJP',
                                          fontSize: 14),
                                      focusColor: Colors.grey[100],
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Color.fromRGBO(216, 216, 216, 1),
                                child: CircleAvatar(
                                  radius: 25.0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Color.fromRGBO(200, 217, 33, 1),
                                    ),
                                    iconSize: 25.0,
                                    onPressed: () {
                                      // _ratingAndReview();
                                      /* NavigationRouter.switchToServiceUserDisplayReviewScreen(context);*/
                                    },
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  'レビューをした隙に名前、施術日時の詳細がセラビストに知られることはありません',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      fontSize: 12,
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return new Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'お名前',
                                style: TextStyle(
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '10月７',
                                style: TextStyle(
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 10,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              unratedColor: Colors.grey[200],
                              glow: true,
                              glowColor: Colors.lime,
                              glowRadius: 2,
                              initialRating: 3,
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
                              ratingsValue.toString(),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(153, 153, 153, 1),
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
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                                  "when an unknown printer took a galley of type and scrambled it to make a type specimen book when an unknown printer took a galley of type and scrambled it to make a type specimen book when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansJP',
                                      fontSize: 12,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  getId() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      _sharedPreferences.then((value) {
        rUserID = value.getString('userID');
        print(rUserID);
      });
    } catch (e) {}
  }

  _ratingAndReview() async {
    var reviewComment = reviewController.text.toString();
    print(HealingMatchConstants.userEditToken);
    print(rUserID);
    print(reviewComment);
    print(ratingsValue);

    try {
      ProgressDialogBuilder.showRatingsAndReviewProgressDialog(context);
      final url = HealingMatchConstants.RATING_USER_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjE1Nzk1NzU3LCJleHAiOjE2MTY0MDA1NTd9.B5hJd-GrTsLP6GSPafx6-WcR8tuxaBIoIGkLpOhvDRA"
          },
          body: json.encode({
            "userId": rUserID,
            "therapistId": "4",
            "ratingsCount": ratingsValue,
            "reviewComment": reviewComment,
          }));
      print(response.body);
      print('Status code : ${response.statusCode}');
      // NavigationRouter.switchToServiceUserBottomBar(context);
    } catch (e) {
      ProgressDialogBuilder.hideForgetRatingsAndReviewProgressDialog(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
  }
}
