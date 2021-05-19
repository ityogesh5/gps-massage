import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bookingTimeToolTip/bookingTimeToolTip.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsCompletedScreenOne.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailCarouselWithIndicator.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailPeofileDetailsHome.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailProfileDetails.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class BookingDetailHomePage extends StatefulWidget {
  final int id;

  BookingDetailHomePage(this.id);
  @override
  _BookingDetailHomePageState createState() => _BookingDetailHomePageState();
}

class _BookingDetailHomePageState extends State<BookingDetailHomePage> {
  TherapistByIdModel therapistDetails;
  int status = 0;
  int _value = 0;
  int serviceTypeVal = 0;
  int lastIndex = 999;
  var result;
  ItemScrollController scrollController = ItemScrollController();
  List<bool> visibility = List<bool>();
  List<TherapistList> allTherapistList = List<TherapistList>();
  List<GlobalKey> globalKeyList = List<GlobalKey>();
  List<String> bannerImages = List<String>();

  String defaultBannerUrl =
      "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80";

  @override
  void initState() {
    getProviderInfo();
    super.initState();
  }

  getServiceType() async {
    print('typwe:${therapistDetails.data.storeType}');
    String serviceType = therapistDetails.data.storeType;
    var splilts = serviceType.split(',');
    final jsonListType = splilts.map((item) => jsonEncode(item)).toList();
    final uniqueJsonListType = jsonListType.toSet().toList();
    result = uniqueJsonListType.map((item) => jsonDecode(item)).toList();
  }

