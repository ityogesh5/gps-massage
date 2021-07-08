import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

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
  var _pageNumber = 0;
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
        body: status == 0
            ? buildLoading()
            : LazyLoadScrollView(
                onEndOfPage: () => _getMoreDataByType(),
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
                      automaticallyImplyLeading: false,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              HealingMatchConstants
                                          .serviceProviderUserName.length >
                                      15
                                  ? '${HealingMatchConstants.serviceProviderUserName.substring(0,14)}...についてのレビュー'
                                  : '${HealingMatchConstants.serviceProviderUserName}についてのレビュー',
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
                                  itemCount: ratingListValues.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == ratingListValues.length) {
                                      return _buildProgressIndicator();
                                    } else {
                                      return new Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${ratingListValues[index].reviewUserId.userName}',
                                                  style: TextStyle(
                                                      fontFamily: 'NotoSansJP',
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          buildReviewContent(
                                              ratingListValues[index]),
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.22,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: new Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12),
                                                          shape:
                                                              BoxShape.circle,
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
                                                          '今のところ、このセラピストの方にはレビューがありません。',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
      var ratingsProvider =
          ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(
              context, _pageNumber, _pageSize, widget.id);
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
              ServiceUserAPIProvider.getAllTherapistsRatingsByLimit(
                  context, _pageNumber, _pageSize, widget.id);
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
                context, _pageNumber, _pageSize, widget.id);
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
              ignoreGestures: true,
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
}
