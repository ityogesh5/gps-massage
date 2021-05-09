import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerReviewandRatingsViewResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/ratings_review_bloc.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/ratings_review_event.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/ratings_review_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/ProviderRatingsAndReviewScreenBlocCalls/Repository/ratings_review_repository.dart';

class ProviderSelfReviewScreen extends StatefulWidget {
  @override
  _ProviderSelfReviewScreenState createState() =>
      _ProviderSelfReviewScreenState();
}

class _ProviderSelfReviewScreenState extends State<ProviderSelfReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          '評価とレビュー',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => TherapistReviewBloc(
            getTherapistReviewRepository: GetTherapistReviewRepositoryImpl()),
        child: Container(
          child: InitialProviderReviewViewScreen(),
        ),
      ),
    );
  }
}

class InitialProviderReviewViewScreen extends StatefulWidget {
  @override
  _InitialProviderReviewViewScreenState createState() =>
      _InitialProviderReviewViewScreenState();
}

class _InitialProviderReviewViewScreenState
    extends State<InitialProviderReviewViewScreen> {
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() {
    CheckInternetConnection.checkConnectivity(context);
    if (HealingMatchConstants.isInternetAvailable) {
      BlocProvider.of<TherapistReviewBloc>(context)
          .add(RefreshEvent(HealingMatchConstants.accessToken));
    } else {
      print('No internet Bloc !!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocListener<TherapistReviewBloc, TherapistReviewState>(
          listener: (context, state) {
            if (state is GetTherapistReviewErrorState) {
              return ReviewPageError();
            }
          },
          child: BlocBuilder<TherapistReviewBloc, TherapistReviewState>(
            builder: (context, state) {
              if (state is GetTherapistReviewLoadingState) {
                print('Loading state');
                return LoadProviderReviewPage();
              } else if (state is GetTherapistReviewLoaderState) {
                print('Loader widget');
                return LoadInitialPage();
              } else if (state is GetTherapistReviewLoadedState) {
                print('Loaded users state');
                return LoadProviderReviewRatingsById(
                    therapistReviewList: state.getTherapistsUsers);
              } else if (state is GetTherapistReviewErrorState) {
                print('Error state : ${state.message}');
                return ReviewPageError();
              } else
                return Text(
                  "エラーが発生しました！",
                  style: TextStyle(color: Colors.white),
                );
            },
          ),
        ),
      ),
    );
  }
}

class LoadProviderReviewPage extends StatefulWidget {
  @override
  _LoadProviderReviewPageState createState() => _LoadProviderReviewPageState();
}

class _LoadProviderReviewPageState extends State<LoadProviderReviewPage> {
  TherapistReviewBloc therapistReviewBloc;
  List<TherapistReviewList> therapistReviewList = [];
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int _totalReviews = 0;

  @override
  void initState() {
    super.initState();
    therapistReviewBloc = BlocProvider.of<TherapistReviewBloc>(context);
    getReviewList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showOverlayLoader();
  }

  showOverlayLoader() {
    Loader.show(context,
        progressIndicator: LoadInitialPage(),
        themeData: Theme.of(context).copyWith(accentColor: Colors.limeAccent));
    Future.delayed(Duration(seconds: 5), () {
      Loader.hide();
    });
  }

