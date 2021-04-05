import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

List<UserList> therapistListByType = [];
List<String> _options = ['エステ', 'リラクゼーション', '整骨・整体', 'フィットネス'];

int _selectedIndex = -1;

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
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() {
    CheckInternetConnection.checkConnectivity(context);
    if (HealingMatchConstants.isInternetAvailable) {
      BlocProvider.of<TherapistTypeBloc>(context)
          .add(RefreshEvent(HealingMatchConstants.accessToken));
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
              if (state is GetTherapistTypeLoadingState) {
                print('Loading state');
                return LoadProvidersPage();
              } else if (state is GetTherapistTypeLoaderState) {
                print('Loader widget');
                return LoadInitialHomePage();
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
            child: Center( //SpinKitSpinningCircle(color: Color.fromRGBO(200, 217, 33, 1)),
              child: SvgPicture.asset('assets/images_gps/normalLogo.svg',
                  width: 150, height: 150),
            ),
          )),
    );
  }
}

class LoadProvidersPage extends StatefulWidget {
  @override
  State createState() {
    return _LoadProvidersPageState();
  }
}

class _LoadProvidersPageState extends State<LoadProvidersPage> {
  TherapistTypeBloc _therapistTypeBloc;
  List<TherapistUserList> therapistUsers = [];
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumber = 1;
  var _pageSize = 1;
  Map<String, String> certificateImages = Map<String, String>();
  List<CertificationTherapistUsers> certificateUpload = [];
  var certificateUploadKeys;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
    getProvidersList();
  }

  getProvidersList() async {
    //therapistUsers.clear();
    var providerListApiProvider =
        ServiceUserAPIProvider.getAllTherapistsByLimit(_pageNumber, _pageSize);
    providerListApiProvider.then((value) {
      if (this.mounted) {
        setState(() {
          therapistUsers = value.therapistData.therapistUserList;
          for (int i = 0; i < therapistUsers.length; i++) {
            certificateUpload = value
                .therapistData.therapistUserList[i].user.certificationUploads;

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
          }
        });
      }
    });
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    showOverlayLoader();
  }

  showOverlayLoader() {
    Loader.show(context,
        progressIndicator: LoadInitialHomePage(),
        themeData: Theme.of(context).copyWith(accentColor: Colors.limeAccent));
    Future.delayed(Duration(seconds: 5), () {
      Loader.hide();
    });
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
                    flexibleSpace: Container(
                      height: MediaQuery.of(context).size.height * 0.082,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[300],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Center(child: MassageTypeChips()),
                    ),
                    // Display a placeholder widget to visualize the shrinking size.
                    // Make the initial height of the SliverAppBar larger than normal.
                  ),
                  // Next, create a SliverList
                  SliverList(
                      delegate: SliverChildListDelegate([
                    GestureDetector(
                      onTap: () {
                        NavigationRouter
                            .switchToServiceUserBookingDetailsCompletedScreenOne(
                                context);
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: therapistUsers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == therapistUsers.length) {
                              return _buildProgressIndicator();
                            } else {
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: new Card(
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
                                                          FilterQuality.high,
                                                      fadeInCurve:
                                                          Curves.easeInSine,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          SpinKitDoubleBounce(
                                                              color: Colors
                                                                  .lightGreenAccent),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              'assets/images_gps/user.png'),
                                                    )
                                                  : new Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration:
                                                          new BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12),
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                            fit: BoxFit.none,
                                                            image: new AssetImage(
                                                                'assets/images_gps/user.png')),
                                                      )),
                                              SizedBox(height: 5),
                                              FittedBox(
                                                child: Text(
                                                  '1.5km園内',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ),
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
                                                              .userName !=
                                                          null
                                                      ? Text(
                                                          '${therapistUsers[index].user.userName}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          '店舗名',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                  Spacer(),
                                                  FavoriteButton(
                                                      iconSize: 40,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite : $_isFavorite');
                                                      }),
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
                                                                        .all(4),
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    Text('店舗')),
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          therapistUsers[index]
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
                                                      visible:
                                                          therapistUsers[index]
                                                              .user
                                                              .coronaMeasure,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          color: Colors.white,
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
                                                  Text(
                                                    ratingsValue.toString(),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 25,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      size: 5,
                                                      color: Colors.black,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      // print(rating);
                                                      setState(() {
                                                        ratingsValue = rating;
                                                      });
                                                      print(ratingsValue);
                                                    },
                                                  ),
                                                  Text('(1518)'),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              certificateImages.length != 0
                                                  ? Container(
                                                      height: 38.0,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              130.0, //200.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          NavigationRouter
                                                              .switchToServiceUserBookingDetailsCompletedScreenOne(
                                                                  context);
                                                        },
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                certificateImages
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              String key =
                                                                  certificateImages
                                                                      .keys
                                                                      .elementAt(
                                                                          index);
                                                              return Wrap(
                                                                children: [
                                                                  Padding(
                                                                    padding: index ==
                                                                            0
                                                                        ? const EdgeInsets.only(
                                                                            left:
                                                                                0.0,
                                                                            top:
                                                                                4.0,
                                                                            right:
                                                                                4.0,
                                                                            bottom:
                                                                                4.0)
                                                                        : const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      decoration:
                                                                          boxDecoration,
                                                                      child:
                                                                          Text(
                                                                        key, //Qualififcation
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : Container(),
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  therapistUsers[index]
                                                              .sixtyMin ==
                                                          0
                                                      ? Text(
                                                          '¥0/60分',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 19),
                                                        )
                                                      : Text(
                                                          '¥${therapistUsers[index].sixtyMin}/60分',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 19),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        '近くにはこのサービスができるセラピストもお店もありません。',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NotoSansJP',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
                          color: Colors.transparent,
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
          child: new SpinKitPulse(color: Colors.greenAccent),
        ),
      ),
    );
  }

  _getMoreData() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          // call fetch more method here
          _pageNumber++;
          _pageSize++;
          print('Page number : $_pageNumber Page Size : $_pageSize');
          var providerListApiProvider =
              ServiceUserAPIProvider.getAllTherapistsByLimit(
                  _pageNumber, _pageSize);
          providerListApiProvider.then((value) {
            if (value.therapistData.therapistUserList.isEmpty) {
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  therapistUsers.addAll(value.therapistData.therapistUserList);
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
}

// Load providers by Massage type
class LoadProvidersByType extends StatefulWidget {
  List<UserList> getTherapistByType;

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
  List<CertificationUploads> certificateUpload = [];
  var certificateUploadKeys;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

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
                    flexibleSpace: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[300],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Center(child: MassageTypeChips()),
                    ),
                    // Display a placeholder widget to visualize the shrinking size.
                    // Make the initial height of the SliverAppBar larger than normal.
                  ),
                  // Next, create a SliverList
                  SliverList(
                      delegate: SliverChildListDelegate([
                    GestureDetector(
                      onTap: () {
                        NavigationRouter
                            .switchToServiceUserBookingDetailsCompletedScreenOne(
                                context);
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.getTherapistByType.length + 1,
                          itemBuilder: (context, index) {
                            if (index == widget.getTherapistByType.length) {
                              return _buildProgressIndicator();
                            } else {
                              return Container(
                                // height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: new Card(
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
                                                          FilterQuality.high,
                                                      fadeInCurve:
                                                          Curves.easeInSine,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          SpinKitDoubleBounce(
                                                              color: Colors
                                                                  .lightGreenAccent),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              'assets/images_gps/user.png'),
                                                    )
                                                  : new Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration:
                                                          new BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12),
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                            fit: BoxFit.none,
                                                            image: new AssetImage(
                                                                'assets/images_gps/user.png')),
                                                      )),
                                              SizedBox(height: 5),
                                              FittedBox(
                                                child: Text(
                                                  '1.5km園内',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ),
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
                                                  widget.getTherapistByType[index]
                                                              .user.userName !=
                                                          null
                                                      ? Text(
                                                          '${widget.getTherapistByType[index].user.userName}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          '店舗名',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                  Spacer(),
                                                  FavoriteButton(
                                                      iconSize: 40,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite : $_isFavorite');
                                                      }),
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
                                                                        .all(4),
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    Text('店舗')),
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
                                                              EdgeInsets.all(4),
                                                          color: Colors.white,
                                                          child: Text('出張')),
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
                                                              EdgeInsets.all(4),
                                                          color: Colors.white,
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
                                                  Text(
                                                    ratingsValue.toString(),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 25,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      size: 5,
                                                      color: Colors.black,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      // print(rating);
                                                      setState(() {
                                                        ratingsValue = rating;
                                                      });
                                                      print(ratingsValue);
                                                    },
                                                  ),
                                                  Text('(1518)'),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              certificateImages.length != 0
                                                  ? Container(
                                                      height: 38.0,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              130.0, //200.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          NavigationRouter
                                                              .switchToServiceUserBookingDetailsCompletedScreenOne(
                                                                  context);
                                                        },
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                certificateImages
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              String key =
                                                                  certificateImages
                                                                      .keys
                                                                      .elementAt(
                                                                          index);
                                                              return Wrap(
                                                                children: [
                                                                  Padding(
                                                                    padding: index ==
                                                                            0
                                                                        ? const EdgeInsets.only(
                                                                            left:
                                                                                0.0,
                                                                            top:
                                                                                4.0,
                                                                            right:
                                                                                4.0,
                                                                            bottom:
                                                                                4.0)
                                                                        : const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      decoration:
                                                                          boxDecoration,
                                                                      child:
                                                                          Text(
                                                                        key, //Qualififcation
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : Container(),
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  widget.getTherapistByType[index]
                                                              .sixtyMin ==
                                                          0
                                                      ? Text(
                                                          '¥0/60分',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 19),
                                                        )
                                                      : Text(
                                                          '¥${widget.getTherapistByType[index].sixtyMin}/60分',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 19),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
                Container(
                  child: Center(
                    child: Text(
                      '近くにはこのサービスができるセラピストもお店もありません。',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Center(child: MassageTypeChips()),
                  ),
                )
              ],
            ),
    );
  }

  getProvidersCertifications(List<UserList> getTherapistByType) async {
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
      });
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
          //_pageSizeType++;
          print('Page number : $_pageNumberType Page Size : $_pageSizeType');
          var providerListApiProvider =
              ServiceUserAPIProvider.getTherapistsByTypeLimit(
                  _pageNumberType, _pageSizeType);
          providerListApiProvider.then((value) {
            if (value.therapistData.userList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.therapistData.userList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.therapistData.userList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  widget.getTherapistByType
                      .addAll(value.therapistData.userList);
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
              color: Color.fromRGBO(0, 0, 0, 1),
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
