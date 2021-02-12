import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';

import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Data userData;
  int status = 0;
  TextStyle textStyle = TextStyle(fontFamily: 'Oxygen', fontSize: 14.0);

  void initState() {
    getProfileDetails();
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
            NavigationRouter.switchToServiceProviderBottomBar(context);
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
      body: status == 0
          ? Container(color: Colors.white)
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.0),
                        Stack(
                          children: [
                            Center(
                              child: new Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: new BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          userData.uploadProfileImgUrl),
                                    ),
                                  )),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 68.0, top: 48.0),
                                child: CircleAvatar(
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
                                            .switchToProviderEditProfileScreen(
                                                context);
                                      }),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        new Text(
                          userData.userName,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold),
                        ),
                        Chip(
                            avatar: Icon(Icons.phone_rounded,
                                color: Colors.grey[400]),
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            label: Text(
                              userData.phoneNumber.toString(), //Phone Number
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
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
                            //  height: MediaQuery.of(context).size.height * 0.75,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MyRow(
                                      Icon(Icons.mail_outline_rounded,
                                          size: 30, color: Colors.grey[500]),
                                      Text(userData.email,
                                          style: textStyle), //Email address
                                      SizedBox(width: 0)),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      Icon(Icons.calendar_today_rounded,
                                          size: 30, color: Colors.grey[500]),
                                      Text(userData.businessForm,
                                          style: textStyle), //Business Form
                                      SizedBox(width: 0)),
                                  userData.numberOfEmp != null
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.numberOfEmp != null
                                      ? MyRow(
                                          Icon(Icons.anchor_outlined,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          Text(
                                              userData.numberOfEmp
                                                  .toString(), //Number of Employees
                                              style: textStyle),
                                          SizedBox(width: 0))
                                      : Container(),
                                  userData.businessTrip != null
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.businessTrip != null
                                      ? MyRow(
                                          Icon(Icons.add_location_alt_sharp,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          userData.businessTrip //Business Trip
                                              ? Text(
                                                  '出張でのサービス対応可否 -はい',
                                                  style: textStyle,
                                                )
                                              : Text(
                                                  '出張でのサービス対応可否 -いいえ',
                                                  style: textStyle,
                                                ),
                                          SizedBox(width: 0))
                                      : Container(),
                                  userData.coronaMeasure != null
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.coronaMeasure != null
                                      ? MyRow(
                                          Icon(Icons.bug_report_outlined,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          userData.coronaMeasure //Corona Measure
                                              ? Text(
                                                  'コロナ対策実施有無 -はい',
                                                  style: textStyle,
                                                )
                                              : Text(
                                                  'コロナ対策実施有無 -いいえ',
                                                  style: textStyle,
                                                ),
                                          SizedBox(width: 0))
                                      : Container(),
                                  userData.childrenMeasure != null &&
                                          userData.childrenMeasure != ''
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.childrenMeasure != null &&
                                          userData.childrenMeasure != ''
                                      ? MyRow(
                                          Icon(Icons.location_on_outlined,
                                              size: 30,
                                              color: Colors.grey[
                                                  500]), //Children Measure
                                          Text(
                                              /* 子供向け施策有無 */ ' ${userData.childrenMeasure}',
                                              style: textStyle),
                                          SizedBox(width: 0),
                                        )
                                      : Container(),
                                  userData.genderOfService != null &&
                                          userData.genderOfService != ''
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.genderOfService != null &&
                                          userData.genderOfService != ''
                                      ? MyRow(
                                          Icon(
                                              Icons.supervisor_account_outlined,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          Text(userData.genderOfService,
                                              style:
                                                  textStyle), //Gender of Service Provided
                                          SizedBox(width: 0))
                                      : Container(),
                                  userData.storeName != null &&
                                          userData.storeName != ''
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.storeName != null &&
                                          userData.storeName != ''
                                      ? MyRow(
                                          Icon(Icons.house,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          Text(userData.storeName,
                                              style: textStyle), //StoreName
                                          SizedBox(width: 0))
                                      : Container(),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      Icon(Icons.calendar_today_rounded,
                                          size: 30, color: Colors.grey[500]),
                                      Text(
                                        "${userData.dob.day}/${userData.dob.month}/${userData.dob.year}",
                                        style: textStyle,
                                      ), //Dob
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              userData.age.toString(), //age
                                              style: textStyle),
                                        ),
                                      )),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      Icon(Icons.perm_identity,
                                          size: 30, color: Colors.grey[500]),
                                      Text(userData.gender,
                                          style: textStyle), //gender
                                      SizedBox(width: 0)),
                                  userData.storePhone != null
                                      ? Divider(
                                          color: Colors.grey[300], height: 1)
                                      : Container(),
                                  userData.storePhone != null
                                      ? MyRow(
                                          Icon(Icons.phone,
                                              size: 30,
                                              color: Colors.grey[500]),
                                          Text(
                                              userData.storePhone
                                                  .toString(), //store phone number
                                              style: textStyle),
                                          SizedBox(width: 0))
                                      : Container(),
                                  Divider(color: Colors.grey[300], height: 1),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: MyRow(
                                        Center(
                                          child: Icon(Icons.location_pin,
                                              size: 30,
                                              color: Colors.grey[500]),
                                        ),
                                        Text(userData.addresses[0].address,
                                            style:
                                                textStyle), //Provider address
                                        SizedBox(width: 0)),
                                  ),
                                  Divider(color: Colors.grey[300], height: 1),
                                  MyRow(
                                      Icon(Icons.perm_identity,
                                          size: 30, color: Colors.grey[500]),
                                      Text(userData.proofOfIdentityType,
                                          style: textStyle), //id type
                                      SizedBox(width: 0)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  userData.qulaificationCertImgUrl != "無資格"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Text('保有資格',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(height: 5),
                            BuildCertificatesLists(),
                            SizedBox(height: 10),
                          ],
                        )
                      : Container(),
                  userData.bankDetails[0].bankName != '' &&
                          userData.bankDetails[0].accountNumber != ''
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Text('売上金振込先銀行情報',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(height: 5),
                            Card(
                              color: Colors.grey[200],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey.shade200, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(userData.bankDetails[0].bankName,
                                            style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900)),
                                        Text(userData.bankDetails[0].branchCode,
                                            style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              userData
                                                  .bankDetails[0].branchNumber,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900)),
                                        ]),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        /*   Text('****',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Oxygen',
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900)),
                              SizedBox(width: 10), */
                                        Text(
                                            userData
                                                .bankDetails[0].accountNumber,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              userData
                                                  .bankDetails[0].accountType,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900)),
                                        ]),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
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
          NavigationRouter.switchToServiceProviderTCScreen(context);
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

  getProfileDetails() async {
    if (HealingMatchConstants.userData != null) {
      userData = HealingMatchConstants.userData;
      print("Qualififcation:+${userData.qulaificationCertImgUrl}");
      setState(() {
        status = 1;
      });
    } else {
      ProgressDialogBuilder.showCommonProgressDialog(context);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userData =
          Data.fromJson(json.decode(sharedPreferences.getString("userData")));
      HealingMatchConstants.accessToken =
          sharedPreferences.getString("accessToken");
      setState(() {
        status = 1;
      });
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }
}

class BuildCertificatesLists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildCertificatesListsState();
  }
}

class _BuildCertificatesListsState extends State<BuildCertificatesLists> {
  Data userData;
  var certificateUpload;
  Map<String, String> certificateImages = Map<String, String>();

  @override
  void initState() {
    userData = HealingMatchConstants.userData;
    certificateUpload = userData.certificationUploads[0].toJson();
    certificateUpload.remove('id');
    certificateUpload.remove('userId');
    certificateUpload.remove('createdAt');
    certificateUpload.remove('updatedAt');
    certificateUpload.forEach((key, value) async {
      if (certificateUpload[key] != null) {
        certificateImages[key] = value;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //padding: const EdgeInsets.all(8.0),
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.99,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: certificateImages.length,
          itemBuilder: (context, index) {
            String key = certificateImages.keys.elementAt(index);
            return buildQualificationImage(key, index);
          }),
    );
  }

  Widget buildQualificationImage(String key, int index) {
    return Container(
      padding: EdgeInsets.only(left: index == 0 ? 0.0 : 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    padding: EdgeInsets.all(8),
                    width: 140.0,
                    height: 140.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          certificateImages[key],
                        ),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            getQualififcationJaWords(key),
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
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
}
