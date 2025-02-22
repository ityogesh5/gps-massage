import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/Repository/user_ratings_review_repository.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/user_ratings_bloc.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/user_ratings_event.dart';
import 'package:gps_massageapp/serviceProvider/BlocCalls/GetUserRatingsandReviewScreenBlocCalls/user_ratings_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class UserRatingReviewScreen extends StatefulWidget {
  final int userId;

  UserRatingReviewScreen(this.userId);

  @override
  _UserRatingReviewScreenState createState() => _UserRatingReviewScreenState();
}

class _UserRatingReviewScreenState extends State<UserRatingReviewScreen> {
  @override
  void initState() {
    HealingMatchConstants.serviceUserId = widget.userId;
    super.initState();
  }

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
        create: (context) => UserReviewBloc(
            getUserReviewRepository: GetUserReviewRepositoryImpl()),
        child: Container(
          child: InitialUserReviewScreen(),
        ),
      ),
    );
  }
}

class InitialUserReviewScreen extends StatefulWidget {
  @override
  _InitialUserReviewScreenState createState() =>
      _InitialUserReviewScreenState();
}

class _InitialUserReviewScreenState extends State<InitialUserReviewScreen> {
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() {
    CheckInternetConnection.checkConnectivity(context);
    if (HealingMatchConstants.isInternetAvailable) {
      BlocProvider.of<UserReviewBloc>(context)
          .add(RefreshEvent(HealingMatchConstants.accessToken));
    } else {
      print('No internet Bloc !!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocListener<UserReviewBloc, UserReviewState>(
          listener: (context, state) {
            if (state is GetUserReviewErrorState) {
              return ReviewPageError();
            }
          },
          child: BlocBuilder<UserReviewBloc, UserReviewState>(
            builder: (context, state) {
              if (state is GetUserReviewLoadingState) {
                print('Loading state');
                return LoadUserReviewPage();
              } else if (state is GetUserReviewErrorState) {
                print('Loader widget');
                return LoadInitialPage();
              } else if (state is GetUserReviewLoadedState) {
                print('Loaded users state');
                return LoadUserReviewRatingsById(
                    userReviewList: state.getUsersRatings);
              } else if (state is GetUserReviewErrorState) {
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

class LoadUserReviewPage extends StatefulWidget {
  @override
  _LoadUserReviewPageState createState() => _LoadUserReviewPageState();
}

class _LoadUserReviewPageState extends State<LoadUserReviewPage> {
  UserReviewBloc userReviewBloc;
  List<UserReviewList> userReviewList = [];
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int _totalReviews = 0;

  @override
  void initState() {
    super.initState();
    userReviewBloc = BlocProvider.of<UserReviewBloc>(context);
    getUserReviewList();
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

  getUserReviewList() {
    var providerListApiProvider =
        ServiceProviderApi.getUserReviewById(_pageNumber, _pageSize);
    providerListApiProvider.then((value) {
      if (this.mounted) {
        setState(() {
          userReviewList = value.userData.userReviewList;
          _totalReviews = value.userData.totalElements;
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
                          HealingMatchConstants.serviceUserName.length > 15
                              ? "${HealingMatchConstants.serviceUserName.substring(0, 15)}..."
                              : '${HealingMatchConstants.serviceUserName}' +
                                  'についてのレビュ',
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
                  userReviewList != null && userReviewList.isNotEmpty
                      ? ListView.separated(
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
                              return buildReviewContent(userReviewList[index]);
                            }
                          })
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                'まだレビューはありません。',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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

class LoadUserReviewRatingsById extends StatefulWidget {
  List<UserReviewList> userReviewList;

  LoadUserReviewRatingsById({Key key, @required this.userReviewList})
      : super(key: key);

  @override
  _LoadUserReviewRatingsByIdState createState() =>
      _LoadUserReviewRatingsByIdState();
}

class _LoadUserReviewRatingsByIdState extends State<LoadUserReviewRatingsById> {
  UserReviewBloc userReviewBloc;
  List<UserReviewList> userReviewList = [];
  bool isLoading = false;
  var _pageNumberType = 0;
  var _pageSizeType = 10;

  @override
  void initState() {
    super.initState();
    userReviewBloc = BlocProvider.of<UserReviewBloc>(context);
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
                  widget.userReviewList != null &&
                          widget.userReviewList.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                              //color: Color.fromRGBO(251, 251, 251, 1),
                              ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.userReviewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == widget.userReviewList.length) {
                              return _buildProgressIndicator();
                            } else {
                              return buildReviewContent(
                                  widget.userReviewList[index]);
                            }
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                'まだレビューはありません。',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NotoSansJP',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
          var providerListApiProvider = ServiceProviderApi.getUserReviewById(
              _pageNumberType, _pageSizeType);
          providerListApiProvider.then((value) {
            if (value.userData.userReviewList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.userData.userReviewList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.userData.userReviewList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  widget.userReviewList.addAll(value.userData.userReviewList);
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
                              BlocProvider.of<UserReviewBloc>(context).add(
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
