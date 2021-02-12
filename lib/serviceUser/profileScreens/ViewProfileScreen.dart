import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';

import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewUserProfile extends StatefulWidget {
  @override
  State createState() {
    return _ViewUserProfileState();
  }
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  String userProfileImage = '';
  String userName = '';
  String userPhoneNumber = '';
  String emailAddress = '';
  String dob = '';
  String userAge = '';
  String userGender = '';
  String userOccupation = '';
  String userAddress = '';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[popupMenuButton()],
      ),
      body: Padding(
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
                      new Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle,
                            image: HealingMatchConstants.profileImageInBytes !=
                                        null ||
                                    profileImageInBytes != null
                                ? new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new MemoryImage(HealingMatchConstants
                                        .profileImageInBytes),
                                  )
                                : new DecorationImage(
                                    fit: BoxFit.none,
                                    image: new AssetImage(
                                        'assets/images_gps/user.png')),
                          )),
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        backgroundColor: Colors.grey[100],
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
                                      context);
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  HealingMatchConstants.serviceUserName.isEmpty ||
                          userName.isEmpty
                      ? new Text(
                          'お名前',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold),
                        )
                      : new Text(
                          '${HealingMatchConstants.serviceUserName}',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold),
                        ),
                  Chip(
                      avatar: SvgPicture.asset(
                        'assets/images_gps/phone.svg',
                        // height: 35,
                        //  color: Colors.grey,
                      ),
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      label: HealingMatchConstants
                                  .serviceUserPhoneNumber.isEmpty ||
                              userPhoneNumber.isEmpty
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
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyRow(
                                SvgPicture.asset(
                                  'assets/images_gps/mail.svg',
                                  // height: 35,
                                  //  color: Colors.grey,
                                ),
                                HealingMatchConstants
                                            .serviceUserEmailAddress.isEmpty ||
                                        emailAddress.isEmpty
                                    ? Text('メールアドレス',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                    : Text(
                                        '${HealingMatchConstants.serviceUserEmailAddress}',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                SvgPicture.asset(
                                  'assets/images_gps/calendar.svg',
                                  // height: 35,
                                  //  color: Colors.grey,
                                ),
                                HealingMatchConstants.serviceUserDOB.isEmpty ||
                                        dob.isEmpty
                                    ? Text('生年月日',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                    : Text(
                                        '${HealingMatchConstants.serviceUserDOB}',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[200],
                                  child: HealingMatchConstants
                                              .serviceUserAge.isEmpty ||
                                          userAge.isEmpty
                                      ? Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          '${HealingMatchConstants.serviceUserAge}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Oxygen',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                )),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                HealingMatchConstants.serviceUserGender
                                        .contains('男性')
                                    ? SvgPicture.asset(
                                        'assets/images_gps/male.svg',
                                        // height: 35,
                                        //  color: Colors.grey,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images_gps/female.svg',
                                        // height: 35,
                                        //  color: Colors.grey,
                                      ),
                                HealingMatchConstants
                                            .serviceUserGender.isEmpty ||
                                        userGender.isEmpty
                                    ? Text('性別',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                    : Text(
                                        '${HealingMatchConstants.serviceUserGender}',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                SvgPicture.asset(
                                  'assets/images_gps/work.svg',
                                  // height: 35,
                                  //  color: Colors.grey,
                                ),
                                HealingMatchConstants
                                            .serviceUserOccupation.isEmpty ||
                                        userOccupation.isEmpty
                                    ? Text('職業',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                    : Text(
                                        '${HealingMatchConstants.serviceUserOccupation}',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                SvgPicture.asset(
                                  'assets/images_gps/address.svg',
                                  // height: 35,
                                  //  color: Colors.grey,
                                ),
                                HealingMatchConstants
                                            .serviceUserAddress.isEmpty ||
                                        userAddress.isEmpty
                                    ? Text(
                                        '436-C鉄道地区ウィンターペットアラコナム。',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        '${HealingMatchConstants.serviceUserAddress}',
                                        style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                SvgPicture.asset(
                                  'assets/images_gps/range.svg',
                                  // height: 35,
                                  //  color: Colors.grey,
                                ),
                                Text('セラピスト検索範囲5.0Km距離。',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen',
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
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(child: image),
          SizedBox(
            width: 5,
          ),
          Flexible(child: text),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: circleAvatar),
          )
        ],
      ),
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
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),
        PopupMenuItem<String>(
          value: "2",
          child: Text(
            'アプリについて', //About the app
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),
        PopupMenuItem<String>(
          value: "3",
          child: Text(
            'お問い合わせ', //Contact Us
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),
        PopupMenuItem<String>(
          value: "4",
          child: Text(
            'ログアウト', //Log out
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),
      ],
      onSelected: (retVal) {
        if (retVal == "1") {
          NavigationRouter.switchToServiceUserTCScreen(context);
        } else if (retVal == "3") {
          emailLaunch();
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
        userProfileImage = value.getString('profileImage');
        userName = value.getString('userName');
        userPhoneNumber = value.getString('userPhoneNumber');
        emailAddress = value.getString('userEmailAddress');
        dob = value.getString('userDOB');
        userAge = value.getString('userAge');
        userGender = value.getString('userGender');
        userOccupation = value.getString('userOccupation');
        userAddress = value.getString('userAddress');

        print(userAddress);

        if (userProfileImage != null) {
          // Convert string url of image to base64 format
          convertBase64ProfileImage(userProfileImage);
        }
        setState(() {
          HealingMatchConstants.serviceUserName = userName;
          HealingMatchConstants.serviceUserPhoneNumber = userPhoneNumber;
          HealingMatchConstants.serviceUserEmailAddress = emailAddress;
          HealingMatchConstants.serviceUserDOB = dob;
          HealingMatchConstants.serviceUserAge = userAge;
          HealingMatchConstants.serviceUserGender = userGender;
          HealingMatchConstants.serviceUserOccupation = userOccupation;
          HealingMatchConstants.serviceUserAddress = userAddress;
        });
      });
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }

  convertBase64ProfileImage(String userProfileImage) async {
    imgBase64ProfileImage =
        await networkImageToBase64RightFront(userProfileImage);
    profileImageInBytes = Base64Decoder().convert(imgBase64ProfileImage);
    setState(() {
      HealingMatchConstants.profileImageInBytes = profileImageInBytes;
    });
  }

  //Profile Image
  Future<String> networkImageToBase64RightFront(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}