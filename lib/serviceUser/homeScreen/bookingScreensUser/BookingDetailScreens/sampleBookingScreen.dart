import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bookingTimeToolTip/bookingTimeToolTip.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailCarouselWithIndicator.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/detailProfileDetails.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SampleBookingScreen extends StatefulWidget {
  final int id;
  SampleBookingScreen(this.id);
  @override
  _SampleBookingScreenState createState() => _SampleBookingScreenState();
}

class _SampleBookingScreenState extends State<SampleBookingScreen> {
  TherapistByIdModel therapistDetails;
  int status = 0;
  int lastIndex = 999;
  int min = 0;
  var serviceName, serviceDuration, serviceCostMap, serviceCost, subCategoryId;
  ItemScrollController scrollController = ItemScrollController();
  List<bool> visibility = List<bool>();
  List<TherapistList> allTherapistList = List<TherapistList>();
  List<GlobalKey> globalKeyList = List<GlobalKey>();
  List<String> bannerImages = List<String>();
  Map<String, Map<int, int>> serviceSelection = Map<String, Map<int, int>>();
  int serviceCId;
  int serviceSubId;
  var finalAmount;
  DateTime selectedTime, endTime;
  String defaultBannerUrl =
      "https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80";

  @override
  void initState() {
    getProviderInfo();
    super.initState();
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
                    DetailProfileDetails(therapistDetails),
                    buildServices(context),
                    dateTimeInfoBuilder(context),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: bookAgain(),
          );
  }

  dateTimeInfoBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        left: 14.0,
        bottom: 4.0,
      ),
      child: Container(
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
        width: MediaQuery.of(context).size.width * 0.90,
        height: 90.0,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 12.0, bottom: 8.0, right: 8.0),
          child: Container(
            child: buildDateTimeDetails(),
          ),
        ),
      ),
    );
  }

  Widget buildDateTimeDetails() {
    return Row(
      children: [
        selectedTime != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images_gps/calendar.svg',
                            height: 16, width: 16),
                        SizedBox(width: 10),
                        new Text(
                          '${selectedTime.day}月${selectedTime.month}:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                        SizedBox(width: 5),
                        new Text(
                          "月曜日",
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images_gps/clock.svg',
                            height: 14, width: 14),
                        SizedBox(width: 7),
                        new Text(
                          '${selectedTime.hour}:${selectedTime.minute} ～ ${endTime.hour}:${endTime.minute}',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                        SizedBox(width: 5),
                        new Text(
                          '$min分',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                'サービスを受ける日時を \nカレンダーから選択してください',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontFamily: 'NotoSansJP'),
              ),
        Spacer(),
        InkWell(
          onTap: () {
            HealingMatchConstants.callBack = updateDateTimeSelection;
            NavigationRouter.switchToUserChooseDate(context);
          },
          child: Card(
            shape: CircleBorder(),
            elevation: 8.0,
            child: CircleAvatar(
              maxRadius: 20,
              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
              child: CircleAvatar(
                maxRadius: 38,
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                child: SvgPicture.asset(
                  'assets/images_gps/calendar.svg',
                  height: 20,
                  width: 20,
                  color: Color.fromRGBO(200, 217, 33, 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void updateDateTimeSelection(DateTime time) {
    setState(() {
      selectedTime = time;
      endTime = DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          selectedTime.hour,
          selectedTime.minute + min,
          selectedTime.second);
    });
  }

  getProviderInfo() async {
    try {
      HealingMatchConstants.selectedDateTime = null;
      ProgressDialogBuilder.showOverlayLoader(context);
      therapistDetails =
          await ServiceUserAPIProvider.getTherapistDetails(context, widget.id);
      HealingMatchConstants.therapistProfileDetails = therapistDetails;
      //append all Service Types for General View
      setState(() {
        if (HealingMatchConstants.serviceType != 0 &&
            HealingMatchConstants.serviceType == 1) {
          allTherapistList.addAll(therapistDetails.therapistEstheticList);
        }
        if (HealingMatchConstants.serviceType != 0 &&
            HealingMatchConstants.serviceType == 2) {
          allTherapistList.addAll(therapistDetails.therapistRelaxationList);
        }
        if (HealingMatchConstants.serviceType != 0 &&
            HealingMatchConstants.serviceType == 3) {
          allTherapistList.addAll(therapistDetails.therapistOrteopathicList);
        }
        if (HealingMatchConstants.serviceType != 0 &&
            HealingMatchConstants.serviceType == 1) {
          allTherapistList.addAll(therapistDetails.therapistFitnessListList);
        }
      });

      for (int i = 0; i < allTherapistList.length; i++) {
        visibility.add(false);
        globalKeyList.add(GlobalKey());
      }

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
        status = 1;
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Therapist details fetch Exception : ${e.toString()}');
    }
  }

  Column buildServices(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 14.0,
            bottom: 4.0,
          ),
          child: Text(
            "施術メニューを選んでください",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
            serviceCId = therapistListItem.categoryId;
            serviceSubId = therapistListItem.subCategoryId;
            if (lastIndex == 999) {
              setState(() {
                visibility[index] = true;
                lastIndex = index;
              });
              scrollListandToolTipCall(index, therapistListItem);
            } else if (visibility[index]) {
              scrollListandToolTipCall(index, therapistListItem);
              /* setState(() {
                serviceSelection.clear();
                visibility[lastIndex] = false;
              }); */
            } else {
              setState(() {
                serviceSelection.clear();
                visibility[lastIndex] = false;
                visibility[index] = true;
                lastIndex = index;
              });
              scrollListandToolTipCall(index, therapistListItem);
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

  void scrollListandToolTipCall(int index, TherapistList therapistListItem) {
    if (index > 2 && index != allTherapistList.length - 1) {
      scrollController
          .scrollTo(
              index: index,
              alignment: 0.5,
              duration: Duration(milliseconds: 200))
          .whenComplete(() => showToolTip(
              globalKeyList[index], context, index, therapistListItem));
    } else {
      showToolTip(globalKeyList[index], context, index, therapistListItem);
    }
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
          bookingConfirmField();
        },
        child: new Text(
          '予約に進む',
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

  //Method called from ShowtoolTip to refresh the page after TimePicker is Selected
  updateServiceSelection(int index, Map<int, int> timePriceSelection) {
    setState(() {
      if (timePriceSelection.length != 0) {
        serviceSelection.clear();
        serviceSelection[allTherapistList[index].name] = timePriceSelection;

        min = timePriceSelection.keys.first;
        HealingMatchConstants.selectedMin = min;

        //
        serviceName = serviceSelection.keys.first;
        serviceDuration = min;
        serviceCostMap = serviceSelection[serviceName][serviceDuration];
        var originalAmount = '${serviceCostMap.toString()}';
        finalAmount = int.parse(originalAmount.replaceAll(',', ''));
        print('w/o comma amount : ${finalAmount.truncate()}');

        // serviceCost = serviceCostMap[[serviceDuration]];
        subCategoryId = serviceSelection[serviceName][index];

        print("serviceName:${serviceSelection[allTherapistList[index].name]}");

        selectedTime = null;
        endTime = null;
      } else {
        visibility[index] = false;
      }
    });
  }

  void showToolTip(var key, BuildContext context, int index,
      TherapistList therapistListItem) {
    var width = MediaQuery.of(context).size.width - 10.0;
    print(width);
    ShowToolTip popup = ShowToolTip(context, updateServiceSelection,
        index: index,
        therapistListItem: therapistListItem,
        timePrice: serviceSelection[allTherapistList[index].name],
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

  bookingConfirmField() async {
    ProgressDialogBuilder.showOverlayLoader(context);
    print('cost:${finalAmount}');
    setState(() {
      print('cost:${finalAmount}');
      HealingMatchConstants.confTherapistId = widget.id;
      HealingMatchConstants.confBooking = HealingMatchConstants
          .therapistProfileDetails.data.uploadProfileImgUrl;
      HealingMatchConstants.confShopName =
          HealingMatchConstants.therapistProfileDetails.data.storeName;
      HealingMatchConstants.confUserName =
          HealingMatchConstants.therapistProfileDetails.data.userName;
      HealingMatchConstants.confAddress = HealingMatchConstants
          .therapistProfileDetails.data.addresses[0].address;
      HealingMatchConstants.confServiceType =
          HealingMatchConstants.therapistProfileDetails.data.storeType;
      HealingMatchConstants.confBuisnessTrip =
          HealingMatchConstants.therapistProfileDetails.data.businessTrip;
      HealingMatchConstants.confShop =
          HealingMatchConstants.therapistProfileDetails.data.isShop;
      HealingMatchConstants.confCoronaMeasures =
          HealingMatchConstants.therapistProfileDetails.data.coronaMeasure;
      HealingMatchConstants.confRatingAvg =
          HealingMatchConstants.therapistProfileDetails.reviewData.ratingAvg;
      HealingMatchConstants.confNoOfReviewsMembers = HealingMatchConstants
          .therapistProfileDetails.reviewData.noOfReviewsMembers;
      HealingMatchConstants.confNoOfReviewsMembers = HealingMatchConstants
          .therapistProfileDetails.reviewData.noOfReviewsMembers;
      HealingMatchConstants.confCertificationUpload = HealingMatchConstants
          .therapistProfileDetails.data.certificationUploads;
      HealingMatchConstants.searchUserAddressType.contains('店舗')
          ? HealingMatchConstants.confServiceAddressType = '店舗'
          : HealingMatchConstants.confServiceAddressType =
              HealingMatchConstants.searchUserAddressType;
      HealingMatchConstants.searchUserAddressType.contains('店舗')
          ? HealingMatchConstants.confServiceAddress = HealingMatchConstants
              .therapistProfileDetails.data.addresses[0].address
          : HealingMatchConstants.confServiceAddress =
              HealingMatchConstants.searchUserAddress;
      HealingMatchConstants.confSelectedDateTime = selectedTime;
      HealingMatchConstants.confEndDateTime = endTime;
      HealingMatchConstants.confServiceName = serviceName;
      HealingMatchConstants.confNoOfServiceDuration = serviceDuration;
      HealingMatchConstants.confServiceCost = finalAmount;
      HealingMatchConstants.confserviceCId = serviceCId;
      HealingMatchConstants.confserviceSubId = serviceSubId;
    });

    print('EndDateTime:${HealingMatchConstants.confEndDateTime.weekday}');
    print('EndDateTime:${HealingMatchConstants.confEndDateTime.hour}');
    print('subCategoryId:${subCategoryId}');
    ProgressDialogBuilder.hideLoader(context);
    NavigationRouter.switchToServiceUserBookingConfirmationScreen(context);
  }
}
