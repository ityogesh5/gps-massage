import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
// import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratings.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/BookingCompletedList.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

class RatingsAndReviewUser extends StatefulWidget {
  final BookingDetailsList bookingDetail;
  RatingsAndReviewUser(this.bookingDetail);
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
  double ratingsValue = 0.0;
  var rUserID;
  String accessToken;
  bool isLoadingData = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  var totalElements;
  bool isLoading = false;

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
          : LazyLoadScrollView(
              onEndOfPage: () => _getMoreDataByType(),
              isLoading: isLoadingData,
              child: ListView(
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
                              '${HealingMatchConstants.serviceProviderUserName}についてのレビュー',
                              style: TextStyle(
                                  fontFamily: 'NotoSansJP',
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "(${totalElements} レビュー)",
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
                            child: Stack(
                              children: [
                                Column(
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
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemSize: 24.0,
                                                itemPadding:
                                                    new EdgeInsets.all(4.0),
                                                itemBuilder: (context, index) =>
                                                    new SizedBox(
                                                        height: 20.0,
                                                        width: 20.0,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: index >
                                                                  ratingsValue -
                                                                      1
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/images_gps/star_2.svg",
                                                                  height: 15.0,
                                                                  width: 15.0,
                                                                  /*  color:
                                                                      Colors.white, */
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  "assets/images_gps/star_colour.svg",
                                                                  height: 15.0,
                                                                  width: 15.0,
                                                                  // color: Color.fromRGBO(200, 217, 33, 1),
                                                                ), /*  new Icon(
                                                                      Icons.star,
                                                                      size: 20.0), */
                                                        )),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                  ratingsValue = rating;
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
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                controller: reviewController,
                                                /* scrollController: _scroll,
                                                scrollPhysics:
                                                    BouncingScrollPhysics(), */
                                                keyboardType:
                                                    TextInputType.multiline,
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 8,
                                                autofocus: false,
                                                focusNode: _focus,
                                                decoration: new InputDecoration(
                                                  filled: false,
                                                  fillColor: ColorConstants
                                                      .formFieldFillColor,
                                                  hintText:
                                                      '良かった点、気づいた点などをご記入ください',
                                                  hintStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Color.fromRGBO(
                                                        217, 217, 217, 1),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontFamily: 'NotoSansJP',
                                                      fontSize: 10),
                                                  focusColor: Colors.grey[100],
                                                  border: HealingMatchConstants
                                                      .textFormInputBorder,
                                                  focusedBorder:
                                                      HealingMatchConstants
                                                          .textFormInputBorder,
                                                  disabledBorder:
                                                      HealingMatchConstants
                                                          .textFormInputBorder,
                                                  enabledBorder:
                                                      HealingMatchConstants
                                                          .textFormInputBorder,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? Positioned(
                                        bottom: 10.0,
                                        right: 4.0,
                                        child: SpinKitFadingCircle(
                                          color: ColorConstants.buttonColor,
                                          size: 25.0,
                                        ),
                                      )
                                    : Positioned(
                                        bottom: 10.0,
                                        right: 4.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLoading = true;
                                              _ratingAndReview();
                                            });
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                      ],
                                    ),
                                  ),
                                  buildReviewContent(ratingListValues[index]),
                                  SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7, right: 7),
                                    child: Container(
                                        child: Divider(
                                            color: Colors.grey[300],
                                            height: 1)),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  getId() async {
    // ProgressDialogBuilder.showCommonProgressDialog(context);
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
      setState(() {
        isLoading = false;
      });
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
      setState(() {
        isLoading = false;
      });
      return null;
    }

    /* if (reviewComment.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('50文字の店舗についての評価をご記入ください。',
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
    } */
    try {
      // _showLoadingIndicator(context);
      // ProgressDialogBuilder.showRatingsAndReviewProgressDialog(context);
      final url = HealingMatchConstants.RATING_USER_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": accessToken
          },
          body: json.encode({
            "therapistId": widget.bookingDetail.therapistId,
            "bookingId": widget.bookingDetail.id,
            "ratingsCount": ratingsValue,
            "reviewComment": reviewComment,
          }));
      print(response.body);
      print('Status code : ${response.statusCode}');
      if (StatusCodeHelper.isReviewRatingSuccess(
          response.statusCode, context, response.body)) {
        final Map ratingResponse = jsonDecode(response.body);
        ratingReviewModel = RatingReviewModel.fromJson(ratingResponse);
        // ProgressDialogBuilder.hideRatingsAndReviewProgressDialog(context);
        print('navigate');
        NavigationRouter.switchToServiceUserGivenReviewScreen(
          context,
        );
      } else {}
    } catch (e) {
      // ProgressDialogBuilder.hideRatingsAndReviewProgressDialog(context);
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

  Widget buildReviewContent(TherapistReviewList ratingListValues) {
    return new Column(
      children: [
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: ratingListValues.ratingsCount.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24.0,
              itemPadding: new EdgeInsets.only(bottom: 3.0),
              itemBuilder: (context, index) => new SizedBox(
                  height: 20.0,
                  width: 18.0,
                  child: new IconButton(
                    onPressed: () {},
                    padding: new EdgeInsets.all(0.0),
                    color: Colors.black,
                    icon: index > ratingListValues.ratingsCount.toDouble() - 1
                        ? SvgPicture.asset(
                            "assets/images_gps/star_2.svg",
                            height: 13.0,
                            width: 13.0,
                            color: Colors.black,
                          )
                        : SvgPicture.asset(
                            "assets/images_gps/star_colour.svg",
                            height: 13.0,
                            width: 13.0,
                            //color: Colors.black,
                          ),
                  )),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(width: 5),
            Text(
              "(${ratingListValues.ratingsCount.toStringAsFixed(2)})",
              style: TextStyle(
                shadows: [
                  Shadow(
                      color: Color.fromRGBO(153, 153, 153, 1),
                      offset: Offset(0, 3))
                ],
                fontSize: 14.0,
                color: Colors.transparent,
                decoration: TextDecoration.underline,
              ),
            ),
            Spacer(),
            Text(
              '${ratingListValues.createdAt.month}月${ratingListValues.createdAt.day}',
              style: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(0, 0, 0, 1),
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
                  "${ratingListValues.reviewComment}",
                  style: TextStyle(
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
  }
  /* _providerRatingList() async {
    try {
      // ProgressDialogBuilder.showCommonProgressDialog(context);
      final url = HealingMatchConstants.RATING_PROVIDER_LIST_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": widget.bookingDetail.therapistId,
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

        */ /* for (var ratingList in ratingListResponseModel.userData.userList) {
          ratingListValues.add(ratingList.ratingsCount);
        }*/ /*
        // ProgressDialogBuilder.hideCommonProgressDialog(context);
      }

      print('Status code : ${response.statusCode}');
    } catch (e) {
      // ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }*/

  _providerRatingList() async {
    try {
      var ratingsProvider =
          ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(context,
              _pageNumber, _pageSize, widget.bookingDetail.therapistId);
      ratingsProvider.then((value) {
        if (this.mounted) {
          setState(() {
            ratingListValues = value.therapistsData.therapistReviewList;
            totalElements = value.therapistsData.totalElements;
            status = 1;
          });
        }
      });
    } catch (e) {
      print('Ratings Exception : ${e.toString()}');
    }
  }

  _getMoreDataByType() async {
    try {
      if (!isLoadingData) {
        setState(() {
          isLoadingData = true;
          // call fetch more method here
          _pageNumber++;
          print('Page number : $_pageNumber Page Size : $_pageSize');
          var ratingsProvider =
              ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(context,
                  _pageNumber, _pageSize, widget.bookingDetail.therapistId);
          ratingsProvider.then((value) {
            if (value.therapistsData.therapistReviewList.isEmpty) {
              setState(() {
                isLoadingData = false;
                print(
                    'TherapistList data count is Zero : ${value.therapistsData.therapistReviewList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.therapistsData.therapistReviewList.length}');
              setState(() {
                isLoadingData = false;
                if (this.mounted) {
                  ratingListValues
                      .addAll(value.therapistsData.therapistReviewList);
                }
              });
            }
          });
        });
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }

  /*_loadMoreData() async {
    try {
      if (!isLoadingData) {
        setState(() {});
        isLoadingData = true;
        // call fetch more method here
        _pageNumber++;
        _pageSize++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        var ratingsProvider =
            ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(context,
                _pageNumber, _pageSize, widget.bookingDetail.therapistId);
        ratingsProvider.then((value) {
          if (value != null && this.mounted) {
            setState(() {
              if (value.therapistsData.therapistReviewList.isEmpty) {
                isLoadingData = false;
              } else {
                isLoadingData = false;
                ratingListValues
                    .addAll(value.therapistsData.therapistReviewList);
              }
            });
          }
        }).catchError(() {
          setState(() {
            isLoadingData = false;
          });
        });
      }
    } catch (e) {
      print('Ratings and review exception pagination : ${e.toString()}');
      setState(() {
        isLoadingData = false;
      });
    }
  }*/

  _showLoadingIndicator(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: ColorConstants.buttonColor,
            size: 50.0,
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
