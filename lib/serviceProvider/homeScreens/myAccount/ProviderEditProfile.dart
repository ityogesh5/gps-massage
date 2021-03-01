import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/cityList.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerProfileUpdateResponseModel.dart'
    as profileUpdate;
import 'package:gps_massageapp/models/responseModels/serviceProvider/stateList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/MyAccount.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/bankNameDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart'
    as loginResponse;
import 'package:shared_preferences/shared_preferences.dart';

List<File> files = List<File>();

class ProviderEditProfile extends StatefulWidget {
  @override
  _ProviderEditProfileState createState() => _ProviderEditProfileState();
}

class _ProviderEditProfileState extends State<ProviderEditProfile> {
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
  bool gpsAddressVisible = false;
  bool showAddressField = false;
  bool _changeProgressText = false;

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

  List<String> qualificationCertificates = [
    "はり師",
    "きゅう師",
    "鍼灸師",
    "あん摩マッサージ指圧師",
    "柔道整復師",
    "理学療法士",
    "国家資格取得予定（学生）",
    "民間資格",
    "無資格",
  ];

  List<dynamic> stateDropDownValues = List<dynamic>();
  List<dynamic> cityDropDownValues = List<dynamic>();
  List<String> childrenMeasuresDropDownValuesSelected = List<String>();
  StatesList states;
  bool businessTripEnabled = true;

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

  int status = 0;
  loginResponse.Data userData;

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
  TextEditingController gpsAddressController = new TextEditingController();
  TextEditingController manualAddressController = new TextEditingController();
  TextEditingController buildingNameController = new TextEditingController();
  TextEditingController roomNumberController = new TextEditingController();
  TextEditingController bankOtherFieldController = TextEditingController();
  PickedFile _profileImage;
  var identificationverify;
  PickedFile _idProfileImage;
  bool idUploadVisible = true;
  bool uploadVisible = false;
  final bankkey = new GlobalKey<FormState>();
  var qualification, bankname, accountType;
  List<String> bankNameDropDownList = List<String>();
  final accountnumberkey = new GlobalKey<FormState>();
  TextEditingController branchCodeController = TextEditingController();
  TextEditingController branchNumberController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  BankNameDropDownModel bankNameDropDownModel;
  Map<String, String> certificateImages = Map<String, String>();
  ProgressDialog _progressDialog = ProgressDialog();
  final identityverification = new GlobalKey<FormState>();
  List<String> oldPrivateQualification = List<String>();
  List<String> privateQualification = List<String>();
  final qualificationupload = new GlobalKey<FormState>();
  Map<String, String> oldCertificateImages = Map<String, String>();
  List<String> oldCertificateImagesJaNames = List<String>();

  double iconHeight = 20.0;
  double iconWidth = 20.0;
  Color iconColor = Colors.black;