  getReviewList() {
    var providerListApiProvider =
        ServiceProviderApi.getTherapistReviewById(_pageNumber, _pageSize);
    providerListApiProvider.then((value) {
      if (this.mounted) {
        setState(() {
          therapistReviewList = value.therapistsData.therapistReviewList;
          _totalReviews = value.therapistsData.totalElements;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
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
                          ' ($_totalReviews レビュー)',
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
                  therapistReviewList != null && therapistReviewList.isNotEmpty
                      ? ListView.separated(
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
                            } else {
                              return buildReviewContent(
                                  therapistReviewList[index]);
                            }
                          })
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'まだレビューはありません。',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
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
              ServiceProviderApi.getTherapistReviewById(_pageNumber, _pageSize);
          providerListApiProvider.then((value) {
            if (value.therapistsData.therapistReviewList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.therapistsData.therapistReviewList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.therapistsData.therapistReviewList.length}');
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
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }

  Widget buildReviewContent(TherapistReviewList therapistReviewList) {
    return new Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: therapistReviewList.ratingsCount.toDouble(),
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
                    icon: index > therapistReviewList.ratingsCount - 1
                        ? SvgPicture.asset(
                            "assets/images_gps/star_2.svg",
                            height: 13.0,
                            width: 13.0,
                            // color: Colors.black,
                          )
                        : SvgPicture.asset(
                            "assets/images_gps/star_colour.svg",
                            height: 13.0,
                            width: 13.0,
                            //  color: Colors.black,
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
              "(${therapistReviewList.ratingsCount.toStringAsFixed(2)})",
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
              '${therapistReviewList.createdAt.month}月${therapistReviewList.createdAt.day}',
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
                  "${therapistReviewList.reviewComment}",
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

class LoadInitialPage extends StatefulWidget {
  @override
  _LoadInitialPageState createState() => _LoadInitialPageState();
}

class _LoadInitialPageState extends State<LoadInitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Container(
          child: Center(
            child:
                SpinKitSpinningCircle(color: Color.fromRGBO(200, 217, 33, 1)),
          ),
        ));
  }
}

class LoadProviderReviewRatingsById extends StatefulWidget {
  List<TherapistReviewList> therapistReviewList;

  LoadProviderReviewRatingsById({Key key, @required this.therapistReviewList})
      : super(key: key);
  @override
  _LoadProviderReviewRatingsByIdState createState() =>
      _LoadProviderReviewRatingsByIdState();
}

class _LoadProviderReviewRatingsByIdState
    extends State<LoadProviderReviewRatingsById> {
  TherapistReviewBloc therapistReviewBloc;
  List<TherapistReviewList> therapistReviewList = [];
  bool isLoading = false;
  var _pageNumberType = 0;
  var _pageSizeType = 10;

  @override
  void initState() {
    super.initState();
    therapistReviewBloc = BlocProvider.of<TherapistReviewBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
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
                          '(152 レビュー)',
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
                  widget.therapistReviewList != null &&
                          widget.therapistReviewList.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                              //color: Color.fromRGBO(251, 251, 251, 1),
                              ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.therapistReviewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == widget.therapistReviewList.length) {
                              return _buildProgressIndicator();
                            } else {
                              return buildReviewContent(
                                  widget.therapistReviewList[index]);
                            }
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'まだレビューはありません。',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        )
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
          _pageNumberType++;
          print('Page number : $_pageNumberType Page Size : $_pageSizeType');
          var providerListApiProvider =
              ServiceProviderApi.getTherapistReviewById(
                  _pageNumberType, _pageSizeType);
          providerListApiProvider.then((value) {
            if (value.therapistsData.therapistReviewList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.therapistsData.therapistReviewList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.therapistsData.therapistReviewList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  widget.therapistReviewList
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

  Widget buildReviewContent(TherapistReviewList therapistReviewList) {
    return new Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: therapistReviewList.ratingsCount.toDouble(),
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
                    icon: index > therapistReviewList.ratingsCount - 1
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
              "(${therapistReviewList.ratingsCount.toStringAsFixed(2)})",
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
              '${therapistReviewList.createdAt.month}月${therapistReviewList.createdAt.day}',
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
                  "${therapistReviewList.reviewComment}",
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

class ReviewPageError extends StatefulWidget {
  @override
  _ReviewPageErrorState createState() => _ReviewPageErrorState();
}

class _ReviewPageErrorState extends State<ReviewPageError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: InkWell(
              splashColor: Colors.deepOrangeAccent,
              highlightColor: Colors.limeAccent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      AntDesign.disconnect,
                      color: Colors.deepOrangeAccent,
                      size: 50,
                    ),
                    Text('インターネット接続を確認してください。',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Open Sans',
                            color: Colors.black)),
                    InkWell(
                      splashColor: Colors.deepOrangeAccent,
                      highlightColor: Colors.limeAccent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(MaterialIcons.refresh),
                            onPressed: () {
                              BlocProvider.of<TherapistReviewBloc>(context).add(
                                  RefreshEvent(
                                      HealingMatchConstants.accessToken));
                            },
                          ),
                          Text(
                            'もう一度試してください。',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Open Sans',
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
