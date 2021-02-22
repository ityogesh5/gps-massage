import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/cityList.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/stateList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterProviderFirstScreen extends StatefulWidget {
  @override
  _RegisterFirstScreenState createState() => _RegisterFirstScreenState();
}

class _RegisterFirstScreenState extends State<RegisterProviderFirstScreen> {
  final picker = ImagePicker();
  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  RegExp emailRegex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  //Regex validation for Username
  RegExp regExpUserName = new RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  //Regex validation for Email address
  RegExp regexMail = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool visible = false;
  bool showAddressField = false;
  bool _changeProgressText = false;
  bool businessTripEnabled = true;

  List<String> businessFormDropDownValues = [
    "施術店舗あり 施術従業員あり",
    "施術店舗あり 施術従業員なし（個人経営）",
    "施術店舗なし 施術従業員あり（出張のみ)",
    "施術店舗なし 施術従業員なし（個人)",
  ];

  List<String> numberOfEmployeesDropDownValues = List<String>();

  List<String> storeTypeDropDownValues = [
    "エステ",
    "整体",
    "リラクゼーション",
    "フィットネス",
  ];

  List<String> serviceBusinessTripDropDownValues = [
    "はい",
    "いいえ",
  ];

  List<String> coronaMeasuresDropDownValues = [
    "はい",
    "いいえ",
  ];

  List<String> childrenMeasuresDropDownValues = [
    "キッズスペースの完備",
    "保育士の常駐",
    "子供同伴OK",
  ];

  List<String> genderTreatmentDropDownValues = [
    "男性女性両方",
    "女性のみ",
    "男性のみ",
  ];

  List<String> genderDropDownValues = [
    "男性",
    "女性",
    "どちらでもない",
  ];

  List<String> registrationAddressTypeDropDownValues = [
    "現在地を取得する",
    "直接入力",
  ];

  List<dynamic> stateDropDownValues = List<dynamic>();
  List<dynamic> cityDropDownValues = List<dynamic>();
  List<String> childrenMeasuresDropDownValuesSelected = List<String>();
  StatesList states;

  final statekey = new GlobalKey<FormState>();
  final citykey = new GlobalKey<FormState>();
  var _prefid;
  bool readonly = false;
  String bussinessForm,
      numberOfEmployees,
      serviceBusinessTrips,
      coronaMeasures,
      genderTreatment,
      gender,
      registrationAddressType,
      myCity,
      myState;

  int storeTypeDisplayStatus = 0;
  int childrenMeasureStatus = 0;

  List<String> selectedStoreTypeDisplayValues = List<String>();

  DateTime selectedDate = DateTime.now();

  String _selectedDOBDate = 'Tap to select date';
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  double age = 0.0;
  var _ageOfUser;
  var selectedYear;

  bool _isGPSLocation = false;

  double sizedBoxFormHeight = 15.0;

  TextEditingController providerNameController = new TextEditingController();
  TextEditingController storeNameController = new TextEditingController();
  TextEditingController userDOBController = new TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController storePhoneNumberController =
      new TextEditingController();
  TextEditingController mailAddressController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController gpsAddressController = new TextEditingController();
  TextEditingController manualAddressController = new TextEditingController();
  TextEditingController buildingNameController = new TextEditingController();
  TextEditingController roomNumberController = new TextEditingController();
  PickedFile _profileImage;

