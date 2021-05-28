import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/auth.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/bankNameDropDownModel.dart'
    as Bank;
import 'package:gps_massageapp/models/responseModels/serviceProvider/registerProviderResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';
import 'package:gps_massageapp/utils/text_field_custom.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ProgressDialog _progressDialog = ProgressDialog();
  Map<String, String> certificateImages = Map<String, String>();
  PickedFile _profileImage;
  PickedFile _idProfileImage;
  TextEditingController branchCodeController = TextEditingController();
  TextEditingController branchNumberController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  TextEditingController bankOtherFieldController = TextEditingController();
  Bank.BankNameDropDownModel bankNameDropDownModel;
  List<String> bankNameDropDownList = List<String>();
  List<String> privateQualification = List<String>();

  void initState() {
    super.initState();
    identificationVerify = '';
    qualification = '';
    bankName = '';
    qualification = '';
    accountType = '';
    getsavedValues();
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
    HealingMatchConstants.branchCode = branchCodeController.text;
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
      accountnumberController.text = HealingMatchConstants.accountNumber;
      accountType = HealingMatchConstants.accountType;
      branchCodeController.text = HealingMatchConstants.branchCode;
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(0.0),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(0.0),
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
                            Form(
                              key: bankkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: DropDownFormField(
                                        titleText: null,
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
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            bankName ==
                                    HealingMatchConstants
                                        .registrationBankOtherDropdownFiled
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50.0,
                                          child: TextFormField(
                                            style: HealingMatchConstants
                                                .formTextStyle,
                                            controller:
                                                bankOtherFieldController,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        5, 5, 5, 0),
                                                hintText: "銀行名",
                                                hintStyle: HealingMatchConstants
                                                    .formHintTextStyle,
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
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Form(
                                  key: accountnumberkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        child: DropDownFormField(
                                          titleText: null,
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
                                                  .requestFocus(
                                                      new FocusNode());
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
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFormField(
                                    style: HealingMatchConstants.formTextStyle,
                                    controller: branchCodeController,
                                    decoration: new InputDecoration(
                                      labelText: HealingMatchConstants
                                          .registrationBankBranchCode,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                  child: TextFormField(
                                    controller: branchNumberController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      labelText: HealingMatchConstants
                                          .registrationBankBranchNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  child: TextFormField(
                                    controller: accountnumberController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: new InputDecoration(
                                      labelText: HealingMatchConstants
                                          .registrationBankAccountNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                  ),
                                ),
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
                        _providerRegistrationDetails();
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

    if (bankName == 'その他' && bankOtherFieldController.text.length > 25) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な銀行名を入力してください。',
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

    if (branchCodeController.text != null || branchCodeController.text != '') {
      if (branchCodeController.text.length > 20) {
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
    }

    if (branchNumber != null) {
      if (branchNumber.length > 5) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          content: Text('支店番号は5文字以内で入力してください。',
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
    }

    if (accountNumber != null) {
      if (accountNumber.length > 10) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          content: Text('アカウント番号は10文字以内で入力してください。',
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
    }
    print("Success");
    registerProvider();
  }

  //Registration Api
  registerProvider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ProgressDialogBuilder.showProviderRegisterProgressDialog(context);
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
    certificateImages.forEach((key, value) async {
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
      'storeName': HealingMatchConstants.serviceProviderStoreName != null
          ? HealingMatchConstants.serviceProviderStoreName
          : '',
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
      'numberOfEmp': HealingMatchConstants.serviceProviderNumberOfEmpl != null
          ? HealingMatchConstants.serviceProviderNumberOfEmpl
          : '0',
      'businessTrip':
          HealingMatchConstants.serviceProviderBusinessTripService == "はい"
              ? '1'
              : '0',
      'coronaMeasure':
          HealingMatchConstants.serviceProviderCoronaMeasure == "はい"
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
      'branchCode': branchCodeController.text,
      'branchNumber': branchNumberController.text,
      'accountNumber': accountnumberController.text,
      'accountType': accountType,
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
    });

    if (HealingMatchConstants.serviceProviderStorePhoneNumber != '') {
      request.fields.addAll({
        'storePhone': HealingMatchConstants.serviceProviderStorePhoneNumber
      });
    }

    var a = request.fields.toString();

    //Upload Proof of ID
    request.files.add(await http.MultipartFile.fromPath(
        'proofOfIdentityImgUrl', _idProfileImage.path));

    //Upload Profile Image if not null
    if (HealingMatchConstants.profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'uploadProfileImgUrl', HealingMatchConstants.profileImage.path));
    }

    //Upload Certificate Files
    request.files.addAll(multipartList);

    //Upload Private Qualification Images
    for (var certificate in privateQualification) {
      request.files.add(await http.MultipartFile.fromPath('民間資格', certificate));
    }

    //Upload Banner Images
    for (var file in files) {
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
        RegisterResponseModel registerResponseModel =
            RegisterResponseModel.fromJson(json.decode(response.body));
        Data userData = registerResponseModel.data;
        HealingMatchConstants.userId = userData.id;
        Auth()
            .signUp(
                userData.storeName != null && userData.storeName != ''
                    ? userData.storeName
                    : userData.userName,
                userData.email,
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
        sharedPreferences.setString("userData", json.encode(userData));
        sharedPreferences.setString(
            "accessToken", registerResponseModel.accessToken);
        sharedPreferences.setBool('isProviderRegister', true);
        ProgressDialogBuilder.hideRegisterProgressDialog(context);
        print('Login response : ${registerResponseModel.toJson()}');
        print('Login token : ${registerResponseModel.accessToken}');
        NavigationRouter.switchToProviderOtpScreen(context);
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
                      title: new Text('プロフィール画像を選択してください。'),
                      onTap: () {
                        _imgFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('プロフィール写真を撮ってください。'),
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
                    HealingMatchConstants.bannerImages.clear();
                    HealingMatchConstants.bannerImages.addAll(images);
                    getFilePath();
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
                      title: new Text('プロフィール画像を選択してください。'),
                      onTap: () {
                        loadAssets();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('プロフィール写真を撮ってください。'),
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
