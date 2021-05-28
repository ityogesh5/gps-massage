import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
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
import 'package:gps_massageapp/customLibraryClasses/customPainterHeart/CustomHeartPainter.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

List<String> _options = ['エステ', 'リラクゼーション', '整骨・整体', 'フィットネス'];

int _selectedIndex;
var therapistId;

class NearByProviderAndShop extends StatelessWidget {
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
      BlocProvider.of<TherapistTypeBloc>(context).add(RefreshEvent(
          HealingMatchConstants.accessToken, _pageNumber, _pageSize, context));
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
    Loader.show(context, progressIndicator: LoadNearByLoaderPage());
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
              if (state is GetTherapistLoadedState) {
                print('Loading state');
                return LoadProvidersPage(
                    getTherapistProfiles: state.getTherapistsUsers);
              } else if (state is GetTherapistTypeLoaderState) {
                print('Loader widget');
                return LoadNearByLoaderPage();
              } else if (state is GetTherapistTypeLoadedState) {
                print('Loaded users state');
                return LoadProvidersByType(
                    getTherapistByType: state.getTherapistsUsers);
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
class LoadNearByLoaderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadInitialHomePageState();
  }
}

class _LoadInitialHomePageState extends State<LoadNearByLoaderPage> {
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

class LoadProvidersPage extends StatefulWidget {
  List<InitialTherapistData> getTherapistProfiles;

  LoadProvidersPage({Key key, @required this.getTherapistProfiles})
      : super(key: key);

  @override
  State createState() {
    return _LoadProvidersPageState();
  }
}

class _LoadProvidersPageState extends State<LoadProvidersPage> {
  TherapistTypeBloc _therapistTypeBloc;
  List<InitialTherapistData> therapistUsers = [];
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumber = 1;
  var _pageSize = 10;
  var distanceRadius;
  Map<String, String> certificateImages = Map<String, String>();
  List<CertificationUploads> certificateUpload = [];
  var certificateUploadKeys;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
    getProvidersList(widget.getTherapistProfiles);
  }

