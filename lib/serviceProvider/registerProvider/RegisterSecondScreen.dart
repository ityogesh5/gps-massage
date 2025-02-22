import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/bankNameDropDownModel.dart'
    as Bank;
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/ProviderDetailsResponseModel.dart'
    as ServicePrice;
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/customLibraryClasses/customTextField/text_field_custom.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ChooseServiceScreen.dart';
//import 'package:dio/dio.dart';

List<File> files = List<File>();

class RegistrationProviderSecondScreen extends StatefulWidget {
  @override
  _RegistrationSecondPageState createState() => _RegistrationSecondPageState();
}

class _RegistrationSecondPageState
    extends State<RegistrationProviderSecondScreen> {
  final formkey = new GlobalKey<FormState>();
  final identityverification = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final qualificationupload = new GlobalKey<FormState>();
  final bankkey = new GlobalKey<FormState>();
  final accountnumberkey = new GlobalKey<FormState>();
  bool readonly = false;
  bool visible = false;
  bool idUploadVisible = false;
  bool uploadVisible = false;
  var identificationVerify, bankName, accountType;
  String qualification;
  String accountHolderType;
  ProgressDialog _progressDialog = ProgressDialog();
  Map<String, String> certificateImages = Map<String, String>();
  PickedFile _profileImage;
  PickedFile _idProfileImage;
  TextEditingController branchNameController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController branchNumberController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController bankOtherFieldController = TextEditingController();
  Bank.BankNameDropDownModel bankNameDropDownModel;
  List<String> bankNameDropDownList = List<String>();
  List<String> privateQualification = List<String>();
  List<ServicePrice.StoreServiceTime> _storeServiceTime =
      List<ServicePrice.StoreServiceTime>();
  List<String> dayNames = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];
  final fireBaseMessaging = new FirebaseMessaging();
  var fcmToken;

  void initState() {
    super.initState();
    identificationVerify = '';
    qualification = '';
    bankName = '';
    qualification = '';
    accountType = '';

    getsavedValues();
    _getFCMToken();
  }

  buildInitialTime(int userId) {
    int i = 1;
    DateTime defaultStart =
        DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0);
    DateTime defaultEnd =
        DateTime(DateTime.now().year, DateTime.now().month, 1, 23, 59, 59);
    for (var day in dayNames) {
      _storeServiceTime.add(ServicePrice.StoreServiceTime(
        id: 0,
        userId: userId,
        weekDay: day,
        dayInNumber: i,
        startTime: defaultStart,
        endTime: defaultEnd,
        shopOpen: true,
      ));
      i = i + 1;
    }
  }

  saveValues() {
    HealingMatchConstants.providerRegisterStatus = 1;
    HealingMatchConstants.idVerify = identificationVerify.toString().trim();
    HealingMatchConstants.bankNameDropDownList.clear();
    HealingMatchConstants.bankNameDropDownList.addAll(bankNameDropDownList);
    HealingMatchConstants.bankName = bankName;
    if (bankName == HealingMatchConstants.registrationBankOtherDropdownFiled) {
      HealingMatchConstants.otherBankName = bankOtherFieldController.text;
    }
    HealingMatchConstants.branchNumber = branchNumberController.text;
    HealingMatchConstants.accountNumber = accountnumberController.text;
    HealingMatchConstants.accountType = accountType;
    HealingMatchConstants.branchCode = branchNameController.text;
    HealingMatchConstants.bankCode = bankNumberController.text;
    HealingMatchConstants.bankAccountHolderType = accountHolderType;
    HealingMatchConstants.accountHolderName = accountHolderNameController.text;
    HealingMatchConstants.qualification = qualification.toString().trim();
    HealingMatchConstants.idProfileImage = _idProfileImage;
    HealingMatchConstants.privateQualification.clear();
    HealingMatchConstants.privateQualification.addAll(privateQualification);
    HealingMatchConstants.certificateImages.clear();
    HealingMatchConstants.certificateImages.addAll(certificateImages);
  }

  getsavedValues() {
    if (HealingMatchConstants.providerRegisterStatus == 1) {
      bankNameDropDownList.addAll(HealingMatchConstants.bankNameDropDownList);
      bankName = HealingMatchConstants.bankName;
      if (bankName ==
          HealingMatchConstants.registrationBankOtherDropdownFiled) {
        bankOtherFieldController.text = HealingMatchConstants.otherBankName;
      }
      identificationVerify = HealingMatchConstants.idVerify;
      branchNumberController.text = HealingMatchConstants.branchNumber;
      bankNumberController.text = HealingMatchConstants.bankCode;
      accountHolderType = HealingMatchConstants.bankAccountHolderType;
      accountHolderNameController.text =
          HealingMatchConstants.accountHolderName;
      accountnumberController.text = HealingMatchConstants.accountNumber;
      accountType = HealingMatchConstants.accountType;
      branchNameController.text = HealingMatchConstants.branchCode;
      qualification = HealingMatchConstants.qualification;
      _idProfileImage = HealingMatchConstants.idProfileImage;
      privateQualification.addAll(HealingMatchConstants.privateQualification);
      certificateImages.addAll(HealingMatchConstants.certificateImages);
      idUploadVisible = _idProfileImage == null ? false : true;
    } else {
      getBankName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              saveValues();
              Navigator.pop(context);
            }),
        title: Text(
          HealingMatchConstants.registrationFirstText,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(102, 102, 102, 1),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.only(
                top: 4.0,
                left: MediaQuery.of(context).size.width / 19,
                right: MediaQuery.of(context).size.width / 19,
                bottom: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HealingMatchConstants.registrationFirstText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ), */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("*", style: TextStyle(color: Colors.red)),
                      Text(
                        HealingMatchConstants.registrationScndText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  drawRangeSlider(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: identityverification,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: DropDownFormField(
                            autovalidate: false,
                            titleText: null,
                            requiredField: true,
                            hintText: readonly
                                ? identificationVerify
                                : HealingMatchConstants
                                    .registrationIdentityVerification,
                            onSaved: (value) {
                              if (_idProfileImage == null) {
                                setState(() {
                                  identificationVerify = value;
                                  idUploadVisible = true;
                                });
                              } else {
                                showIdSelectError();
                              }
                            },
                            value: identificationVerify,
                            onChanged: (value) {
                              if (_idProfileImage == null) {
                                setState(() {
                                  identificationVerify = value;
                                  idUploadVisible = true;
                                });
                              } else {
                                showIdSelectError();
                              }
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            dataSource: [
                              {
                                "display": "運転免許証",
                                "value": "運転免許証",
                              },
                              {
                                "display": "運転経歴証明書",
                                "value": "運転経歴証明書",
                              },
                              {
                                "display": "パスポート",
                                "value": "パスポート",
                              },
                              {
                                "display": "個人番号カード",
                                "value": "個人番号カード",
                              },
                              {
                                "display": "健康保険証",
                                "value": "健康保険証",
                              },
                              {
                                "display": "住民基本台帳カード",
                                "value": "住民基本台帳カード",
                              },
                              {
                                "display": "マイナンバーカード",
                                "value": "マイナンバーカード",
                              },
                              // {
                              //   "display": "運転経歴証明書",
                              //   "value": "運転経歴証明書",
                              // },
                              {
                                "display": "学生証",
                                "value": "学生証",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
                        identificationVerify != null &&
                                identificationVerify != ''
                            ? Positioned(
                                left: 12.0,
                                child: Row(
                                  children: [
                                    Text(
                                      HealingMatchConstants
                                          .registrationIdentityVerification,
                                      style: TextStyle(
                                          color:
                                              ColorConstants.formHintTextColor,
                                          fontFamily: 'NotoSansJP',
                                          fontSize: 10.0),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.redAccent.shade700,
                                          fontFamily: 'NotoSansJP',
                                          fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: idUploadVisible ? 20 : 0,
                  ),
                  Visibility(
                    visible: idUploadVisible,
                    child: _idProfileImage == null
                        ? InkWell(
                            onTap: () {
                              _showPicker(context, 0);
                            },
                            child: TextFieldCustom(
                              enabled: false,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                disabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                suffixIcon:
                                    Image.asset("assets/images_gps/upload.png"),
                                filled: true,
                                fillColor: ColorConstants.formFieldFillColor,
                                /*   hintStyle:
                                    HealingMatchConstants.formHintTextStyle,
                                hintText: HealingMatchConstants
                                    .registrationIdentityUpload, */
                              ),
                              hintText: Text.rich(
                                TextSpan(
                                  text: HealingMatchConstants
                                      .registrationIdentityUpload,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '*',
                                      style: HealingMatchConstants
                                          .formHintTextStyleStar,
                                    ),
                                  ],
                                  style:
                                      HealingMatchConstants.formHintTextStyle,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width:
                                      140.0, // MediaQuery.of(context).size.width * 0.38,
                                  height:
                                      MediaQuery.of(context).size.height * 0.19,
                                  decoration: new BoxDecoration(
                                    //   border: Border.all(color: Colors.black12),
                                    //   shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(File(_idProfileImage.path)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _idProfileImage = null;
                                    });
                                  },
                                  child: Card(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                    elevation: 10.0,
                                    shadowColor: Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.close_outlined,
                                        color: Colors.black,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            HealingMatchConstants.registrationAdd,
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text("\n*", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorConstants.formFieldFillColor,
                          border: Border.all(color: Colors.transparent),
                        ),
                        //  backgroundColor: ColorConstants.formFieldFillColor,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                qualification = "";
                                uploadVisible = false;
                                visible = true;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: visible ? 20 : 0,
                  ),
                  Visibility(
                    visible: visible,
                    child: Form(
                      key: qualificationupload,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: DropDownFormField(
                              titleText: null,
                              requiredField: true,
                              hintText: readonly
                                  ? qualification
                                  : HealingMatchConstants
                                      .registrationQualificationDropdown,
                              onSaved: (value) {
                                setState(() {
                                  visible = value == "無資格" ? true : false;
                                  qualification = value;
                                  uploadVisible = value == "無資格"
                                      ? false
                                      : certificateImages
                                              .containsKey(qualification)
                                          ? false
                                          : (value == "民間資格") &&
                                                  (privateQualification
                                                          .length ==
                                                      5)
                                              ? false
                                              : true;
                                  if (value == "無資格") {
                                    certificateImages.clear();
                                    privateQualification.clear();
                                  }
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                });
                              },
                              value: qualification,
                              onChanged: (value) {
                                setState(() {
                                  visible = value == "無資格" ? true : false;
                                  qualification = value;
                                  uploadVisible = value == "無資格"
                                      ? false
                                      : certificateImages
                                              .containsKey(qualification)
                                          ? false
                                          : (value == "民間資格") &&
                                                  (privateQualification
                                                          .length ==
                                                      5)
                                              ? false
                                              : true;
                                  if (value == "無資格") {
                                    certificateImages.clear();
                                    privateQualification.clear();
                                  }
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                });
                              },
                              dataSource: [
                                {
                                  "display": "はり師",
                                  "value": "はり師",
                                },
                                {
                                  "display": "きゅう師",
                                  "value": "きゅう師",
                                },
                                {
                                  "display": "鍼灸師",
                                  "value": "鍼灸師",
                                },
                                {
                                  "display": "あん摩マッサージ指圧師",
                                  "value": "あん摩マッサージ指圧師",
                                },
                                {
                                  "display": "柔道整復師",
                                  "value": "柔道整復師",
                                },
                                {
                                  "display": "理学療法士",
                                  "value": "理学療法士",
                                },
                                {
                                  "display": "国家資格取得予定（学生）",
                                  "value": "国家資格取得予定（学生）",
                                },
                                {
                                  "display": "民間資格",
                                  "value": "民間資格",
                                },
                                {
                                  "display": "無資格",
                                  "value": "無資格",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          qualification != null && qualification != ''
                              ? Positioned(
                                  left: 12.0,
                                  child: Row(
                                    children: [
                                      Text(
                                        HealingMatchConstants
                                            .registrationQualificationDropdown,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .formHintTextColor,
                                            fontFamily: 'NotoSansJP',
                                            fontSize: 10.0),
                                      ),
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.redAccent.shade700,
                                            fontFamily: 'NotoSansJP',
                                            fontSize: 10.0),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: !uploadVisible &&
                            certificateImages.length == 0 &&
                            privateQualification.length == 0
                        ? 0
                        : 195.0, // MediaQuery.of(context).size.height * 0.19,
                    padding: EdgeInsets.only(top: 16.0),

                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            /*   Visibility(
                              visible: uploadVisible &&
                                  !certificateImages.containsKey(qualification),
                              child: */
                            uploadVisible &&
                                    !certificateImages
                                        .containsKey(qualification)
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _showPicker(context, 1);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: ColorConstants
                                                .formFieldFillColor,
                                          ),
                                          padding: EdgeInsets.all(8),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          height: 140.0,
                                          //MediaQuery.of(context).size.height * 0.19,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              /*  Text('アップロード'),
                                              Text('証明書'), */
                                              Center(
                                                child: FittedBox(
                                                    child: Text(
                                                  "$qualification",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _showPicker(context, 1);
                                                  /*  if (certificateImages.length ==
                                                      5) {
                                                    showCertificateImageError();
                                                  } else {
                                                    _showPicker(context, 1);
                                                  } */
                                                },
                                                icon: Image.asset(
                                                    "assets/images_gps/upload.png"),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                HealingMatchConstants
                                                    .registrationQualificationUpload,
                                                style: TextStyle(fontSize: 8.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),

                            //   ),
                            SizedBox(
                              width: uploadVisible &&
                                      !certificateImages
                                          .containsKey(qualification)
                                  ? 10
                                  : 0,
                            ),
                            ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: certificateImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key =
                                      certificateImages.keys.elementAt(index);
                                  return buildQualificationImage(key, index);
                                }),
                            ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: privateQualification.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildPrivateQualificationImage(
                                      privateQualification[index], index);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChooseServiceScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 51.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorConstants.formFieldFillColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 14.0),
                        child: Text(
                          HealingMatchConstants.registrationChooseServiceNavBtn,
                          textAlign: TextAlign.left,
                          style: HealingMatchConstants.formHintTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BannerImageUpload();
                          });
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(8, 3, 6, 3),
                        disabledBorder:
                            HealingMatchConstants.textFormInputBorder,
                        suffixIcon: Image.asset("assets/images_gps/upload.png"),
                        filled: true,
                        hintStyle: HealingMatchConstants.formHintTextStyle,
                        hintText:
                            HealingMatchConstants.registrationMultiPhotoUpload,
                        fillColor: ColorConstants.formFieldFillColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    HealingMatchConstants.registrationBankDetails,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: DropDownFormField(
                                    titleText: null,
                                    requiredField: true,
                                    hintText: readonly
                                        ? bankName
                                        : HealingMatchConstants
                                            .registrationBankName,
                                    onSaved: (value) {
                                      setState(() {
                                        bankName = value;
                                      });
                                    },
                                    value: bankName,
                                    onChanged: (value) {
                                      setState(() {
                                        bankName = value;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    },
                                    dataSource: bankNameDropDownList,
                                    isList: true,
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                ),
                                bankName != null && bankName != ''
                                    ? Positioned(
                                        left: 12.0,
                                        child: Row(
                                          children: [
                                            Text(
                                              HealingMatchConstants
                                                  .registrationBankName,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .formHintTextColor,
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 10.0),
                                            ),
                                            Text(
                                              "*",
                                              style: TextStyle(
                                                  color:
                                                      Colors.redAccent.shade700,
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            bankName ==
                                    HealingMatchConstants
                                        .registrationBankOtherDropdownFiled
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8.0, right: 8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50.0,
                                          child: TextFieldCustom(
                                            style: HealingMatchConstants
                                                .formTextStyle,
                                            controller:
                                                bankOtherFieldController,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(16.0),

                                                /* hintText: "銀行名",
                                                hintStyle: HealingMatchConstants
                                                    .formHintTextStyle, */
                                                filled: true,
                                                fillColor: Colors.white,
                                                enabledBorder: HealingMatchConstants
                                                    .otherFiledTextFormInputBorder,
                                                focusedBorder: HealingMatchConstants
                                                    .otherFiledTextFormInputBorder,
                                                disabledBorder:
                                                    HealingMatchConstants
                                                        .otherFiledTextFormInputBorder,
                                                border: HealingMatchConstants
                                                    .otherFiledTextFormInputBorder),
                                            labelText: Text.rich(
                                              TextSpan(
                                                text: "銀行名",
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: '*',
                                                    style: HealingMatchConstants
                                                        .formHintTextStyleStar,
                                                  ),
                                                ],
                                                style: HealingMatchConstants
                                                    .formLabelTextStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 6.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      child: DropDownFormField(
                                        titleText: null,
                                        requiredField: true,
                                        hintText: readonly
                                            ? accountType
                                            : HealingMatchConstants
                                                .registrationBankAccountType,
                                        onSaved: (value) {
                                          setState(() {
                                            accountType = value;
                                          });
                                        },
                                        value: accountType,
                                        onChanged: (value) {
                                          setState(() {
                                            accountType = value;
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          });
                                        },
                                        dataSource: [
                                          {
                                            "display": "普通",
                                            "value": "普通",
                                          },
                                          {
                                            "display": "当座",
                                            "value": "当座",
                                          },
                                          {
                                            "display": "貯蓄",
                                            "value": "貯蓄",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
                                    accountType != null && accountType != ''
                                        ? Positioned(
                                            left: 12.0,
                                            child: Row(
                                              children: [
                                                Text(
                                                  HealingMatchConstants
                                                      .registrationBankAccountType,
                                                  style: TextStyle(
                                                      color: ColorConstants
                                                          .formHintTextColor,
                                                      fontFamily: 'NotoSansJP',
                                                      fontSize: 10.0),
                                                ),
                                                Text(
                                                  "*",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .redAccent.shade700,
                                                      fontFamily: 'NotoSansJP',
                                                      fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(''),
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: TextFieldCustom(
                                    style: HealingMatchConstants.formTextStyle,
                                    controller: branchNameController,
                                    decoration: new InputDecoration(
                                      /*  labelText: HealingMatchConstants
                                          .registrationBankBranchCode,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle, */
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                    labelText: Text.rich(
                                      TextSpan(
                                        text: HealingMatchConstants
                                            .registrationBankBranchCode,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: HealingMatchConstants
                                                .formHintTextStyleStar,
                                          ),
                                        ],
                                        style: HealingMatchConstants
                                            .formLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFieldCustom(
                                    controller: branchNumberController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      /*  labelText: HealingMatchConstants
                                          .registrationBankBranchNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle, */
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                    labelText: Text.rich(
                                      TextSpan(
                                        text: HealingMatchConstants
                                            .registrationBankBranchNumber,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: HealingMatchConstants
                                                .formHintTextStyleStar,
                                          ),
                                        ],
                                        style: HealingMatchConstants
                                            .formLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFieldCustom(
                                    controller: accountnumberController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      /* labelText: HealingMatchConstants
                                          .registrationBankAccountNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle, */
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                    labelText: Text.rich(
                                      TextSpan(
                                        text: HealingMatchConstants
                                            .registrationBankAccountNumber,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: HealingMatchConstants
                                                .formHintTextStyleStar,
                                          ),
                                        ],
                                        style: HealingMatchConstants
                                            .formLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFieldCustom(
                                    controller: bankNumberController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      /*  labelText: HealingMatchConstants
                                          .registrationBankNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle, */
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                    labelText: Text.rich(
                                      TextSpan(
                                        text: HealingMatchConstants
                                            .registrationBankNumber,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: HealingMatchConstants
                                                .formHintTextStyleStar,
                                          ),
                                        ],
                                        style: HealingMatchConstants
                                            .formLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFieldCustom(
                                    controller: accountHolderNameController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      labelText: HealingMatchConstants
                                          .registrationHolderName,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle,
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                    labelText: Text.rich(
                                      TextSpan(
                                        text: HealingMatchConstants
                                            .registrationHolderName,
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: HealingMatchConstants
                                                .formHintTextStyleStar,
                                          ),
                                        ],
                                        style: HealingMatchConstants
                                            .formLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  // width: MediaQuery.of(context).size.width * 0.38,
                                  child: DropDownFormField(
                                    titleText: null,
                                    requiredField: true,
                                    hintText: readonly
                                        ? accountHolderType
                                        : HealingMatchConstants
                                            .registrationBankAccountHolderType,
                                    onSaved: (value) {
                                      setState(() {
                                        accountHolderType = value;
                                      });
                                    },
                                    value: accountHolderType,
                                    onChanged: (value) {
                                      setState(() {
                                        accountHolderType = value;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    },
                                    dataSource: [
                                      {
                                        "display": "個人",
                                        "value": "individual",
                                      },
                                      {
                                        "display": "会社",
                                        "value": "company",
                                      },
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
                                ),
                                accountHolderType != null &&
                                        accountHolderType != ''
                                    ? Positioned(
                                        left: 12.0,
                                        child: Row(
                                          children: [
                                            Text(
                                              HealingMatchConstants
                                                  .registrationBankAccountHolderType,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .formHintTextColor,
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 10.0),
                                            ),
                                            Text(
                                              "*",
                                              style: TextStyle(
                                                  color:
                                                      Colors.redAccent.shade700,
                                                  fontFamily: 'NotoSansJP',
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: RaisedButton(
                      child: Text(
                        HealingMatchConstants.registrationCompleteBtn,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: ColorConstants.buttonColor,
                      onPressed: () {
                        /* DialogHelper.showProviderRegisterSuccessDialog(context); */
                        validateServicePriceDialog();
                        //_providerRegistrationDetails();
                        //  registerProvider();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () =>
                        NavigationRouter.switchToProviderLogin(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          HealingMatchConstants.registrationAlreadyActTxt,
                          style: TextStyle(
                              fontSize: 12.0,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 2,
                              decorationStyle: TextDecorationStyle.solid),
                        ),
                      ],
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

  validateServicePriceDialog() {
    if (HealingMatchConstants.estheticServicePriceModel.isEmpty &&
        HealingMatchConstants.relaxationServicePriceModel.isEmpty &&
        HealingMatchConstants.treatmentServicePriceModel.isEmpty &&
        HealingMatchConstants.fitnessServicePriceModel.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: buildDialogContent(context),
            );
          });
    } else {
      _providerRegistrationDetails();
    }
  }

  buildDialogContent(BuildContext context) {
    return Container(
      width: 350.0, // MediaQuery.of(context).size.width,
      //margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "サービス料金の設定まで入力完了\nしていない場合は利用者の検索結果に\n表示されません。 \n(利用者への情報展開はされません)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
              _providerRegistrationDetails();
            },
            color: Color.fromRGBO(217, 217, 217, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              '登録完了',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChooseServiceScreen()));
            },
            color: Color.fromRGBO(200, 217, 33, 1),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              '料金を設定する',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  _providerRegistrationDetails() {
    var _myidentificationVerify = identificationVerify.toString().trim();
    var _myqualification = qualification.toString().trim();
    String branchNumber = branchNumberController.text;
    String accountNumber = accountnumberController.text;

    //id Validation
    if (_myidentificationVerify.isEmpty || _myidentificationVerify == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('本人確認証を選択してください。', style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (_idProfileImage == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('本人確認証をアップロードしてください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //Certificate validation
    /*  if ((_myqualification.isEmpty || _myqualification == null)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('保有資格を入力してください。', style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    } */

    if (_myqualification == "" || _myqualification == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('保有資格の種類を選択してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (certificateImages.isEmpty &&
        _myqualification != "無資格" &&
        privateQualification.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('保有資格の証明書をアップロードしてください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    /* //Choose Service Screen validation
    if (HealingMatchConstants.estheticServicePriceModel.isEmpty &&
        HealingMatchConstants.relaxationServicePriceModel.isEmpty &&
        HealingMatchConstants.treatmentServicePriceModel.isEmpty &&
        HealingMatchConstants.fitnessServicePriceModel.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('提供するサービスと価格を選択してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    } */

    if (bankName == null || bankName == '') {
      displaySnackBarError("銀行名は必須項目なので選択してください。");

      return;
    }

    if (bankName == 'その他' &&
        (bankOtherFieldController.text == '' ||
            bankOtherFieldController.text == null)) {
      displaySnackBarError("銀行名は必須項目なので入力してください。");

      return;
    }

    if (bankName == 'その他' && bankOtherFieldController.text.length > 25) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('正しい銀行名を入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (accountType == null || accountType == '') {
      displaySnackBarError("口座種類は必須項目なので選択してください。");

      return;
    }

    if (branchNameController.text == null || branchNameController.text == '') {
      displaySnackBarError("支店名を入力してください。");

      return;
    }

    if (branchNameController.text.length > 20) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('支店名は20文字以内で入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (branchNumberController.text == null ||
        branchNumberController.text == '') {
      displaySnackBarError("支店番号を入力してください。");

      return;
    }

    if (branchNumber.length > 3 || branchNumber.length < 3) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('3文字の支店番号を入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (bankNumberController.text == null || bankNumberController.text == '') {
      displaySnackBarError("銀行番号を入力してください。");

      return;
    }

    if (bankNumberController.text.length > 4 ||
        bankNumberController.text.length < 4) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('4文字の銀行番号を入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (accountnumberController.text == null ||
        accountnumberController.text == '') {
      displaySnackBarError("口座番号を入力してください。");

      return;
    }

    if (accountNumber.length > 8 || accountNumber.length < 7) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('7-8文字の口座番号を入力してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (accountHolderNameController.text == null ||
        accountHolderNameController.text == '') {
      displaySnackBarError("必須項目ですので、口座名義人の名前を入力してください。");

      return;
    }

    if (accountHolderNameController.text.length > 20) {
      displaySnackBarError("アカウント所有者の名前を20文字以内で入力してください。");

      return;
    }

    if (accountHolderType == null || accountHolderType == '') {
      displaySnackBarError("アカウント所有者のタイプを選択してください。");

      return;
    }

    print("Success");
    compressImages();
    //  registerProvider();
  }

  void displaySnackBarError(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('$text', style: TextStyle(fontFamily: 'NotoSansJP')),
      action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'はい',
          textColor: Colors.white),
    ));
    ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
  }

  compressImages() async {
    ProgressDialogBuilder.showProviderRegisterProgressDialog(context);

    List<File> bannerImages = List<File>();
    List<File> privateQualificationImages = List<File>();
    Map<String, String> compressedCertificateImages = Map<String, String>();
    File profileImageUrl;
    File idProofImageUrl;

    profileImageUrl = await FlutterNativeImage.compressImage(
        HealingMatchConstants.profileImage.path,
        quality: 50);

    idProofImageUrl = await FlutterNativeImage.compressImage(
        _idProfileImage.path,
        quality: 50);

    // Banner Images
    for (var file in files) {
      File banner =
          await FlutterNativeImage.compressImage(file.path, quality: 50);
      bannerImages.add(banner);
    }

    certificateImages.forEach((key, value) async {
      File certificateUrl = await FlutterNativeImage.compressImage(
          certificateImages[key],
          quality: 50);
      compressedCertificateImages[key] = certificateUrl.path;
    });

    for (var certificate in privateQualification) {
      File certificateUrl =
          await FlutterNativeImage.compressImage(certificate, quality: 50);
      privateQualificationImages.add(certificateUrl);
    }

    Future.delayed(Duration(seconds: 1), () {
      print('a');
      print(profileImageUrl.path +
          idProofImageUrl.path +
          bannerImages.length.toString() +
          compressedCertificateImages.length.toString() +
          privateQualificationImages.length.toString());
      registerProvider(profileImageUrl, idProofImageUrl, bannerImages,
          compressedCertificateImages, privateQualificationImages);
    });

    /*  registerProvider(profileImageUrl, idProofImageUrl, bannerImages,
        compressedCertificateImages, privateQualificationImages); */
  }

  //Registration Api
  registerProvider(
      File compressedProfileImageUrl,
      File compressedIdProofImageUrl,
      List<File> compressedBannerImages,
      Map<String, String> compressedCertificateImages,
      List<File> compressedPrivateQualificationImages) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String qualification = '';
    int i = 0;
    if (this.qualification == "無資格") {
      qualification = "無資格";
    } else {
      certificateImages.forEach((key, value) {
        if (i == 0) {
          qualification = key;
        } else {
          qualification = qualification + "," + key;
        }
        i++;
      });

      if (privateQualification.length != 0) {
        if (qualification != '') {
          qualification = qualification + "," + '民間資格';
        } else {
          qualification = '民間資格';
        }
      }
    }

    String childrenMeasure = '';
    if (HealingMatchConstants.serviceProviderChildrenMeasure.isEmpty) {
      childrenMeasure = '';
    } else {
      for (int i = 0;
          i < HealingMatchConstants.serviceProviderChildrenMeasure.length;
          i++) {
        if (i == 0) {
          childrenMeasure =
              HealingMatchConstants.serviceProviderChildrenMeasure[0];
        } else {
          childrenMeasure = childrenMeasure +
              "," +
              HealingMatchConstants.serviceProviderChildrenMeasure[i];
        }
      }
    }

    String storeTypeDisplay = '';
    if (HealingMatchConstants.serviceProviderStoreType.isEmpty) {
      storeTypeDisplay = '';
    } else {
      for (int i = 0;
          i < HealingMatchConstants.serviceProviderStoreType.length;
          i++) {
        if (i == 0) {
          storeTypeDisplay = HealingMatchConstants.serviceProviderStoreType[0];
        } else {
          storeTypeDisplay = storeTypeDisplay +
              "," +
              HealingMatchConstants.serviceProviderStoreType[i];
        }
      }
    }

    List<MultipartFile> multipartList = new List<MultipartFile>();
    compressedCertificateImages.forEach((key, value) async {
      multipartList.add(await http.MultipartFile.fromPath(key, value));
    });

    Map<String, String> headers = {"Content-Type": "multipart/form-data"};
    var request = http.MultipartRequest(
        'POST', Uri.parse(HealingMatchConstants.REGISTER_PROVIDER_URL));
    request.headers.addAll(headers);
    request.fields.addAll({
      'email': HealingMatchConstants.serviceProviderEmailAddress,
      'phoneNumber': HealingMatchConstants.serviceProviderPhoneNumber,
      'userName': HealingMatchConstants.serviceProviderUserName,
      'gender': HealingMatchConstants.serviceProviderGender != null
          ? HealingMatchConstants.serviceProviderGender
          : "",
      'dob': HealingMatchConstants.serviceProviderDOB,
      'age': HealingMatchConstants.serviceProviderAge,
      'password': HealingMatchConstants.serviceProviderPassword,
      'password_confirmation':
          HealingMatchConstants.serviceProviderConfirmPassword,
      'isTherapist': '1',
      'buildingName': HealingMatchConstants.serviceProviderBuildingName,
      'addressTypeSelection': "直接入力",
      'address': HealingMatchConstants.serviceProviderAddress,
      'capitalAndPrefecture': HealingMatchConstants.serviceProviderPrefecture,
      'capitalAndPrefectureId':
          HealingMatchConstants.serviceProviderPrefectureID.toString(),
      'citiesId': HealingMatchConstants.serviceProviderCityID.toString(),
      'cityName': HealingMatchConstants.serviceProviderCity,
      'area': HealingMatchConstants.serviceProviderArea,
      'lat': HealingMatchConstants.serviceProviderCurrentLatitude.toString(),
      'lon': HealingMatchConstants.serviceProviderCurrentLongitude.toString(),
      'genderOfService':
          HealingMatchConstants.serviceProviderGenderService != null
              ? HealingMatchConstants.serviceProviderGenderService
              : '',
      'storeType': storeTypeDisplay,
      'numberOfEmp': (HealingMatchConstants.serviceProviderBusinessForm ==
                      "施術店舗あり 施術従業員あり" ||
                  HealingMatchConstants.serviceProviderBusinessForm ==
                      "施術店舗なし 施術従業員あり（出張のみ)") &&
              HealingMatchConstants.serviceProviderNumberOfEmpl != null
          ? HealingMatchConstants.serviceProviderNumberOfEmpl
          : '0',
      'businessTrip':
          HealingMatchConstants.serviceProviderBusinessTripService == "出張可能"
              ? '1'
              : '0',
      'coronaMeasure':
          HealingMatchConstants.serviceProviderCoronaMeasure == "実施"
              ? '1'
              : '0',
      'childrenMeasure': childrenMeasure,
      'businessForm': HealingMatchConstants.serviceProviderBusinessForm != null
          ? HealingMatchConstants.serviceProviderBusinessForm
          : '',
      'userRoomNumber': HealingMatchConstants.serviceProviderRoomNumber,
      'qulaificationCertImgUrl': qualification,
      'bankName':
          bankName == HealingMatchConstants.registrationBankOtherDropdownFiled
              ? bankOtherFieldController.text
              : bankName,
      'bankCode': bankNumberController.text,
      'branchName': branchNameController.text,
      'branchNumber': branchNumberController.text,
      'accountNumber': accountnumberController.text,
      'accountType': accountType,
      "accountHolderType": accountHolderType,
      'accountHolderName': accountHolderNameController.text,
      'proofOfIdentityType': identificationVerify,
      'estheticList':
          json.encode(HealingMatchConstants.estheticServicePriceModel),
      'relaxationList':
          json.encode(HealingMatchConstants.relaxationServicePriceModel),
      'orteopathicList': json.encode(
        HealingMatchConstants.treatmentServicePriceModel,
      ),
      'fitnessList': json.encode(
        HealingMatchConstants.fitnessServicePriceModel,
      ),
      "fcmToken":
          sharedPreferences.getString("notificationStatus") == "accepted"
              ? fcmToken
              : '',
      "isShop": HealingMatchConstants.serviceProviderBusinessForm ==
                  "施術店舗あり 施術従業員あり" ||
              HealingMatchConstants.serviceProviderBusinessForm ==
                  "施術店舗あり 施術従業員なし（個人経営）"
          ? "true"
          : "false",
      "appleUserId": HealingMatchConstants.appleTokenId != null
          ? HealingMatchConstants.appleTokenId
          : '',
      "lineUserToken": HealingMatchConstants.lineAccessToken != null
          ? HealingMatchConstants.lineAccessToken
          : '',
      "lineBotUserId": HealingMatchConstants.lineUserID != null
          ? HealingMatchConstants.lineUserID
          : ''
    });

    if (HealingMatchConstants.serviceProviderBusinessForm == "施術店舗あり 施術従業員あり" ||
        HealingMatchConstants.serviceProviderBusinessForm ==
            "施術店舗あり 施術従業員なし（個人経営）") {
      request.fields.addAll({
        'storePhone': HealingMatchConstants.serviceProviderStorePhoneNumber,
        'storeName': HealingMatchConstants.serviceProviderStoreName
      });
    }

    var a = request.fields.toString();

    //Upload Proof of ID
    request.files.add(await http.MultipartFile.fromPath(
        'proofOfIdentityImgUrl', compressedIdProofImageUrl.path));

    //Upload Profile Image if not null
    if (HealingMatchConstants.profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'uploadProfileImgUrl', compressedProfileImageUrl.path));
    }

    //Upload Certificate Files
    request.files.addAll(multipartList);

    //Upload Private Qualification Images
    for (var certificate in compressedPrivateQualificationImages) {
      request.files
          .add(await http.MultipartFile.fromPath('民間資格', certificate.path));
    }

    //Upload Banner Images
    for (var file in compressedBannerImages) {
      request.files
          .add(await http.MultipartFile.fromPath('bannerImage', file.path));
    }

    try {
      final userDetailsRequest = await request.send();
      print("This is request : ${userDetailsRequest.request}");
      final response = await http.Response.fromStream(userDetailsRequest);
      print("This is response: ${response.statusCode}\n${response.body}");
      if (StatusCodeHelper.isRegisterSuccess(
          response.statusCode, context, response.body)) {
        LoginResponseModel registerResponseModel =
            LoginResponseModel.fromJson(json.decode(response.body));
        Data userData = registerResponseModel.data;
        HealingMatchConstants.userId = userData.id;
        HealingMatchConstants.serviceProviderPhoneNumber =
            userData.phoneNumber.toString();
        HealingMatchConstants.accessToken = registerResponseModel.accessToken;
        Auth()
            .signUp(
                userData.storeName != null && userData.storeName != ''
                    ? userData.storeName
                    : userData.userName,
                userData.phoneNumber.toString() +
                    userData.id.toString() +
                    "@nexware.global.com",
                "password",
                userData.uploadProfileImgUrl,
                1,
                userData.id)
            .then((value) {
          if (value != null) {
            ServiceProviderApi.saveFirebaseUserID(value, context);
            userData.firebaseUDID = value;
          }
        });
        buildInitialTime(userData.id);
        ServiceProviderApi.saveRegShiftServiceTime(_storeServiceTime, context)
            .then((value) {
          sharedPreferences.setString("userData", json.encode(userData));
          sharedPreferences.setString(
              "accessToken", registerResponseModel.accessToken);
          sharedPreferences.setString(
              "lineBotIdProvider", registerResponseModel.data.lineBotUserId);
          sharedPreferences.setString(
              "appleIdProvider", registerResponseModel.data.appleUserId);
          sharedPreferences.setBool(
              "isActive", registerResponseModel.data.isActive);
          sharedPreferences.setString("providerPhoneNumer",
              registerResponseModel.data.phoneNumber.toString());
          sharedPreferences.setBool(
              'isActive', registerResponseModel.data.isActive);
          /*   sharedPreferences.setBool('isProviderRegister', true); */
          HealingMatchConstants.estheticServicePriceModel.clear();
          HealingMatchConstants.relaxationServicePriceModel.clear();
          HealingMatchConstants.treatmentServicePriceModel.clear();
          HealingMatchConstants.fitnessServicePriceModel.clear();
          HealingMatchConstants.serviceProviderStoreType.clear();
          HealingMatchConstants.selectedEstheticDropdownValues.clear();
          HealingMatchConstants.selectedRelaxationDropdownValues.clear();
          HealingMatchConstants.selectedTreatmentDropdownValues.clear();
          HealingMatchConstants.selectedFitnessDropdownValues.clear();
          HealingMatchConstants.otherEstheticDropDownValues.clear();
          HealingMatchConstants.otherTreatmentDropDownValues.clear();
          HealingMatchConstants.otherRelaxationDropDownValues.clear();
          HealingMatchConstants.otherFitnessDropDownValues.clear();

          ProgressDialogBuilder.hideRegisterProgressDialog(context);
          print('Login response : ${registerResponseModel.toJson()}');
          print('Login token : ${registerResponseModel.accessToken}');
          NavigationRouter.switchToProviderOtpScreen(context);
        });
      } else {
        ProgressDialogBuilder.hideRegisterProgressDialog(context);
        print('Response error occured!');
      }
    } on SocketException catch (_) {
      //handle socket Exception
      ProgressDialogBuilder.hideRegisterProgressDialog(context);
      NavigationRouter.switchToNetworkHandler(context);
      print('Network error !!');
    } catch (_) {
      //handle other error
      print("Error");
      ProgressDialogBuilder.hideRegisterProgressDialog(context);
    }
  }

  void _showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('既存の写真から選択する'),
                      onTap: () {
                        _imgFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('カメラで撮影する'),
                    onTap: () {
                      _imgFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(int index) async {
    final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      _profileImage = image;
      if (index == 0) {
        _idProfileImage = _profileImage;
      } else {
        if (qualification == "民間資格") {
          privateQualification.add(_profileImage.path);
          uploadVisible = false;
        } else {
          certificateImages[qualification] = _profileImage.path;
        }
      }
    });
    print('image path : ${_profileImage.path}');
  }

  _imgFromGallery(int index) async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _profileImage = image;
      if (index == 0) {
        _idProfileImage = _profileImage;
      } else {
        if (qualification == "民間資格") {
          privateQualification.add(_profileImage.path);
          uploadVisible = false;
        } else {
          certificateImages[qualification] = _profileImage.path;
        }
      }
    });
    print('image path : ${_profileImage.path}');
  }

  void showProgressDialog() {
    _progressDialog.showProgressDialog(context,
        textToBeDisplayed: '住所を取得しています...', dismissAfter: Duration(seconds: 5));
  }

  void hideProgressDialog() {
    _progressDialog.dismissProgressDialog(context);
  }

  void showIdSelectError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('アップロードできる本人確認は1つだけです。',
          style: TextStyle(fontFamily: 'NotoSansJP')),
      action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'はい',
          textColor: Colors.white),
    ));
    return;
  }

  void showCertificateImageError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('アップロードできる品質証明書は5つだけです。',
          style: TextStyle(fontFamily: 'NotoSansJP')),
      action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'はい',
          textColor: Colors.white),
    ));
    return;
  }

  void getBankName() async {
    await http
        .get(HealingMatchConstants.REGISTER_PROVIDER_GET_BANK_LIST_URL)
        .then((response) {
      if (response.statusCode == 200) {
        bankNameDropDownModel =
            Bank.BankNameDropDownModel.fromJson(json.decode(response.body));
        for (var bankList in bankNameDropDownModel.data) {
          bankNameDropDownList.add(bankList.value);
        }
        setState(() {
          bankNameDropDownList
              .add(HealingMatchConstants.registrationBankOtherDropdownFiled);
        });
      } else {
        print(response.reasonPhrase);
      }
    });
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
                    width: 140.0, // MediaQuery.of(context).size.width * 0.38,
                    height: 140.0, //MediaQuery.of(context).size.height * 0.19,
                    decoration: new BoxDecoration(
                      //   border: Border.all(color: Colors.black12),
                      //   shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(certificateImages[key])),
                      ),
                    )),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      certificateImages.remove(key);
                    });
                  },
                  child: Card(
                    shape: CircleBorder(),
                    color: Colors.white,
                    elevation: 10.0,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.black,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("$key", style: TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }

  Widget buildPrivateQualificationImage(
      String privateQualificationImage, int index) {
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
                    width: 140.0, // MediaQuery.of(context).size.width * 0.38,
                    height: 140.0, //MediaQuery.of(context).size.height * 0.19,
                    decoration: new BoxDecoration(
                      //   border: Border.all(color: Colors.black12),
                      //   shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(privateQualificationImage)),
                      ),
                    )),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      privateQualification.removeAt(index);
                    });
                  },
                  child: Card(
                    shape: CircleBorder(),
                    color: Colors.white,
                    elevation: 10.0,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.black,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("民間資格", style: TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }

  drawRangeSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 15.0,
          color: ColorConstants.buttonColor,
        ),
        SizedBox(
            width: 100.0,
            child: Divider(
              color: ColorConstants.buttonColor,
            )),
        Icon(
          Icons.circle,
          size: 15.0,
          color: ColorConstants.buttonColor,
        ),
      ],
    );
  }

  _getFCMToken() async {
    fireBaseMessaging.getToken().then((fcmTokenValue) {
      if (fcmTokenValue != null) {
        fcmToken = fcmTokenValue;
        print('FCM Skip Token : $fcmToken');
        HealingMatchConstants.userDeviceToken = fcmToken;
      } else {
        fireBaseMessaging.onTokenRefresh.listen((refreshToken) {
          if (refreshToken != null) {
            fcmToken = refreshToken;
            HealingMatchConstants.userDeviceToken = fcmToken;
            print('FCM Skip Refresh Tokens : $fcmToken');
          }
        }).onError((handleError) {
          print('On FCM Skip Token Refresh error : ${handleError.toString()}');
        });
      }
    }).catchError((onError) {
      print('FCM Skip Token Exception : ${onError.toString()}');
    });
  }
}

//Class for the Banner Image Upload
class BannerImageUpload extends StatefulWidget {
  @override
  _BannerImageUploadState createState() => _BannerImageUploadState();
}

class _BannerImageUploadState extends State<BannerImageUpload> {
  String error = 'No Error Dectected';
  List<Asset> images = List<Asset>();

  PickedFile _profileImage;

  @override
  void initState() {
    images.addAll(HealingMatchConstants.bannerImages);
    super.initState();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          selectionLimitReachedText: "バナーイメージは5個以上選択できません。選択を解除してやり直すことができます。",
          textOnNothingSelected: "掲載写真を選択してください。",
          statusBarColor: "#F6F6F6",
          actionBarColor: "#C8D921",
          actionBarTitle: "Healing Match App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      //if Back was pressed
      if (error != "The user has cancelled the selection") {
        images = resultList;
      }
      this.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 18.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                '掲載写真のアップロード',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            buildGridView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "キャンセル",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                FlatButton(
                  onPressed: () {
                    if (images.length > 0) {
                      HealingMatchConstants.bannerImages.clear();
                      HealingMatchConstants.bannerImages.addAll(images);
                      getFilePath();
                    } else {
                      Toast.show("掲載写真を選択してください。", context,
                          duration: 4,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "アップロードする",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: ColorConstants.buttonColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildGridView() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 18.0, bottom: 18.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(images.length + 1, (index) {
          if (index < images.length) {
            Asset asset = images[index];
            return InkWell(
              onTap: () => loadAssets(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AssetThumb(
                  asset: asset,
                  width: 500,
                  height: 500,
                ),
              ),
            );
          } else if (images.length != 5) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(225, 225, 225, 1),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 25.0,
                ),
                onPressed: loadAssets,
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('既存の写真から選択する'),
                      onTap: () {
                        loadAssets();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('カメラで撮影する'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      _profileImage = image;
    });
    print('image path : ${_profileImage.path}');
  }

  //Get the file Path of the Assets Selected
  getFilePath() async {
    files.clear();
    for (var asset in images) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      files.add(File(filePath));
    }
    Navigator.pop(context);
    //  bannerImageUploadApi();
  }

/*  bannerImageUploadApi() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(HealingMatchConstants.REGISTER_PROVIDER_BANNER_UPLOAD_URL));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.fields.addAll({'userId': '13'});
    request.headers.addAll(headers);
    for (var file in files) {
      request.files
          .add(await http.MultipartFile.fromPath('bannerImage', file.path));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  } */
}

class CertificateImageUpload {
  String name;
  String path;

  CertificateImageUpload(this.name, this.path);
}
