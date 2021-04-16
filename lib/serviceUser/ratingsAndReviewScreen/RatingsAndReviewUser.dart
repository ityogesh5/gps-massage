import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratings.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

class RatingsAndReviewUser extends StatefulWidget {
  @override
  _RatingsAndReviewUserState createState() => _RatingsAndReviewUserState();
}

class _RatingsAndReviewUserState extends State<RatingsAndReviewUser> {
  int status = 0;
  List<TherapistReviewList> ratingListValues = List();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserReviewListById ratingListResponseModel;
  RatingReviewModel ratingReviewModel;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  var ratingsValue = 0.0;
  String rUserID, accessToken;

  // String noOfRating = ratingListResponseModel.userData.totalElements;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
    _providerRatingList();
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: status == 0
          ? buildLoading()
          : ListView(
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
                            "(${ratingListResponseModel.therapistsData.totalElements})",
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
                              color: Color.fromRGBO(217, 217, 217, 1),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 0,
                                          minRating: 0.5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 30,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            size: 5,
                                            color:
                                                Color.fromRGBO(200, 217, 33, 1),
                                          ),
                                          onRatingUpdate: (rating) {
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
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                          child: Divider(
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
                                              height: 1)),
                                    ),
                                    SizedBox(height: 2),
                                    Expanded(
                                      flex: 1,
                                      child: SingleChildScrollView(
                                        child: TextField(
                                          controller: reviewController,
                                          scrollController: _scroll,
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 8,
                                          autofocus: false,
                                          focusNode: _focus,
                                          decoration: new InputDecoration(
                                            filled: false,
                                            fillColor: ColorConstants
                                                .formFieldFillColor,
                                            hintText: '良かった点、気づいた点などをご記入ください',
                                            hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
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
                                            disabledBorder:
                                                HealingMatchConstants
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
                                  child: InkWell(
                                    onTap: () {
                                      _ratingAndReview();
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Card(
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Color.fromRGBO(
                                                    216, 216, 216, 1))),
                                        elevation: 8.0,
                                        margin: EdgeInsets.all(4.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: SvgPicture.asset(
                                              "assets/images_gps/sending.svg",
                                              height: 25.0,
                                              width: 25.0,
                                            ),
                                          ),
                                        ),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 6, left: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'レビューをした隙に名前、施術日時の詳細がセラビストに\n知られることはありません',
                              style: TextStyle(
                                  fontFamily: 'NotoSansJP',
                                  fontSize: 12,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 6, left: 6),
                      child: ListView.builder(
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
                                        "${ratingListValues[index].reviewUserId.userName}",
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
                                            fontSize: 10,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.bold),
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
                                      initialRating: ratingListValues[index]
                                          .ratingsCount
                                          .toDouble(),
                                      minRating: 0.5,
                                      direction: Axis.horizontal,
                                      ignoreGestures: true,
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
                                        setState(() {
                                          ratingsValue = ratingListValues[index]
                                              .ratingsCount
                                              .toDouble();
                                        });
                                        print(ratingsValue);
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "(${ratingListValues[index].ratingsCount.toDouble()})",
                                      style: TextStyle(
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
                                          "${ratingListValues[index].reviewComment}",
                                          style: TextStyle(
                                              fontFamily: 'NotoSansJP',
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(51, 51, 51, 1),
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: Container(
                                      child: Divider(
                                          color: Colors.grey[300], height: 1)),
                                ),
                              ],
                            );
                          }),
                    ),
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
        accessToken = value.getString('accessToken');
        print('user id: ${rUserID}');
      });
    } catch (e) {}
  }

  _ratingAndReview() async {
    var reviewComment = reviewController.text.toString().trim();
    print('token: $accessToken');
    print(rUserID);
    print(reviewComment);
    print(ratingsValue);
    if (ratingsValue == 0 || ratingsValue == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('評価を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (reviewComment.length == 0 ||
        reviewComment.isEmpty ||
        reviewComment == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('セラピストを5段階で評価してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (reviewComment.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('店舗についての評価をご記入ください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    try {
      ProgressDialogBuilder.showRatingsAndReviewProgressDialog(context);
      final url = HealingMatchConstants.RATING_USER_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": accessToken
          },
          body: json.encode({
            "userId": rUserID,
            "therapistId": "18",
            "ratingsCount": ratingsValue.toString(),
            "reviewComment": reviewComment,
          }));
      print(response.body);
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isReviewRatingSuccess(
          response.statusCode, context, response.body)) {
        final Map ratingResponse = jsonDecode(response.body);
        ratingReviewModel = RatingReviewModel.fromJson(ratingResponse);
        ProgressDialogBuilder.hideRatingsAndReviewProgressDialog(context);
        print('navigate');
        NavigationRouter.switchToServiceUserDisplayReviewScreen(context);
      } else {}
    } catch (e) {
      ProgressDialogBuilder.hideRatingsAndReviewProgressDialog(context);
      print('Response catch error : ${e.toString()}');
      return;
    }
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
            "therapistId": "18",
          }));
      // print(response.body);
      print('Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        ratingListResponseModel =
            UserReviewListById.fromJson(json.decode(response.body));
        setState(() {
          ratingListValues =
              ratingListResponseModel.therapistsData.therapistReviewList;
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
