import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/UserBannerImagesModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/Repository/therapist_type_repository.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_bloc.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_event.dart';
import 'package:gps_massageapp/serviceUser/BlocCalls/HomeScreenBlocCalls/therapist_type_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

List<String> userBannerImages = [];
List<String> _options = ['エステ', 'リラクゼーション', '整骨・整体', 'フィットネス'];
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

int _selectedIndex;
List<UserList> therapistListByType = [];
List<TherapistUserList> therapistUsers = [];
var accessToken;
Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

void main() {
  runApp(UserHomeScreen());
}

String result = '';
var colorsValue = Colors.white;

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreen> {
  String accessToken;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    getId();
    super.initState();
  }

  getId() async {
    // ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      ProgressDialogBuilder.showCommonProgressDialog(context);
      _sharedPreferences.then((value) {
        accessToken = value.getString('accessToken');
        ProgressDialogBuilder.hideCommonProgressDialog(context);

        setState(() {
          HealingMatchConstants.uAccessToken = accessToken;
        });
      });
    } catch (e) {}
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

  convertBase64ProfileImage(String therapistProfileImage) async {
    imgBase64TherapistImage =
        await networkImageToBase64RightFront(therapistProfileImage);
    therapistImageInBytes = Base64Decoder().convert(imgBase64TherapistImage);
    setState(() {
      HealingMatchConstants.therapistProfileImageInBytes =
          therapistImageInBytes;
      print(
          'Bytes images : ${HealingMatchConstants.therapistProfileImageInBytes}');
    });
  }

