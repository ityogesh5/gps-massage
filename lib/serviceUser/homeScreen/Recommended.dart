import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/customPainterHeart/CustomHeartPainter.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
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
  var _pageNumber = 0;
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
                return LoadInitialRecommendPage();
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
class LoadInitialRecommendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadInitialRecommendPageState();
  }
}

class _LoadInitialRecommendPageState extends State<LoadInitialRecommendPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Shimmer(
                    duration: Duration(milliseconds: 300),
                    //Default value
                    interval: Duration(milliseconds: 300),
                    //Default value: Duration(seconds: 0)
                    color: Colors.grey[300],
                    //Default value
                    enabled: true,
                    //Default value
                    direction: ShimmerDirection.fromLeftToRight(),
                    child: CarouselSlider(
                      items: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: new BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.none,
                                        image: new AssetImage(
                                            'assets/images_gps/logo.png')),
                                  )),
                              Text(
                                'Healing match',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        )
                      ],
                      options: CarouselOptions(
                          autoPlay: false,
                          autoPlayCurve: Curves.easeInOutCubic,
                          enlargeCenterPage: false,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer(
              duration: Duration(milliseconds: 300),
              //Default value
              interval: Duration(milliseconds: 300),
              //Default value: Duration(seconds: 0)
              color: Colors.grey[400],
              //Default value
              enabled: true,
              //Default value
              direction: ShimmerDirection.fromLTRB(),
              child: Container(
                color: Colors.grey[200],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[300],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Card(elevation: 5),
            ),
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Shimmer(
                duration: Duration(milliseconds: 300),
                //Default value
                interval: Duration(milliseconds: 300),
                //Default value: Duration(seconds: 0)
                color: Colors.grey[300],
                //Default value
                enabled: true,
                //Default value
                direction: ShimmerDirection.fromLTRB(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        new Card(
                          color: Colors.grey[200],
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Shimmer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[200]),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.none,
                                              image: new AssetImage(
                                                  'assets/images_gps/logo.png')),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Shimmer(
                duration: Duration(milliseconds: 300),
                //Default value
                interval: Duration(milliseconds: 300),
                //Default value: Duration(seconds: 0)
                color: Colors.grey[300],
                //Default value
                enabled: true,
                //Default value
                direction: ShimmerDirection.fromLTRB(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                        new Card(
                          color: Colors.grey[200],
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Shimmer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(
                                              color: Colors.grey[200]),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.none,
                                              image: new AssetImage(
                                                  'assets/images_gps/logo.png')),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer(
            duration: Duration(milliseconds: 300),
            //Default value
            interval: Duration(milliseconds: 300),
            //Default value: Duration(seconds: 0)
            color: Colors.grey[400],
            //Default value
            enabled: true,
            //Default value
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendTherapists extends StatefulWidget {
  List<UserList> getRecommendedTherapists;

  RecommendTherapists({Key key, @required this.getRecommendedTherapists})
      : super(key: key);

  @override
  _RecommendTherapistsState createState() => _RecommendTherapistsState();
}

class _RecommendTherapistsState extends State<RecommendTherapists> {
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();

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
            //Navigator.pop(context);
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
                        margin: EdgeInsets.all(5.0),
                        height: 200.0,
                        // height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: buildRecommendedTherapists(index, context),
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

  WidgetAnimator buildRecommendedTherapists(int index, BuildContext context) {
    double distance = widget.getRecommendedTherapists[index].distance != 0.0 &&
            widget.getRecommendedTherapists[index].distance != null
        ? widget.getRecommendedTherapists[index].distance / 1000.0
        : 0.0;
    return WidgetAnimator(
      InkWell(
        splashColor: Colors.lime,
        hoverColor: Colors.lime,
        onTap: () {
          HealingMatchConstants.therapistId =
              widget.getRecommendedTherapists[index].id;
          HealingMatchConstants.serviceDistanceRadius = distance;

          NavigationRouter.switchToServiceUserBookingDetailsCompletedScreenOne(
              context, HealingMatchConstants.therapistId);
        },
        child: new Card(
          color: Color.fromRGBO(242, 242, 242, 1),
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 125.0,
              width: MediaQuery.of(context).size.width * 0.78,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        widget.getRecommendedTherapists[index]
                                    .uploadProfileImgUrl !=
                                null
                            ? CachedNetworkImage(
                                width: 110.0,
                                height: 110.0,
                                imageUrl: widget.getRecommendedTherapists[index]
                                    .uploadProfileImgUrl,
                                filterQuality: FilterQuality.high,
                                fadeInCurve: Curves.easeInSine,
                                imageBuilder: (context, imageProvider) =>
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
                                        color: Colors.lightGreenAccent),
                                errorWidget: (context, url, error) => Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black12),
                                    image: DecorationImage(
                                        image: new AssetImage(
                                            'assets/images_gps/placeholder_image.png'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            : new Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new AssetImage(
                                          'assets/images_gps/placeholder_image.png')),
                                )),
                        SizedBox(height: 5),
                        Text(
                          '${distance.toStringAsFixed(2)} ｋｍ圏内',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5),
                            widget.getRecommendedTherapists[index].isShop != 0
                                ? Text(
                                    widget.getRecommendedTherapists[index]
                                                .storeName.length >
                                            10
                                        ? widget.getRecommendedTherapists[index]
                                                .storeName
                                                .substring(0, 10) +
                                            "..."
                                        : widget.getRecommendedTherapists[index]
                                            .storeName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    widget.getRecommendedTherapists[index]
                                                .userName.length >
                                            10
                                        ? widget.getRecommendedTherapists[index]
                                                .userName
                                                .substring(0, 10) +
                                            "..."
                                        : widget.getRecommendedTherapists[index]
                                            .userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                            Spacer(flex: 2),
                            HealingMatchConstants.isUserRegistrationSkipped
                                ? GestureDetector(
                                    onTap: () {
                                      return;
                                    },
                                    child: Container(
                                      child: CustomPaint(
                                        size: Size(30, 30),
                                        painter: HeartPainter(),
                                      ),
                                    ), /*  SvgPicture.asset(
                                      'assets/images_gps/heart_wo_color.svg',
                                      width: 25,
                                      height: 25,
                                      color: Colors.grey[400],
                                    ), */
                                  )
                                : FavoriteButton(
                                    iconSize: 40,
                                    iconColor: Colors.red,
                                    isFavorite: widget
                                                .getRecommendedTherapists[index]
                                                .favouriteToTherapist !=
                                            null &&
                                        widget.getRecommendedTherapists[index]
                                                .favouriteToTherapist ==
                                            1,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                      if (_isFavorite != null && _isFavorite) {
                                        // call favorite therapist API
                                        ServiceUserAPIProvider
                                            .favouriteTherapist(widget
                                                .getRecommendedTherapists[index]
                                                .id);
                                      } else {
                                        // call un-favorite therapist API
                                        ServiceUserAPIProvider
                                            .unFavouriteTherapist(widget
                                                .getRecommendedTherapists[index]
                                                .id);
                                      }
                                    }),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5),
                              widget.getRecommendedTherapists[index]
                                          .businessForm
                                          .contains('施術店舗あり 施術従業員あり') ||
                                      widget.getRecommendedTherapists[index]
                                          .businessForm
                                          .contains('施術店舗あり 施術従業員なし（個人経営）') ||
                                      widget.getRecommendedTherapists[index]
                                          .businessForm
                                          .contains('施術店舗なし 施術従業員なし（個人)')
                                  ? Visibility(
                                      visible: true,
                                      child: Container(
                                          padding: EdgeInsets.all(4),
                                          color: Colors.white,
                                          child: Text(
                                            '店舗',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 5,
                              ),
                              Visibility(
                                visible: widget.getRecommendedTherapists[index]
                                        .businesstrip !=
                                    0,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    color: Colors.white,
                                    child: Text(
                                      '出張',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Visibility(
                                visible: widget.getRecommendedTherapists[index]
                                        .coronameasure !=
                                    0,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    color: Colors.white,
                                    child: Text(
                                      'コロナ対策実施有無',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              widget.getRecommendedTherapists[index].rating !=
                                      null
                                  ? Text(
                                      '(${widget.getRecommendedTherapists[index].rating.toString()})',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: ColorConstants.fontFamily,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                    )
                                  : Text(
                                      '(0.0)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: ColorConstants.fontFamily,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                              widget.getRecommendedTherapists[index].rating !=
                                          null &&
                                      widget.getRecommendedTherapists[index]
                                              .rating !=
                                          "0.00"
                                  ? RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: double.parse(widget
                                          .getRecommendedTherapists[index]
                                          .rating),
                                      minRating: 0.25,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 24,
                                      itemBuilder: (context, rindex) =>
                                          new SizedBox(
                                              height: 20.0,
                                              width: 18.0,
                                              child: new IconButton(
                                                onPressed: () {},
                                                padding:
                                                    new EdgeInsets.all(0.0),
                                                // color: Colors.white,
                                                icon: rindex >
                                                        (double.parse(widget
                                                                    .getRecommendedTherapists[
                                                                        index]
                                                                    .rating))
                                                                .ceilToDouble() -
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
                                      onRatingUpdate: (rating) {},
                                    )
                                  : RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: 0.0,
                                      minRating: 0.25,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 24,
                                      /*  itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0), */
                                      itemBuilder: (context, _) => new SizedBox(
                                          height: 20.0,
                                          width: 18.0,
                                          child: new IconButton(
                                              onPressed: () {},
                                              padding: new EdgeInsets.all(0.0),
                                              // color: Colors.white,
                                              icon: SvgPicture.asset(
                                                "assets/images_gps/star_2.svg",
                                                height: 13.0,
                                                width: 13.0,
                                              ))),
                                      onRatingUpdate: (rating) {},
                                    ),
                              widget.getRecommendedTherapists[index]
                                              .noOfReviewsMembers !=
                                          null &&
                                      widget.getRecommendedTherapists[index]
                                              .noOfReviewsMembers !=
                                          0
                                  ? Text(
                                      '(${widget.getRecommendedTherapists[index].noOfReviewsMembers})',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          fontFamily:
                                              ColorConstants.fontFamily),
                                    )
                                  : Text(
                                      '(0)',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          fontFamily:
                                              ColorConstants.fontFamily),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                                certificateUploadList[index].keys.length != 0
                                    ? 10.0
                                    : 0.0),
                        certificateUploadList[index].keys.length != 0
                            ? Container(
                                height: 38.0,
                                width: MediaQuery.of(context).size.width -
                                    130.0, //200.0,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: certificateUploadList[index]
                                        .keys
                                        .length,
                                    itemBuilder: (context, keyIndex) {
                                      String key = certificateUploadList[index]
                                          .keys
                                          .elementAt(keyIndex);
                                      return WidgetAnimator(
                                        Wrap(
                                          children: [
                                            Padding(
                                              padding: index == 0
                                                  ? const EdgeInsets.only(
                                                      left: 0.0,
                                                      top: 4.0,
                                                      right: 4.0,
                                                      bottom: 4.0)
                                                  : const EdgeInsets.all(4.0),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: boxDecoration,
                                                child: Text(
                                                  key, //Qualififcation
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                        widget.getRecommendedTherapists[index].lowestPrice !=
                                    null &&
                                widget.getRecommendedTherapists[index]
                                        .lowestPrice !=
                                    0
                            ? Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '¥${widget.getRecommendedTherapists[index].lowestPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '/${widget.getRecommendedTherapists[index].leastPriceMin}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                    )
                                  ],
                                ),
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

  getCertificateValues(List<UserList> getRecommendedTherapists) async {
    try {
      if (this.mounted) {
        setState(() {
          if (getRecommendedTherapists != null &&
              getRecommendedTherapists.isNotEmpty) {
            for (int i = 0; i < getRecommendedTherapists.length; i++) {
              Map<String, String> certificateUploaded = Map<String, String>();

              if (getRecommendedTherapists[i].qulaificationCertImgUrl != null &&
                  getRecommendedTherapists[i].qulaificationCertImgUrl != '') {
                var split = getRecommendedTherapists[i]
                    .qulaificationCertImgUrl
                    .split(',');

                for (int i = 0; i < split.length; i++) {
                  String jKey = split[i];
                  if (jKey == "はり師" ||
                      jKey == "きゅう師" ||
                      jKey == "鍼灸師" ||
                      jKey == "あん摩マッサージ指圧師" ||
                      jKey == "柔道整復師" ||
                      jKey == "理学療法士") {
                    certificateUploaded["国家資格保有"] = "国家資格保有";
                  } else if (jKey == "国家資格取得予定（学生）") {
                    certificateUploaded["国家資格取得予定（学生）"] = "国家資格取得予定（学生）";
                  } else if (jKey == "民間資格") {
                    certificateUploaded["民間資格"] = "民間資格";
                  } else if (jKey == "無資格") {
                    certificateUploaded["無資格"] = "無資格";
                  }
                }

                if (certificateUploaded.length > 0) {
                  certificateUploadList.add(certificateUploaded);
                }
              }

              if (certificateUploaded.length == 0) {
                certificateUploaded["無資格"] = "無資格";
                certificateUploadList.add(certificateUploaded);
              }
            }
          } else {
            print('List is empty');
          }
        });
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
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
              if (value.data.userList.isEmpty) {
                setState(() {
                  isLoading = false;
                });
              } else {
                isLoading = false;
                widget.getRecommendedTherapists.addAll(value.data.userList);
                getCertificateValues(widget.getRecommendedTherapists);
              }
            }).catchError(() {
              setState(() {
                isLoading = false;
              });
            });
          });
        }
      }
      //print('Therapist users data Size : ${therapistUsers.length}');
    } catch (e) {
      print('Exception more data' + e.toString());
      setState(() {
        isLoading = false;
      });
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
  var _pageNumber = 0;
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
