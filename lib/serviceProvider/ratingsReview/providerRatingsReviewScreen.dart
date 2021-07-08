import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProviderRatingsAndReviewUser extends StatefulWidget {
  final int index;

  ProviderRatingsAndReviewUser(this.index);

  @override
  _ProviderRatingsAndReviewUserState createState() =>
      _ProviderRatingsAndReviewUserState();
}

class _ProviderRatingsAndReviewUserState
    extends State<ProviderRatingsAndReviewUser> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<UserReviewList> userReviewList = [];
  bool isLoading = false;
  bool isSendLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int _totalReviews = 0;
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getUserReviewList();
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  getUserReviewList() {
    var providerListApiProvider =
        ServiceProviderApi.getUserReviewById(_pageNumber, _pageSize);
    providerListApiProvider.then((value) {
      if (this.mounted) {
        setState(() {
          userReviewList = value.userData.userReviewList;
          _totalReviews = value.userData.totalElements;
          status = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              //   NavigationRouter.switchToServiceProviderBottomBar(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            '評価とレビュー',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: status == 0
            ? Container(
                color: Colors.white,
                child: Center(child: SpinKitThreeBounce(color: Colors.lime)),
              )
            : LazyLoadScrollView(
                isLoading: isLoading,
                onEndOfPage: () => _getMoreDataByType(),
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Row(
                              children: [
                                Text(
                                  HealingMatchConstants.serviceUserName.length >
                                          10
                                      ? HealingMatchConstants.serviceUserName
                                              .substring(0, 10) +
                                          "..."
                                      : HealingMatchConstants.serviceUserName +
                                          ' さんについてのレビュー',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '($_totalReviews レビュー)',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          _buildReviewSendTextField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                  //color: Color.fromRGBO(251, 251, 251, 1),
                                  ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: userReviewList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == userReviewList.length) {
                                  return _buildProgressIndicator();
                                } else {
                                  return buildReviewContent(
                                      userReviewList[index]);
                                }
                              })
                        ],
                      )),
                ),
              ) /* userReviewList != null && userReviewList.isNotEmpty
              ? 
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: _buildReviewSendTextField(),
                  ),
                ), */
        );
  }

  Widget _buildReviewSendTextField() {
    return Padding(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 24.0,
                              itemPadding: new EdgeInsets.all(4.0),
                              itemBuilder: (context, index) => new SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: index > ratingsValue - 1
                                        ? SvgPicture.asset(
                                            "assets/images_gps/star_2.svg",
                                            height: 15.0,
                                            width: 15.0,
                                            /*  color:
                                                                    Colors.white, */
                                          )
                                        : SvgPicture.asset(
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                              child:
                                  Divider(color: Colors.grey[300], height: 1)),
                        ),
                        SizedBox(height: 2),
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: TextField(
                              maxLength: 240,
                              controller: reviewController,
                              scrollController: _scroll,
                              scrollPhysics: BouncingScrollPhysics(),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              maxLines: 8,
                              autofocus: false,
                              focusNode: _focus,
                              decoration: new InputDecoration(
                                filled: false,
                                fillColor: ColorConstants.formFieldFillColor,
                                hintText: '良かった点、気づいた点などをご記入ください',
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ),
                                labelStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14),
                                focusColor: Colors.grey[100],
                                border:
                                    HealingMatchConstants.textFormInputBorder,
                                focusedBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                disabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                enabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isSendLoading
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
                            isSendLoading = true;
                            validateFields();
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Card(
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(216, 216, 216, 1))),
                            elevation: 8.0,
                            margin: EdgeInsets.all(4.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
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
    );
  }

  void saveReviewandRatings() {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    var userCreateResponse = ServiceProviderApi.giveUserReview(
        ratingsValue, reviewController.text, HealingMatchConstants.bookingId);
    userCreateResponse.then((value) {
      if (this.mounted) {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        if (value.status == "success") {
          NavigationRouter.switchToProviderReviewScreenSent(
              context, HealingMatchConstants.serviceUserId);
        }
      }
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new SpinKitPulse(color: Colors.lime),
        ),
      ),
    );
  }

  _getMoreDataByType() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          // call fetch more method here
          _pageNumber++;
          print('Page number : $_pageNumber Page Size : $_pageSize');
          var providerListApiProvider =
              ServiceProviderApi.getUserReviewById(_pageNumber, _pageSize);
          providerListApiProvider.then((value) {
            if (value.userData.userReviewList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'UserReviewList data count is Zero : ${value.userData.userReviewList.length}');
              });
            } else {
              print(
                  'UserReviewList data Size : ${value.userData.userReviewList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  userReviewList.addAll(value.userData.userReviewList);
                }
              });
            }
          });
        });
      }
      //print('User users data Size : ${userReviewList.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }

  Widget buildReviewContent(UserReviewList userReviewList) {
    return new Column(
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userReviewList.reviewTherapistId.userName}",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '${userReviewList.createdAt.month}月${userReviewList.createdAt.day}',
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: userReviewList.ratingsCount.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              ignoreGestures: true,
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
                    icon: index > userReviewList.ratingsCount - 1
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
                            // color: Colors.black,
                          ), /*  new Icon(
                                                                                            Icons.star,
                                                                                            size: 20.0), */
                  )),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(width: 5),
            Text(
              "(${userReviewList.ratingsCount.toStringAsFixed(2)})",
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  "${userReviewList.reviewComment}",
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

  void validateFields() {
    if (ratingsValue == null || ratingsValue == 0.0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('評価とレビューをご入力ください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      setState(() {
        isSendLoading = false;
      });
      return;
    }

    saveReviewandRatings();
  }
}
