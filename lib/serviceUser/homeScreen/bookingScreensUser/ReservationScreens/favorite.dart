import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/favouriteTherapist/FavouriteList.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

var therapistId;

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

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  double ratingsValue = 3.0;
  bool isLoading = false;
  var _pageNumber = 0;
  var _pageSize = 10;
  int count = 0;
  int status = 0;

  List<FavouriteUserList> favouriteUserList = List();
  Map<int, String> storeTypeValues;
  Map<String, String> certificateImages = Map<String, String>();
  List<CertificationUploads> certificationUploads = [];
  List<dynamic> addresses = [];
  var certificateUploadKeys;
  var addressOfTherapists, distanceRadius;
  List<dynamic> distanceOfTherapist = new List();
  List<GlobalObjectKey<FormState>> formKeyList;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    // _providerRatingList();
    getFavoriteList();
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

  getFavoriteList() async {
    var getFavourite =
        ServiceUserAPIProvider.getFavouriteList(_pageNumber, _pageSize);
    getFavourite.then((value) {
      if (this.mounted) {
        setState(() {
          favouriteUserList = value.data.favouriteUserList;
          count = value.data.count;
        });
      }
      getSearchResults(favouriteUserList);
    });
  }

  getSearchResults(List<FavouriteUserList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          formKeyList = List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>(index));
          for (int i = 0; i < favouriteUserList.length; i++) {
            if (favouriteUserList[i]
                    .favouriteTherapistId
                    .certificationUploads !=
                null) {
              certificationUploads = favouriteUserList[i]
                  .favouriteTherapistId
                  .certificationUploads;

              for (int j = 0; j < certificationUploads.length; j++) {
                print(
                    'Certificate upload : ${certificationUploads[j].toJson()}');
                certificateUploadKeys = certificationUploads[j].toJson();
                certificateUploadKeys.remove('id');
                certificateUploadKeys.remove('userId');
                certificateUploadKeys.remove('createdAt');
                certificateUploadKeys.remove('updatedAt');
                print('Keys certificate : $certificateUploadKeys');
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
              print('certificateImages data : $certificateImages');
            }
            for (int k = 0;
                k < favouriteUserList[i].favouriteTherapistId.addresses.length;
                k++) {
              if (favouriteUserList[i].favouriteTherapistId.addresses != null) {
                addresses.add(favouriteUserList[i]
                    .favouriteTherapistId
                    .addresses[k]
                    .address);

                distanceOfTherapist.add(favouriteUserList[i]
                    .favouriteTherapistId
                    .addresses[k]
                    .distance
                    .toStringAsFixed(2));

                addressOfTherapists = addresses;

                distanceRadius = distanceOfTherapist;
                print(
                    'Position values : ${addressOfTherapists[0]} && ${addresses.length}');
              }
            }
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
    return LazyLoadScrollView(
      isLoading: isLoading,
      onEndOfPage: () => _getMoreDataByType(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  //height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: favouriteUserList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.30,
                          height: 190,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: WidgetAnimator(
                            InkWell(
                              splashColor: Colors.lime,
                              hoverColor: Colors.lime,
                              onTap: () {
                                HealingMatchConstants.therapistId =
                                    favouriteUserList[index].therapistId;

                                NavigationRouter
                                    .switchToServiceUserBookingDetailsCompletedScreenOne(
                                        context,
                                        HealingMatchConstants.therapistId);
                              },
                              child: new Card(
                                color: Color.fromRGBO(242, 242, 242, 1),
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                favouriteUserList[index]
                                                            .favouriteTherapistId
                                                            .uploadProfileImgUrl !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl: favouriteUserList[
                                                                index]
                                                            .favouriteTherapistId
                                                            .uploadProfileImgUrl,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                        fadeInCurve:
                                                            Curves.easeInSine,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 65.0,
                                                          height: 65.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
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
                                                            Container(
                                                          width: 56.0,
                                                          height: 56.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12),
                                                            image: DecorationImage(
                                                                image: new AssetImage(
                                                                    'assets/images_gps/placeholder_image.png'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        child: Image.asset(
                                                          'assets/images_gps/placeholder_image.png',
                                                          height: 70,
                                                          color: Colors.black,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        radius: 35,
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
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
                                                    favouriteUserList[index]
                                                                .favouriteTherapistId
                                                                .storeName !=
                                                            null
                                                        ? Text(
                                                            '${favouriteUserList[index].favouriteTherapistId.storeName}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            '${favouriteUserList[index].favouriteTherapistId.userName}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                    SizedBox(width: 4),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white
                                                              ]),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey[400],
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images_gps/info.svg",
                                                            height: 10.0,
                                                            width: 10.0,
                                                            // key: key,
                                                            color: Colors.black,
                                                          ), /* Icon(
                                                            Icons
                                                                .shopping_bag_rounded,
                                                            key: key,
                                                            color: Colors.black ), */
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    FavoriteButton(
                                                        isFavorite:
                                                            favouriteUserList[
                                                                    index]
                                                                .isFavourite,
                                                        iconSize: 40,
                                                        iconColor: Colors.red,
                                                        valueChanged:
                                                            (_isFavorite) {
                                                          print(
                                                              'Is Favorite : $_isFavorite');
                                                          if (_isFavorite !=
                                                                  null &&
                                                              _isFavorite) {
                                                            // call favorite therapist API
                                                            ServiceUserAPIProvider
                                                                .favouriteTherapist(
                                                                    favouriteUserList[
                                                                            index]
                                                                        .therapistId);
                                                          } else {
                                                            // call un-favorite therapist API
                                                            ServiceUserAPIProvider
                                                                .unFavouriteTherapist(
                                                                    favouriteUserList[
                                                                            index]
                                                                        .therapistId);
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
                                                            .spaceBetween,
                                                    children: [
                                                      favouriteUserList[index]
                                                              .favouriteTherapistId
                                                              .isShop
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child:
                                                                  buildProileDetailCard(
                                                                      "店舗",
                                                                      12.0),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      favouriteUserList[index]
                                                              .favouriteTherapistId
                                                              .businessTrip
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child:
                                                                  buildProileDetailCard(
                                                                      "出張",
                                                                      12.0),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      favouriteUserList[index]
                                                              .favouriteTherapistId
                                                              .coronaMeasure
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0),
                                                              child:
                                                                  buildProileDetailCard(
                                                                      "コロナ対策実施",
                                                                      12.0),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "  (${favouriteUserList[index].reviewAvgData.toString()})",
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                          /* decoration: TextDecoration
                                                              .underline,*/
                                                        ),
                                                      ),
                                                      RatingBar.builder(
                                                        initialRating: 4.5,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 24.0,
                                                        ignoreGestures: true,
                                                        itemPadding:
                                                            new EdgeInsets.only(
                                                                bottom: 3.0),
                                                        itemBuilder: (context,
                                                                index) =>
                                                            new SizedBox(
                                                                height: 20.0,
                                                                width: 18.0,
                                                                child:
                                                                    new IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  padding:
                                                                      new EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  // color: Colors.white,
                                                                  icon: index >
                                                                          (4.5).ceilToDouble() -
                                                                              1
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          "assets/images_gps/star_2.svg",
                                                                          height:
                                                                              13.0,
                                                                          width:
                                                                              13.0,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          "assets/images_gps/star_colour.svg",
                                                                          height:
                                                                              13.0,
                                                                          width:
                                                                              13.0,
                                                                          //color: Colors.black,
                                                                        ),
                                                                )),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                      Text(
                                                        '(${favouriteUserList[index].noOfReviewsMembers})',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              153, 153, 153, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                                                              return WidgetAnimator(
                                                                Wrap(
                                                                  children: [
                                                                    Padding(
                                                                      padding: index ==
                                                                              0
                                                                          ? const EdgeInsets.only(
                                                                              left: 0.0,
                                                                              top: 4.0,
                                                                              right: 4.0,
                                                                              bottom: 4.0)
                                                                          : const EdgeInsets.all(4.0),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(5),
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
                                                                ),
                                                              );
                                                            }),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/images_gps/gps.svg',
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                height: 20,
                                                width: 20),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              '${addressOfTherapists[index]}',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            distanceRadius[index] != null
                                                ? Text(
                                                    '${distanceRadius[index]}ｋｍ圏内',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  )
                                                : Text(
                                                    '0.0ｋｍ圏内',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          153, 153, 153, 1),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
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

  Container buildProileDetailCard(String key, double size) {
    return Container(
        padding: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
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
        child: Text(
          '$key',
          style: TextStyle(fontSize: size),
        ));
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
              ServiceUserAPIProvider.getFavouriteList(_pageNumber, _pageSize);
          providerListApiProvider.then((value) {
            if (value.data.favouriteUserList.isEmpty) {
              setState(() {
                isLoading = false;
                print(
                    'TherapistList data count is Zero : ${value.data.favouriteUserList.length}');
              });
            } else {
              print(
                  'TherapistList data Size : ${value.data.favouriteUserList.length}');
              setState(() {
                isLoading = false;
                if (this.mounted) {
                  favouriteUserList.addAll(value.data.favouriteUserList);
                }
                getSearchResults(favouriteUserList);
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