  void initState() {
    super.initState();
    getBankName();
    _getState();
    identificationverify = '';
    myState = '';
    myCity = '';
    _prefid = '';
    qualification = '';
    bankname = '';
    qualification = '';
    accountType = '';
    buildNumberOfEmployess();
    //  getProfileDetails();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent, brightness: Brightness.light,
        elevation: 0.0,
        leading: IconButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'マイアカウント',
          style: TextStyle(
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: status != 3
          ? Center(
              child: SpinKitDoubleBounce(color: Colors.limeAccent),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        _profileImage != null
                            ? InkWell(
                                onTap: () {
                                  _showPicker(context, 0);
                                },
                                child: Semantics(
                                  child: new Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: new BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(_profileImage.path)),
                                        ),
                                      )),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  _showPicker(context, 0);
                                },
                                child: new Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[200]),
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            userData.uploadProfileImgUrl),
                                      ),
                                    )),
                              ),
                        Positioned(
                          right: -60.0,
                          top: 60,
                          left: 10.0,
                          child: InkWell(
                            onTap: () {
                              _showPicker(context, 0);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 13,
                              child: SvgPicture.asset(
                                "assets/images_gps/edit_button.svg",
                                /*  height: iconHeight,
                                width: iconWidth, */
                                color: iconColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
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
                    SizedBox(height: sizedBoxFormHeight),
                    Container(
                      height: containerHeight,
                      width: containerWidth,
                      /*  decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                         // color: Colors.black12,
                                          border: Border.all(color: Colors.transparent)), */
                      child: DropDownFormField(
                        hintText: '事業形態',
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

                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                          initialValue:
                              HealingMatchConstants.registrationStoretype,
                          style: HealingMatchConstants.formHintTextStyle,
                          decoration: new InputDecoration(
                            focusedBorder:
                                HealingMatchConstants.textFormInputBorder,
                            disabledBorder:
                                HealingMatchConstants.textFormInputBorder,
                            enabledBorder:
                                HealingMatchConstants.textFormInputBorder,
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                          initialValue:
                              HealingMatchConstants.registrationChildrenTxt,
                          style: HealingMatchConstants.formHintTextStyle,
                          decoration: new InputDecoration(
                            focusedBorder:
                                HealingMatchConstants.textFormInputBorder,
                            disabledBorder:
                                HealingMatchConstants.textFormInputBorder,
                            enabledBorder:
                                HealingMatchConstants.textFormInputBorder,
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
                                itemCount:
                                    childrenMeasuresDropDownValues.length,
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                            HealingMatchConstants
                                .registrationJapanAssociationTxt,
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              enabled: false,
                              controller: providerNameController,
                              style: HealingMatchConstants.formTextStyle,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.editProfileName,
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
                                      style:
                                          HealingMatchConstants.formTextStyle,
                                      decoration: InputDecoration(
                                        labelText: HealingMatchConstants
                                            .editProfileStoreName,
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
                                    //   _selectDate(context);
                                  },
                                  child: TextFormField(
                                      enabled: false,
                                      controller: userDOBController,
                                      style:
                                          HealingMatchConstants.formTextStyle,
                                      decoration: InputDecoration(
                                          labelText: HealingMatchConstants
                                              .editProfileDob,
                                          labelStyle: HealingMatchConstants
                                              .formLabelTextStyle,
                                          filled: true,
                                          fillColor:
                                              ColorConstants.formFieldFillColor,
                                          focusedBorder: HealingMatchConstants
                                              .textFormInputBorder,
                                          disabledBorder: HealingMatchConstants
                                              .textFormInputBorder,
                                          enabledBorder: HealingMatchConstants
                                              .textFormInputBorder,
                                          suffixIcon: IconButton(
                                              icon: SvgPicture.asset(
                                                "assets/images_gps/calendar.svg",
                                                height: iconHeight,
                                                width: iconWidth,
                                                color: iconColor,
                                              ),
                                              onPressed: () {
                                                _selectDate(context);
                                              }))),
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
                                    HealingMatchConstants.editProfileGender,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text("*", style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: containerHeight,
                              child: DropDownFormField(
                                enabled: false,
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              enabled: false,
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              style: HealingMatchConstants.formTextStyle,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.editProfilePhnNum,
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
                                    labelText: HealingMatchConstants
                                        .editProfileStorePhnNum,
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
                            ))
                        : Container(),
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
                              controller: mailAddressController,
                              style: HealingMatchConstants.formTextStyle,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.editProfileMailAdress,
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
                        hintText: '検索地点の登録',
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
                              gpsAddressVisible = true; // !visible;
                              _getCurrentLocation();
                            });
                          } else {
                            setState(() {
                              registrationAddressType = value;
                              showAddressField = true;
                              gpsAddressVisible = false;
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
                                child: gpsAddressVisible
                                    ? TextFormField(
                                        controller: gpsAddressController,
                                        style:
                                            HealingMatchConstants.formTextStyle,
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
                                            icon: SvgPicture.asset(
                                              "assets/images_gps/gps.svg",
                                              height: iconHeight,
                                              width: iconWidth,
                                              color: iconColor,
                                            ),
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
                                        style:
                                            HealingMatchConstants.formTextStyle,
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
                          !gpsAddressVisible
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
                                                      margin:
                                                          EdgeInsets.all(0.0),
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
                                                            _getCityDropDown(
                                                                _prefid);
                                                            FocusScope.of(
                                                                    context)
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
                                                  hintText:
                                                      readonly ? myCity : '市',
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
                                                  dataSource:
                                                      cityDropDownValues,
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
                                      style:
                                          HealingMatchConstants.formTextStyle,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(4.0),
                                        labelText: HealingMatchConstants
                                            .editProfileBuildingName,
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
                                        style:
                                            HealingMatchConstants.formTextStyle,
                                        keyboardType: TextInputType.text,
                                        maxLength: 4,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: HealingMatchConstants
                                              .editProfileRoomNo,
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
                    SizedBox(height: sizedBoxFormHeight),
                    Container(
                      width: containerWidth,
                      child: Form(
                        key: identityverification,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(0.0),
                              child: DropDownFormField(
                                enabled: false,
                                autovalidate: false,
                                titleText: null,
                                hintText: readonly
                                    ? identificationverify
                                    : HealingMatchConstants
                                        .registrationIdentityVerification,
                                onSaved: (value) {
                                  if (_idProfileImage == null) {
                                    setState(() {
                                      identificationverify = value;
                                      idUploadVisible = true;
                                    });
                                  } else {
                                    showIdSelectError();
                                  }
                                },
                                value: identificationverify,
                                onChanged: (value) {
                                  if (_idProfileImage == null) {
                                    setState(() {
                                      identificationverify = value;
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
                    ),
                    SizedBox(height: idUploadVisible ? sizedBoxFormHeight : 0),
                    Container(
                      width: containerWidth,
                      child: Visibility(
                        visible: true,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  //width: 140.0, // MediaQuery.of(context).size.width * 0.38,
                                  //height: MediaQuery.of(context).size.height * 0.19,
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                    //   border: Border.all(color: Colors.black12),
                                    //   shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          userData.proofOfIdentityImgUrl),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sizedBoxFormHeight),
                    Container(
                      width: containerWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                HealingMatchConstants.registrationAdd,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("\n*", style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: ColorConstants.formFieldFillColor,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = true;
                                    uploadVisible = false;
                                    qualification = '';
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
                    ),
                    SizedBox(height: visible ? sizedBoxFormHeight : 0),
                    Visibility(
                      visible: visible,
                      child: Form(
                        key: qualificationupload,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              //margin: EdgeInsets.all(0.0),
                              width: containerWidth,
                              child: DropDownFormField(
                                titleText: null,
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
                                                                .length +
                                                            oldPrivateQualification
                                                                .length >=
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
                                dataSource: qualificationCertificates,
                                isList: true,
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
                              privateQualification.length == 0 &&
                              oldCertificateImages.length == 0
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
                              (uploadVisible &&
                                          !certificateImages
                                              .containsKey(qualification)) &&
                                      (!oldCertificateImages.containsKey(
                                              getQualififcationEngWords(
                                                  qualification)) ||
                                          qualification == "民間資格")
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Column(
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  /*  Text('アップロード'),
                                                    Text('証明書'), */
                                                  Center(
                                                    child: FittedBox(
                                                        child: Text(
                                                      "$qualification",
                                                      textAlign:
                                                          TextAlign.center,
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
                                                    icon: SvgPicture.asset(
                                                      "assets/images_gps/upload.svg",
                                                      height: iconHeight,
                                                      width: iconWidth,
                                                      color: iconColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    HealingMatchConstants
                                                        .registrationQualificationUpload,
                                                    style: TextStyle(
                                                        fontSize: 8.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),

                              //   ),
                              SizedBox(
                                width: (uploadVisible &&
                                            !certificateImages
                                                .containsKey(qualification)) &&
                                        (!oldCertificateImages.containsKey(
                                                getQualififcationEngWords(
                                                    qualification)) ||
                                            qualification == "民間資格")
                                    ? 10
                                    : 0,
                              ),
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: oldCertificateImages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key = oldCertificateImages.keys
                                        .elementAt(index);
                                    return buildOldQualificationImage(
                                        key, index);
                                  }),
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: certificateImages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key =
                                        certificateImages.keys.elementAt(index);
                                    return buildQualificationImage(key, index);
                                  }),
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: privateQualification.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildPrivateQualificationImage(
                                        privateQualification[index], index);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizedBoxFormHeight),
                    Container(
                      width: containerWidth,
                      child: Text(
                        HealingMatchConstants.registrationBankDetails,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: sizedBoxFormHeight),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
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
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
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
                              bankname ==
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
                                                  hintText: "銀行名",
                                                  hintStyle:
                                                      HealingMatchConstants
                                                          .formHintTextStyle,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  enabledBorder:
                                                      HealingMatchConstants
                                                          .otherFiledTextFormInputBorder,
                                                  focusedBorder:
                                                      HealingMatchConstants
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Form(
                                    key: accountnumberkey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: TextFormField(
                                      controller: branchCodeController,
                                      decoration: new InputDecoration(
                                        labelText: HealingMatchConstants
                                            .registrationBankBranchCode,
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
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: TextFormField(
                                      controller: branchNumberController,
                                      decoration: new InputDecoration(
                                        labelText: HealingMatchConstants
                                            .registrationBankBranchNumber,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    child: TextFormField(
                                      controller: accountnumberController,
                                      decoration: new InputDecoration(
                                        labelText: HealingMatchConstants
                                            .registrationBankAccountNumber,
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
                    SizedBox(height: 20),
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
                          HealingMatchConstants.profileUpdateBtn,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.lime,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {
                          //!Commented for Dev purposes
                          validateFields();

                          /*  NavigationRouter.switchToServiceProviderSecondScreen(
                                context); */
                        },
                      ),
                    ),
                    SizedBox(height: sizedBoxFormHeight),
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

    //Profile image validation
    if ((_profileImage == null) && userData.uploadProfileImgUrl == null) {
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

    /*if (dob.length == 0 || dob.isEmpty || dob == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: ColorConstants.snackBarColor,
                content:
                    Text('生年月日を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
                action: SnackBarAction(
                    onPressed: () {
                      _scaffoldKey.currentState.hideCurrentSnackBar();
                    },
                    label: 'はい',
                    textColor: Colors.white),
              ));
              return;
            }*/

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
        content: Text('あなたのメールアドレスを入力してください',
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

    /*  //certificate Validation
    if (certificateImages.isEmpty &&
        qualification != "無資格" &&
        privateQualification.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('証明書ファイルをアップロードしてください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    } */

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

    // Getting user GPS Address value
    if (HealingMatchConstants.serviceProviderAddressType == '現在地を取得する') {
      HealingMatchConstants.serviceProviderAddress = address;
      print('GPS Address : ${HealingMatchConstants.serviceProviderAddress}');
    } else {
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
      HealingMatchConstants.serviceProviderCity =
          userAddedAddressPlaceMark.locality;
      HealingMatchConstants.serviceProviderPrefecture =
          userAddedAddressPlaceMark.administrativeArea;
      HealingMatchConstants.serviceProviderAddress = address;
      HealingMatchConstants.serviceProviderPrefecture = myState;
      HealingMatchConstants.serviceProviderCity = myCity;
      HealingMatchConstants.serviceProviderArea = myCity;
    }
    updateProfile();
  }

  void updateProfile() async {
    String qualification = '';
    ProgressDialogBuilder.showUserDetailsUpdateProgressDialog(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int i = 0;
    List<MultipartFile> multipartList = new List<MultipartFile>();

    certificateImages.forEach((key, value) {
      if (i == 0) {
        qualification = key;
      } else {
        qualification = qualification + "," + key;
      }
      i++;
    });

    if (privateQualification.length != 0 &&
        !(oldPrivateQualification.length == 0)) {
      if (qualification != '') {
        qualification = qualification + "," + '民間資格';
      } else {
        qualification = '民間資格';
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

    updateAddressValues();

    updateBankValues();

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

    var headers = {
      'Content-Type': 'application/json',
      'x-access-token': HealingMatchConstants.accessToken
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(HealingMatchConstants.UPDATE_PROVIDER_DETAILS_URL));
    request.fields.addAll({
      'id': userData.id.toString(),
      'isTherapist': '1',
      'email': HealingMatchConstants.serviceProviderEmailAddress,
      'storeName': HealingMatchConstants.serviceProviderStoreName,
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
      'businessForm': HealingMatchConstants.serviceProviderBusinessForm,
      'bankDetails': json.encode(userData.bankDetails),
      'address': json.encode(userData.addresses),
    });
    if (storePhoneNumberController.text != '' &&
        storePhoneNumberController.text != null) {
      request.fields.addAll({
        'storePhone':
            '9842765543' //HealingMatchConstants.serviceProviderStorePhoneNumber
      });
    }
    if (userData.qulaificationCertImgUrl != null &&
        userData.qulaificationCertImgUrl != '') {
      if (qualification != '') {
        request.fields.addAll({
          'qulaificationCertImgUrl':
              userData.qulaificationCertImgUrl + ',' + qualification
        });
      } else {
        request.fields.addAll(
            {'qulaificationCertImgUrl': userData.qulaificationCertImgUrl});
      }
    } else {
      request.fields.addAll({'qulaificationCertImgUrl': qualification});
    }

    //Upload Profile Image if not null
    if (HealingMatchConstants.profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'uploadProfileImgUrl', HealingMatchConstants.profileImage.path));
    }

    //Upload Certificate Files
    certificateImages.forEach((key, value) async {
      request.files.add(await http.MultipartFile.fromPath(key, value));
      print('abc');
    });

    //Upload Private Qualification Images
    int privateQualificationLength = oldPrivateQualification.length + 1;
    for (var certificate in privateQualification) {
      request.files.add(await http.MultipartFile.fromPath(
          'privateQualification' + (privateQualificationLength++).toString(),
          certificate));
    }
    request.headers.addAll(headers);

    try {
      final userDetailsRequest = await request.send();
      print("This is request : ${userDetailsRequest.request}");
      final response = await http.Response.fromStream(userDetailsRequest);
      print("This is response: ${response.statusCode}\n${response.body}");
      if (StatusCodeHelper.isRegisterSuccess(
          response.statusCode, context, response.body)) {
        profileUpdate.ProviderProfileUpdateResponseModel
            providerProfileUpdateResponseModel =
            profileUpdate.ProviderProfileUpdateResponseModel.fromJson(
                json.decode(response.body));
        profileUpdate.Data userData = providerProfileUpdateResponseModel.data;
        sharedPreferences.setString("userData", json.encode(userData));
        HealingMatchConstants.userData = loginResponse.Data.fromJson(
            json.decode(sharedPreferences.getString("userData")));
        ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
        print(
            'Update response : ${providerProfileUpdateResponseModel.toJson()}');
        Navigator.pop(context);
        NavigationRouter.switchToServiceProviderMyAccount(context);
      } else {
        ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
        print('Response error occured!');
      }
    } on SocketException catch (_) {
      //handle socket Exception
      ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
      NavigationRouter.switchToNetworkHandler(context);
      print('Network error !!');
    } catch (_) {
      //handle other error
      print("Error");
      ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
    }
  }

  void updateBankValues() {
    userData.bankDetails[0].bankName =
        bankname == HealingMatchConstants.registrationBankOtherDropdownFiled
            ? bankOtherFieldController.text
            : bankname;
    userData.bankDetails[0].branchCode = branchCodeController.text;
    userData.bankDetails[0].branchNumber = branchNumberController.text;
    userData.bankDetails[0].accountNumber = accountnumberController.text;
    userData.bankDetails[0].accountType = accountType;
    userData.bankDetails[0].updatedAt = DateTime.now();
  }

  void updateAddressValues() {
    userData.addresses[0].addressTypeSelection =
        HealingMatchConstants.serviceProviderAddressType;
    userData.addresses[0].address =
        HealingMatchConstants.serviceProviderAddress;
    userData.addresses[0].area = HealingMatchConstants.serviceProviderArea;
    userData.addresses[0].buildingName =
        HealingMatchConstants.serviceProviderBuildingName;
    userData.addresses[0].userRoomNumber =
        HealingMatchConstants.serviceProviderRoomNumber;
    userData.addresses[0].cityName = HealingMatchConstants.serviceProviderCity;
    userData.addresses[0].capitalAndPrefecture =
        HealingMatchConstants.serviceProviderPrefecture;
    userData.addresses[0].lat =
        HealingMatchConstants.serviceProviderCurrentLatitude;
    userData.addresses[0].lon =
        HealingMatchConstants.serviceProviderCurrentLongitude;
    if (HealingMatchConstants.serviceProviderAddressType == "直接入力") {
      userData.addresses[0].citiesId = cityDropDownValues.indexOf(myCity) + 1;
      userData.addresses[0].capitalAndPrefectureId =
          stateDropDownValues.indexOf(myState) + 1;
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
    PickedFile pickedFile;
    final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      pickedFile = image;
      if (index == 0) {
        _profileImage = pickedFile;
      } else {
        if (qualification == "民間資格") {
          privateQualification.add(pickedFile.path);
          uploadVisible = false;
        } else {
          certificateImages[qualification] = pickedFile.path;
        }
      }
    });
    print('image path : ${pickedFile.path}');
  }

  _imgFromGallery(int index) async {
    PickedFile pickedFile;
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      pickedFile = image;
      if (index == 0) {
        _profileImage = pickedFile;
      } else {
        if (qualification == "民間資格") {
          privateQualification.add(pickedFile.path);
          uploadVisible = false;
        } else {
          certificateImages[qualification] = pickedFile.path;
        }
      }
    });
    print('image path : ${pickedFile.path}');
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
        setState(() {
          if (registrationAddressType != '現在地を取得する') {
            myCity = userData.addresses[0].cityName;
          }
        });
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

  void _showPicker1(context, int index) {
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
                        _imgFromGallery1(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('プロフィール写真を撮ってください。'),
                    onTap: () {
                      _imgFromCamera1(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera1(int index) async {
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

  _imgFromGallery1(int index) async {
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

  void showCertificateImageError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('アップロードできる品質証明書は5つだけです。',
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

  void getBankName() async {
    await http
        .get(HealingMatchConstants.REGISTER_PROVIDER_GET_BANK_LIST_URL)
        .then((response) {
      if (response.statusCode == 200) {
        bankNameDropDownModel =
            BankNameDropDownModel.fromJson(json.decode(response.body));
        for (var bankList in bankNameDropDownModel.data) {
          bankNameDropDownList.add(bankList.value);
        }
        setState(() {
          bankNameDropDownList
              .add(HealingMatchConstants.registrationBankOtherDropdownFiled);
          status = status + 1;
          print("b Status: $status");
          if (status == 2) {
            getProfileDetails();
          }
        });
      } else {
        print(response.reasonPhrase);
      }
    });
  }

  Widget buildOldQualificationImage(String key, int index) {
    String keyJaValue = getQualififcationJaWords(key);
    return Container(
      padding: EdgeInsets.only(left: 16.0),
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
                        image: NetworkImage(oldCertificateImages[key]),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("$keyJaValue"),
        ],
      ),
    );
  }

  Widget buildQualificationImage(String key, int index) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
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
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("$key"),
        ],
      ),
    );
  }

  Widget buildPrivateQualificationImage(
      String privateQualificationImage, int index) {
    return Container(
      padding: EdgeInsets.only(
          left: index == 0 &&
                  (oldCertificateImages.length == 0 &&
                      certificateImages.length == 0)
              ? 0.0
              : 16.0),
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
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("民間資格"),
        ],
      ),
    );
  }

  void getProfileDetails() {
    var certificateUpload;
    userData = HealingMatchConstants.userData;
    bussinessForm = userData.businessForm;
    numberOfEmployees = userData.numberOfEmp.toString();
    selectedStoreTypeDisplayValues = userData.storeType.split(',');
    serviceBusinessTrips = userData.businessTrip ? 'はい' : 'いいえ';
    coronaMeasures = userData.coronaMeasure ? 'はい' : 'いいえ';
    if (userData.childrenMeasure != null && userData.childrenMeasure != '') {
      childrenMeasuresDropDownValuesSelected =
          userData.childrenMeasure.split(',');
    }
    genderTreatment = userData.genderOfService;
    providerNameController.text = userData.userName;
    storeNameController.text = userData.storeName;
    userDOBController.text =
        DateFormat("yyyy-MM-dd").format(userData.dob).toString();
    ageController.text = userData.age.toString();
    gender = userData.gender;
    phoneNumberController.text = userData.phoneNumber.toString();
    if (userData.storePhone.toString() != '' &&
        userData.storePhone.toString() != null) {
      storePhoneNumberController.text = userData.storePhone.toString();
    }
    mailAddressController.text = userData.email;
    registrationAddressType = userData.addresses[0].addressTypeSelection;
    showAddressField = true;
    if (registrationAddressType == '現在地を取得する') {
      gpsAddressController.text = userData.addresses[0].address;
      gpsAddressVisible = true;
    } else {
      manualAddressController.text = userData.addresses[0].address;
      //   myCity = userData.addresses[0].cityName;
      myState = userData.addresses[0].capitalAndPrefecture;
      _prefid = stateDropDownValues.indexOf(myState) + 1;
      _getCityDropDown(_prefid);
    }
    identificationverify = userData.proofOfIdentityType;
    roomNumberController.text = userData.addresses[0].userRoomNumber;
    buildingNameController.text = userData.addresses[0].buildingName;
    if (userData.bankDetails[0].bankName != '') {
      if (bankNameDropDownList.contains(userData.bankDetails[0].bankName)) {
        bankname = userData.bankDetails[0].bankName;
      } else {
        bankname = HealingMatchConstants.registrationBankOtherDropdownFiled;
        bankOtherFieldController.text = userData.bankDetails[0].bankName;
      }
    }

    accountType = userData.bankDetails[0].accountType;
    accountnumberController.text = userData.bankDetails[0].accountNumber;
    branchCodeController.text = userData.bankDetails[0].branchCode;
    branchNumberController.text = userData.bankDetails[0].branchNumber;
    userData = HealingMatchConstants.userData;
    certificateUpload = userData.certificationUploads[0].toJson();
    certificateUpload.remove('id');
    certificateUpload.remove('userId');
    certificateUpload.remove('createdAt');
    certificateUpload.remove('updatedAt');
    certificateUpload.forEach((key, value) async {
      if (certificateUpload[key] != null) {
        oldCertificateImages[key] = value;
        if (getQualififcationJaWords(key) == "民間資格") {
          oldPrivateQualification.add(value);
        }
      }
    });
    //remove unqualified value from dropddown if certififcate already uploaded
    if (oldCertificateImages.length != 0) {
      qualificationCertificates.removeLast();
    }
    setState(() {
      status = 3;
    });
  }

  _getState() async {
    await http.get(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesList.fromJson(json.decode(response.body));
      // print(states.toJson());

      for (var stateList in states.data) {
        stateDropDownValues.add(stateList.prefectureJa);
        // print(stateDropDownValues);
      }
      setState(() {
        /*   if (myState != null && myState != '') {
          _prefid = stateDropDownValues.indexOf(myState) + 1;
          print('prefID : ${_prefid.toString()}'); */
        status = status + 1;
        print("s Status: $status");
        if (status == 2) {
          getProfileDetails();
        }
        /*   cityDropDownValues.clear();
          myCity = '';
          _getCityDropDown(_prefid); */
        /*   } */
      });
      // print('prefID : ${stateDropDownValues.indexOf(_mystate).toString()}');
    });
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

  String getQualififcationEngWords(String key) {
    switch (key) {
      case 'はり師':
        return 'acupuncturist';
        break;
      case 'きゅう師':
        return 'moxibutionist';
        break;
      case '鍼灸師':
        return 'acupuncturistAndMoxibustion';
        break;
      case 'あん摩マッサージ指圧師':
        return 'anmaMassageShiatsushi';
        break;
      case '柔道整復師':
        return 'judoRehabilitationTeacher';
        break;
      case '理学療法士':
        return 'physicalTherapist';
        break;
      case '国家資格取得予定（学生）':
        return 'acquireNationalQualifications';
        break;
      case '民間資格':
        return 'privateQualification1';
        break;
    }
  }
}
