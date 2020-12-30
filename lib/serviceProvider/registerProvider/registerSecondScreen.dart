import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/apiResponseModels/estheticDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/stateList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/utils/dropdown.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSuccessOtpScreen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'chooseServiceScreen.dart';

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
  var identificationverify, qualification, bankname, accountnumber;

  List<dynamic> stateDropDownValues = List<dynamic>();
  StatesList states;
  final statekey = new GlobalKey<FormState>();
  final citykey = new GlobalKey<FormState>();
  var _mystate, _mycity;

  void initState() {
    super.initState();
    identificationverify = '';
    qualification = '';
    bankname = '';
    accountnumber = '';
    _mystate = '';
    _mycity;
    _getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HealingMatchConstants.registrationFirstText,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HealingMatchConstants.registrationSecondText,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: identityverification,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(0.0),
                          color: Colors.grey[200],
                          child: DropDownFormField(
                            autovalidate: false,
                            titleText: null,
                            hintText: readonly
                                ? identificationverify
                                : HealingMatchConstants
                                    .registrationIdentityVerification,
                            onSaved: (value) {
                              setState(() {
                                identificationverify = value;
                              });
                            },
                            value: identificationverify,
                            onChanged: (value) {
                              setState(() {
                                identificationverify = value;
                              });
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
                                "display": "個人番号カー",
                                "value": "個人番号カー",
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
                    height: 13,
                  ),
                  InkWell(
                    onTap: () {},
                    child: TextFormField(
                      enabled: false,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: Icon(Icons.file_upload)),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText:
                              HealingMatchConstants.registrationIdentityUpload,
                          fillColor: Colors.grey[200]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        HealingMatchConstants.registrationAdd,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = true;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
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
                            color: Colors.grey[200],
                            child: DropDownFormField(
                              titleText: null,
                              hintText: readonly
                                  ? qualification
                                  : HealingMatchConstants
                                      .registrationQualificationDropdown,
                              onSaved: (value) {
                                setState(() {
                                  qualification = value;
                                });
                              },
                              value: qualification,
                              onChanged: (value) {
                                setState(() {
                                  qualification = value;
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
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.19,
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('アップロード'),
                        Text('証明書'),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.file_upload),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          HealingMatchConstants.registrationQualificationUpload,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.065,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     color: Colors.black),
                    child: RaisedButton(
                      child: Text(
                        HealingMatchConstants.registrationChooseServiceNavBtn,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.grey[200],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChooseServiceScreen()));
                      },
                    ),
                  ),
                  /*  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          'hello',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: TextFormField(
                      enabled: false,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.file_upload)),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                        hintText:
                            HealingMatchConstants.registrationMultiPhotoUpload,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    HealingMatchConstants.registrationBankDetails,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: bankkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              color: Colors.grey[200],
                              child: DropDownFormField(
                                titleText: null,
                                hintText: readonly
                                    ? bankname
                                    : HealingMatchConstants
                                        .registrationBankName,
                                onSaved: (value) {
                                  setState(() {
                                    bankname = value;
                                  });
                                },
                                value: bankname,
                                onChanged: (value) {
                                  setState(() {
                                    bankname = value;
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "賃貸",
                                    "value": "賃貸",
                                  },
                                  {
                                    "display": "販売（売買）",
                                    "value": "販売（売買）",
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
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.0,
                              ),
                            ),
                            filled: true,
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            hintText: HealingMatchConstants
                                .registrationBankBranchCode,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.0,
                              ),
                            ),
                            filled: true,
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            hintText: HealingMatchConstants
                                .registrationBankBranchNumber,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.0,
                              ),
                            ),
                            filled: true,
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            hintText: HealingMatchConstants
                                .registrationBankAccountNumber,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: accountnumberkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              color: Colors.transparent,
                              child: DropDownFormField(
                                titleText: null,
                                hintText: readonly
                                    ? accountnumber
                                    : HealingMatchConstants
                                        .registrationBankAccountType,
                                onSaved: (value) {
                                  setState(() {
                                    accountnumber = value;
                                  });
                                },
                                value: accountnumber,
                                onChanged: (value) {
                                  setState(() {
                                    accountnumber = value;
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
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Visibility(
                          visible: false,
                          child: TextFormField(
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0.0,
                                ),
                              ),
                              filled: true,
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              hintText: "",
                              fillColor: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: statekey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // height: containerHeight,
                              margin: EdgeInsets.all(0.0),
                              width: MediaQuery.of(context).size.width * 0.33,
                              color: Colors.grey[200],

                              child: DropDownFormField(
                                titleText: null,
                                hintText: readonly ? _mystate : 'state',
                                onSaved: (value) {
                                  setState(() {
                                    _mystate = value;
                                  });
                                },
                                value: _mystate,
                                onChanged: (value) {
                                  setState(() {
                                    _mystate = value;
                                  });
                                },
                                dataSource: stateDropDownValues,
                                islist: true,
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Form(
                        key: citykey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // height: containerHeight,
                              margin: EdgeInsets.all(0.0),
                              width: MediaQuery.of(context).size.width * 0.33,
                              color: Colors.grey[200],

                              child: DropDownFormField(
                                titleText: null,
                                hintText: readonly ? _mycity : 'city',
                                onSaved: (value) {
                                  setState(() {
                                    _mycity = value;
                                  });
                                },
                                value: _mycity,
                                onChanged: (value) {
                                  setState(() {
                                    _mycity = value;
                                  });
                                },
                                dataSource: stateDropDownValues,
                                islist: true,
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: RaisedButton(
                      child: Text(
                        HealingMatchConstants.registrationCompleteBtn,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.lime,
                      onPressed: () {
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegistrationSuccessOtpScreen()));*/
                        _providerRegistrationDetails();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        HealingMatchConstants.registrationAlreadyActTxt,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
    var _myidentificationverify = identificationverify.toString().trim();
    var _myqualification = qualification.toString().trim();

    if (_myidentificationverify.isEmpty || _myidentificationverify == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('本人確認証を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
    if (/*_myqualification ==
            HealingMatchConstants.registrationQualificationDropdown ||
        _myqualification.contains(
            HealingMatchConstants.registrationQualificationDropdown)*/
        _myqualification.isEmpty || _myqualification == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('保有資格を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
    NavigationRouter.switchToProviderOtpScreen(context);
  }

  _getState() async {
    await http.post(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesList.fromJson(json.decode(response.body));
      // print(states.toJson());
      for (var stateList in states.prefectureJpData) {
        stateDropDownValues.add(stateList.prefectureJa);
        print(stateDropDownValues);
      }
    });
  }
}
