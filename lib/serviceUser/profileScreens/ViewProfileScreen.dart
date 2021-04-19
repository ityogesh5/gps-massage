import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ViewUserProfile extends StatefulWidget {
  @override
  State createState() {
    return _ViewUserProfileState();
  }
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  String userProfileImage;
  String userName;

  String userPhoneNumber;

  String emailAddress;

  String dob;

  String userAge;

  String userGender;

  String userOccupation;

  String userAddress;
  int status = 0;
  var _myCity;
  var _myCategoryPlaceForMassage;
  var _myPrefecture;

  double iconHeight = 20.0;
  double iconWidth = 20.0;
  Color iconColor = Colors.black;

  //base64 profile image
  String imgBase64ProfileImage;

  //Uint8List profile image;
  Uint8List profileImageInBytes;

  @override
  void initState() {
    getUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'マイアカウント',
          style: TextStyle(
              fontFamily: 'NotoSansJP',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[popupMenuButton()],
      ),
      body: status == 0
          ? buildLoading()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 35.0),
                            userProfileImage != null
                                ? CachedNetworkImage(
                                    imageUrl: userProfileImage,
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
                                        Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.black12),
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
                            SizedBox(width: 10.0),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.grey[100],
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1),
                                radius: 15,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.edit_rounded,
                                      size: 15,
                                      color: Colors.grey[400],
                                    ),
                                    onPressed: () {
                                      NavigationRouter
                                          .switchToServiceUserEditProfileScreen(
                                              context, userProfileImage);
                                    }),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        HealingMatchConstants.serviceUserName == null ||
                                HealingMatchConstants.serviceUserName.isEmpty
                            ? new Text(
                                'お名前',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.bold),
                              )
                            : new Text(
                                '${HealingMatchConstants.serviceUserName}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.bold),
                              ),
                        Chip(
                            avatar: SvgPicture.asset(
                              'assets/images_gps/phone.svg',
                              // height: 35,
                              //  color: Colors.grey,
                            ),
                            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey[100]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            label: HealingMatchConstants
                                        .serviceUserPhoneNumber.isEmpty ||
                                    HealingMatchConstants
                                            .serviceUserPhoneNumber ==
                                        null
                                ? Text(
                                    "電話番号",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )
                                : Text(
                                    "${HealingMatchConstants.serviceUserPhoneNumber}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.white]),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey[100],
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.white),
                            width: MediaQuery.of(context).size.width * 0.85,
                            // height: MediaQuery.of(context).size.height * 0.42,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MyRow(
                                      SvgPicture.asset(
                                        'assets/images_gps/mail.svg',
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      HealingMatchConstants
                                                  .serviceUserEmailAddress
                                                  .isEmpty ||
                                              HealingMatchConstants
                                                      .serviceUserEmailAddress ==
                                                  null
                                          ? Text('メールアドレス',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))
                                          : Text(
                                              '${HealingMatchConstants.serviceUserEmailAddress}',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0)),
                                      SizedBox(width: 0)),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      SvgPicture.asset(
                                        'assets/images_gps/calendar.svg',
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      HealingMatchConstants
                                                  .serviceUserDOB.isEmpty ||
                                              HealingMatchConstants
                                                      .serviceUserDOB ==
                                                  null
                                          ? Text('生年月日',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))
                                          : Text(
                                              '${HealingMatchConstants.serviceUserDOB}',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: HealingMatchConstants
                                                    .serviceUserAge.isEmpty ||
                                                HealingMatchConstants
                                                        .serviceUserAge ==
                                                    null
                                            ? Text(
                                                '0',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'NotoSansJP',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                '${HealingMatchConstants.serviceUserAge}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'NotoSansJP',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                      )),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      SvgPicture.asset(
                                        HealingMatchConstants.serviceUserGender
                                                .contains('男性')
                                            ? 'assets/images_gps/male.svg'
                                            : HealingMatchConstants
                                                    .serviceUserGender
                                                    .contains('女性')
                                                ? 'assets/images_gps/female.svg'
                                                : "assets/images_gps/profile_pic_user.svg",
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      HealingMatchConstants
                                                  .serviceUserGender.isEmpty ||
                                              HealingMatchConstants
                                                      .serviceUserGender ==
                                                  null
                                          ? Text('性別',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))
                                          : Text(
                                              '${HealingMatchConstants.serviceUserGender}',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                      SizedBox(width: 0)),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      SvgPicture.asset(
                                        'assets/images_gps/work.svg',
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      HealingMatchConstants
                                                  .serviceUserOccupation
                                                  .isEmpty ||
                                              HealingMatchConstants
                                                      .serviceUserOccupation ==
                                                  null
                                          ? Text('職業',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500))
                                          : Text(
                                              '${HealingMatchConstants.serviceUserOccupation}',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                      SizedBox(width: 0)),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      SvgPicture.asset(
                                        'assets/images_gps/address.svg',
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      HealingMatchConstants
                                                  .serviceUserAddress.isEmpty ||
                                              HealingMatchConstants
                                                      .serviceUserAddress ==
                                                  null
                                          ? Text(
                                              '436-C鉄道地区ウィンターペットアラコナム。',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              '${HealingMatchConstants.serviceUserAddress}',
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                      SizedBox(width: 0)),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      SvgPicture.asset(
                                        'assets/images_gps/range.svg',
                                        height: iconHeight,
                                        width: iconWidth,
                                        color: iconColor,
                                      ),
                                      Text('セラピスト検索範囲5.0Km距離。',
                                          style: TextStyle(
                                              fontFamily: 'NotoSansJP',
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 0))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyRow(Widget image, Widget text, Widget circleAvatar) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: image,
        ),
        Flexible(
            child: Padding(padding: const EdgeInsets.all(10.0), child: text)),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: circleAvatar,
        )
      ],
    );
  }

  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 30.0,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "1",
          child: Text(
            '利用規約とプライバシーポリシー', //Terms and Conditions
            style: TextStyle(fontFamily: 'NotoSansJP'),
          ),
        ),
        PopupMenuItem<String>(
          value: "2",
          child: Text(
            'アプリについて', //About the app
            style: TextStyle(fontFamily: 'NotoSansJP'),
          ),
        ),
        PopupMenuItem<String>(
          value: "3",
          child: Text(
            'お問い合わせ', //Contact Us
            style: TextStyle(fontFamily: 'NotoSansJP'),
          ),
        ),
        PopupMenuItem<String>(
          value: "4",
          child: Text(
            'ログアウト', //Log out
            style: TextStyle(fontFamily: 'NotoSansJP'),
          ),
        ),
      ],
      onSelected: (retVal) {
        if (retVal == "1") {
          NavigationRouter.switchToServiceUserTCScreen(context);
        } else if (retVal == "2") {
          NavigationRouter.switchToUserTutorialScreen(context);
        } else if (retVal == "3") {
          emailLaunch();
        } else if (retVal == "4") {
          DialogHelper.showLogOutUserDialog(context);
        }
      },
    );
  }

  emailLaunch() {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'healingMatch@yopmail.com',
        queryParameters: {'subject': 'QueryMail!'});
    launch(_emailLaunchUri.toString());
  }

  getUserProfileData() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      _sharedPreferences.then((value) {
        print('Getting values...SPF');
        setState(() {
          // userProfileImage = value.getString('profileImage');

          _myCategoryPlaceForMassage = value.getString('userPlaceForMassage');
          _myCity = value.getString('cityName');
          _myPrefecture = value.getString('capitalAndPrefecture');
        });

        print(userAddress);
        print('Prefectute: $_myPrefecture');
        print('City: $_myCity');
        print('myCategoryPlaceForMassage: $_myCategoryPlaceForMassage');
        print('serviceUserById: ${HealingMatchConstants.serviceUserById}');
      });
      var userListApiProvider = ServiceUserAPIProvider.getUserDetailsById();
      userListApiProvider.then((value) {
        setState(() {
          // userProfileImage = value.data.uploadProfileImgUrl.toString();
          HealingMatchConstants.serviceUserName = value.data.userName;
          HealingMatchConstants.serviceUserPhoneNumber =
              value.data.phoneNumber.toString();
          HealingMatchConstants.serviceUserEmailAddress = value.data.email;
          HealingMatchConstants.serviceUserDOB =
              DateFormat("yyyy-MM-dd").format(value.data.dob).toString();
          HealingMatchConstants.serviceUserAge = value.data.age.toString();
          HealingMatchConstants.serviceUserGender = value.data.gender;
          HealingMatchConstants.serviceUserOccupation =
              value.data.userOccupation;
          for (var userAddressData in value.data.addresses) {
            HealingMatchConstants.serviceUserAddress = userAddressData.address;
          }
          status = 1;
          print('serviceUserById: ${HealingMatchConstants.serviceUserById}');
        });
      });
      print('serviceUserName: ${HealingMatchConstants.serviceUserName}');
      print(
          'serviceUserPhoneNumber: ${HealingMatchConstants.serviceUserPhoneNumber}');
      print(
          'serviceUserEmailAddress: ${HealingMatchConstants.serviceUserEmailAddress}');
      print('serviceUserDOB: ${HealingMatchConstants.serviceUserDOB}');
      print('serviceUserAge: ${HealingMatchConstants.serviceUserAge}');
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }

  Widget buildLoading() {
    return Center(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SpinKitPulse(color: Colors.lime),
            //buildLoadingIndicator()
          ],
        ),
      ),
    );
  }
}
