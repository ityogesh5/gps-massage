import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/currentBookingRatingResponseModel.dart';

import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';

class GivenRatingList extends StatefulWidget {
  @override
  _GivenRatingListState createState() => _GivenRatingListState();
}

class _GivenRatingListState extends State<GivenRatingList> {
  List<TherapistReviewList> therapistReviewList = List();
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int _totalReviews = 0;
  CurrentOrderReviewResponseModel currentOrderReviewResponseModel;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getUserReviewList();
  }

  getUserReviewList() {
    ServiceUserAPIProvider.getBookingOrderReviewUser(
            HealingMatchConstants.bookingId)
        .then((value) {
      currentOrderReviewResponseModel = value;
      /*   currentOrderReviewResponseModel.bookingReviewData.ratingsCount = 4;
      currentOrderReviewResponseModel.bookingReviewData.reviewComment =
          "Sample data for testing has been added"; */
      var providerListApiProvider =
          ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(context,
              _pageNumber, _pageSize, HealingMatchConstants.therapistRatingID);
      providerListApiProvider.then((value) {
        if (this.mounted) {
          setState(() {
            therapistReviewList = value.therapistsData.therapistReviewList;
            _totalReviews = value.therapistsData.totalElements;
            status = 1;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                '店舗についてのレビュー',
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
                          height: 16.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: (double.parse(
                                      (currentOrderReviewResponseModel
                                              .bookingReviewData.ratingsCount)
                                          .toString())),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 24.0,
                                  ignoreGestures: true,
                                  itemPadding: new EdgeInsets.only(bottom: 3.0),
                                  itemBuilder: (context, index) => new SizedBox(
                                      height: 20.0,
                                      width: 18.0,
                                      child: new IconButton(
                                        onPressed: () {},
                                        padding: new EdgeInsets.all(0.0),
                                        // color: Colors.white,
                                        icon: index >
                                                (double.parse(
                                                        (currentOrderReviewResponseModel
                                                                .bookingReviewData
                                                                .ratingsCount)
                                                            .toString())) -
                                                    1
                                            ? SvgPicture.asset(
                                                "assets/images_gps/star_2.svg",
                                                height: 13.0,
                                                width: 13.0,
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
                                Text(
                                    "${currentOrderReviewResponseModel.bookingReviewData.reviewComment}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                //color: Color.fromRGBO(251, 251, 251, 1),
                                ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: therapistReviewList.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == therapistReviewList.length) {
                                return _buildProgressIndicator();
                              } else if (therapistReviewList[index].bookingId !=
                                  HealingMatchConstants.bookingId) {
                                return buildReviewContent(
                                    therapistReviewList[index]);
                              } else {
                                return Container();
                              }
                            })
                      ],
                    )),
              ),
            ),
    );
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
              ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(
                  context,
                  _pageNumber,
                  _pageSize,
                  HealingMatchConstants.therapistRatingID);
          providerListApiProvider.then((value) {
            if (value.therapistsData.therapistReviewList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'UserReviewList data count is Zero : ${value.therapistsData.therapistReviewList.length}');
              });
            } else {
              print(
                  'UserReviewList data Size : ${value.therapistsData.therapistReviewList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  therapistReviewList
                      .addAll(value.therapistsData.therapistReviewList);
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

  Widget buildReviewContent(TherapistReviewList userReviewList) {
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
                "${userReviewList}",
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
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24.0,
              ignoreGestures: true,
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
}
