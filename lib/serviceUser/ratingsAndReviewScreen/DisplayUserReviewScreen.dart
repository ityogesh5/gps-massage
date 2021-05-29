import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayUserReview extends StatefulWidget {
  final int id;
  DisplayUserReview(this.id);
  @override
  _DisplayUserReviewState createState() => _DisplayUserReviewState();
}

class _DisplayUserReviewState extends State<DisplayUserReview> {
  List<TherapistReviewList> ratingListValues = List();
  UserReviewListById ratingListResponseModel;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  final reviewController = new TextEditingController();
  double ratingsValue = 0.0;
  int status = 0;
  bool isLoadingData = false;
  var _pageNumber = 1;
  var _pageSize = 10;
  var totalElements;

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
        body: LazyLoadScrollView(
          onEndOfPage: () => _loadMoreData(),
          isLoading: isLoadingData,
          child: CustomScrollView(
            //shrinkWrap: true,
            slivers: <Widget>[
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                // Provide a standard title.
                elevation: 0.0,
                backgroundColor: Colors.white,
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                floating: true,
                flexibleSpace: Padding(
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
                        "($totalElements)",
                        style: TextStyle(
                            fontFamily: 'NotoSansJP',
                            fontSize: 12,
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // Display a placeholder widget to visualize the shrinking size.
                // Make the initial height of the SliverAppBar larger than normal.
              ),
              // Next, create a SliverList
              SliverList(
                  delegate: SliverChildListDelegate([
                ratingListValues != null && ratingListValues.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ratingListValues.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == ratingListValues.length) {
                                return _buildProgressIndicator();
                              } else {
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
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " ${DateFormat("MM月dd").format(ratingListValues[index].createdAt).toString()}",
                                            style: TextStyle(
                                                fontFamily: 'NotoSansJP',
                                                fontSize: 12,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                            color:
                                                Color.fromRGBO(255, 217, 0, 1),
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
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
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
                              }
                            }),
                      )
                    : Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 1)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'レビューの情報！',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'NotoSansJP',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: new Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new AssetImage(
                                                          'assets/images_gps/appIcon.png')),
                                                )),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'まだレビューはありません。',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ]))
            ],
          ),
        ));
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingData ? 1.0 : 00,
          child: new SpinKitPulse(color: Colors.lime),
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
      ServiceUserAPIProvider.getAllTherapistsRatings(context).then((value) {
        if (value != null) {
          setState(() {
            totalElements = value.therapistsData.totalElements;
            ratingListValues = value.therapistsData.therapistReviewList;
          });
        }
      });
    } catch (e) {
      print('Ratings Exception : ${e.toString()}');
    }
  }

  _loadMoreData() async {
    try {
      if (!isLoadingData) {
        isLoadingData = true;
        // call fetch more method here
        _pageNumber++;
        _pageSize++;
        print('Page number : $_pageNumber Page Size : $_pageSize');
        var ratingsProvider =
            ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(
                context, _pageNumber, _pageSize);
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
        });
      }
    } catch (e) {
      print('Ratings and review exception pagination : ${e.toString()}');
    }
  }
}
