import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/RecommendTherapistModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

var therapistId;

class Recommended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProvidersScreen(),
    );
  }
}

class ProvidersScreen extends StatefulWidget {
  @override
  _ProvidersScreenState createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  double ratingsValue = 3.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TherapistTypeBloc(
            getTherapistTypeRepository: GetTherapistTypeRepositoryImpl()),
        child: Container(
          child: InitialProvidersScreen(),
        ),
      ),
    );
  }
}

class InitialProvidersScreen extends StatefulWidget {
  @override
  State createState() {
    return _InitialProvidersScreenState();
  }
}

class _InitialProvidersScreenState extends State<InitialProvidersScreen> {
  var _pageNumber = 1;
  var _pageSize = 10;

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() {
    CheckInternetConnection.checkConnectivity(context);
    if (HealingMatchConstants.isInternetAvailable) {
      BlocProvider.of<TherapistTypeBloc>(context).add(RecommendEvent(
          HealingMatchConstants.accessToken, _pageNumber, _pageSize));
    } else {
      print('No internet Bloc !!');
      //return HomePageError();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showOverlayLoader();
  }

  showOverlayLoader() {
    Loader.show(context, progressIndicator: LoadInitialHomePage());
    Future.delayed(Duration(seconds: 4), () {
      Loader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocListener<TherapistTypeBloc, TherapistTypeState>(
          listener: (context, state) {
            if (state is GetTherapistTypeErrorState) {
              return HomePageError();
            }
          },
          child: BlocBuilder<TherapistTypeBloc, TherapistTypeState>(
            builder: (context, state) {
              if (state is GetTherapistTypeLoaderState) {
                print('Loading state');
                return LoadInitialHomePage();
              } else if (state is GetRecommendTherapistLoadedState) {
                print('Loader state');
                return RecommendTherapists(
                    getRecommendedTherapists: state.getRecommendedTherapists);
              } else if (state is GetTherapistTypeErrorState) {
                print('Error state : ${state.message}');
                return HomePageError();
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

// Loader HomePage
class LoadInitialHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadInitialHomePageState();
  }
}

class _LoadInitialHomePageState extends State<LoadInitialHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 1),
      //Default value
      interval: Duration(seconds: 2),
      //Default value: Duration(seconds: 0)
      color: Colors.grey[300],
      //Default value
      enabled: true,
      //Default value
      direction: ShimmerDirection.fromLeftToRight(),
      child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          body: Container(
            color: Colors.white,
            child: Center(
              //SpinKitSpinningCircle(color: Color.fromRGBO(200, 217, 33, 1)),
              child: SvgPicture.asset('assets/images_gps/normalLogo.svg',
                  width: 150, height: 150),
            ),
          )),
    );
  }
}

class RecommendTherapists extends StatefulWidget {
  List<RecommendTherapistList> getRecommendedTherapists;

  RecommendTherapists({Key key, @required this.getRecommendedTherapists})
      : super(key: key);

  @override
  _RecommendTherapistsState createState() => _RecommendTherapistsState();
}

class _RecommendTherapistsState extends State<RecommendTherapists> {
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumber = 1;
  var _pageSize = 10;
  var distanceRadius;
  Map<String, String> certificateImages = Map<String, String>();
  Map<int, String> storeTypeValues;
  List<RecommendedTherapistCertification> certificateUpload = [];
  var certificateUploadKeys;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  List<dynamic> recommendedTherapistAddress = new List();

  @override
  void initState() {
    super.initState();
    getCertificateValues(widget.getRecommendedTherapists);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          'おすすめ',
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: widget.getRecommendedTherapists != null &&
              widget.getRecommendedTherapists.isNotEmpty
          ? LazyLoadScrollView(
              isLoading: isLoading,
              onEndOfPage: () => _getMoreData(),
              scrollOffset: 0,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.getRecommendedTherapists.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.getRecommendedTherapists.length) {
                      return _buildProgressIndicator();
                    } else {
                      return Container(
                        // height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: WidgetAnimator(
                          InkWell(
                            splashColor: Colors.lime,
                            onTap: () {
                              var userID = widget
                                  .getRecommendedTherapists[index].user.id;
                              NavigationRouter
                                  .switchToServiceUserBookingDetailsCompletedScreenOne(
                                      context, userID);
                            },
                            child: Card(
                              elevation: 0.0,
                              color: Colors.grey[100],
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          widget
                                                      .getRecommendedTherapists[
                                                          index]
                                                      .user
                                                      .uploadProfileImgUrl !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: widget
                                                      .getRecommendedTherapists[
                                                          index]
                                                      .user
                                                      .uploadProfileImgUrl,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fadeInCurve:
                                                      Curves.easeInSine,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      SpinKitDoubleBounce(
                                                          color: Colors
                                                              .lightGreenAccent),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      new Container(
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
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: new AssetImage(
                                                                    'assets/images_gps/placeholder_image.png')),
                                                          )),
                                                )
                                              : new Container(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  decoration: new BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: new AssetImage(
                                                            'assets/images_gps/placeholder_image.png')),
                                                  )),
                                          SizedBox(height: 5),
                                          distanceRadius != null &&
                                                  distanceRadius != 0
                                              ? FittedBox(
                                                  child: Text(
                                                    '${distanceRadius[index]}ｋｍ圏内',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                )
                                              : FittedBox(
                                                  child: Text(
                                                    '0.0ｋｍ圏内',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              widget.getRecommendedTherapists[index]
                                                          .user.storeName !=
                                                      null
                                                  ? Expanded(
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${widget.getRecommendedTherapists[index].user.storeName}',
                                                              maxLines: widget
                                                                          .getRecommendedTherapists[
                                                                              index]
                                                                          .user
                                                                          .storeName
                                                                          .length >
                                                                      15
                                                                  ? 2
                                                                  : 1,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${widget.getRecommendedTherapists[index].user.userName}',
                                                              maxLines: widget
                                                                          .getRecommendedTherapists[
                                                                              index]
                                                                          .user
                                                                          .userName
                                                                          .length >
                                                                      15
                                                                  ? 2
                                                                  : 1,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Spacer(),
                                              SvgPicture.asset(
                                                  'assets/images_gps/recommendedHeart.svg',
                                                  width: 25,
                                                  height: 25),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                widget
                                                            .getRecommendedTherapists[
                                                                index]
                                                            .user
                                                            .businessForm
                                                            .contains(
                                                                '施術店舗あり 施術従業員あり') ||
                                                        widget
                                                            .getRecommendedTherapists[
                                                                index]
                                                            .user
                                                            .businessForm
                                                            .contains(
                                                                '施術店舗あり 施術従業員なし（個人経営）') ||
                                                        widget
                                                            .getRecommendedTherapists[
                                                                index]
                                                            .user
                                                            .businessForm
                                                            .contains(
                                                                '施術店舗なし 施術従業員なし（個人)')
                                                    ? Visibility(
                                                        visible: true,
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            color: Colors.white,
                                                            child: Text('店舗')),
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Visibility(
                                                  visible: widget
                                                      .getRecommendedTherapists[
                                                          index]
                                                      .user
                                                      .businessTrip,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      color: Colors.white,
                                                      child: Text('出張')),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Visibility(
                                                  visible: widget
                                                      .getRecommendedTherapists[
                                                          index]
                                                      .user
                                                      .coronaMeasure,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      color: Colors.white,
                                                      child: Text('コロナ対策実施有無')),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              widget.getRecommendedTherapists[index]
                                                          .reviewAvgData !=
                                                      null
                                                  ? Text(
                                                      '(${widget.getRecommendedTherapists[index].reviewAvgData.toString()})',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            ColorConstants
                                                                .fontFamily,
                                                        color: Color.fromRGBO(
                                                            153, 153, 153, 1),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    )
                                                  : Text(
                                                      '(0.0)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            ColorConstants
                                                                .fontFamily,
                                                        color: Color.fromRGBO(
                                                            153, 153, 153, 1),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                              widget.getRecommendedTherapists[index]
                                                          .reviewAvgData !=
                                                      null
                                                  ? RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating:
                                                          double.parse(widget
                                                              .getRecommendedTherapists[
                                                                  index]
                                                              .reviewAvgData),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 22,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        size: 5,
                                                        color: Color.fromRGBO(
                                                            255, 217, 0, 1),
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    )
                                                  : RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: 0.0,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 22,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        size: 5,
                                                        color: Color.fromRGBO(
                                                            255, 217, 0, 1),
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                              widget
                                                              .getRecommendedTherapists[
                                                                  index]
                                                              .noOfReviewsMembers !=
                                                          null &&
                                                      widget
                                                              .getRecommendedTherapists[
                                                                  index]
                                                              .noOfReviewsMembers !=
                                                          0
                                                  ? Text(
                                                      '(${widget.getRecommendedTherapists[index].noOfReviewsMembers})',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                          fontFamily:
                                                              ColorConstants
                                                                  .fontFamily),
                                                    )
                                                  : Text(
                                                      '(0)',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                          fontFamily:
                                                              ColorConstants
                                                                  .fontFamily),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          certificateImages.length != 0
                                              ? Container(
                                                  height: 38.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      130.0, //200.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      var userID = widget
                                                          .getRecommendedTherapists[
                                                              index]
                                                          .user
                                                          .id;
                                                      NavigationRouter
                                                          .switchToServiceUserBookingDetailsCompletedScreenOne(
                                                              context, userID);
                                                    },
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            certificateImages
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          String key =
                                                              certificateImages
                                                                  .keys
                                                                  .elementAt(
                                                                      index);
                                                          return WidgetAnimator(
                                                            Wrap(
                                                              children: [
                                                                Padding(
                                                                  padding: index == 0
                                                                      ? const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              0.0,
                                                                          top:
                                                                              4.0,
                                                                          right:
                                                                              4.0,
                                                                          bottom:
                                                                              4.0)
                                                                      : const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        boxDecoration,
                                                                    child: Text(
                                                                      key,
                                                                      //Qualififcation
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                )
                                              : Container(),
                                          widget.getRecommendedTherapists[index]
                                                          .lowestPrice !=
                                                      null &&
                                                  widget
                                                          .getRecommendedTherapists[
                                                              index]
                                                          .lowestPrice !=
                                                      0
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      '¥${widget.getRecommendedTherapists[index].lowestPrice}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      '/${widget.getRecommendedTherapists[index].priceForMinute}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                )
                                              : SizedBox.shrink()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          border: Border.all(
                              color: Color.fromRGBO(217, 217, 217, 1)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'おすすめのセラピストの情報',
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
                                        border:
                                            Border.all(color: Colors.black12),
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
                                        'おすすめのセラピスト・店舗はありません。',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold),
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

  getCertificateValues(
      List<RecommendTherapistList> getRecommendedTherapists) async {
    if (this.mounted) {
      setState(() {
        if (widget.getRecommendedTherapists != null &&
            widget.getRecommendedTherapists.isNotEmpty) {
          for (int i = 0; i < widget.getRecommendedTherapists.length; i++) {
            if (widget.getRecommendedTherapists[i].user.storeType != null &&
                widget.getRecommendedTherapists[i].user.storeType != '') {
              var split =
                  widget.getRecommendedTherapists[i].user.storeType.split(',');
              final jsonList = split.map((item) => jsonEncode(item)).toList();
              final uniqueJsonList = jsonList.toSet().toList();
              final result =
                  uniqueJsonList.map((item) => jsonDecode(item)).toList();
              print('Map Duplicate type : $result');
              storeTypeValues = {
                for (int i = 0; i < result.length; i++) i: result[i]
              };
              print('Store type map values type : $storeTypeValues');
            }
            certificateUpload =
                widget.getRecommendedTherapists[i].user.certificationUploads;
            for (int j = 0; j < certificateUpload.length; j++) {
              print(
                  'Certificate upload type : ${certificateUpload[j].toJson()}');
              certificateUploadKeys = certificateUpload[j].toJson();
              certificateUploadKeys.remove('id');
              certificateUploadKeys.remove('userId');
              certificateUploadKeys.remove('createdAt');
              certificateUploadKeys.remove('updatedAt');
              print('Keys certificate type : $certificateUploadKeys');
            }

            certificateUploadKeys.forEach((key, value) async {
              if (certificateUploadKeys[key] != null) {
                String jKey = getQualificationJPWordsForType(key);
                if (jKey == "はり師" ||
                    jKey == "きゅう師" ||
                    jKey == "鍼灸師" ||
                    jKey == "あん摩マッサージ指圧師" ||
                    jKey == "柔道整復師" ||
                    jKey == "理学療法士") {
                  certificateImages["国家資格保有"] = "国家資格保有";
                } else if (jKey == "国家資格取得予定（学生）") {
                  certificateImages["国家資格取得予定（学生）"] = "国家資格取得予定（学生）";
                } else if (jKey == "民間資格") {
                  certificateImages["民間資格"] = "民間資格";
                } else if (jKey == "無資格") {
                  certificateImages["無資格"] = "無資格";
                }
              }
            });
            if (certificateImages.length == 0) {
              certificateImages["無資格"] = "無資格";
            }
            print('certificateImages data type : $certificateImages');

            for (int k = 0;
                k < widget.getRecommendedTherapists[i].user.addresses.length;
                k++) {
              recommendedTherapistAddress.add(widget
                  .getRecommendedTherapists[i].user.addresses[k].distance
                  .truncateToDouble());
              distanceRadius = recommendedTherapistAddress;
              print(
                  'Recommned Position values : ${distanceRadius[0]} && ${recommendedTherapistAddress.length}');
            }
          }
        } else {
          print('List is empty');
        }
      });
    }
  }

  String getQualificationJPWordsForType(String key) {
    switch (key) {
      case 'acupuncturist':
        return 'はり師';
        break;
      case 'moxibutionist':
        return 'きゅう師';
        break;
      case 'acupuncturistAndMoxibustion':
        return '鍼灸師';
        break;
      case 'anmaMassageShiatsushi':
        return 'あん摩マッサージ指圧師';
        break;
      case 'judoRehabilitationTeacher':
        return '柔道整復師';
        break;
      case 'physicalTherapist':
        return '理学療法士';
        break;
      case 'acquireNationalQualifications':
        return '国家資格取得予定（学生）';
        break;
      case 'privateQualification1':
        return '民間資格';
      case 'privateQualification2':
        return '民間資格';
      case 'privateQualification3':
        return '民間資格';
      case 'privateQualification4':
        return '民間資格';
      case 'privateQualification5':
        return '民間資格';
        break;
    }
  }

  _getMoreData() async {
    try {
      if (!isLoading) {
        if (this.mounted) {
          setState(() {
            isLoading = true;
            // call fetch more method here
            _pageNumber++;
            _pageSize++;
            print('Page number : $_pageNumber Page Size : $_pageSize');
            var recommendedProviderListApiProvider =
                ServiceUserAPIProvider.getRecommendedTherapists(
                    context, _pageNumber, _pageSize);
            recommendedProviderListApiProvider.then((value) {
              if (value.homeTherapistData.recommendedTherapistData.isEmpty) {
                setState(() {
                  isLoading = false;
                });
              } else {
                isLoading = false;
                widget.getRecommendedTherapists
                    .addAll(value.homeTherapistData.recommendedTherapistData);
                getCertificateValues(widget.getRecommendedTherapists);
              }
            });
          });
        }
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }
}

class HomePageError extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageErrorState();
  }
}

class _HomePageErrorState extends State<HomePageError> {
  var _pageNumber = 1;
  var _pageSize = 10;

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
                              BlocProvider.of<TherapistTypeBloc>(context).add(
                                  RefreshEvent(
                                      HealingMatchConstants.accessToken,
                                      _pageNumber,
                                      _pageSize,
                                      context));
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