  getProviderInfo() async {
    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      therapistDetails =
          await ServiceUserAPIProvider.getTherapistDetails(context, widget.id);
      //append all Service Types for General View

      //add Banner Images
      if (therapistDetails.data.banners[0].bannerImageUrl1 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl1);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl2 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl2);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl3 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl3);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl4 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl4);
      }
      if (therapistDetails.data.banners[0].bannerImageUrl5 != null) {
        bannerImages.add(therapistDetails.data.banners[0].bannerImageUrl5);
      }
      if (bannerImages.length == 0) {
        bannerImages.add(defaultBannerUrl);
      }

      setState(() {
        getServiceType();

        status = 1;
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Therapist details fetch Exception : ${e.toString()}');
    }
  }

  getSubType() {
    setState(() {
      if (_value == 1) {
        allTherapistList.addAll(therapistDetails.therapistEstheticList);
      }
      if (_value == 2) {
        allTherapistList.addAll(therapistDetails.therapistOrteopathicList);
      }
      if (_value == 3) {
        allTherapistList.addAll(therapistDetails.therapistRelaxationList);
      }
      if (_value == 4) {
        allTherapistList.addAll(therapistDetails.therapistFitnessListList);
      }
    });
    for (int i = 0; i < allTherapistList.length; i++) {
      visibility.add(false);
      globalKeyList.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Container()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailCarouselWithIndicator(bannerImages),
                    DetailPeofileDetailsHome(therapistDetails, widget.id),
                    buildServiceTypeDatas(context),
                    buildServices(context),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: bookAgain(),
          );
  }

  Column buildServiceTypeDatas(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: result.contains("エステ"),
              child: GestureDetector(
                //  onTap: () => setState(() => _value = 0),
                onTap: () {
                  setState(() {
                    allTherapistList != null
                        ? allTherapistList.clear()
                        : Container();
                    _value = 1;
                    getSubType();
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 1 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 1
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 1
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeOne.svg',
                            color: _value == 1
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 29.81,
                            width: 27.61,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("接骨・整体"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 1),
                onTap: () {
                  setState(() {
                    allTherapistList != null
                        ? allTherapistList.clear()
                        : Container();
                    _value = 2;
                    getSubType();
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 2 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 2
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 2
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeTwo.svg',
                            color: _value == 2
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 33,
                            width: 34,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("リラクゼーション"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 2),
                onTap: () {
                  setState(() {
                    allTherapistList != null
                        ? allTherapistList.clear()
                        : Container();
                    _value = 3;
                    getSubType();
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 3 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 3
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 3
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeThree.svg',
                            color: _value == 3
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: result.contains("フィットネス"),
              child: GestureDetector(
                //onTap: () => setState(() => _value = 3),
                onTap: () {
                  setState(() {
                    allTherapistList != null
                        ? allTherapistList.clear()
                        : Container();
                    _value = 4;
                    getSubType();
                  });
                },
                child: Column(
                  children: [
                    Card(
                      elevation: _value == 4 ? 4.0 : 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _value == 4
                              ? Color.fromRGBO(242, 242, 242, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: _value == 4
                                ? Color.fromRGBO(102, 102, 102, 1)
                                : Color.fromRGBO(228, 228, 228, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/images_gps/serviceTypeFour.svg',
                            color: _value == 4
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            height: 35,
                            width: 27,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: result.contains("エステ"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchEsteticTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 1
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("接骨・整体"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchOsthepaticTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 2
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("リラクゼーション"),
              child: Expanded(
                child: FittedBox(
                  child: Text(
                    HealingMatchConstants.searchRelaxationTxt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _value == 3
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: result.contains("フィットネス"),
              child: Expanded(
                child: Text(
                  HealingMatchConstants.searchFitnessTxt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _value == 4
                        ? Color.fromRGBO(0, 0, 0, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column buildServices(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemScrollController: scrollController,
                itemCount: allTherapistList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildScrollCard(allTherapistList[index], index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildScrollCard(TherapistList therapistListItem, int index) {
    String path =
        assignServiceIcon(therapistListItem.name, therapistListItem.categoryId);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          key: globalKeyList[index],
          onTap: () {
            /* if (lastIndex == 999) {
              setState(() {
                visibility[index] = true;
                lastIndex = index;
              });
            } else if (visibility[index]) {
              setState(() {
                visibility[lastIndex] = false;
              });
            } else {
              setState(() {
                visibility[lastIndex] = false;
                visibility[index] = true;
                lastIndex = index;
              });
            } */
            if (index > 2 && index != allTherapistList.length - 1) {
              scrollController
                  .scrollTo(
                      index: index,
                      alignment: 0.5,
                      duration: Duration(milliseconds: 200))
                  .whenComplete(() => showToolTip(
                      globalKeyList[index], context, index, therapistListItem));
            } else {
              showToolTip(
                  globalKeyList[index], context, index, therapistListItem);
            }
          },
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: visibility[index]
                      ? Color.fromRGBO(242, 242, 242, 1)
                      : Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: visibility[index]
                        ? Color.fromRGBO(102, 102, 102, 1)
                        : Color.fromRGBO(228, 228, 228, 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    '$path',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    '${therapistListItem.name}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: visibility[index]
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Color.fromRGBO(102, 102, 102, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bookAgain() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Colors.red,
        onPressed: () {
          /*NavigationRouter.switchToServiceUserBookingConfirmationScreen(
              context);*/
        },
        child: new Text(
          'もう一度予約する',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Container buildShiftPriceCard(int min, int price) {
    return Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: true //massageTipColor == 1
              ? Color.fromRGBO(242, 242, 242, 1)
              : Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images_gps/processing.svg',
                      height: 20, width: 20, color: Colors.black),
                  SizedBox(width: 5),
                  new Text(
                    '$min分',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            new Text(
              price == 0 ? "利用できません" : '\t¥$price',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: price == 0 ? Colors.grey : Colors.black,
                  fontSize: price == 0 ? 10 : 13,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  void showToolTip(var key, BuildContext context, int index,
      TherapistList therapistListItem) {
    var width = MediaQuery.of(context).size.width - 10.0;
    print(width);
    ShowToolTip popup = ShowToolTip(context,
        index: index,
        therapistListItem: therapistListItem,
        textStyle: TextStyle(color: Colors.black),
        height: 90,
        width: MediaQuery.of(context).size.width - 20.0, //180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  String assignServiceIcon(String name, int cid) {
    //Esthetic
    if (cid == 1) {
      if (name.contains("ブライダル")) {
        return "assets/images_gps/subCategory/esthetic/bridal.svg";
      } else if (name.contains("ボディ")) {
        return "assets/images_gps/subCategory/esthetic/body.svg";
      } else if (name.contains("太もも・ヒップ")) {
        return "assets/images_gps/subCategory/esthetic/thighsHips.svg";
      } else if (name.contains("フェイシャル")) {
        return "assets/images_gps/subCategory/esthetic/facial.svg";
      } else if (name.contains("バストアップ")) {
        return "assets/images_gps/subCategory/esthetic/breastEnhancement.svg";
      } else if (name.contains("脱毛（女性")) {
        return "assets/images_gps/subCategory/esthetic/hairRemovalWomen.svg";
      } else if (name.contains("脱毛（女性")) {
        return "assets/images_gps/subCategory/esthetic/hairRemovalMen.svg";
      } else if (name.contains("アロマテラピー")) {
        return "assets/images_gps/subCategory/esthetic/aromatherapy.svg";
      } else if (name.contains("マタニティ")) {
        return "assets/images_gps/subCategory/esthetic/Maternity.svg";
      } else if (name.contains("ロミロミ")) {
        return "assets/images_gps/subCategory/esthetic/lomiLomiAndHotStone.svg";
      } else if (name.contains("ホットストーン")) {
        return "assets/images_gps/subCategory/esthetic/hotStone.svg";
      } else {
        return "assets/images_gps/subCategory/esthetic/estheticOthers.svg";
      }
    } //relaxation
    else if (cid == 4) {
      if (name.contains("もみほぐし")) {
        return "assets/images_gps/subCategory/relaxation/firLoosening.svg";
      } else if (name.contains("リンパ")) {
        return "assets/images_gps/subCategory/relaxation/lymph.svg";
      } else if (name.contains("カイロプラクティック")) {
        return "assets/images_gps/subCategory/relaxation/chiropractic.svg";
      } else if (name.contains("コルギ")) {
        return "assets/images_gps/subCategory/relaxation/Corgi.svg";
      } else if (name.contains("リフレクソロジー")) {
        return "assets/images_gps/subCategory/relaxation/reflexology.svg";
      } else if (name.contains("タイ古式")) {
        return "assets/images_gps/subCategory/relaxation/thaiTraditional.svg";
      } else if (name.contains("カッピング")) {
        return "assets/images_gps/subCategory/relaxation/cupping1.svg";
      } else {
        return "assets/images_gps/subCategory/relaxation/relaxationOthers.svg";
      }
    }
    //treatment
    else if (cid == 3) {
      if (name.contains("はり")) {
        return "assets/images_gps/subCategory/osteopathic/needle.svg";
      } else if (name.contains("美容鍼（顔）")) {
        return "assets/images_gps/subCategory/osteopathic/beautyAcupunctureFace.svg";
      } else if (name.contains("きゅう")) {
        return "assets/images_gps/subCategory/osteopathic/Kyu.svg";
      } else if (name.contains("マッサージ")) {
        return "assets/images_gps/subCategory/osteopathic/Massage.svg";
      } else if (name.contains("ストレッチ")) {
        return "assets/images_gps/subCategory/osteopathic/stretch.svg";
      } else if (name.contains("矯正")) {
        return "assets/images_gps/subCategory/osteopathic/orthodontics.svg";
      } else if (name.contains("カッピング")) {
        return "assets/images_gps/subCategory/osteopathic/cupping.svg";
      } else if (name.contains("マタニティ")) {
        return "assets/images_gps/subCategory/osteopathic/maternity1.svg";
      } else if (name.contains("ベビーマッサージ")) {
        return "assets/images_gps/subCategory/osteopathic/babyMassage.svg";
      }
      //other fields
      else {
        return "assets/images_gps/subCategory/osteopathic/othersOrthopatic.svg";
      }
    }
    //fitness
    else if (cid == 2) {
      if (name.contains("ヨガ")) {
        return "assets/images_gps/subCategory/fitness/yoga.svg";
      } else if (name.contains("ホットヨガ")) {
        return "assets/images_gps/subCategory/fitness/hotYoga.svg";
      } else if (name.contains("ピラティス")) {
        return "assets/images_gps/subCategory/fitness/pilates.svg";
      } else if (name.contains("トレーニング")) {
        return "assets/images_gps/subCategory/fitness/training.svg";
      } else if (name.contains("エクササイズ")) {
        //check icon
        return "assets/images_gps/subCategory/fitness/exercise.svg";
      }
      //other fields
      else {
        return "assets/images_gps/subCategory/fitness/othersFitness.svg";
      }
    }
    return "";
  }
}