//Profile Image
  Future<String> networkImageToBase64RightFront(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
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

class InitialUserHomeScreen extends StatefulWidget {
  @override
  State createState() {
    return _InitialUserHomeScreenState();
  }
}

class _InitialUserHomeScreenState extends State<InitialUserHomeScreen> {
  @override
  void initState() {
    CheckInternetConnection.checkConnectivity(context);
    super.initState();
    getAccessToken();
  }

  getAccessToken() async {
    _sharedPreferences.then((value) {
      accessToken = value.getString('accessToken');
      if (accessToken != null) {
        print('Access token value : $accessToken');
        HealingMatchConstants.accessToken = accessToken;
        getBannerImages();
      } else {
        print('No token value found !!');
      }
    });
  }

  getBannerImages() async {
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
                return LoadHomePage();
              } else if (state is GetTherapistTypeLoaderState) {
                print('Loader widget');
                return LoadInitialHomePage();
              } else if (state is GetTherapistTypeLoadedState) {
                print('Loaded users state');
                return HomeScreenByMassageType(
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

class LoadHomePage extends StatefulWidget {
  @override
  State createState() {
    return _LoadHomePageState();
  }
}

class _LoadHomePageState extends State<LoadHomePage> {
  TherapistTypeBloc _therapistTypeBloc;

  @override
  void initState() {
    CheckInternetConnection.checkConnectivity(context);
    super.initState();
    _therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    NavigationRouter.switchToServiceUserSearchScreen(context);
                  },
                  child: InkWell(
                    onTap: () {
                      NavigationRouter.switchToServiceUserSearchScreen(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6.0),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.85,
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
                            color: Color.fromRGBO(102, 102, 102, 1),
                          ),
                          borderRadius: BorderRadius.circular(7.0),
                          color: Color.fromRGBO(228, 228, 228, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'キーワードでさがす',
                              style: TextStyle(
                                  color: Color.fromRGBO(225, 225, 225, 1),
                                  fontSize: 14,
                                  fontFamily: 'NotoSansJP'),
                            ),
                            Spacer(),
                            InkWell(
                              child: Image.asset(
                                "assets/images_gps/search.png",
                                color: Color.fromRGBO(225, 225, 225, 1),
                              ),
                              onTap: () {
                                NavigationRouter
                                    .switchToServiceUserSearchScreen(context);
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
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
                      NavigationRouter.switchToNearByProviderAndShop(context);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PaginationSample()));*/
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
          BuildProviderUsers(),
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
                    fontFamily: ColorConstants.fontFamily,
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavigationRouter.switchToRecommended(context);
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
          RecommendLists(),
          Container(height: 65),
        ],
      ),
    );
  }
}

class HomeScreenByMassageType extends StatefulWidget {
  List<UserList> getTherapistByType;

  HomeScreenByMassageType({Key key, @required this.getTherapistByType})
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
    return widget.getTherapistByType != null &&
            widget.getTherapistByType.isNotEmpty
        ? Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          NavigationRouter.switchToServiceUserSearchScreen(
                              context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextFormField(
                            readOnly: true,
                            autofocus: false,
                            textInputAction: TextInputAction.search,
                            decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'キーワードでさがす',
                                suffixIcon: InkWell(
                                  child: Image.asset(
                                      "assets/images_gps/search.png"),
                                  onTap: () {
                                    NavigationRouter
                                        .switchToServiceUserSearchScreen(
                                            context);
                                  },
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                    fontFamily: 'NotoSansJP'),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                            NavigationRouter.switchToNearByProviderAndShop(
                                context);
                          },
                          child: Text(
                            'もっと見る',
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
                      Text(
                        'もっとみる',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                RecommendLists(),
                Container(height: 65),
              ],
            ),
          )
        : Container(
            child: Center(
              child: Text(
                '近くにはセラピストもお店もありません。',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansJP',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
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
                    duration: Duration(seconds: 1),
                    //Default value
                    interval: Duration(seconds: 2),
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
              duration: Duration(seconds: 1),
              //Default value
              interval: Duration(seconds: 2),
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
              duration: Duration(seconds: 1),
              //Default value
              interval: Duration(seconds: 2),
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
                      return new Card(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
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
                      );
                    }),
              ),
            ),
          ),
          Shimmer(
            duration: Duration(seconds: 1),
            //Default value
            interval: Duration(seconds: 1),
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
            duration: Duration(seconds: 1),
            //Default value
            interval: Duration(seconds: 2),
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
                duration: Duration(seconds: 1),
                //Default value
                interval: Duration(seconds: 2),
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
                      return new Card(
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
                                        border:
                                            Border.all(color: Colors.grey[200]),
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
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer(
            duration: Duration(seconds: 1),
            //Default value
            interval: Duration(seconds: 2),
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

//Build therapists list view

class BuildProviderListByType extends StatefulWidget {
  List<UserList> getTherapistByType;

  BuildProviderListByType({Key key, @required this.getTherapistByType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BuildProviderListByTypeState();
  }
}

class _BuildProviderListByTypeState extends State<BuildProviderListByType> {
  @override
  void initState() {
    super.initState();
  }

  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        width: MediaQuery.of(context).size.width * 0.95,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: widget.getTherapistByType.length,
            itemBuilder: (context, index) {
              return new Card(
                color: Color.fromRGBO(242, 242, 242, 1),
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              widget.getTherapistByType[index].user
                                          .uploadProfileImgUrl !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.getTherapistByType[index]
                                          .user.uploadProfileImgUrl,
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
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images_gps/user.png'),
                                    )
                                  : new Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.none,
                                            image: new AssetImage(
                                                'assets/images_gps/user.png')),
                                      )),
                              FittedBox(
                                child: Text(
                                  '1.5km圏内',
                                  style: TextStyle(
                                    fontFamily: ColorConstants.fontFamily,
                                    fontSize: 12,
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 5),
                                  widget.getTherapistByType[index].user
                                              .userName !=
                                          null
                                      ? Text(
                                          '${widget.getTherapistByType[index].user.userName}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          'お名前',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      /* NavigationRouter
                                          .switchToServiceUserReservationAndFavourite(
                                              context);*/
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 10,
                                      backgroundColor: Colors.black26,
                                      child: CircleAvatar(
                                        maxRadius: 8,
                                        backgroundColor: Colors.white,
                                        child: SvgPicture.asset(
                                            'assets/images_gps/info.svg',
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            height: 15,
                                            width: 15),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  FavoriteButton(
                                      iconSize: 40,
                                      iconColor: Colors.red,
                                      valueChanged: (_isFavorite) {
                                        print('Is Favorite : $_isFavorite');
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 5),
                                    widget.getTherapistByType[index].user
                                                .businessForm
                                                .contains('施術店舗あり 施術従業員あり') ||
                                            widget.getTherapistByType[index]
                                                .user.businessForm
                                                .contains(
                                                    '施術店舗あり 施術従業員なし（個人経営）') ||
                                            widget.getTherapistByType[index]
                                                .user.businessForm
                                                .contains('施術店舗なし 施術従業員なし（個人)')
                                        ? Visibility(
                                            visible: true,
                                            child: Container(
                                                padding: EdgeInsets.all(4),
                                                color: Colors.white,
                                                child: Text('店舗')),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Visibility(
                                      visible: widget.getTherapistByType[index]
                                          .user.businessTrip,
                                      child: Container(
                                          padding: EdgeInsets.all(4),
                                          color: Colors.white,
                                          child: Text('出張')),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Visibility(
                                      visible: widget.getTherapistByType[index]
                                          .user.coronaMeasure,
                                      child: Container(
                                          padding: EdgeInsets.all(4),
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
                                  Text(
                                    '(${ratingsValue.toString()})',
                                    style: TextStyle(
                                      fontFamily: ColorConstants.fontFamily,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 22,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 5,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratingsValue = rating;
                                      });
                                      print(ratingsValue);
                                    },
                                  ),
                                  Text(
                                    '(1518)',
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: ColorConstants.fontFamily),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        '国家資格保有',
                                        style: TextStyle(
                                          fontFamily: ColorConstants.fontFamily,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      )),
                                  Spacer(),
                                  widget.getTherapistByType[index].sixtyMin == 0
                                      ? Text(
                                          '¥0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        )
                                      : Text(
                                          '¥${widget.getTherapistByType[index].sixtyMin}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                  //Text('/60分')
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
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
    return userBannerImages != null
        ? Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  CarouselSlider(
                    items: <Widget>[
                      for (int i = 0; i < userBannerImages.length; i++)
                        Container(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Stack(
                                  children: <Widget>[
                                    /*Image.network(userBannerImages[i],
                                        fit: BoxFit.cover, width: 2000.0),*/
                                    CachedNetworkImage(
                                        width: 2000.0,
                                        fit: BoxFit.cover,
                                        imageUrl: userBannerImages[i],
                                        placeholder: (context, url) =>
                                            SpinKitWave(
                                                color: Colors.lightBlueAccent),
                                        errorWidget: (context, url, error) =>
                                            Column(
                                              children: [
                                                Text(
                                                  'Failed to Download Banners...Try Again!!',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                new IconButton(
                                                  icon: Icon(
                                                      Icons.refresh_sharp,
                                                      size: 40),
                                                  onPressed: () {
                                                    _getBannerImages();
                                                  },
                                                ),
                                              ],
                                            )),
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
    return HealingMatchConstants.isBookingDone
        ? Container(
            padding: EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [Text('今後の予約')],
                    ),
                    ListTile(
                      leading: new Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new AssetImage(
                                    'assets/images_gps/logo.png')),
                          )),
                      title: Row(
                        children: [
                          Text('お名前'),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            maxRadius: 10,
                            backgroundColor: Colors.black26,
                            child: CircleAvatar(
                              maxRadius: 8,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                  'assets/images_gps/info.svg',
                                  height: 15,
                                  width: 15),
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/images_gps/processing.svg',
                              height: 17, width: 15),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '承認待ち',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          )
                        ],
                      ),

                      // trailing: Text('承認待ち'),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '4.0',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 5,
                                  color: Colors.black,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text('(1518)'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images_gps/clock.svg',
                                  height: 15, width: 15),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '09: 00 ~ 10: 00',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              //Text('(60分)')
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images_gps/cost.svg',
                                  height: 20, width: 20),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '¥4,500',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              Text('(オフィス)'),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      // height: 50,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/location.svg',
                            height: 20, width: 15),
                        Text('オフィス'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          child: RaisedButton(
                            child: Text(
                              'オフィス',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            color: Colors.white,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('オフィス')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.22,
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
                      CircleAvatar(
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
                                        color: Color.fromRGBO(200, 217, 33, 1),
                                      ),
                                    )
                                  : Text(
                                      '3月',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NotoSansJP',
                                        color: Color.fromRGBO(200, 217, 33, 1),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            '頑張りすぎのあなた・・。\nそろそろリフレッシュしませんか？',
                            style: TextStyle(
                                fontSize: 14,
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

class RecommendLists extends StatefulWidget {
  @override
  _RecommendListsState createState() => _RecommendListsState();
}

class _RecommendListsState extends State<RecommendLists> {
  var ratingValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return new Card(
              color: Color.fromRGBO(242, 242, 242, 1),
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            new Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new AssetImage(
                                          'assets/images_gps/logo.png')),
                                )),
                            FittedBox(
                              child: Text(
                                '1.5km圏内',
                                style: TextStyle(
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontFamily: ColorConstants.fontFamily,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'お店名',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: ColorConstants.fontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                FavoriteButton(
                                    iconSize: 40,
                                    iconColor: Colors.red,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        '店舗',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        '出張',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ]),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.grey[200]),
                                      child: Text(
                                        'コロナ対策実施',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: ColorConstants.fontFamily,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  '(${ratingValue.toString()})',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      decoration: TextDecoration.underline,
                                      fontFamily: ColorConstants.fontFamily),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 22,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 5,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  onRatingUpdate: (rating) {
                                    // print(rating);
                                    setState(() {
                                      ratingValue = rating;
                                    });

                                    print(ratingValue);
                                  },
                                ),
                                Text(
                                  '(1518)',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: ColorConstants.fontFamily),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                            ]),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.grey[200]),
                                    child: Text(
                                      '国家資格保有',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: ColorConstants.fontFamily,
                                      ),
                                    )),
                                Spacer(),
                                Text(
                                  '¥4,500',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: ColorConstants.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
/*
                                Text(
                                  '/60分',
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: ColorConstants.fontFamily),
                                )*/

                                //Text('/60分')
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
          }),
    );
  }
}

class BuildProviderUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildProviderUsersState();
  }
}

class _BuildProviderUsersState extends State<BuildProviderUsers> {
  var _pageNumber = 1;
  var _pageSize = 1;

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  getAccessToken() async {
    _sharedPreferences.then((value) {
      accessToken = value.getString('accessToken');
      if (accessToken != null) {
        print('Access token value : $accessToken');
        HealingMatchConstants.accessToken = accessToken;
        getTherapists();
      } else {
        print('No prefs value found !!');
      }
    });
  }

  // get therapist api
  getTherapists() async {
    therapistUsers.clear();
    try {
      var apiProvider = ServiceUserAPIProvider.getAllTherapistsByLimit(
          _pageNumber, _pageSize);
      // wait for 2 seconds to simulate loading of data
      await Future.delayed(const Duration(seconds: 2));
      apiProvider.then((value) {
        if (this.mounted) {
          setState(() {
            therapistUsers = value.therapistData.therapistUserList;
            for (int i = 0; i < therapistUsers.length; i++) {}
            print(
                'Provider data : ${value.therapistData.therapistUserList.length}');
          });
        }
      }).catchError((onError) {
        print('Catch Error Exception caught : ${onError.toString()}');
      });
    } catch (e) {
      print('Exception caught : ${e.toString()}');
      throw Exception(e);
    }
  }

  double ratingsValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return therapistUsers != null && therapistUsers.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width * 0.95,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: therapistUsers.length,
                  itemBuilder: (context, index) {
                    return new Card(
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
                                            imageUrl: therapistUsers[index]
                                                .user
                                                .uploadProfileImgUrl,
                                            filterQuality: FilterQuality.high,
                                            fadeInCurve: Curves.easeInSine,
                                            imageBuilder:
                                                (context, imageProvider) =>
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
                                                Image.asset(
                                                    'assets/images_gps/user.png'),
                                          )
                                        : new Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12),
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.none,
                                                  image: new AssetImage(
                                                      'assets/images_gps/user.png')),
                                            )),
                                    FittedBox(
                                      child: Text(
                                        '1.5km圏内',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 5),
                                        therapistUsers[index].user.userName !=
                                                null
                                            ? Row(
                                                children: [
                                                  Text(
                                                    '${therapistUsers[index].user.userName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                'お名前',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        SizedBox(width: 4),
                                        InkWell(
                                          onTap: () {
                                            NavigationRouter
                                                .switchToServiceUserReservationAndFavourite(
                                                    context);
                                          },
                                          child: CircleAvatar(
                                            maxRadius: 10,
                                            backgroundColor: Colors.black26,
                                            child: CircleAvatar(
                                              maxRadius: 8,
                                              backgroundColor: Colors.white,
                                              child: SvgPicture.asset(
                                                  'assets/images_gps/info.svg',
                                                  height: 15,
                                                  width: 15),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        FavoriteButton(
                                            iconSize: 40,
                                            iconColor: Colors.red,
                                            valueChanged: (_isFavorite) {
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
                                        children: [
                                          SizedBox(width: 5),
                                          therapistUsers[index]
                                                      .user
                                                      .businessForm
                                                      .contains(
                                                          '施術店舗あり 施術従業員あり') ||
                                                  therapistUsers[index]
                                                      .user
                                                      .businessForm
                                                      .contains(
                                                          '施術店舗あり 施術従業員なし（個人経営）') ||
                                                  therapistUsers[index]
                                                      .user
                                                      .businessForm
                                                      .contains(
                                                          '施術店舗なし 施術従業員なし（個人)')
                                              ? Visibility(
                                                  visible: true,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      color: Colors.white,
                                                      child: Text('店舗')),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Visibility(
                                            visible: therapistUsers[index]
                                                .user
                                                .businessTrip,
                                            child: Container(
                                                padding: EdgeInsets.all(4),
                                                color: Colors.white,
                                                child: Text('出張')),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Visibility(
                                            visible: therapistUsers[index]
                                                .user
                                                .coronaMeasure,
                                            child: Container(
                                                padding: EdgeInsets.all(4),
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
                                        Text(
                                          ratingsValue.toString(),
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            size: 5,
                                            color: Colors.black,
                                          ),
                                          onRatingUpdate: (rating) {
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
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(4),
                                            color: Colors.white,
                                            child: Text('コロナ対策実施')),
                                        Spacer(),
                                        therapistUsers[index].sixtyMin == 0
                                            ? Text(
                                                '¥0',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19),
                                              )
                                            : Text(
                                                '¥${therapistUsers[index].sixtyMin}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19),
                                              ),
                                        //Text('/60分')
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        : Container(
            child: Center(
              child: Text(
                '近くにはセラピストもお店もありません。',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NotoSansJP',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
  }
}