  getProvidersList(List<InitialTherapistData> getTherapistProfiles) async {
    List<dynamic> therapistAddress = new List();
    try {
      if (this.mounted) {
        setState(() {
          therapistUsers = widget.getTherapistProfiles;
          for (int i = 0; i < therapistUsers.length; i++) {
            certificateUpload = therapistUsers[i].user.certificationUploads;

            for (int j = 0; j < certificateUpload.length; j++) {
              print('Certificate upload : ${certificateUpload[j].toJson()}');
              certificateUploadKeys = certificateUpload[j].toJson();
              certificateUploadKeys.remove('id');
              certificateUploadKeys.remove('userId');
              certificateUploadKeys.remove('createdAt');
              certificateUploadKeys.remove('updatedAt');
              print('Keys certificate : $certificateUploadKeys');
            }

            certificateUploadKeys.forEach((key, value) async {
              if (certificateUploadKeys[key] != null) {
                String jKey = getQualificationJPWords(key);
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
            print('certificateImages data : $certificateImages');

            for (int k = 0; k < therapistUsers[i].user.addresses.length; k++) {
              therapistAddress.add(therapistUsers[i]
                  .user
                  .addresses[k]
                  .distance
                  .truncateToDouble()
                  .toStringAsFixed(2));
              distanceRadius = therapistAddress;
              print(
                  'Position values : ${distanceRadius[0]} && ${therapistAddress.length}');
            }
          }
        });
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  String getQualificationJPWords(String key) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          '近くのセラピスト＆お店',
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: therapistUsers != null && therapistUsers.isNotEmpty
          ? LazyLoadScrollView(
              isLoading: isLoading,
              onEndOfPage: () => _getMoreData(),
              scrollOffset: 0,
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
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.082,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Center(child: MassageTypeChips()),
                      ),
                    ),
                    // Display a placeholder widget to visualize the shrinking size.
                    // Make the initial height of the SliverAppBar larger than normal.
                  ),
                  // Next, create a SliverList
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: therapistUsers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == therapistUsers.length) {
                              return _buildProgressIndicator();
                            } else {
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: WidgetAnimator(
                                  InkWell(
                                    splashColor: Colors.lime,
                                    onTap: () {
                                      HealingMatchConstants.therapistId =
                                          therapistUsers[index].user.id;
                                      NavigationRouter
                                          .switchToServiceUserBookingDetailsCompletedScreenOne(
                                              context,
                                              HealingMatchConstants
                                                  .therapistId);
                                    },
                                    child: Card(
                                      elevation: 0.0,
                                      color: Colors.grey[100],
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  therapistUsers[index]
                                                              .user
                                                              .uploadProfileImgUrl !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: therapistUsers[
                                                                  index]
                                                              .user
                                                              .uploadProfileImgUrl,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          fadeInCurve:
                                                              Curves.easeInSine,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 80.0,
                                                            height: 80.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitDoubleBounce(
                                                                  color: Colors
                                                                      .lightGreenAccent),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Container(
                                                                  width: 80.0,
                                                                  height: 80.0,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    shape: BoxShape
                                                                        .circle,
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
                                                  SizedBox(height: 5),
                                                  distanceRadius != null &&
                                                          distanceRadius != 0
                                                      ? FittedBox(
                                                          child: Text(
                                                            '${distanceRadius[index]}ｋｍ圏内',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                      : FittedBox(
                                                          child: Text(
                                                            '0.0ｋｍ圏内',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
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
                                                      therapistUsers[index]
                                                                  .user
                                                                  .storeName !=
                                                              null
                                                          ? Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      '${therapistUsers[index].user.storeName}',
                                                                      maxLines:
                                                                          therapistUsers[index].user.storeName.length > 15
                                                                              ? 2
                                                                              : 1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                      '${therapistUsers[index].user.userName}',
                                                                      maxLines:
                                                                          therapistUsers[index].user.userName.length > 15
                                                                              ? 2
                                                                              : 1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      Spacer(),
                                                      HealingMatchConstants
                                                          .isUserRegistrationSkipped
                                                          ? GestureDetector(
                                                        onTap: () {
                                                          return;
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/images_gps/heart_wo_color.svg',
                                                          width: 25,
                                                          height: 25,
                                                          color: Colors.grey[400],
                                                        ),
                                                      )
                                                          : FavoriteButton(
                                                              iconSize: 40,
                                                              iconColor:
                                                                  Colors.red,
                                                              valueChanged:
                                                                  (_isFavorite) {
                                                                print(
                                                                    'Is Favorite : $_isFavorite');
                                                                if (_isFavorite !=
                                                                        null &&
                                                                    _isFavorite) {
                                                                  // call favorite therapist API
                                                                  ServiceUserAPIProvider.favouriteTherapist(
                                                                      therapistUsers[
                                                                              index]
                                                                          .user
                                                                          .id);
                                                                } else {
                                                                  // call un-favorite therapist API
                                                                  ServiceUserAPIProvider.unFavouriteTherapist(
                                                                      therapistUsers[
                                                                              index]
                                                                          .user
                                                                          .id);
                                                                }
                                                              }),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        therapistUsers[index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗あり 施術従業員あり') ||
                                                                therapistUsers[
                                                                        index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗あり 施術従業員なし（個人経営）') ||
                                                                therapistUsers[
                                                                        index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗なし 施術従業員なし（個人)')
                                                            ? Visibility(
                                                                visible: true,
                                                                child: Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                4),
                                                                    color: Colors
                                                                        .white,
                                                                    child: Text(
                                                                        '店舗')),
                                                              )
                                                            : Container(),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              therapistUsers[
                                                                      index]
                                                                  .user
                                                                  .businessTrip,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  Text('出張')),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              therapistUsers[
                                                                      index]
                                                                  .user
                                                                  .coronaMeasure,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              color:
                                                                  Colors.white,
                                                              child: Text(
                                                                  'コロナ対策実施有無')),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      therapistUsers[index]
                                                                  .reviewAvgData !=
                                                              null
                                                          ? Text(
                                                              '(${therapistUsers[index].reviewAvgData.toString()})',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    ColorConstants
                                                                        .fontFamily,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
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
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                      therapistUsers[index]
                                                                  .reviewAvgData !=
                                                              null
                                                          ? RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              initialRating: double.parse(
                                                                  therapistUsers[
                                                                          index]
                                                                      .reviewAvgData),
                                                              minRating: 0.25,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 22,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            )
                                                          : RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              initialRating:
                                                                  0.0,
                                                              minRating: 0.25,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 22,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            ),
                                                      therapistUsers[index]
                                                                      .noOfReviewsMembers !=
                                                                  null &&
                                                              therapistUsers[
                                                                          index]
                                                                      .noOfReviewsMembers !=
                                                                  0
                                                          ? Text(
                                                              '(${therapistUsers[index].noOfReviewsMembers})',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                  fontFamily:
                                                                      ColorConstants
                                                                          .fontFamily),
                                                            )
                                                          : Text(
                                                              '(0)',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              130.0, //200.0,
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      certificateImages
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    String key =
                                                                        certificateImages
                                                                            .keys
                                                                            .elementAt(index);
                                                                    return WidgetAnimator(
                                                                      Wrap(
                                                                        children: [
                                                                          Padding(
                                                                            padding: index == 0
                                                                                ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0)
                                                                                : const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.all(5),
                                                                              decoration: boxDecoration,
                                                                              child: Text(
                                                                                key,
                                                                                //Qualififcation
                                                                                style: TextStyle(
                                                                                  fontSize: 14,
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
                                                  therapistUsers[index]
                                                                  .lowestPrice !=
                                                              null &&
                                                          therapistUsers[index]
                                                                  .lowestPrice !=
                                                              0
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              '¥${therapistUsers[index].lowestPrice}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              '/${therapistUsers[index].priceForMinute}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
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
                  ]))
                ],
              ),
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
                                  '近くのセラピスト＆お店の情報',
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
                                        '残念ながらお近くにはセラピスト・店舗の登録がまだありません。',
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
                Positioned(
                  top: 0.0,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.082,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[200],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Center(child: MassageTypeChips()),
                  ),
                )
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
            var providerListApiProvider =
                ServiceUserAPIProvider.getAllTherapistsByLimit(
                    context, _pageNumber, _pageSize);
            providerListApiProvider.then((value) {
              if (value.homeTherapistData.therapistData.isEmpty) {
                setState(() {
                  isLoading = false;
                });
              } else {
                isLoading = false;
                therapistUsers.addAll(value.homeTherapistData.therapistData);
                getProvidersList(therapistUsers);
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

// Load providers by Massage type
class LoadProvidersByType extends StatefulWidget {
  List<TypeTherapistData> getTherapistByType;

  LoadProvidersByType({Key key, @required this.getTherapistByType})
      : super(key: key);

  @override
  State createState() {
    return _LoadProvidersByTypeState();
  }
}

class _LoadProvidersByTypeState extends State<LoadProvidersByType> {
  // ignore: close_sinks
  TherapistTypeBloc therapistTypeBloc;
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumberType = 1;
  var _pageSizeType = 10;
  Map<String, String> certificateImages = Map<String, String>();
  List<CertificationUploadsByType> certificateUpload = [];
  var certificateUploadKeys;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );
  var distanceRadius;
  List<dynamic> therapistTypeAddress = new List();

  @override
  void initState() {
    super.initState();
    therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
    getProvidersCertifications(widget.getTherapistByType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          '近くのセラピスト＆お店',
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      body: widget.getTherapistByType != null &&
              widget.getTherapistByType.isNotEmpty
          ? LazyLoadScrollView(
              isLoading: isLoading,
              onEndOfPage: () => _getMoreDataByType(),
              scrollOffset: 0,
              child: CustomScrollView(
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
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: Center(child: MassageTypeChips()),
                      ),
                    ),
                    // Display a placeholder widget to visualize the shrinking size.
                    // Make the initial height of the SliverAppBar larger than normal.
                  ),
                  // Next, create a SliverList
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: widget.getTherapistByType.length + 1,
                          itemBuilder: (context, index) {
                            if (index == widget.getTherapistByType.length) {
                              return _buildProgressIndicator();
                            } else {
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: WidgetAnimator(
                                  InkWell(
                                    splashColor: Colors.lime,
                                    hoverColor: Colors.lime,
                                    onTap: () {
                                      HealingMatchConstants.therapistId = widget
                                          .getTherapistByType[index].user.id;
                                      NavigationRouter
                                          .switchToServiceUserBookingDetailsCompletedScreenOne(
                                              context,
                                              HealingMatchConstants
                                                  .therapistId);
                                    },
                                    child: new Card(
                                      elevation: 0.0,
                                      color: Colors.grey[100],
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  widget
                                                              .getTherapistByType[
                                                                  index]
                                                              .user
                                                              .uploadProfileImgUrl !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl: widget
                                                              .getTherapistByType[
                                                                  index]
                                                              .user
                                                              .uploadProfileImgUrl,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          fadeInCurve:
                                                              Curves.easeInSine,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 80.0,
                                                            height: 80.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitDoubleBounce(
                                                                  color: Colors
                                                                      .lightGreenAccent),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Container(
                                                                  width: 80.0,
                                                                  height: 80.0,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black12),
                                                                    shape: BoxShape
                                                                        .circle,
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
                                                  SizedBox(height: 5),
                                                  distanceRadius != null &&
                                                          distanceRadius != 0
                                                      ? FittedBox(
                                                          child: Text(
                                                            '${distanceRadius[index]}ｋｍ圏内',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                      : FittedBox(
                                                          child: Text(
                                                            '0.0ｋｍ圏内',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
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
                                                      widget
                                                                  .getTherapistByType[
                                                                      index]
                                                                  .user
                                                                  .storeName !=
                                                              null
                                                          ? Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      '${widget.getTherapistByType[index].user.storeName}',
                                                                      maxLines:
                                                                          widget.getTherapistByType[index].user.storeName.length > 15
                                                                              ? 2
                                                                              : 1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                      '${widget.getTherapistByType[index].user.userName}',
                                                                      maxLines:
                                                                          widget.getTherapistByType[index].user.userName.length > 15
                                                                              ? 2
                                                                              : 1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      Spacer(),
                                                      HealingMatchConstants
                                                          .isUserRegistrationSkipped
                                                          ? GestureDetector(
                                                        onTap: () {
                                                          return;
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/images_gps/heart_wo_color.svg',
                                                          width: 25,
                                                          height: 25,
                                                          color: Colors.grey[400],
                                                        ),
                                                      )
                                                          : FavoriteButton(
                                                              iconSize: 40,
                                                              iconColor:
                                                                  Colors.red,
                                                              valueChanged:
                                                                  (_isFavorite) {
                                                                print(
                                                                    'Is Favorite : $_isFavorite');
                                                                if (_isFavorite !=
                                                                        null &&
                                                                    _isFavorite) {
                                                                  // call favorite therapist API
                                                                  ServiceUserAPIProvider
                                                                      .favouriteTherapist(widget
                                                                          .getTherapistByType[
                                                                              index]
                                                                          .user
                                                                          .id);
                                                                } else {
                                                                  // call un-favorite therapist API
                                                                  ServiceUserAPIProvider
                                                                      .unFavouriteTherapist(widget
                                                                          .getTherapistByType[
                                                                              index]
                                                                          .user
                                                                          .id);
                                                                }
                                                              }),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        widget
                                                                    .getTherapistByType[
                                                                        index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗あり 施術従業員あり') ||
                                                                widget
                                                                    .getTherapistByType[
                                                                        index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗あり 施術従業員なし（個人経営）') ||
                                                                widget
                                                                    .getTherapistByType[
                                                                        index]
                                                                    .user
                                                                    .businessForm
                                                                    .contains(
                                                                        '施術店舗なし 施術従業員なし（個人)')
                                                            ? Visibility(
                                                                visible: true,
                                                                child: Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                4),
                                                                    color: Colors
                                                                        .white,
                                                                    child: Text(
                                                                        '店舗')),
                                                              )
                                                            : Container(),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Visibility(
                                                          visible: widget
                                                              .getTherapistByType[
                                                                  index]
                                                              .user
                                                              .businessTrip,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  Text('出張')),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Visibility(
                                                          visible: widget
                                                              .getTherapistByType[
                                                                  index]
                                                              .user
                                                              .coronaMeasure,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              color:
                                                                  Colors.white,
                                                              child: Text(
                                                                  'コロナ対策実施有無')),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      widget.getTherapistByType[index]
                                                                  .reviewAvgData !=
                                                              null
                                                          ? Text(
                                                              '(${widget.getTherapistByType[index].reviewAvgData.toString()})',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    ColorConstants
                                                                        .fontFamily,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
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
                                                                color: Color
                                                                    .fromRGBO(
                                                                        153,
                                                                        153,
                                                                        153,
                                                                        1),
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                      widget.getTherapistByType[index]
                                                                  .reviewAvgData !=
                                                              null
                                                          ? RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              initialRating: double
                                                                  .parse(widget
                                                                      .getTherapistByType[
                                                                          index]
                                                                      .reviewAvgData),
                                                              minRating: 0.25,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 22,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            )
                                                          : RatingBar.builder(
                                                              ignoreGestures:
                                                                  true,
                                                              initialRating:
                                                                  0.0,
                                                              minRating: 0.25,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemSize: 22,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                size: 5,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        217,
                                                                        0,
                                                                        1),
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            ),
                                                      widget
                                                                      .getTherapistByType[
                                                                          index]
                                                                      .noOfReviewsMembers !=
                                                                  null &&
                                                              widget
                                                                      .getTherapistByType[
                                                                          index]
                                                                      .noOfReviewsMembers !=
                                                                  0
                                                          ? Text(
                                                              '(${widget.getTherapistByType[index].noOfReviewsMembers})',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                  fontFamily:
                                                                      ColorConstants
                                                                          .fontFamily),
                                                            )
                                                          : Text(
                                                              '(0)',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              130.0, //200.0,
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      certificateImages
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    String key =
                                                                        certificateImages
                                                                            .keys
                                                                            .elementAt(index);
                                                                    return WidgetAnimator(
                                                                      Wrap(
                                                                        children: [
                                                                          Padding(
                                                                            padding: index == 0
                                                                                ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0)
                                                                                : const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.all(5),
                                                                              decoration: boxDecoration,
                                                                              child: Text(
                                                                                key,
                                                                                //Qualififcation
                                                                                style: TextStyle(
                                                                                  fontSize: 14,
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
                                                  widget
                                                                  .getTherapistByType[
                                                                      index]
                                                                  .lowestPrice !=
                                                              null &&
                                                          widget
                                                                  .getTherapistByType[
                                                                      index]
                                                                  .lowestPrice !=
                                                              0
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              '¥${widget.getTherapistByType[index].lowestPrice}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              '/${widget.getTherapistByType[index].priceForMinute}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
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
                  ]))
                ],
              ),
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
                                  '近くのセラピスト＆お店の情報',
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
                                        '残念ながらお近くにはセラピスト・店舗の登録がまだありません。',
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
                Positioned(
                  top: 0.0,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.082,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[300],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Center(child: MassageTypeChips()),
                  ),
                )
              ],
            ),
    );
  }

  getProvidersCertifications(List<TypeTherapistData> getTherapistByType) async {
    try {
      if (this.mounted) {
        setState(() {
          for (int i = 0; i < getTherapistByType.length; i++) {
            certificateUpload = getTherapistByType[i].user.certificationUploads;
            for (int j = 0; j < certificateUpload.length; j++) {
              print('Certificate upload : ${certificateUpload[j].toJson()}');
              certificateUploadKeys = certificateUpload[j].toJson();
              certificateUploadKeys.remove('id');
              certificateUploadKeys.remove('userId');
              certificateUploadKeys.remove('createdAt');
              certificateUploadKeys.remove('updatedAt');
              print('Keys certificate : $certificateUploadKeys');
            }

            certificateUploadKeys.forEach((key, value) async {
              if (certificateUploadKeys[key] != null) {
                String jKey = getQualificationJPWords(key);
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
            print('certificateImages data : $certificateImages');

            for (int k = 0;
                k < getTherapistByType[i].user.addresses.length;
                k++) {
              therapistTypeAddress.add(getTherapistByType[i]
                  .user
                  .addresses[k]
                  .distance
                  .truncateToDouble()
                  .toStringAsFixed(2));
              distanceRadius = therapistTypeAddress;
              print(
                  'Position values : $distanceRadius && ${therapistTypeAddress.length}');
            }
          }
        });
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  String getQualificationJPWords(String key) {
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

  Widget _buildProgressIndicator() {
    return new Center(
      child: new Opacity(
        opacity: isLoading ? 1.0 : 0.0,
        child: new SpinKitPulse(color: Colors.lime),
      ),
    );
  }

  _getMoreDataByType() async {
    try {
      if (!isLoading) {
        if (this.mounted) {
          setState(() {
            isLoading = true;
            // call fetch more method here
            _pageNumberType++;
            //_pageSizeType++;
            print('Page number : $_pageNumberType Page Size : $_pageSizeType');
            var providerListApiProvider =
                ServiceUserAPIProvider.getTherapistsByTypeLimit(
                    context, _pageNumberType, _pageSizeType);
            providerListApiProvider.then((value) {
              if (value.homeTherapistData.typeTherapistData.isEmpty) {
                setState(() {
                  isLoading = false;
                  print(
                      'TherapistList data count is Zero : ${value.homeTherapistData.typeTherapistData.length}');
                });
              } else {
                print(
                    'TherapistList data Size : ${value.homeTherapistData.typeTherapistData.length}');
                isLoading = false;
                widget.getTherapistByType
                    .addAll(value.homeTherapistData.typeTherapistData);
                getProvidersCertifications(widget.getTherapistByType);
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

class MassageTypeChips extends StatefulWidget {
  @override
  _MassageTypeChipsState createState() => _MassageTypeChipsState();
}

class _MassageTypeChipsState extends State<MassageTypeChips>
    with TickerProviderStateMixin {
  TherapistTypeBloc therapistTypeBloc;
  var _pageNumber = 1;
  var _pageSize = 10;

  @override
  void initState() {
    super.initState();
    therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(
              color: _selectedIndex == i
                  ? Color.fromRGBO(251, 251, 251, 1)
                  : Color.fromRGBO(0, 0, 0, 1),
            )),
        backgroundColor: Colors.white70,
        selectedColor: Colors.lime,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              print('Chip value : ${_options[_selectedIndex].toString()}');
              if (selected && i == 0) {
                HealingMatchConstants.serviceTypeValue = 1;
              } else if (selected && i == 1) {
                HealingMatchConstants.serviceTypeValue = 2;
              } else if (selected && i == 2) {
                HealingMatchConstants.serviceTypeValue = 3;
              } else if (selected && i == 3) {
                HealingMatchConstants.serviceTypeValue = 4;
              } else {
                print(
                    'Chip value else loop : ${_options[_selectedIndex].toString()}');
              }
            }
          });
          therapistTypeBloc.add(FetchTherapistTypeEvent(
              HealingMatchConstants.accessToken,
              HealingMatchConstants.serviceTypeValue,
              _pageNumber,
              _pageSize));
          print('Access token : ${HealingMatchConstants.accessToken}');
          print('Type value : ${HealingMatchConstants.serviceTypeValue}');
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2), child: choiceChip));
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      // This next line does the trick.

      scrollDirection: Axis.horizontal,

      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: _buildChips(),
              ),
            ],
          )),
    );
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
