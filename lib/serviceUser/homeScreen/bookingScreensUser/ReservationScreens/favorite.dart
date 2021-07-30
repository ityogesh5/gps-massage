import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/favouriteTherapist/FavouriteList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
  List<CertificationUploads> certificationUploads = [];
  List<dynamic> addresses = [];
  List<Map<String, String>> certificateUploadList = List<Map<String, String>>();
  var addressOfTherapists, distanceRadius;
  List<dynamic> distanceOfTherapist = new List();

  // List<GlobalKey<ScaffoldState>> _favformKeyList;
  List<GlobalKey> _favformKeyList = List<GlobalKey>();
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    // _providerRatingList();
    Loader.show(context,
        progressIndicator: SpinKitThreeBounce(color: Colors.lime));
    getFavoriteList();
    Future.delayed(Duration(seconds: 2), () {
      Loader.hide();
    });
  }

  @override
  void dispose() {
    _favformKeyList.clear();
    super.dispose();
  }

  getFavoriteList() async {
    var getFavourite =
        ServiceUserAPIProvider.getFavouriteList(_pageNumber, _pageSize);
    getFavourite.then((value) {
      if (this.mounted) {
        setState(() {
          favouriteUserList = value.data.favouriteUserList;
          count = value.data.count;
          status = 1;
        });
      }
      getSearchResults(favouriteUserList);
    });
  }

  getSearchResults(List<FavouriteUserList> favouriteUserList) async {
    try {
      if (this.mounted) {
        setState(() {
          /*    _favformKeyList = List.generate(favouriteUserList.length,
              (index) => GlobalKey<ScaffoldState>(debugLabel: 'Fav$index')); */
          _favformKeyList.addAll(List.generate(favouriteUserList.length,
              (index) => GlobalObjectKey<FormState>('Fav$index')));
          for (int i = 0; i < favouriteUserList.length; i++) {
            Map<String, String> certificateUploaded = Map<String, String>();
            if (favouriteUserList[i]
                        .favouriteTherapistId
                        .qulaificationCertImgUrl !=
                    null &&
                favouriteUserList[i]
                        .favouriteTherapistId
                        .qulaificationCertImgUrl !=
                    '') {
              var split = favouriteUserList[i]
                  .favouriteTherapistId
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
            /* if (certificateImages.length == 0) {
              certificateImages["無資格"] = "無資格";
            }
            print('certificateImages data : $certificateImages'); */

            for (int k = 0;
                k < favouriteUserList[i].favouriteTherapistId.addresses.length;
                k++) {}
          }
        });
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Center(child: SpinKitThreeBounce(color: Colors.lime))
        : LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => _getMoreDataByType(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: favouriteUserList != null && favouriteUserList.isNotEmpty
                  ? SingleChildScrollView(
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
                                    double distance = favouriteUserList[index]
                                                    .favouriteTherapistId
                                                    .addresses[0]
                                                    .distance !=
                                                0.0 &&
                                            favouriteUserList[index]
                                                    .favouriteTherapistId
                                                    .addresses[0]
                                                    .distance !=
                                                null
                                        ? favouriteUserList[index]
                                                .favouriteTherapistId
                                                .addresses[0]
                                                .distance /
                                            1000.0
                                        : 0.0;
                                    return Container(
                                      // height: MediaQuery.of(context).size.height * 0.30,
                                      height:
                                          certificateUploadList[index].length !=
                                                      0 &&
                                                  certificateUploadList[index]
                                                          .keys
                                                          .elementAt(0) !=
                                                      "無資格"
                                              ? 190
                                              : 155.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: WidgetAnimator(
                                        InkWell(
                                          splashColor: Colors.lime,
                                          hoverColor: Colors.lime,
                                          onTap: () {
                                            HealingMatchConstants
                                                    .serviceDistanceRadius =
                                                distance;
                                            HealingMatchConstants.therapistId =
                                                favouriteUserList[index]
                                                    .therapistId;

                                            NavigationRouter
                                                .switchToServiceUserBookingDetailsCompletedScreenOne(
                                                    context,
                                                    favouriteUserList[index]
                                                        .therapistId);
                                          },
                                          child: new Card(
                                            color: Color.fromRGBO(
                                                242, 242, 242, 1),
                                            semanticContainer: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .uploadProfileImgUrl !=
                                                                    null
                                                                ? CachedNetworkImage(
                                                                    imageUrl: favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .uploadProfileImgUrl,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    fadeInCurve:
                                                                        Curves
                                                                            .easeInSine,
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      width:
                                                                          65.0,
                                                                      height:
                                                                          65.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
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
                                                                            color:
                                                                                Colors.lightGreenAccent),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Container(
                                                                      width:
                                                                          56.0,
                                                                      height:
                                                                          56.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black12),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                new AssetImage('assets/images_gps/placeholder_image.png'),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : CircleAvatar(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images_gps/placeholder_image.png',
                                                                      height:
                                                                          70,
                                                                      color: Colors
                                                                          .black,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    radius: 35,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                            SizedBox(
                                                                height: 5.0),
                                                            favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .addresses[
                                                                            0]
                                                                        .distance !=
                                                                    null
                                                                ? Text(
                                                                    '${distance.toStringAsFixed(2)}ｋｍ圏内',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          9.0,
                                                                      color: Color.fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    '0.0ｋｍ圏内',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromRGBO(
                                                                          153,
                                                                          153,
                                                                          153,
                                                                          1),
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                favouriteUserList[index].favouriteTherapistId.storeName !=
                                                                            null &&
                                                                        favouriteUserList[index].favouriteTherapistId.storeName !=
                                                                            ''
                                                                    ? Text(
                                                                        favouriteUserList[index].favouriteTherapistId.storeName.length > 10
                                                                            ? favouriteUserList[index].favouriteTherapistId.storeName.substring(0, 10) +
                                                                                "..."
                                                                            : favouriteUserList[index].favouriteTherapistId.storeName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : Text(
                                                                        favouriteUserList[index].favouriteTherapistId.userName.length > 10
                                                                            ? favouriteUserList[index].favouriteTherapistId.userName.substring(0, 10) +
                                                                                "..."
                                                                            : favouriteUserList[index].favouriteTherapistId.userName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                SizedBox(
                                                                    width: 4),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showToolTipForFav(
                                                                        favouriteUserList[index]
                                                                            .favouriteTherapistId
                                                                            .storeType,
                                                                        _favformKeyList[
                                                                            index]);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                          begin:
                                                                              Alignment.topCenter,
                                                                          end: Alignment.bottomCenter,
                                                                          colors: [
                                                                            Colors.white,
                                                                            Colors.white
                                                                          ]),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey[400],
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "assets/images_gps/info.svg",
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        key: _favformKeyList[
                                                                            index],
                                                                        // key: key,
                                                                        color: Colors
                                                                            .black,
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
                                                                        favouriteUserList[index]
                                                                            .isFavourite,
                                                                    iconSize:
                                                                        40,
                                                                    iconColor:
                                                                        Colors
                                                                            .red,
                                                                    valueChanged:
                                                                        (_isFavorite) {
                                                                      print(
                                                                          'Is Favorite : $_isFavorite');
                                                                      print(
                                                                          'Is Favorite : $_isFavorite');
                                                                      if (_isFavorite !=
                                                                              null &&
                                                                          _isFavorite) {
                                                                        // call favorite therapist API
                                                                        ServiceUserAPIProvider.favouriteTherapist(
                                                                            favouriteUserList[index].therapistId);
                                                                      } else {
                                                                        // call un-favorite therapist API
                                                                        ServiceUserAPIProvider.unFavouriteTherapist(
                                                                            favouriteUserList[index].therapistId);
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
                                                                  Visibility(
                                                                    visible: favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .isShop,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              3.0),
                                                                      child: buildProileDetailCard(
                                                                          "店舗",
                                                                          12.0),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Visibility(
                                                                    visible: favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .businessTrip,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              3.0),
                                                                      child: buildProileDetailCard(
                                                                          "出張",
                                                                          12.0),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Visibility(
                                                                    visible: favouriteUserList[
                                                                            index]
                                                                        .favouriteTherapistId
                                                                        .coronaMeasure,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              3.0),
                                                                      child: buildProileDetailCard(
                                                                          "コロナ対策実施",
                                                                          12.0),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            FittedBox(
                                                              child: Row(
                                                                children: [
                                                                  favouriteUserList[index].reviewAvgData ==
                                                                              null ||
                                                                          favouriteUserList[index].reviewAvgData ==
                                                                              "0.00"
                                                                      ? Text(
                                                                          '(0.0)',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          "  (${favouriteUserList[index].reviewAvgData.toString()})",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                            /* decoration: TextDecoration
                                                              .underline,*/
                                                                          ),
                                                                        ),
                                                                  favouriteUserList[index].reviewAvgData ==
                                                                              null ||
                                                                          favouriteUserList[index].reviewAvgData ==
                                                                              "0.00"
                                                                      ? RatingBar
                                                                          .builder(
                                                                          initialRating:
                                                                              0.00,
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              24.0,
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemPadding:
                                                                              new EdgeInsets.only(bottom: 3.0),
                                                                          itemBuilder:
                                                                              (context, rindex) {
                                                                            return new SizedBox(
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
                                                                                    )));
                                                                          },
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            print(rating);
                                                                          },
                                                                        )
                                                                      : RatingBar
                                                                          .builder(
                                                                          initialRating:
                                                                              double.parse(favouriteUserList[index].reviewAvgData),
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              24.0,
                                                                          ignoreGestures:
                                                                              true,
                                                                          itemPadding:
                                                                              new EdgeInsets.only(bottom: 3.0),
                                                                          itemBuilder:
                                                                              (context, rindex) {
                                                                            return new SizedBox(
                                                                                height: 20.0,
                                                                                width: 18.0,
                                                                                child: new IconButton(
                                                                                  onPressed: () {},
                                                                                  padding: new EdgeInsets.all(0.0),
                                                                                  // color: Colors.white,
                                                                                  icon: rindex > double.parse(favouriteUserList[index].reviewAvgData).ceilToDouble() - 1
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
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            print(rating);
                                                                          },
                                                                        ),
                                                                  favouriteUserList[index].noOfReviewsMembers ==
                                                                              null ||
                                                                          favouriteUserList[index].noOfReviewsMembers ==
                                                                              "0.00"
                                                                      ? Text(
                                                                          '(0.00)',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          '(${favouriteUserList[index].noOfReviewsMembers})',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                            /*   SizedBox(
                                                  height: 5,
                                                ), */
                                                            certificateUploadList[index]
                                                                            .length !=
                                                                        0 &&
                                                                    certificateUploadList[index]
                                                                            .keys
                                                                            .elementAt(0) !=
                                                                        "無資格"
                                                                ? Container(
                                                                    height:
                                                                        38.0,
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5.0),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        130.0, //200.0,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: certificateUploadList[index].length,
                                                                        itemBuilder: (context, subindex) {
                                                                          String
                                                                              key =
                                                                              certificateUploadList[index].keys.elementAt(subindex);
                                                                          return WidgetAnimator(
                                                                            Wrap(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: index == 0 ? const EdgeInsets.only(left: 0.0, top: 4.0, right: 4.0, bottom: 4.0) : const EdgeInsets.all(4.0),
                                                                                  child: Container(
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
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Divider(
                                                      color: Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images_gps/gps.svg',
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            height: 20,
                                                            width: 20),
                                                        SizedBox(
                                                          width: 7,
                                                        ),

                                                        Flexible(
                                                          child: Text(
                                                            favouriteUserList[
                                                                        index]
                                                                    .favouriteTherapistId
                                                                    .isShop
                                                                ? '${favouriteUserList[index].favouriteTherapistId.addresses[0].address}'
                                                                : '  ${favouriteUserList[index].favouriteTherapistId.addresses[0].capitalAndPrefecture} ${favouriteUserList[index].favouriteTherapistId.addresses[0].cityName} ${favouriteUserList[index].favouriteTherapistId.addresses[0].area}',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        // Spacer(),
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
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 1)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: new Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new AssetImage(
                                                          'assets/images_gps/appIcon.png')),
                                                )),
                                          ),
                                          SizedBox(width: 20,),
                                          Flexible(
                                            child: Text(
                                              'お気に入りに登録したセラピスト・\n店舗はありません。',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'NotoSansJP',
                                                  fontWeight:
                                                      FontWeight.bold),
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
                        ),
                      ],
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
                getSearchResults(value.data.favouriteUserList);
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

  void showToolTipForFav(String text, var _favformKeyList) {
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
      widgetKey: _favformKeyList,
    );
  }
}
