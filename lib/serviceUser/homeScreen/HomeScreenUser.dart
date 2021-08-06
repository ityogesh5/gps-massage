import 'dart:math';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/customLibraryClasses/customPainterHeart/CustomHeartPainter.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/UpComingReservationModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/UserBannerImagesModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';

List<String> userBannerImages = [];
List<String> _options = ['エステ', 'フィットネス', '整骨・整体', 'リラクゼーション'];
final List<String> dummyBannerImages = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

//base64 profile image
String imgBase64TherapistImage;

//Uint8List profile image;
Uint8List therapistImageInBytes;
String therapistImage = '';

var _selectedIndex;
List<UserList> therapistListByType = [];
List<UserList> therapistUsers = [];
List<Datum> bookingDetailsList = List();
var accessToken, deviceToken;
var userID;
List<UserAddresses> constantUserAddressValuesList = new List<UserAddresses>();
bool isRecommended = true;
bool isActive;
int status = 0;

String result = '';
var colorsValue = Colors.white;
Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

Animation<double> animation_rotation;
Animation<double> animation_radius_in;
Animation<double> animation_radius_out;
AnimationController controller;

double radius;
double dotRadius;

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreen> {
  @override
  void initState() {
    HealingMatchConstants.isProvider = false;
    _selectedIndex = null;
    super.initState();
  }

  @override
  void dispose() {
    CheckInternetConnection.cancelSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: BlocProvider(
        create: (context) => TherapistTypeBloc(
            getTherapistTypeRepository: GetTherapistTypeRepositoryImpl()),
        child: Container(
          child: InitialUserHomeScreen(),
        ),
      ),
    );
  }
}

class InitialUserHomeScreen extends StatefulWidget {
  @override
  State createState() {
    return _InitialUserHomeScreenState();
  }
}

class _InitialUserHomeScreenState extends State<InitialUserHomeScreen> {
  var _pageNumber = 0;
  var _pageSize = 10;
  final fireBaseMessaging = new FirebaseMessaging();
  int _state = 0;
  String fcmToken;

  @override
  void initState() {
    CheckInternetConnection.checkConnectivity(context);
    super.initState();
    getAccessToken();
  }

  void initBlocCall() {
    BlocProvider.of<TherapistTypeBloc>(context).add(RefreshEvent(
        HealingMatchConstants.accessToken, _pageNumber, _pageSize, context));
  }

