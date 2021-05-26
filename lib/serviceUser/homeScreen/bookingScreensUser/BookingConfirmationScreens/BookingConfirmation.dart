import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gps_massageapp/customLibraryClasses/cardToolTips/showToolTip.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/createBooking.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';

double ratingsValue = 4.0;
bool checkValue = false;
List<String> massageBuildingTypeValues = [
  "マンション",
  "アバート",
  "一軒家",
  "ホテル",
  "施設",
  "その他",
];
bool isOtherSelected = false;
final _otherBuildingController = new TextEditingController();
final _queriesAskController = new TextEditingController();
Map<String, dynamic> _formData = {
  'text': null,
  'category': null,
  'date': null,
  'time': null,
};

List<String> selectedBuildingTypeValues = List<String>();
var selectedBuildingType;

class BookingConfirmationScreen extends StatefulWidget {
  @override
  State createState() {
    return _BookingConfirmationState();
  }
}

class _BookingConfirmationState extends State<BookingConfirmationScreen> {
  Map<String, String> certificateImages = Map<String, String>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String weekDays;
  GlobalKey key = new GlobalKey();
  CreateBookingModel createBooking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          color: Colors.black,
        ),
        title: Text(
          '予約確認',
          style: TextStyle(
              fontFamily: 'NotoSansJP',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              '予約の詳細',
              style: TextStyle(
                  fontFamily: 'NotoSansJP',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[200], Colors.grey[200]]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.90,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildProfileImage(),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                HealingMatchConstants.confShopName.isNotEmpty &&
                                        HealingMatchConstants.confShopName !=
                                            null
                                    ? Text(
                                        '${HealingMatchConstants.confShopName}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        '${HealingMatchConstants.confUserName}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    showToolTip(
                                        HealingMatchConstants.confServiceType);
                                  },
                                  child: Container(
                                    key: key,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
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
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  HealingMatchConstants.confShop
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child:
                                              buildProileDetailCard("店舗", 12.0),
                                        )
                                      : Container(),
                                  SizedBox(width: 5.0),
                                  HealingMatchConstants.confBuisnessTrip
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child:
                                              buildProileDetailCard("出張", 12.0),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  HealingMatchConstants.confCoronaMeasures
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: buildProileDetailCard(
                                              "コロナ対策実施", 14.0),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  '(${HealingMatchConstants.confRatingAvg})',
                                  style: TextStyle(
                                      decorationColor:
                                          Color.fromRGBO(153, 153, 153, 1),
                                      shadows: [
                                        Shadow(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                            offset: Offset(0, -3))
                                      ],
                                      fontSize: 14,
                                      color: Colors.transparent,
                                      fontWeight: FontWeight.bold),
                                ),
                                buildRatingBar(),
                                Text(
                                  '(1518)',
                                  style: TextStyle(
                                      decorationColor:
                                          Color.fromRGBO(153, 153, 153, 1),
                                      shadows: [
                                        Shadow(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                            offset: Offset(0, -3))
                                      ],
                                      fontSize: 14,
                                      color: Colors.transparent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: certificateImages != null ? 5.0 : 0.0,
                            ),
                            certificateImages != null
                                ? Container(
                                    height: 30.0,
                                    width: MediaQuery.of(context).size.width -
                                        130.0, //200.0,
                                    child: ListView.builder(
                                        itemCount: certificateImages.length,
                                        padding: EdgeInsets.all(0.0),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String key = certificateImages.keys
                                              .elementAt(index);
                                          return buildProileDetailCard(
                                              key, 12.0);
                                        }),
                                  )
                                : Container(),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Divider(
                          color: Color.fromRGBO(217, 217, 217, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Expanded(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset('assets/images_gps/gps.svg',
                                height: 25, width: 25),
                            SizedBox(width: 5),
                            FittedBox(
                              child: Text(
                                '${HealingMatchConstants.confAddress}',
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSansJP'),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                HealingMatchConstants.serviceDistanceRadius !=
                                            null &&
                                        HealingMatchConstants
                                                .serviceDistanceRadius !=
                                            0
                                    ? Text(
                                        '${HealingMatchConstants.serviceDistanceRadius}Ｋｍ圏内',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[400],
                                            fontFamily: 'NotoSansJP'),
                                      )
                                    : Text(
                                        '0.0ｋｍ圏内',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
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
                  color: Colors.grey[400],
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              width: MediaQuery.of(context).size.width * 0.90,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/calendar.svg',
                            height: 25, width: 25),
                        Text(
                          ' ${HealingMatchConstants.confSelectedDateTime.month}月${HealingMatchConstants.confSelectedDateTime.day}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansJP'),
                        ),
                        Text(
                          ' $weekDays',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        SvgPicture.asset('assets/images_gps/clock.svg',
                            height: 25, width: 25),
                        Text(
                          '${HealingMatchConstants.confSelectedDateTime.hour}:00～${HealingMatchConstants.confEndDateTime.hour}:00',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansJP'),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '${HealingMatchConstants.confNoOfServiceDuration}分',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'NotoSansJP'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images_gps/cost.svg',
                            height: 25, width: 25),
                        SizedBox(width: 3),
                        Chip(
                          label:
                              Text('${HealingMatchConstants.confServiceName}'),
                          backgroundColor: Colors.grey[300],
                        ),
                        Text(
                          "¥${HealingMatchConstants.confServiceCost}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "\t\t施術を受ける場所",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(242, 242, 242, 1),
                        Color.fromRGBO(242, 242, 242, 1),
                      ]),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200]),
              width: MediaQuery.of(context).size.width * 0.90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildProileDetailCard(
                        "${HealingMatchConstants.confServiceAddressType}", 12),
                    SizedBox(width: 10),
                    Flexible(
                      child: new Text(
                        "${HealingMatchConstants.confServiceAddress}",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontFamily: 'NotoSansJP'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            HealingMatchConstants.confServiceAddressType.contains('店舗')
                ? SizedBox.shrink()
                : SizedBox(height: 20),
            HealingMatchConstants.confServiceAddressType.contains('店舗')
                ? SizedBox.shrink()
                : Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/images_gps/diamond.svg',
                                height: 12, width: 12),
                            Text(
                              "\t\t施術を受ける建物を選んでください。",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      massageBuildTypeDisplayContent(),
                    ],
                  ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.82,
              child: TextField(
                controller: _queriesAskController,
                autofocus: false,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                decoration: new InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    hintText: '質問、要望などメッセージがあれば入力してください。',
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300], width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
            ),
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.start,
              text: new TextSpan(
                text: '*\t\t',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  new TextSpan(
                      text: '${HealingMatchConstants.additionalDistanceCost}',
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontFamily: 'NotoSansJP',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: reservation(),
    );
  }

  CachedNetworkImage buildProfileImage() {
    return CachedNetworkImage(
      imageUrl: HealingMatchConstants.confBooking,
      filterQuality: FilterQuality.high,
      fadeInCurve: Curves.easeInSine,
      imageBuilder: (context, imageProvider) => Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>
          SpinKitDoubleBounce(color: Colors.lightGreenAccent),
      errorWidget: (context, url, error) => Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
          image: DecorationImage(
              image: new AssetImage('assets/images_gps/placeholder_image.png'),
              fit: BoxFit.cover),
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

  RatingBar buildRatingBar() {
    return RatingBar.builder(
      initialRating: double.parse(HealingMatchConstants.confRatingAvg),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24.0,
      ignoreGestures: true,
      itemPadding: new EdgeInsets.only(bottom: 3.0),
      itemBuilder: (context, index) => new SizedBox(
          height: 20.0,
          width: 18.0,
          child: new IconButton(
            onPressed: () {},
            padding: new EdgeInsets.all(0.0),
            // color: Colors.white,
            icon: index >
                    (double.parse(HealingMatchConstants.confRatingAvg))
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
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  getProfileDetails() {
    var certificateUpload =
        HealingMatchConstants.confCertificationUpload[0].toJson();
    certificateUpload.remove('id');
    certificateUpload.remove('userId');
    certificateUpload.remove('createdAt');
    certificateUpload.remove('updatedAt');
    certificateUpload.forEach((key, value) async {
      if (certificateUpload[key] != null) {
        String jKey = getQualififcationJaWords(key);
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
    if (HealingMatchConstants.confSelectedDateTime.weekday == 1) {
      weekDays = '月曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 2) {
      weekDays = '火曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 3) {
      weekDays = '水曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 4) {
      weekDays = '木曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 5) {
      weekDays = '金曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 6) {
      weekDays = '土曜日';
    }
    if (HealingMatchConstants.confSelectedDateTime.weekday == 7) {
      weekDays = '日曜日';
    }
  }

  String getQualififcationJaWords(String key) {
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

  Widget reservation() {
    return Container(
      margin: EdgeInsets.all(12),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(6.0),
          //side: BorderSide(color: Colors.black),
        ),
        color: Color.fromRGBO(255, 0, 0, 1),
        onPressed: () {
          _updateUserBookingDetails();
        },
        child: new Text(
          '予約する',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget massageBuildTypeDisplayContent() {
    bool newChoosenVal = false;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: BuildingCategories.initial()
                .categories
                .map((BuildingCategory category) {
              final bool selected =
                  _formData['category']?.name == category.name;
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment(-1.2, 1.1),
                    child: new Text('${category.name}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'NotoSansJP')),
                  ),
                ),
                leading: CustomRadioButton(
                    color: Colors.black,
                    selected: selected,
                    onChange: (newVal) {
                      newChoosenVal = newVal;
                      _handleCategoryChange(newChoosenVal, category);
                      if (category.name.contains('その他')) {
                        print('SELECTED VALUE IF ON CHANGE : ${category.name}');

                        setState(() {
                          isOtherSelected = true;
                        });
                      } else {
                        _handleCategoryChange(true, category);
                        print(
                            'SELECTED VALUE ELSE ON CHANGE : ${category.name}');
                        setState(() {
                          isOtherSelected = false;
                        });
                      }
                    }),
                onTap: () {
                  _handleCategoryChange(true, category);
                  if (category.name.contains('その他')) {
                    print('SELECTED VALUE IF ON TAP : ${category.name}');
                    setState(() {
                      isOtherSelected = true;
                    });
                  } else {
                    _handleCategoryChange(true, category);
                    print('SELECTED VALUE ELSE ON TAP : ${category.name}');
                    setState(() {
                      isOtherSelected = false;
                    });
                  }
                },
              );
            }).toList(),
          ),
          Visibility(
            visible: isOtherSelected,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Container(
                height: 51,
                width: MediaQuery.of(context).size.width * 0.82,
                child: TextField(
                  controller: _otherBuildingController,
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  enableInteractiveSelection: false,
                  // readOnly: true,
                  decoration: new InputDecoration(
                      filled: false,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCategoryChange(bool newVal, BuildingCategory category) {
    setState(() {
      if (newVal) {
        _formData['category'] = category;
        selectedBuildingType = category.name;
        print('Chosen value : $newVal : name : $selectedBuildingType');
      } else {
        _formData['category'] = null;
      }
    });
  }

  void showToolTip(String text) {
    ShowToolTip popup = ShowToolTip(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: 100,
        width: 180,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

  _updateUserBookingDetails() async {
    ProgressDialogBuilder.showOverlayLoader(context);
    int therapistId = HealingMatchConstants.confTherapistId;
    String startTime =
        HealingMatchConstants.confSelectedDateTime.toLocal().toString();
    String endTime = HealingMatchConstants.confEndDateTime.toLocal().toString();
    int paymentStatus = 0;
    int subCategoryId = 12;
    int categoryId = 3;
    String nameOfService = HealingMatchConstants.confServiceName;
    int totalMinOfService = HealingMatchConstants.confNoOfServiceDuration;
    int priceOfService = HealingMatchConstants.confServiceCost;
    int bookingStatus = 0;
    String locationType = selectedBuildingType;
    String location = HealingMatchConstants.confServiceAddress;
    int totalCost = HealingMatchConstants.confServiceCost;
    int userReviewStatus = 0;
    int therapistReviewStatus = 0;
    String userCommands = _otherBuildingController.text;

    print('Entering on press');
    print('StartTime: ${HealingMatchConstants.confSelectedDateTime.toLocal()}');
    print('StartTime: ${startTime}');
/*    if (HealingMatchConstants.confServiceAddressType.contains('店舗') &&
            selectedBuildingType == null ||
        selectedBuildingType.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('施術を受ける建物を選んでください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    } else if (isOtherSelected &&
        selectedBuildingType.toString().contains('その他')) {
      HealingMatchConstants.selectedBookingPlace = '公園';
      print('Entering on if : ${HealingMatchConstants.selectedBookingPlace}');
    } else {
      HealingMatchConstants.selectedBookingPlace =
          selectedBuildingType.toString();
      print('Entering on else : ${HealingMatchConstants.selectedBookingPlace}');
    }*/

    try {
      createBooking = await ServiceUserAPIProvider.createBooking(
          context,
          therapistId,
          startTime,
          endTime,
          paymentStatus,
          subCategoryId,
          categoryId,
          nameOfService,
          totalMinOfService,
          priceOfService,
          bookingStatus,
          locationType,
          location,
          totalCost,
          userReviewStatus,
          therapistReviewStatus,
          userCommands);
    } catch (e) {
      print(e.toString());
    }
    ProgressDialogBuilder.hideLoader(context);
    NavigationRouter.switchToServiceUserReservationAndFavourite(context);
  }
}

class BuildingCategory {
  final String name;

  BuildingCategory({this.name});
}

class BuildingCategories {
  final List<BuildingCategory> categories;

  BuildingCategories(this.categories);

  factory BuildingCategories.initial() {
    return BuildingCategories(
      <BuildingCategory>[
        BuildingCategory(name: 'マンション'),
        BuildingCategory(name: 'アバート'),
        BuildingCategory(name: '一軒家'),
        BuildingCategory(name: 'ホテル'),
        BuildingCategory(name: '施設'),
        BuildingCategory(name: 'その他'),
      ],
    );
  }
}