  void initState() {
    super.initState();
    myState = '';
    myCity = '';
    _prefid = '';
    buildNumberOfEmployess();
    _getState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        //locale : const Locale("ja","JP"),
        initialDatePickerMode: DatePickerMode.day,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _selectedDOBDate = new DateFormat("yyyy-MM-dd").format(picked);
        userDOBController.value =
            TextEditingValue(text: _selectedDOBDate.toString());
        //print(_selectedDOBDate);
        selectedYear = picked.year;
        calculateAge();
      });
    }
  }

  void calculateAge() {
    setState(() {
      age = (DateTime.now().year - selectedYear).toDouble();
      _ageOfUser = age.toString();
      //print('Age : $ageOfUser');
      ageController.value = TextEditingValue(text: age.toStringAsFixed(0));
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  buildNumberOfEmployess() {
    for (int i = 1; i <= 100; i++) {
      numberOfEmployeesDropDownValues.add(i.toString());
    }
  }

  List<dynamic> newbuildDropDownMenuItems(List<String> listItems) {
    List<dynamic> items = List();
    for (String listItemVal in listItems) {
      items.add({
        "display": listItemVal,
        "value": listItemVal,
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight =
        51.0; //height of Every TextFormField wrapped with container
    double containerWidth =
        size.width * 0.9; //width of Every TextFormField wrapped with container
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    HealingMatchConstants.registrationFirstText,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "*",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    HealingMatchConstants.registrationSecondText,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              drawRangeSlider(),
              SizedBox(
                height: 20.0,
              ),
              Stack(
                overflow: Overflow.visible,
                children: [
                  _profileImage != null
                      ? InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Semantics(
                            child: new Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(_profileImage.path)),
                                  ),
                                )),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: new Container(
                              width: 95.0,
                              height: 95.0,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.grey[200]),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.none,
                                  image: new AssetImage(
                                      'assets/images_gps/user.png'),
                                ),
                              )),
                        ),
                  _profileImage != null
                      ? Visibility(
                          visible: false,
                          child: Positioned(
                            right: -60.0,
                            top: 60,
                            left: 10.0,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[500],
                                radius: 13,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 12,
                                  child: Image.asset(
                                      "assets/images_gps/upload.png"),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Visibility(
                          visible: true,
                          child: Positioned(
                            right: -60.0,
                            top: 60,
                            left: 10.0,
                            child: InkWell(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[500],
                                radius: 13,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 12,
                                  child: Image.asset(
                                      "assets/images_gps/upload.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Text(
                  HealingMatchConstants.registrationFacePhtoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                /*  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                 // color: Colors.black12,
                                  border: Border.all(color: Colors.transparent)), */
                child: DropDownFormField(
                  hintText: '事業形態*',
                  value: bussinessForm,
                  onSaved: (value) {
                    setState(() {
                      bussinessForm = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      bussinessForm = value;
                      if (value == "施術店舗なし 施術従業員あり（出張のみ)") {
                        serviceBusinessTrips = "はい";
                        businessTripEnabled = false;
                      } else {
                        businessTripEnabled = true;
                      }

                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  dataSource: businessFormDropDownValues,
                  isList: true,
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              SizedBox(
                height: bussinessForm == "施術店舗あり 施術従業員あり" ||
                        bussinessForm == "施術店舗なし 施術従業員あり（出張のみ)"
                    ? sizedBoxFormHeight
                    : 0.0,
              ),
              bussinessForm == "施術店舗あり 施術従業員あり" ||
                      bussinessForm == "施術店舗なし 施術従業員あり（出張のみ)"
                  ? Container(
                      height: containerHeight,
                      width: containerWidth,
                      /*  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                 // color: Colors.black12,
                                  border: Border.all(color: Colors.black12)), */
                      child: DropDownFormField(
                        hintText: '従業員数',
                        value: numberOfEmployees,
                        onSaved: (value) {
                          setState(() {
                            numberOfEmployees = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            numberOfEmployees = value;
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          });
                        },
                        dataSource: numberOfEmployeesDropDownValues,
                        isList: true,
                        textField: 'display',
                        valueField: 'value',
                      ),
                    )
                  : Container(),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      storeTypeDisplayStatus == 0
                          ? storeTypeDisplayStatus = 1
                          : storeTypeDisplayStatus = 0;
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    initialValue: HealingMatchConstants.registrationStoretype,
                    style: HealingMatchConstants.formHintTextStyle,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(left: 8.0),
                          icon: storeTypeDisplayStatus == 0
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30.0,
                                  color: Colors
                                      .black, //Color.fromRGBO(200, 200, 200, 1),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30.0,
                                  color: Colors
                                      .black, //Color.fromRGBO(200, 200, 200, 1),
                                ),
                          onPressed: () {
                            setState(() {
                              storeTypeDisplayStatus == 0
                                  ? storeTypeDisplayStatus = 1
                                  : storeTypeDisplayStatus = 0;
                            });
                          }),
                      filled: true,
                      fillColor: ColorConstants.formFieldFillColor,
                    ),
                  ),
                ),
              ),
              storeTypeDisplayStatus == 1
                  ? Container(
                      width: containerWidth,
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: storeTypeDropDownValues.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return buildStoreTypeDisplayBoxContent(
                              storeTypeDropDownValues[index],
                              index,
                            );
                          }),
                    )
                  : Container(
                      width: containerWidth,
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: selectedStoreTypeDisplayValues
                            .map((e) {
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "$e",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                    ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          HealingMatchConstants.registrationBuisnessTrip,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: containerHeight,
                        /* decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.black12,
                                          border: Border.all(color: Colors.black12)), */
                        child: DropDownFormField(
                          enabled: businessTripEnabled,
                          hintText: '',
                          value: serviceBusinessTrips,
                          onSaved: (value) {
                            setState(() {
                              serviceBusinessTrips = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              serviceBusinessTrips = value;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          },
                          dataSource: serviceBusinessTripDropDownValues,
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
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          HealingMatchConstants.registrationCoronaTxt,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: containerHeight,
                        child: DropDownFormField(
                          hintText: '',
                          value: coronaMeasures,
                          onSaved: (value) {
                            setState(() {
                              coronaMeasures = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              coronaMeasures = value;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          },
                          dataSource: coronaMeasuresDropDownValues,
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
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      childrenMeasureStatus == 0
                          ? childrenMeasureStatus = 1
                          : childrenMeasureStatus = 0;
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    initialValue: HealingMatchConstants.registrationChildrenTxt,
                    style: HealingMatchConstants.formHintTextStyle,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(left: 8.0),
                          icon: childrenMeasureStatus == 0
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30.0,
                                  color: Colors
                                      .black, //Color.fromRGBO(200, 200, 200, 1),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30.0,
                                  color: Colors
                                      .black, //Color.fromRGBO(200, 200, 200, 1),
                                ),
                          onPressed: () {
                            setState(() {
                              childrenMeasureStatus == 0
                                  ? childrenMeasureStatus = 1
                                  : childrenMeasureStatus = 0;
                            });
                          }),
                      filled: true,
                      fillColor: ColorConstants.formFieldFillColor,
                    ),
                  ),
                ),
              ),
              childrenMeasureStatus == 1
                  ? Container(
                      width: containerWidth,
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: childrenMeasuresDropDownValues.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return buildChildrenMeasureCheckBoxContent(
                              childrenMeasuresDropDownValues[index],
                              index,
                            );
                          }),
                    )
                  : Container(
                      width: containerWidth,
                      padding: EdgeInsets.only(top: 8.0),
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: childrenMeasuresDropDownValuesSelected
                            .map((e) {
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                height: 40.0,
                                //  width: 110.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        "$e",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                    ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: DropDownFormField(
                  hintText: '施術を提供できる利用者の性別',
                  value: genderTreatment,
                  onSaved: (value) {
                    setState(() {
                      genderTreatment = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      genderTreatment = value;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  dataSource: genderTreatmentDropDownValues,
                  isList: true,
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                width: containerWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("*", style: TextStyle(color: Colors.red)),
                    Text(
                      HealingMatchConstants.registrationJapanAssociationTxt,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(splashColor: Colors.black12),
                    child: TextFormField(
                        controller: providerNameController,
                        style: HealingMatchConstants.formTextStyle,
                        decoration: InputDecoration(
                          labelText: HealingMatchConstants.registrationName,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        )),
                  )),
              bussinessForm == "施術店舗あり 施術従業員あり" ||
                      bussinessForm == "施術店舗あり 施術従業員なし（個人経営）"
                  ? Column(children: [
                      SizedBox(
                        height: sizedBoxFormHeight,
                      ),
                      Container(
                        width: containerWidth,
                        child: Text(
                          HealingMatchConstants.registrationStoreTxt,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: sizedBoxFormHeight,
                      ),
                      Container(
                          height: containerHeight,
                          width: containerWidth,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: storeNameController,
                                style: HealingMatchConstants.formTextStyle,
                                decoration: InputDecoration(
                                  labelText: HealingMatchConstants
                                      .registrationStoreName,
                                  labelStyle:
                                      HealingMatchConstants.formLabelTextStyle,
                                  filled: true,
                                  fillColor: ColorConstants.formFieldFillColor,
                                  focusedBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  enabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                )),
                          )),
                    ])
                  : Container(),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                //margin: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: TextFormField(
                                enabled: false,
                                controller: userDOBController,
                                style: HealingMatchConstants.formTextStyle,
                                decoration: InputDecoration(
                                  labelText:
                                      HealingMatchConstants.registrationDob,
                                  labelStyle:
                                      HealingMatchConstants.formLabelTextStyle,
                                  filled: true,
                                  fillColor: ColorConstants.formFieldFillColor,
                                  focusedBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  disabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  enabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  suffixIcon: Image.asset(
                                      "assets/images_gps/calendar.png"),
                                )),
                          ),
                        )),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        height: containerHeight,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          controller: ageController,
                          style: HealingMatchConstants.formTextStyle,
                          decoration: InputDecoration(
                            labelText: "年齢	",
                            labelStyle:
                                HealingMatchConstants.formLabelTextStyle,
                            filled: true,
                            fillColor: ColorConstants.formFieldFillColor,
                            focusedBorder:
                                HealingMatchConstants.textFormInputBorder,
                            disabledBorder:
                                HealingMatchConstants.textFormInputBorder,
                            enabledBorder:
                                HealingMatchConstants.textFormInputBorder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              HealingMatchConstants.registrationGender,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("*", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: containerHeight,
                        child: DropDownFormField(
                          hintText: '',
                          value: gender,
                          onSaved: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          },
                          dataSource: genderDropDownValues,
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
                height: sizedBoxFormHeight,
              ),
              Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(splashColor: Colors.black12),
                    child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: HealingMatchConstants.formTextStyle,
                        decoration: InputDecoration(
                          labelText: HealingMatchConstants.registrationPhnNum,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        )),
                  )),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                width: containerWidth,
                child: Text(
                  HealingMatchConstants.registrationStorePhnText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: bussinessForm == "施術店舗あり 施術従業員あり" ||
                        bussinessForm == "施術店舗あり 施術従業員なし（個人経営）"
                    ? sizedBoxFormHeight
                    : 0,
              ),
              bussinessForm == "施術店舗あり 施術従業員あり" ||
                      bussinessForm == "施術店舗あり 施術従業員なし（個人経営）"
                  ? Container(
                      height: containerHeight,
                      width: containerWidth,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.black12),
                        child: TextFormField(
                            controller: storePhoneNumberController,
                            style: HealingMatchConstants.formTextStyle,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText:
                                  HealingMatchConstants.registrationStorePhnNum,
                              labelStyle:
                                  HealingMatchConstants.formLabelTextStyle,
                              filled: true,
                              fillColor: ColorConstants.formFieldFillColor,
                              focusedBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              enabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                            )),
                      ))
                  : Container(),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(splashColor: Colors.black12),
                    child: TextFormField(
                        controller: mailAddressController,
                        style: HealingMatchConstants.formTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText:
                              HealingMatchConstants.registrationMailAdress,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        )),
                  )),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(splashColor: Colors.black12),
                    child: TextFormField(
                        controller: passwordController,
                        obscureText: passwordVisibility,
                        style: HealingMatchConstants.formTextStyle,
                        decoration: InputDecoration(
                          labelText: HealingMatchConstants.registrationPassword,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          suffixIcon: IconButton(
                              icon: passwordVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              }),
                        )),
                  )),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                child: Row(
                  children: [
                    Text("*", style: TextStyle(color: Colors.red)),
                    Text(
                      HealingMatchConstants.registrationPasswordInstructionText,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  height: containerHeight,
                  width: containerWidth,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(splashColor: Colors.black12),
                    child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: passwordConfirmVisibility,
                        style: HealingMatchConstants.formTextStyle,
                        decoration: InputDecoration(
                          labelText:
                              HealingMatchConstants.registrationConfirmPassword,
                          labelStyle: HealingMatchConstants.formLabelTextStyle,
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          suffixIcon: IconButton(
                              icon: passwordConfirmVisibility
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordConfirmVisibility =
                                      !passwordConfirmVisibility;
                                });
                              }),
                        )),
                  )),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                /*  decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                color: Colors.black12,
                                                                border: Border.all(color: Colors.black12)), */
                child: DropDownFormField(
                  hintText: '検索地点の登録*',
                  value: registrationAddressType,
                  onSaved: (value) {
                    setState(() {
                      registrationAddressType = value;
                    });
                  },
                  onChanged: (value) {
                    if (value == "現在地を取得する") {
                      setState(() {
                        gpsAddressController.clear();
                        registrationAddressType = value;
                        showAddressField = true;
                        visible = true; // !visible;
                        //_getCurrentLocation();
                      });
                    } else {
                      setState(() {
                        registrationAddressType = value;
                        showAddressField = true;
                        visible = false;
                      });
                    }
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  dataSource: registrationAddressTypeDropDownValues,
                  isList: true,
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Visibility(
                visible: showAddressField,
                child: Column(
                  children: [
                    SizedBox(
                      height: sizedBoxFormHeight,
                    ),
                    Container(
                      width: containerWidth,
                      child: Text(
                        HealingMatchConstants.registrationIndividualText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: sizedBoxFormHeight,
                    ),
                    Container(
                        height: 60.0, //containerHeight,
                        width: size.width * 0.8,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: visible
                              ? TextFormField(
                                  controller: gpsAddressController,
                                  style: HealingMatchConstants.formTextStyle,
                                  decoration: InputDecoration(
                                    labelText: "現在地を取得する",
                                    labelStyle: HealingMatchConstants
                                        .formLabelTextStyle,
                                    filled: true,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                    disabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    focusedBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    enabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.location_on, size: 28),
                                      onPressed: () {
                                        setState(() {
                                          _changeProgressText = true;
                                          print(
                                              'location getting.... : $_changeProgressText');
                                        });
                                        _getCurrentLocation();
                                      },
                                    ),
                                  ),
                                )
                              : TextFormField(
                                  controller: manualAddressController,
                                  style: HealingMatchConstants.formTextStyle,
                                  decoration: InputDecoration(
                                    labelText: "丁目, 番地",
                                    labelStyle: HealingMatchConstants
                                        .formLabelTextStyle,
                                    filled: true,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                    disabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    focusedBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    enabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                  ),
                                ),
                        )),
                    !visible
                        ? Column(
                            children: [
                              SizedBox(
                                height: sizedBoxFormHeight,
                              ),
                              Container(
                                  width: size.width * 0.8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Form(
                                          key: statekey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(0.0),
                                                //    width: MediaQuery.of(context).size.width * 0.33,

                                                child: DropDownFormField(
                                                  titleText: null,
                                                  hintText: readonly
                                                      ? myState
                                                      : '都、県選択',
                                                  onSaved: (value) {
                                                    setState(() {
                                                      myState = value;
                                                    });
                                                  },
                                                  value: myState,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      myState = value;

                                                      _prefid =
                                                          stateDropDownValues
                                                                  .indexOf(
                                                                      value) +
                                                              1;
                                                      print(
                                                          'prefID : ${_prefid.toString()}');
                                                      cityDropDownValues
                                                          .clear();
                                                      myCity = '';
                                                      _getCityDropDown(_prefid);
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                    });
                                                  },
                                                  dataSource:
                                                      stateDropDownValues,
                                                  isList: true,
                                                  textField: 'display',
                                                  valueField: 'value',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(0.0),
                                          child: DropDownFormField(
                                            titleText: null,
                                            hintText: readonly ? myCity : '市',
                                            onSaved: (value) {
                                              setState(() {
                                                myCity = value;
                                              });
                                            },
                                            value: myCity,
                                            onChanged: (value) {
                                              setState(() {
                                                myCity = value;
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                              });
                                            },
                                            dataSource: cityDropDownValues,
                                            isList: true,
                                            textField: 'display',
                                            valueField: 'value',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: sizedBoxFormHeight,
                    ),
                    Container(
                      height: containerHeight,
                      width: size.width * 0.8,
                      //margin: EdgeInsets.all(16.0),
                      //margin: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: buildingNameController,
                                style: HealingMatchConstants.formTextStyle,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(4.0),
                                  labelText: HealingMatchConstants
                                      .registrationBuildingName,
                                  labelStyle:
                                      HealingMatchConstants.formLabelTextStyle,
                                  filled: true,
                                  fillColor: ColorConstants.formFieldFillColor,
                                  focusedBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  enabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                )),
                          )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.black12),
                              child: TextFormField(
                                  controller: roomNumberController,
                                  style: HealingMatchConstants.formTextStyle,
                                  keyboardType: TextInputType.text,
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelText: HealingMatchConstants
                                        .registrationRoomNo,
                                    labelStyle: HealingMatchConstants
                                        .formLabelTextStyle,
                                    filled: true,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                    focusedBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    enabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                  )),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                width: containerWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("*", style: TextStyle(color: Colors.red)),
                    Expanded(
                      child: Text(
                        HealingMatchConstants.registrationPointTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                height: containerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lime,
                ),
                child: RaisedButton(
                  //padding: EdgeInsets.all(15.0),
                  child: Text(
                    HealingMatchConstants.registrationNextBtn,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.lime,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    validateFields();
                    /*     NavigationRouter.switchToServiceProviderSecondScreen(
                                      context); */
                  },
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
              Container(
                width: containerWidth,
                child: InkWell(
                  onTap: () {
                    NavigationRouter.switchToProviderLogin(context);
                  },
                  child: Text(
                    HealingMatchConstants.registrationAlreadyActTxt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ),
              ),
              SizedBox(
                height: sizedBoxFormHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get current address from Latitude Longitude
  _getCurrentLocation() {
    ProgressDialogBuilder.showLocationProgressDialog(context);
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      var latitude = _currentPosition.latitude;
      var longitude = _currentPosition.longitude;
      setState(() {
        _currentAddress =
            '${place.locality},${place.subAdministrativeArea},${place.postalCode},${place.country}';
        // print('Place Json : ${place.toJson()}');
        if (_currentAddress != null && _currentAddress.isNotEmpty) {
          print('Current address : $_currentAddress : $latitude : $longitude');
          gpsAddressController.value = TextEditingValue(text: _currentAddress);
          setState(() {
            _isGPSLocation = true;
          });
          HealingMatchConstants.serviceProviderCurrentLatitude = latitude;
          HealingMatchConstants.serviceProviderCurrentLongitude = longitude;
          HealingMatchConstants.serviceProviderCity = place.locality;
          HealingMatchConstants.serviceProviderPrefecture =
              place.administrativeArea;
          HealingMatchConstants.serviceProviderArea = place.country;
        } else {
          ProgressDialogBuilder.hideLocationProgressDialog(context);
          return null;
        }
      });
      ProgressDialogBuilder.hideLocationProgressDialog(context);
    } catch (e) {
      ProgressDialogBuilder.hideLocationProgressDialog(context);
      print(e);
    }
  }

  validateFields() async {
    var userPhoneNumber = phoneNumberController.text.toString();
    var password = passwordController.text.toString();
    var confirmpassword = confirmPasswordController.text.toString();
    var email = mailAddressController.text.toString();
    var userName = providerNameController.text.toString();
    var storename = storeNameController.text.toString();
    var storenumber = storePhoneNumberController.text.toString();
    var age = ageController.text.toString();
    var address = gpsAddressController.text.toString();
    var manualAddresss = manualAddressController.text.toString();
    var buildingname = buildingNameController.text.toString();
    var roomnumber = roomNumberController.text.toString();
    var _myAddressInputType = registrationAddressType;
    var userDOB = userDOBController.text;
    var genderSelecetedValue = gender;
    var businessFormVal = bussinessForm;

    //Profile image validation
    if (_profileImage == null || _profileImage.path == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('プロフィール画像を選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //Business Form Validation
    if (businessFormVal == null || businessFormVal.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('事業形態は必須項目なので選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //Store Type validation
    if (selectedStoreTypeDisplayValues.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('お店の種類は必須項目なので選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //name Validation
    if (userName.length == 0 || userName.isEmpty || userName == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('お名前を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (userName.length > 20) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('お名前は20文字以内で入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //storename Validation
    if ((bussinessForm == "施術店舗あり 施術従業員あり" ||
            bussinessForm == "施術店舗あり 施術従業員なし（個人経営）") &&
        (storename.length == 0 || storename.isEmpty || storename == null)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('店舗名を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if ((bussinessForm == "施術店舗あり 施術従業員あり" ||
            bussinessForm == "施術店舗あり 施術従業員なし（個人経営）") &&
        (storename.length > 20)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('店舗名は20文字以内で入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    // user DOB validation
    if (userDOB == null || userDOB.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な生年月日を選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    // gender validation
    if (genderSelecetedValue == null || genderSelecetedValue.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('性別フィールドを選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    // user phone number validation
    if ((userPhoneNumber == null || userPhoneNumber.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('電話番号を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (userPhoneNumber.length > 10 ||
        userPhoneNumber.length < 10 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('10文字の電話番号を入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    // store phone number validation
    if ((bussinessForm == "施術店舗あり 施術従業員あり" ||
            bussinessForm == "施術店舗あり 施術従業員なし（個人経営）") &&
        (storenumber == null || storenumber.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('お店の電話番号を入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if ((bussinessForm == "施術店舗あり 施術従業員あり" ||
            bussinessForm == "施術店舗あり 施術従業員なし（個人経営）") &&
        (storenumber.length > 10 ||
            storenumber.length < 10 ||
            storenumber == null ||
            storenumber.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('10文字の店舗の電話番号を入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //email validation
    if ((email == null || email.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('メールアドレスを入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (!(email.contains(regexMail))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('正しいメールアドレスを入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
    if (email.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('メールアドレスは50文字以内で入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
    if ((email.contains(regexEmojis))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text("有効なメールアドレスを入力してください。",
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //password Validation
    if (password == null || password.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは必須項目なので入力してください。 ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
    if (password.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは8文字以上で入力してください。  ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.length > 16) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは16文字以内で入力してください。 ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    // Combination password
    if (!passwordRegex.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードには、大文字、小文字、数字、特殊文字を1つ含める必要があります。'),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (password.contains(regexEmojis)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な文字でパスワードを入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //confirm password Validation
    if (confirmpassword.length == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text("パスワード再確認は必須項目なので入力してください。",
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    if (confirmpassword != password) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text("パスワードが一致がしませんのでもう一度お試しください。",
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //addressType validation
    if (_myAddressInputType == null || _myAddressInputType.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な登録する地点のカテゴリーを選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //gps address Validation
    if ((_myAddressInputType == "現在地を取得する") &&
        (address == null || address.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('現在の住所を取得するには、場所アイコンを選択してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //manual address Validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (manualAddresss == null || manualAddresss.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('住所を入力してください。。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //prefecture Validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (myState == null || myState.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('有効な府県を選択してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //city validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (myCity == null || myCity.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('有効な市を選択してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    //building Validation
    if (buildingname == null || buildingname.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('ビル名を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //roomno Validation
    if (roomnumber == null || roomnumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('部屋番号を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }

    //Save Values to Constants
    HealingMatchConstants.profileImage = _profileImage;
    HealingMatchConstants.serviceProviderUserName = userName;
    HealingMatchConstants.serviceProviderStoreName = storename;
    HealingMatchConstants.serviceProviderDOB = userDOBController.text;
    HealingMatchConstants.serviceProviderAge = age;
    HealingMatchConstants.serviceProviderGender = gender;
    HealingMatchConstants.serviceProviderPhoneNumber = userPhoneNumber;
    HealingMatchConstants.serviceProviderStorePhoneNumber = storenumber;
    HealingMatchConstants.serviceProviderEmailAddress = email;
    HealingMatchConstants.serviceProviderAddressType = _myAddressInputType;
    HealingMatchConstants.serviceProviderBuildingName = buildingname;
    HealingMatchConstants.serviceProviderRoomNumber = roomnumber;
    HealingMatchConstants.serviceProviderPassword = passwordController.text;
    HealingMatchConstants.serviceProviderConfirmPassword =
        confirmPasswordController.text;
    HealingMatchConstants.serviceProviderBusinessForm = bussinessForm;
    HealingMatchConstants.serviceProviderNumberOfEmpl = numberOfEmployees;
    HealingMatchConstants.serviceProviderStoreType.clear();
    HealingMatchConstants.serviceProviderStoreType
        .addAll(selectedStoreTypeDisplayValues);
    HealingMatchConstants.serviceProviderBusinessTripService =
        serviceBusinessTrips;
    HealingMatchConstants.serviceProviderCoronaMeasure = coronaMeasures;
    HealingMatchConstants.serviceProviderChildrenMeasure.clear();
    HealingMatchConstants.serviceProviderChildrenMeasure
        .addAll(childrenMeasuresDropDownValuesSelected);
    HealingMatchConstants.serviceProviderGenderService = genderTreatment;

    ProgressDialogBuilder.showCommonProgressDialog(context);
    // Getting user GPS Address value
    if (HealingMatchConstants.serviceProviderAddressType == '現在地を取得する' &&
        _isGPSLocation) {
      HealingMatchConstants.serviceProviderAddress = address;
      print('GPS Address : ${HealingMatchConstants.serviceProviderAddress}');
    } else //if (HealingMatchConstants.serviceProviderAddress.isEmpty) {
    {
      String address = roomnumber +
          ',' +
          buildingname +
          ',' +
          manualAddresss +
          ',' +
          myCity +
          ',' +
          myState;
      List<Placemark> userAddress =
          await geolocator.placemarkFromAddress(address);
      var userAddedAddressPlaceMark = userAddress[0];
      Position addressPosition = userAddedAddressPlaceMark.position;
      HealingMatchConstants.serviceProviderCurrentLatitude =
          addressPosition.latitude;
      HealingMatchConstants.serviceProviderCurrentLongitude =
          addressPosition.longitude;
      /* HealingMatchConstants.serviceProviderCity =
          userAddedAddressPlaceMark.locality;
       HealingMatchConstants.serviceProviderPrefecture =
          userAddedAddressPlaceMark.administrativeArea;*/
      HealingMatchConstants.serviceProviderAddress = address;
      HealingMatchConstants.serviceProviderPrefecture = myState;
      HealingMatchConstants.serviceProviderCity = myCity;
      HealingMatchConstants.serviceProviderArea = myCity;
    }
    ProgressDialogBuilder.hideCommonProgressDialog(context);
    NavigationRouter.switchToServiceProviderSecondScreen(context);
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
                        _imgFromGallery();
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

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _profileImage = image;
    });
    print('image path : ${_profileImage.path}');
  }

  _getState() async {
    await http.get(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesList.fromJson(json.decode(response.body));
      // print(states.toJson());

      for (var stateList in states.data) {
        stateDropDownValues.add(stateList.prefectureJa);
        // print(stateDropDownValues);
      }
      setState(() {});
      // print('prefID : ${stateDropDownValues.indexOf(_mystate).toString()}');
    });
  }

  // CityList cityResponse;
  _getCityDropDown(var prefid) async {
    ProgressDialogBuilder.showGetCitiesProgressDialog(context);
    await post(HealingMatchConstants.CITY_PROVIDER_URL,
        body: {"prefecture_id": prefid.toString()}).then((response) {
      if (response.statusCode == 200) {
        CityList cityResponse = CityList.fromJson(json.decode(response.body));
        print(cityResponse.toJson());
        for (var cityList in cityResponse.data) {
          cityDropDownValues.add(cityList.cityJa + cityList.specialDistrictJa);
          print(cityDropDownValues);
        }
        ProgressDialogBuilder.hideGetCitiesProgressDialog(context);
        setState(() {});
      }
    });
  }

  Widget buildChildrenMeasureCheckBoxContent(
      String childrenMeasuresValue, int index) {
    bool checkValue =
        childrenMeasuresDropDownValuesSelected.contains(childrenMeasuresValue);
    return Column(
      children: [
        Row(
          children: [
            checkValue
                ? Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Checkbox(
                      tristate: true,
                      activeColor: Colors.black,
                      checkColor: Colors.black,
                      value: checkValue,
                      onChanged: (value) {
                        if (value == null) {
                          setState(() {
                            childrenMeasuresDropDownValuesSelected
                                .remove(childrenMeasuresValue);
                          });
                        } else {
                          setState(() {
                            childrenMeasuresDropDownValuesSelected
                                .add(childrenMeasuresValue);
                          });
                        }
                      },
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        childrenMeasuresDropDownValuesSelected
                            .add(childrenMeasuresValue);
                      });
                    },
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
            SizedBox(
              width: 10.0,
            ),
            Text("$childrenMeasuresValue", style: TextStyle(fontSize: 14.0)),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  Widget buildStoreTypeDisplayBoxContent(
      String storeTypeDisplayValues, int index) {
    bool checkValue =
        selectedStoreTypeDisplayValues.contains(storeTypeDisplayValues);
    return Column(
      children: [
        Row(
          children: [
            checkValue
                ? Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Checkbox(
                      tristate: true,
                      activeColor: Colors.black,
                      checkColor: Colors.black,
                      value: checkValue,
                      onChanged: (value) {
                        /*  setState(() {
                          checkValue = value;
                        }); */
                        if (value == null) {
                          setState(() {
                            selectedStoreTypeDisplayValues
                                .remove(storeTypeDisplayValues);
                          });
                        } else {
                          setState(() {
                            selectedStoreTypeDisplayValues
                                .add(storeTypeDisplayValues);
                          });
                        }
                      },
                    ),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        selectedStoreTypeDisplayValues
                            .add(storeTypeDisplayValues);
                      });
                    },
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
            SizedBox(
              width: 10.0,
            ),
            Text("$storeTypeDisplayValues", style: TextStyle(fontSize: 14.0)),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  drawRangeSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 15.0,
          color: Colors.lime,
        ),
        SizedBox(width: 100.0, child: Divider(color: Colors.grey[300])),
        Icon(
          Icons.circle,
          size: 15.0,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