  /// Update user status on Firebase
  Future<dynamic> _updateOnlineStatus(var fbUserId) {
    if (HealingMatchConstants.isInternetAvailable) {
      final docRef =
          FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(fbUserId);
      print('Firebase UID Internet available : $fbUserId');
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.update(docRef, {
          'isOnline': true,
        });
      });
    } else {
      final docRef =
          FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(fbUserId);
      print('Firebase UID Internet not available : $fbUserId');
      return FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.update(docRef, {
          'isOnline': false,
        });
      });
    }
  }

  getAccessToken() async {
    if (HealingMatchConstants.isUserRegistrationSkipped) {
      HealingMatchConstants.fbUserId = null;
      HealingMatchConstants.serviceUserID = "0";
    } else {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      HealingMatchConstants.fbUserId = firebaseAuth.currentUser.uid;

      print('Current user id : ${firebaseAuth.currentUser.uid}');
      _updateOnlineStatus(firebaseAuth.currentUser.uid);
    }
    _sharedPreferences.then((value) {
      accessToken = value.getString('accessToken');
      // isActive = value.getBool('isActive');
      var fcmToken = value.getString('deviceToken');
      HealingMatchConstants.userAddressId = value.getString('addressID');
      HealingMatchConstants.serviceUserID = value.getString('userID');
      HealingMatchConstants.serviceUserGender = value.getString('userGender');

      HealingMatchConstants.serviceUserName = value.getString("userName");
      if (accessToken != null) {
        print('Access token FCM token value : $accessToken && \n $fcmToken');
        print(
            'Address ID VALUE : ${HealingMatchConstants.userAddressId} && ${HealingMatchConstants.serviceUserID}');
        HealingMatchConstants.accessToken = accessToken;
        HealingMatchConstants.isActive = isActive;
        HealingMatchConstants.userDeviceToken = fcmToken;
        initBlocCall();
        getBannerImages();
        getUserDetails();
        getBookingList();
      } else {
        print('No token value found !!');
      }
    });
  }

  getBookingList() async {
    var getFavourite = ServiceUserAPIProvider.getUpComingBookingStatus();
    getFavourite.then((value) {
      if (this.mounted) {
        setState(() {
          bookingDetailsList = value.data;
          print('bookingDetails:${bookingDetailsList}');
          status = 1;
        });
      }
    });
  }

  getUserDetails() async {
    try {
      var userDetails = ServiceUserAPIProvider.getUserDetails(
          context, HealingMatchConstants.serviceUserID);
      userDetails.then((value) {
        HealingMatchConstants.isActive = value.data.isActive;
        print('isActiveUser:${value.data.isActive}');
        HealingMatchConstants.userProfileImage = value.data.uploadProfileImgUrl;
        HealingMatchConstants.serviceUserName = value.data.userName;
        HealingMatchConstants.userEditUserOccupation =
            value.data.userOccupation;
        HealingMatchConstants.serviceUserPhoneNumber =
            value.data.phoneNumber.toString();
        HealingMatchConstants.serviceUserEmailAddress = value.data.email;
        HealingMatchConstants.serviceUserDOB = value.data.dob;
        //DateFormat("yyyy-MM-dd").format(value.data.dob).toString();
        HealingMatchConstants.serviceUserAge = value.data.age.toString();
        HealingMatchConstants.serviceUserGender = value.data.gender;
        HealingMatchConstants.serviceUserOccupation = value.data.userOccupation;
        for (int i = 0; i < value.data.addresses.length; i++) {
          if (value.data.addresses[0].isDefault) {
            HealingMatchConstants.userRegAddressId = value.data.addresses[0].id;
            HealingMatchConstants.userAddressesList =
                value.data.addresses.cast<UserAddresses>();
            HealingMatchConstants.serviceUserID = value.data.addresses[0].userId.toString();
            HealingMatchConstants.intServiceUserID = value.data.addresses[0].userId;
            HealingMatchConstants.userRegisteredAddressDetail =
                value.data.addresses[0].address;
            HealingMatchConstants.userCity = value.data.addresses[0].cityName;
            HealingMatchConstants.userPrefecture =
                value.data.addresses[0].capitalAndPrefecture;
            HealingMatchConstants.userPlaceForMassage =
                value.data.addresses[0].userPlaceForMassage;
            HealingMatchConstants.userPlaceForMassageOther =
                value.data.addresses[0].otherAddressType;
            HealingMatchConstants.userArea = value.data.addresses[0].area;
            HealingMatchConstants.userBuildName =
                value.data.addresses[0].buildingName;
            HealingMatchConstants.userRoomNo =
                value.data.addresses[0].userRoomNumber;
          } else {
            print('Is default false');
          }
        }
        getFCMToken();
        print('User Profile image : ${HealingMatchConstants.userProfileImage}');
      }).catchError((onError) {
        print('Home error user details : $onError');
      });
    } catch (e) {
      print('Home error user details : ${e.toString()}');
    }
  }

  getBannerImages() async {
    List<BannersList> bannerImages = [];
    if (userBannerImages != null &&
        HealingMatchConstants.userBannerImages != null) {
      userBannerImages.clear();
      bannerImages.clear();
      HealingMatchConstants.userBannerImages.clear();
    }

    try {
      var bannerApiProvider =
          ServiceUserAPIProvider.getAllBannerImages(context);
      bannerApiProvider.then((value) {
        if (this.mounted) {
          setState(() {
            bannerImages = value.data.bannersList;
            if (bannerImages != null && bannerImages.isNotEmpty) {
              bannerImages.sort((a, b) =>
                  a.bannerDisplayOrder.compareTo(b.bannerDisplayOrder));
              for (var item in bannerImages) {
                if (item.isBannerImage) {
                  userBannerImages.add(item.bannerUrl);
                } else {
                  userBannerImages.add(item.bannerImageUrl);
                }

                print('Therapist banner images : ${item.bannerImageUrl}');
              }
              HealingMatchConstants.userBannerImages.addAll(userBannerImages);
            } else {
              HealingMatchConstants.userBannerImages.addAll(dummyBannerImages);
            }

            print(
                'Therapist banner images : ${HealingMatchConstants.userBannerImages.length}');
          });
        }
      });
    } catch (e) {
      print('Exception caught : ${e.toString()}');
      throw Exception(e);
    }
  }

  getFCMToken() async {
    _sharedPreferences.then((value) {
      fcmToken = value.getString('deviceToken');
      print('FCM Token : $fcmToken');
      if (fcmToken != null) {
        HealingMatchConstants.userDeviceToken = fcmToken;
        print(
            'FCM SPF Home Token : $fcmToken && \n${HealingMatchConstants.userDeviceToken}');
      } else {
        fireBaseMessaging.onTokenRefresh.listen((refreshToken) {
          HealingMatchConstants.userDeviceToken = refreshToken;
          print(
              'FCM Refresh Tokens : $refreshToken && \n${HealingMatchConstants.userDeviceToken}');
        }).onError((handleError) {
          print('On FCM Token Refresh error : ${handleError.toString()}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _state = 1;
        if (HealingMatchConstants.isActive != null &&
            HealingMatchConstants.isActive == false) {
          DialogHelper.showUserBlockDialog(context);
        } else {
          return;
        }
      });
    }
    return Scaffold(
      body: Center(
        child: Container(
          child: BlocListener<TherapistTypeBloc, TherapistTypeState>(
            listener: (context, state) {
              if (state is GetTherapistTypeErrorState) {
                return HomePageError();
              }
            },
            child: BlocBuilder<TherapistTypeBloc, TherapistTypeState>(
              builder: (context, state) {
                if (state is GetTherapistTypeLoaderState) {
                  print('Loader widget');
                  return LoadInitialHomePage();
                } else if (state is GetTherapistTypeLoadingState) {
                  print('Loader widget');
                  return LoadInitialHomePage();
                } else if (state is GetTherapistLoadedState) {
                  return LoadHomePage(
                      getTherapistProfiles: state.getTherapistsUsers,
                      getRecommendedTherapists: state.getRecommendedTherapists);
                } else if (state is GetTherapistTypeLoadedState) {
                  print('Loaded users state');
                  return HomeScreenByMassageType(
                      getTherapistByType: state.getTherapistsUsers,
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
                      items: [],
                      options: CarouselOptions(
                          autoPlay: true,
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
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
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
                              width: MediaQuery.of(context).size.width * 0.81,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.none,
                                            image: new AssetImage(
                                                'assets/images_gps/logo.png')),
                                      )),
                                  FittedBox(
                                    child: Text(
                                      'Healing Match',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'NotoSansJP'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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
                              width: MediaQuery.of(context).size.width * 0.81,
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

// Load home page

class LoadHomePage extends StatefulWidget {
  List<UserList> getTherapistProfiles;
  List<UserList> getRecommendedTherapists;

  LoadHomePage(
      {Key key,
      @required this.getTherapistProfiles,
      @required this.getRecommendedTherapists})
      : super(key: key);

  @override
  State createState() {
    return _LoadHomePageState();
  }
}

class _LoadHomePageState extends State<LoadHomePage> {
  TherapistTypeBloc _therapistTypeBloc;
  var _pageNumber = 0;
  var _pageSize = 10;

  @override
  void initState() {
    CheckInternetConnection.checkConnectivity(context);
    super.initState();
    _therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20),
          CarouselWithIndicatorDemo(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '近くのセラピスト＆お店',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: ColorConstants.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (therapistUsers != null && therapistUsers.isNotEmpty) {
                        NavigationRouter.switchToNearByProviderAndShop(context);
                      } else {
                        return;
                      }
                    },
                    child: Text(
                      'もっとみる',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: ColorConstants.fontFamily,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BuildMassageTypeChips(),
          BuildProviderUsers(getTherapistProfiles: widget.getTherapistProfiles),
          status == 0
              ? Center(child: CircularProgressIndicator())
              : ReservationList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'おすすめ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: ColorConstants.fontFamily,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.getRecommendedTherapists != null &&
                        widget.getRecommendedTherapists.isNotEmpty) {
                      NavigationRouter.switchToRecommended(context);
                    } else {
                      return;
                    }
                  },
                  child: Text(
                    'もっとみる',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ColorConstants.fontFamily,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          RecommendLists(
              getRecommendedTherapists: widget.getRecommendedTherapists),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class HomeScreenByMassageType extends StatefulWidget {
  List<UserList> getTherapistByType;
  List<UserList> getRecommendedTherapists;

  HomeScreenByMassageType(
      {Key key,
      @required this.getTherapistByType,
      @required this.getRecommendedTherapists})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenByMassageType();
  }
}

class _HomeScreenByMassageType extends State<HomeScreenByMassageType> {
  TherapistTypeBloc _therapistTypeBloc;

  @override
  void initState() {
    super.initState();
    _therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          CarouselWithIndicatorDemo(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '近くのセラピスト＆お店',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.getTherapistByType != null &&
                          widget.getTherapistByType.isNotEmpty) {
                        NavigationRouter.switchToNearByProviderAndShop(context);
                      } else {
                        return;
                      }
                    },
                    child: Text(
                      'もっとみる',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BuildMassageTypeChips(),
          BuildProviderListByType(
              getTherapistByType: widget.getTherapistByType),
          ReservationList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'おすすめ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.getRecommendedTherapists != null &&
                        widget.getRecommendedTherapists.isNotEmpty) {
                      NavigationRouter.switchToRecommended(context);
                    } else {
                      return;
                    }
                  },
                  child: Text(
                    'もっとみる',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          RecommendLists(
              getRecommendedTherapists: widget.getRecommendedTherapists),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Awesome custom dialog viewer
  showNoTherapistsDialog(BuildContext context) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.INFO,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: false,
        closeIcon: Icon(Icons.close),
        title: '情報',
        desc: '近くにはセラピストもお店もありません。',
        btnOkOnPress: () {
          print('Ok pressed!!');
          return InitialUserHomeScreen();
        })
      ..show();
  }
}

//Build therapists list view

class BuildProviderListByType extends StatefulWidget {
  List<UserList> getTherapistByType;

  // Create the key

  BuildProviderListByType({Key key, @required this.getTherapistByType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BuildProviderListByTypeState();
  }
}

class _BuildProviderListByTypeState extends State<BuildProviderListByType> {
  List<GlobalObjectKey<FormState>> formKeyList;
  Map<int, String> storeTypeValues;
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  var distanceRadius;
  List<dynamic> therapistTypeAddress = new List();

  @override
  void initState() {
    super.initState();
    formKeyList = List.generate(widget.getTherapistByType.length,
        (index) => GlobalObjectKey<FormState>(index));
    getCertificateValues(widget.getTherapistByType);
  }

  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return widget.getTherapistByType != null &&
            widget.getTherapistByType.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.getTherapistByType.length,
                    itemBuilder: (context, index) {
                      return buildTherapistDetails(index, context);
                    }),
              ),
            ),
          )
        : buildEmptyCard(context);
  }

  WidgetAnimator buildEmptyCard(BuildContext context) {
    return WidgetAnimator(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 200.0,
              width: MediaQuery.of(context).size.width * 0.96,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
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
                              border: Border.all(color: Colors.black12),
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
    );
  }

  WidgetAnimator buildTherapistDetails(int index, BuildContext context) {
    double distance = widget.getTherapistByType[index].distance != 0.0 &&
            widget.getTherapistByType[index].distance != null
        ? widget.getTherapistByType[index].distance / 1000.0
        : 0.0;
    return WidgetAnimator(
      InkWell(
        splashColor: Colors.lime,
        hoverColor: Colors.lime,
        onTap: () {
          HealingMatchConstants.therapistId =
              widget.getTherapistByType[index].id;
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
              width: MediaQuery.of(context).size.width * 0.81,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        widget.getTherapistByType[index].uploadProfileImgUrl !=
                                null
                            ? CachedNetworkImage(
                                width: 110.0,
                                height: 110.0,
                                imageUrl: widget.getTherapistByType[index]
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
                            widget.getTherapistByType[index].isShop != 0
                                ? Text(
                                    widget.getTherapistByType[index].storeName
                                                .length >
                                            10
                                        ? widget.getTherapistByType[index]
                                                .storeName
                                                .substring(0, 10) +
                                            "..."
                                        : widget.getTherapistByType[index]
                                            .storeName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    widget.getTherapistByType[index].userName
                                                .length >
                                            8
                                        ? widget.getTherapistByType[index]
                                                .userName
                                                .substring(0, 7) +
                                            "..."
                                        : widget
                                            .getTherapistByType[index].userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                            SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                showToolTipForType(
                                    widget.getTherapistByType[index].storeType,
                                    formKeyList[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/images_gps/info.svg",
                                    height: 15.0,
                                    width: 15.0,
                                    key: formKeyList[index],
                                    color: Colors.black,
                                  ), /* Icon(
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          key: key,
                                                          color: Colors.black ), */
                                ),
                              ),
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
                                    isFavorite: widget.getTherapistByType[index]
                                                .favouriteToTherapist !=
                                            null &&
                                        widget.getTherapistByType[index]
                                                .favouriteToTherapist ==
                                            1,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                      if (_isFavorite != null && _isFavorite) {
                                        // call favorite therapist API
                                        ServiceUserAPIProvider
                                            .favouriteTherapist(widget
                                                .getTherapistByType[index].id);
                                      } else {
                                        // call un-favorite therapist API
                                        ServiceUserAPIProvider
                                            .unFavouriteTherapist(widget
                                                .getTherapistByType[index].id);
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
                              widget.getTherapistByType[index].isShop == 1
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
                                visible: widget.getTherapistByType[index]
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
                                visible: widget.getTherapistByType[index]
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
                              widget.getTherapistByType[index].rating != null
                                  ? Text(
                                      '(${widget.getTherapistByType[index].rating.toString()})',
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
                              widget.getTherapistByType[index].rating != null &&
                                      widget.getTherapistByType[index].rating !=
                                          "0.00"
                                  ? RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: double.parse(widget
                                          .getTherapistByType[index].rating),
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
                                                                    .getTherapistByType[
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
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          ratingsValue = rating;
                                        });
                                        print(ratingsValue);
                                      },
                                    ),
                              widget.getTherapistByType[index]
                                              .noOfReviewsMembers !=
                                          null &&
                                      widget.getTherapistByType[index]
                                              .noOfReviewsMembers !=
                                          0
                                  ? Text(
                                      '(${widget.getTherapistByType[index].noOfReviewsMembers})',
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
                        widget.getTherapistByType[index].lowestPrice != null &&
                                widget.getTherapistByType[index].lowestPrice !=
                                    0
                            ? Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '¥${widget.getTherapistByType[index].lowestPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '/${widget.getTherapistByType[index].leastPriceMin}',
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

  void showToolTipForType(String text, var key) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  getCertificateValues(List<UserList> getTherapistByType) async {
    try {
      if (this.mounted) {
        setState(() {
          if (getTherapistByType != null && getTherapistByType.isNotEmpty) {
            for (int i = 0; i < getTherapistByType.length; i++) {
              Map<String, String> certificateUploaded = Map<String, String>();

              if (getTherapistByType[i].qulaificationCertImgUrl != null &&
                  getTherapistByType[i].qulaificationCertImgUrl != '') {
                var split =
                    getTherapistByType[i].qulaificationCertImgUrl.split(',');

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
                    certificateUploaded["民間資格保有"] = "民間資格保有";
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
}

//Build Carousel images for banner
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  _getBannerImages() async {
    List<BannersList> bannerImages = [];
    if (userBannerImages != null) {
      userBannerImages.clear();
      bannerImages.clear();
    }

    try {
      var bannerApiProvider =
          ServiceUserAPIProvider.getAllBannerImages(context);
      bannerApiProvider.then((value) {
        if (this.mounted) {
          setState(() {
            bannerImages = value.data.bannersList;
            for (var item in bannerImages) {
              if (item.bannerImageUrl == null || item.bannerImageUrl.isEmpty) {
                userBannerImages.add(
                    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80');
              }
              userBannerImages.add(item.bannerImageUrl);
              print('Therapist banner images : ${item.bannerImageUrl}');
            }
          });
        }
      });
    } catch (e) {
      print('Exception caught : ${e.toString()}');
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return userBannerImages != null && userBannerImages.isNotEmpty
        ? Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Column(children: [
                  CarouselSlider(
                    items: <Widget>[
                      for (int i = 0; i < userBannerImages.length; i++)
                        Container(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                child: Stack(
                                  children: <Widget>[
                                    CachedNetworkImage(
                                        width: 2000.0,
                                        fit: BoxFit.cover,
                                        imageUrl: userBannerImages[i],
                                        placeholder: (context, url) =>
                                            SpinKitWave(
                                                color: Colors.lightBlueAccent),
                                        errorWidget: (context, url, error) {
                                          return CachedNetworkImage(
                                            width: 2000.0,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                                            placeholder: (context, url) =>
                                                SpinKitWave(
                                                    color:
                                                        Colors.lightBlueAccent),
                                          );
                                        }),
                                  ],
                                )),
                          ),
                        )
                    ],
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOutCubic,
                        enlargeCenterPage: false,
                        viewportFraction: 1.02,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ]),
              ),
              Positioned(
                  bottom: 5.0,
                  left: 50.0,
                  right: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: userBannerImages.map((url) {
                      int index = userBannerImages.indexOf(url);
                      return Expanded(
                        child: Container(
                          width: 45.0,
                          height: 4.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                            color: _current == index
                                ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ],
          )
        : Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  CarouselSlider(
                    items: dummyImageSliders,
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOutCubic,
                        enlargeCenterPage: false,
                        viewportFraction: 1.02,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ]),
              ),
              Positioned(
                  bottom: 5.0,
                  left: 50.0,
                  right: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: dummyBannerImages.map((url) {
                      int index = dummyBannerImages.indexOf(url);
                      return Expanded(
                        child: Container(
                          width: 45.0,
                          height: 4.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
// shape: BoxShape.circle,
                            color: _current == index
                                ? Colors.white //Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ],
          );
  }
}

final List<Widget> dummyImageSliders = dummyBannerImages
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 2000.0),
                  ],
                )),
          ),
        ))
    .toList();

//Build Chips for provider massage types
class BuildMassageTypeChips extends StatefulWidget {
  @override
  _BuildMassageTypeChipsState createState() =>
      new _BuildMassageTypeChipsState();
}

class _BuildMassageTypeChipsState extends State<BuildMassageTypeChips>
    with TickerProviderStateMixin {
  TherapistTypeBloc therapistTypeBloc;
  var _pageNumber = 0;
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
                fontFamily: ColorConstants.fontFamily)),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        selectedColor: Color.fromRGBO(242, 242, 242, 1),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              print('Chip Index : $_selectedIndex : $i');
              print('Chip value : ${_options[_selectedIndex]}');
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
          padding: const EdgeInsets.all(10.0),
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

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  String finalDate = '';
  String currentDay = '';
  String currentMonth = '';
  String month;
  String day;
  String sTime;
  String eTime;
  String jaName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentDate();
  }

  _getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.year}/${dateParse.month}/${dateParse.day}";
    setState(() {
      finalDate = formattedDate.toString();
      HealingMatchConstants.currentDay = dateParse.day.toString();
      HealingMatchConstants.currentMonth = dateParse.month.toString();
      HealingMatchConstants.currentDate = currentDay + currentMonth + '月';
      print(
          'Current date : ${HealingMatchConstants.currentDay + HealingMatchConstants.currentMonth + '月'}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bookingDetailsList != null && bookingDetailsList.isNotEmpty) {
      DateTime startTime = bookingDetailsList[0].newStartTime != null
          ? DateTime.parse(bookingDetailsList[0].newStartTime).toLocal()
          : bookingDetailsList[0].startTime.toLocal();
      DateTime endTime = bookingDetailsList[0].newEndTime != null
          ? DateTime.parse(bookingDetailsList[0].newEndTime).toLocal()
          : bookingDetailsList[0].endTime.toLocal();
      setState(() {
        month = DateFormat('MM月').format(startTime);
        day = DateFormat('d').format(startTime);
        sTime = startTime.hour == 0
            ? DateFormat('KK:mm').format(startTime)
            : DateFormat('kk:mm').format(startTime);
        eTime = DateFormat('kk:mm').format(endTime);
        jaName = DateFormat('EEEE', 'ja_JP').format(startTime);
      });
      print('Booking status : ${bookingDetailsList[0].bookingStatus}');
    } else {
      //print('Booking status : ${bookingDetailsList[0].bookingStatus}');
    }

    GlobalKey key = new GlobalKey();
    void showToolTip(String text) {
      ShowToolTip popup = ShowToolTip(context,
          text: text,
          textStyle: TextStyle(color: Colors.black),
          height: 150,
          width: 190,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(10.0));

      /// show the popup for specific widget
      popup.show(
        widgetKey: key,
      );
    }

    return bookingDetailsList != null && bookingDetailsList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 1),
                          Color.fromRGBO(255, 255, 255, 1),
                        ]),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('今後の予約',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontFamily: ColorConstants.fontFamily)),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  NavigationRouter
                                      .switchToUserCalendarScreenScreen(
                                          context);
                                },
                                child: CircleAvatar(
                                  maxRadius: 41,
                                  backgroundColor:
                                      Color.fromRGBO(225, 225, 225, 1),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 1),
                                    maxRadius: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        bookingDetailsList[0].startTime != null
                                            ? Text(
                                                '${day}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        200, 217, 33, 1),
                                                    fontFamily: 'NotoSansJP',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                '31',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        200, 217, 33, 1),
                                                    fontFamily: 'NotoSansJP',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        bookingDetailsList[0].startTime != null
                                            ? Text(
                                                '${month}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'NotoSansJP',
                                                  color: Color.fromRGBO(
                                                      200, 217, 33, 1),
                                                ),
                                              )
                                            : Text(
                                                '3月',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'NotoSansJP',
                                                  color: Color.fromRGBO(
                                                      200, 217, 33, 1),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  bookingDetailsList[0].bookingTherapistId.storeName != "" &&
                                          bookingDetailsList[0].bookingTherapistId.storeName !=
                                              null
                                      ? Text(
                                          bookingDetailsList[0]
                                                      .bookingTherapistId
                                                      .storeName
                                                      .length >
                                                  8
                                              ? bookingDetailsList[0]
                                                      .bookingTherapistId
                                                      .storeName
                                                      .substring(0, 7) +
                                                  "..."
                                              : bookingDetailsList[0]
                                                  .bookingTherapistId
                                                  .storeName,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  ColorConstants.fontFamily))
                                      : Text(bookingDetailsList[0].bookingTherapistId.userName.length > 10 ? bookingDetailsList[0].bookingTherapistId.userName.substring(0, 10) + "..." : bookingDetailsList[0].bookingTherapistId.userName,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: ColorConstants.fontFamily)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showToolTip(
                                        bookingDetailsList[0]
                                            .bookingTherapistId
                                            .storeType,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.white
                                            ]),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          "assets/images_gps/info.svg",
                                          height: 10.0,
                                          width: 10.0,
                                          key: key,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  // ignore: unrelated_type_equality_checks
                                  bookingDetailsList[0].bookingStatus == 0
                                      ? Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/images_gps/processing.svg',
                                                height: 17,
                                                width: 15),
                                            Text(
                                              '承認待ち',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.orange,
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              /*  SizedBox(
                                height: 5,
                              ), */
                              FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                        bookingDetailsList[0].reviewAvgData ==
                                                null
                                            ? "0.00"
                                            : '${bookingDetailsList[0].reviewAvgData}',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily:
                                                ColorConstants.fontFamily)),
                                    bookingDetailsList[0].reviewAvgData ==
                                                null ||
                                            bookingDetailsList[0]
                                                    .reviewAvgData ==
                                                "0.00"
                                        ? RatingBar.builder(
                                            initialRating: 0.00,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemSize: 24.0,
                                            ignoreGestures: true,
                                            itemPadding: new EdgeInsets.only(
                                                bottom: 3.0),
                                            itemBuilder: (context, rindex) {
                                              return new SizedBox(
                                                  height: 20.0,
                                                  width: 18.0,
                                                  child: new IconButton(
                                                      onPressed: () {},
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      // color: Colors.white,
                                                      icon: SvgPicture.asset(
                                                        "assets/images_gps/star_2.svg",
                                                        height: 13.0,
                                                        width: 13.0,
                                                      )));
                                            },
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        : RatingBar.builder(
                                            initialRating: double.parse(
                                                bookingDetailsList[0]
                                                    .reviewAvgData),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemSize: 24.0,
                                            ignoreGestures: true,
                                            itemPadding: new EdgeInsets.only(
                                                bottom: 3.0),
                                            itemBuilder: (context, rindex) {
                                              return new SizedBox(
                                                  height: 20.0,
                                                  width: 18.0,
                                                  child: new IconButton(
                                                    onPressed: () {},
                                                    padding:
                                                        new EdgeInsets.all(0.0),
                                                    // color: Colors.white,
                                                    icon: rindex >
                                                            double.parse(bookingDetailsList[
                                                                            0]
                                                                        .reviewAvgData)
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
                                                  ));
                                            },
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                    Text(
                                        bookingDetailsList[0]
                                                    .noOfReviewsMembers ==
                                                null
                                            ? "0.00"
                                            : '(${bookingDetailsList[0].noOfReviewsMembers})',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily:
                                                ColorConstants.fontFamily)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images_gps/clock.svg',
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        height: 20,
                                        width: 20),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${sTime}~${eTime}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${bookingDetailsList[0].totalMinOfService}分',
                                      style: TextStyle(
                                        color: Color.fromRGBO(102, 102, 102, 1),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/images_gps/cost.svg',
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      height: 20,
                                      width: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '¥${bookingDetailsList[0].totalCost}',
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  bookingDetailsList[0].addedPrice != null
                                      ? Text(
                                          '(${bookingDetailsList[0].addedPrice})',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            // height: 50,

                            color: Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                      ],
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images_gps/gps.svg',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 20,
                              width: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '施術を受ける場所',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 1),
                                      Color.fromRGBO(255, 255, 255, 1),
                                    ]),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey[300],
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.grey[200]),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              '${bookingDetailsList[0].locationType}',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            '${bookingDetailsList[0].location}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(102, 102, 102, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              // height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '今後の予約',
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
                        onTap: () {
                          NavigationRouter.switchToUserCalendarScreenScreen(
                              context);
                        },
                        child: CircleAvatar(
                          maxRadius: 41,
                          backgroundColor: Color.fromRGBO(225, 225, 225, 1),
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                            maxRadius: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                HealingMatchConstants.currentDay != null
                                    ? Text(
                                        '${HealingMatchConstants.currentDay}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(200, 217, 33, 1),
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        '31',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(200, 217, 33, 1),
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold),
                                      ),
                                HealingMatchConstants.currentMonth != null
                                    ? Text(
                                        '${HealingMatchConstants.currentMonth}月',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'NotoSansJP',
                                          color:
                                              Color.fromRGBO(200, 217, 33, 1),
                                        ),
                                      )
                                    : Text(
                                        '3月',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'NotoSansJP',
                                          color:
                                              Color.fromRGBO(200, 217, 33, 1),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '頑張りすぎのあなた・・・。\nそろそろリフレッシュしませんか？',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class BuildProviderUsers extends StatefulWidget {
  List<UserList> getTherapistProfiles;

  // Create the key

  BuildProviderUsers({Key key, @required this.getTherapistProfiles})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BuildProviderUsersState();
  }
}

class _BuildProviderUsersState extends State<BuildProviderUsers> {
  var _pageNumber = 0;
  var _pageSize = 10;
  var keys;
  Map<int, String> storeTypeValues;

  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();

  bool _value = false;

  // Create the key
  List<GlobalObjectKey<FormState>> formKeyList;
  var certificateUploadKeys;
  var distanceRadius;
  List<dynamic> therapistAddress = new List();

  @override
  void initState() {
    super.initState();
    if (widget.getTherapistProfiles != null) {
      formKeyList = List.generate(widget.getTherapistProfiles.length,
          (index) => GlobalObjectKey<FormState>(index));
    }
    getTherapists();
  }

  // get therapist api
  getTherapists() async {
    try {
      // wait for 2 seconds to simulate loading of data
      // await Future.delayed(const Duration(seconds: 2));
      if (this.mounted) {
        setState(() {
          therapistUsers = widget.getTherapistProfiles;

          if (therapistUsers != null && therapistUsers.isNotEmpty) {
            for (int i = 0; i < therapistUsers.length; i++) {
              Map<String, String> certificateUploaded = Map<String, String>();

              if (therapistUsers[i].qulaificationCertImgUrl != null &&
                  therapistUsers[i].qulaificationCertImgUrl != '') {
                var split =
                    therapistUsers[i].qulaificationCertImgUrl.split(',');

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
                    certificateUploaded["民間資格保有"] = "民間資格保有";
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
            print('List is empty !!');
          }
        });
      }
    } catch (e) {
      print('Exception caught : ${e.toString()}');
      throw Exception(e);
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

  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return therapistUsers != null && therapistUsers.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: therapistUsers.length,
                    itemBuilder: (context, index) {
                      return buildTherapistDetails(index, context);
                    }),
              ),
            ),
          )
        : buildEmptyCard(context);
  }

  WidgetAnimator buildEmptyCard(BuildContext context) {
    return WidgetAnimator(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 200.0,
              width: MediaQuery.of(context).size.width * 0.96,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
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
                              border: Border.all(color: Colors.black12),
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
    );
  }

  WidgetAnimator buildTherapistDetails(int index, BuildContext context) {
    double distance = therapistUsers[index].distance != 0.0 &&
            therapistUsers[index].distance != null
        ? therapistUsers[index].distance / 1000.0
        : 0.0;
    return WidgetAnimator(
      InkWell(
        splashColor: Colors.lime,
        hoverColor: Colors.lime,
        onTap: () {
          HealingMatchConstants.therapistId = therapistUsers[index].id;
          HealingMatchConstants.serviceDistanceRadius = distance;
          NavigationRouter.switchToServiceUserBookingDetailsCompletedScreenOne(
              context, HealingMatchConstants.therapistId);
        },
        child: Card(
          color: Color.fromRGBO(242, 242, 242, 1),
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 125.0,
              width: MediaQuery.of(context).size.width * 0.81,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        therapistUsers[index].uploadProfileImgUrl != null
                            ? CachedNetworkImage(
                                width: 110.0,
                                height: 110.0,
                                imageUrl:
                                    therapistUsers[index].uploadProfileImgUrl,
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
                                  width: 100.0,
                                  height: 100.0,
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
                                width: 100.0,
                                height: 100.0,
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
                            therapistUsers[index].isShop != 0
                                ? Text(
                                    therapistUsers[index].storeName.length > 10
                                        ? therapistUsers[index]
                                                .storeName
                                                .substring(0, 10) +
                                            "..."
                                        : therapistUsers[index].storeName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    therapistUsers[index].userName.length > 10
                                        ? therapistUsers[index]
                                                .userName
                                                .substring(0, 10) +
                                            "..."
                                        : therapistUsers[index].userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                            SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                showToolTip(therapistUsers[index].storeType,
                                    formKeyList[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/images_gps/info.svg",
                                    height: 15.0,
                                    key: formKeyList[index],
                                    width: 15.0,
                                    color: Colors.black,
                                  ), /* Icon(
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          key: key,
                                                          color: Colors.black ), */
                                ),
                              ),
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
                                    ),
                                  )
                                : FavoriteButton(
                                    iconSize: 40,
                                    iconColor: Colors.red,
                                    isFavorite: therapistUsers[index]
                                                .favouriteToTherapist !=
                                            null &&
                                        therapistUsers[index]
                                                .favouriteToTherapist ==
                                            1,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                      if (_isFavorite != null && _isFavorite) {
                                        therapistUsers[index]
                                            .favouriteToTherapist = 1;

                                        // call favorite therapist API

                                        ServiceUserAPIProvider
                                            .favouriteTherapist(
                                                therapistUsers[index].id);
                                      } else {
                                        therapistUsers[index]
                                            .favouriteToTherapist = 0;

                                        // call un-favorite therapist API
                                        ServiceUserAPIProvider
                                            .unFavouriteTherapist(
                                                therapistUsers[index].id);
                                      }
                                    }),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              therapistUsers[index].isShop == 1
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
                                visible:
                                    therapistUsers[index].businesstrip != 0,
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
                                visible:
                                    therapistUsers[index].coronameasure != 0,
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
                          height: 10,
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              therapistUsers[index].rating != null
                                  ? Text(
                                      '( ${therapistUsers[index].rating})',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      '0.0',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                              therapistUsers[index].rating != null &&
                                      therapistUsers[index].rating != '0.00'
                                  ? RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: double.parse(
                                          therapistUsers[index].rating),
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
                                                        (double.parse(therapistUsers[
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
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          ratingsValue = rating;
                                        });
                                        print(ratingsValue);
                                      },
                                    ),
                              therapistUsers[index].noOfReviewsMembers !=
                                          null &&
                                      therapistUsers[index]
                                              .noOfReviewsMembers !=
                                          0
                                  ? Text(
                                      '(${therapistUsers[index].noOfReviewsMembers})',
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
                                                  key,
                                                  //Qualififcation
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
                        therapistUsers[index].lowestPrice != null &&
                                therapistUsers[index].lowestPrice != 0
                            ? Expanded(
                                child: Row(
                                  //    crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '¥${therapistUsers[index].lowestPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '/${therapistUsers[index].leastPriceMin}',
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

  void showToolTip(String text, var key) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 2,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }
}

class RecommendLists extends StatefulWidget {
  List<UserList> getRecommendedTherapists;

  RecommendLists({Key key, @required this.getRecommendedTherapists})
      : super(key: key);

  @override
  _RecommendListsState createState() => _RecommendListsState();
}

class _RecommendListsState extends State<RecommendLists> {
  var ratingValue = 3.0;
  Map<int, String> storeTypeValues;
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  var recommendedDistanceRadius;
  List<dynamic> recommendedTherapistAddress = new List();

  @override
  void initState() {
    super.initState();
    getCertificateValues(widget.getRecommendedTherapists);
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
                    certificateUploaded["民間資格保有"] = "民間資格保有";
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

  @override
  Widget build(BuildContext context) {
    return widget.getRecommendedTherapists != null &&
            widget.getRecommendedTherapists.isNotEmpty
        ? Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width * 0.85,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: widget.getRecommendedTherapists.length,
                itemBuilder: (context, index) {
                  return buildRecommendedTherapists(index, context);
                }),
          )
        : WidgetAnimator(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      border:
                          Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
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
                                    border: Border.all(color: Colors.black12),
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
              width: MediaQuery.of(context).size.width * 0.81,
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
                                ? Container(
                                    child: SvgPicture.asset(
                                      'assets/images_gps/recommendedHeart.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                  )
                                : Container(
                                    child: SvgPicture.asset(
                                      'assets/images_gps/recommendedHeart.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
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
                              widget.getRecommendedTherapists[index].isShop == 1
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

class ColorLoader extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader({this.radius = 75.0, this.dotRadius = 5.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 1000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      //color: Colors.white,
      child: new Center(
        child: ScaleTransition(
          scale: animation_rotation,
          child: new Container(
            //color: Colors.limeAccent,
            child: new Center(
              child: Stack(
                children: <Widget>[
                  new Transform.translate(
                    offset: Offset(0.0, 0.0),
                    child: Dot(
                      radius: radius,
                      color: Colors.black12,
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.amber,
                    ),
                    offset: Offset(
                      radius * cos(0.0),
                      radius * sin(0.0),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepOrangeAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 1 * pi / 4),
                      radius * sin(0.0 + 1 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.pinkAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 2 * pi / 4),
                      radius * sin(0.0 + 2 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purple,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 3 * pi / 4),
                      radius * sin(0.0 + 3 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.yellow,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 4 * pi / 4),
                      radius * sin(0.0 + 4 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.lightGreen,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 5 * pi / 4),
                      radius * sin(0.0 + 5 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.orangeAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 6 * pi / 4),
                      radius * sin(0.0 + 6 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.blueAccent,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 7 * pi / 4),
                      radius * sin(0.0 + 7 * pi / 4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: new AssetImage('assets/images_gps/appIcon.png')),
        ),
      ),
    );
  }
}
