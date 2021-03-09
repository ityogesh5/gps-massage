import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/models/customModels/address.dart';
import 'package:gps_massageapp/models/customModels/userAddressAdd.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/profile/profileUpdateResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
List<AddUserSubAddress> otherUserAddress = new List<AddUserSubAddress>();
List<UpdateAddress> updateAddress = new List<UpdateAddress>();

class UpdateServiceUserDetails extends StatefulWidget {
  @override
  _UpdateServiceUserDetailsState createState() =>
      _UpdateServiceUserDetailsState();
}

class _UpdateServiceUserDetailsState extends State<UpdateServiceUserDetails> {
  UpdateAddress addUpdateAddress;

  String rUserName = '';
  String rUserID = '';
  String rID = '';
  String raccessToken = '';
  String rUserPhoneNumber = '';
  String rEmailAddress = '';
  String rDob = '';
  String rUserAge = '';
  String rUserGender = '';
  String rUserOccupation = '';
  String rUserAddress = '';
  String rUserBuildName = '';
  String rUserRoomNo = '';
  String rUserPlaceMassage = '';
  String rUserArea = '';

  String imgBase64ProfileImage;
  Uint8List profileImageInBytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEditUserFields();
    getUserProfileData();
    // getUpdateAddress();

    _getStates();
    _getCities(_prefId);
  }

  var userAddressType = '';
  final _searchRadiusKey = new GlobalKey<FormState>();
  String _mySearchRadiusDistance = '';
  TextEditingController _userDOBController = new TextEditingController();

  String _selectedDOBDate = 'Tap to select date';
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  final Geolocator addAddressgeoLocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _currentPosition;
  Position _addAddressPosition;
  String _currentAddress = '';
  String _addedAddress = '';
  double age = 0.0;
  var selectedYear;
  final ageController = TextEditingController();
  var _ageOfUser = '';
  String _myGender = '';
  String _myOccupation = '';
  String _myAddressInputType = '', accessToken;
  String _userAddressID = '';
  String _myAddedAddressInputType = '';
  String _myCategoryPlaceForMassage = '';
  String _myPrefecture = '';
  String _myCity = '';
  String _myAddedPrefecture = '';
  String _myAddedCity;
  File _profileImage;
  final picker = ImagePicker();
  Placemark currentLocationPlaceMark;
  Placemark userAddedAddressPlaceMark;

  bool _showCurrentLocationInput = false;
  bool _isLoggedIn = false;
  bool _isGPSLocation = false;
  bool _isAddedGPSLocation = false;
  final _genderKey = new GlobalKey<FormState>();
  final _occupationKey = new GlobalKey<FormState>();
  final _addressTypeKey = new GlobalKey<FormState>();
  final _addedAddressTypeKey = new GlobalKey<FormState>();
  final _addAddressKey = new GlobalKey<FormState>();
  final _placeOfAddressKey = new GlobalKey<FormState>();
  final _perfectureKey = new GlobalKey<FormState>();
  final _cityKey = new GlobalKey<FormState>();
  final _addedPrefectureKey = new GlobalKey<FormState>();
  final _addedCityKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _updateUserFormKey = new GlobalKey<FormState>();
  final userNameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = TextEditingController();
  final buildingNameController = new TextEditingController();
  final userAreaController = new TextEditingController();
  final gpsAddressController = new TextEditingController();
  final roomNumberController = new TextEditingController();

  final additionalAddressController = new TextEditingController();

  //final gpsAddressController = new TextEditingController();

  bool _changeProgressText = false;

  List<dynamic> stateDropDownValues = List();
  List<dynamic> cityDropDownValues = List();

  List<dynamic> addedAddressStateDropDownValues = List();
  List<dynamic> addedAddressCityDropDownValues = List();

  StatesListResponseModel states;
  CitiesListResponseModel cities;
  var _prefId, _addedAddressPrefId;
  int _count = 0;

  //CityListResponseModel city;

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
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
        _userDOBController.value =
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

  //Regex validation for Username
  RegExp regExpUserName = new RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  //numeric check user name
  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  //Regex validation for Email address
  RegExp regexMail = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  //Regex validation for emojis in text
  RegExp regexEmojis = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  //finding Japanese characters in text regex
  RegExp regexJapanese =
      RegExp(r'(/[一-龠]+|[ぁ-ゔ]+|[ァ-ヴー]+|[a-zA-Z0-9]+|[ａ-ｚＡ-Ｚ０-９]+|[々〆〤]+/u)');

  // Password combination
  /*r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])          // should contain at least one digit
  (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
  $*/
  // Password combination ==> r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'

  //..old regex pattern
  /*RegExp passwordRegex = new RegExp(
      r'^(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{8,40}$');*/

//..updated regex pattern
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~!?@#$%^&*_-]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            // NavigationRouter.switchToServiceUserViewProfileScreen(context);
            Navigator.pop(context);
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Form(
            key: _updateUserFormKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        HealingMatchConstants.profileImageInBytes != null
                            ? InkWell(
                                onTap: () {
                                  _showPicker(context);
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
                                          image: MemoryImage(
                                              HealingMatchConstants
                                                  .profileImageInBytes),
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
                                      border:
                                          Border.all(color: Colors.grey[200]),
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
                                  right: -70.0,
                                  top: 65,
                                  left: 10.0,
                                  child: InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[500],
                                      radius: 13,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        radius: 12,
                                        child: Icon(Icons.edit,
                                            color: Colors.grey[400],
                                            size: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Visibility(
                                visible: true,
                                child: Positioned(
                                  right: -70.0,
                                  top: 65,
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
                                        child: Icon(Icons.edit,
                                            color: Colors.grey[400],
                                            size: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        //maxLength: 20,
                        autofocus: false,
                        controller: userNameController,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: 'お名前',
                          //hintText: 'お名前 *',
                          /*hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),*/
                          labelStyle: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'NotoSansJP',
                              fontSize: 14),
                          focusColor: Colors.grey[100],
                          border: HealingMatchConstants.textFormInputBorder,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          disabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.63,
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    //enableInteractiveSelection: false,
                                    controller: _userDOBController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'NotoSansJP'),
                                    cursorColor: Colors.redAccent,
                                    readOnly: true,
                                    decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      labelText: '生年月日',
                                      hintText: '生年月日',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14),
                                      labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Color.fromRGBO(211, 211, 211, 1),
                                      ),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //age
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.20,
                              alignment: Alignment.topCenter,
                              child: TextFormField(
                                //enableInteractiveSelection: false,
                                controller: ageController,
                                autofocus: false,
                                readOnly: true,
                                decoration: new InputDecoration(
                                  filled: true,
                                  fillColor: ColorConstants.formFieldFillColor,
                                  labelText: '年齢',
                                  labelStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: 'NotoSansJP',
                                      fontSize: 14),
                                  border:
                                      HealingMatchConstants.textFormInputBorder,
                                  focusedBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  disabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                  enabledBorder:
                                      HealingMatchConstants.textFormInputBorder,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Drop down gender user
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '性別',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.w300),
                          ),
                          Form(
                            key: _genderKey,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: DropDownFormField(
                                  hintText: '性別',
                                  value: _myGender,
                                  onSaved: (value) {
                                    setState(() {
                                      _myGender = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myGender = value;
                                      //print(_myBldGrp.toString());
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "display": "男性",
                                      "value": "男性",
                                    },
                                    {
                                      "display": "女性",
                                      "value": "女性",
                                    },
                                    {
                                      "display": "どちらでもない",
                                      "value": "どちらでもない",
                                    },
                                  ],
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Drop down occupation user
                    Form(
                      key: _occupationKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: DropDownFormField(
                                hintText: '職業',
                                value: _myOccupation,
                                onSaved: (value) {
                                  setState(() {
                                    _myOccupation = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _myOccupation = value;
                                    //print(_myBldGrp.toString());
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "会社員",
                                    "value": "会社員",
                                  },
                                  {
                                    "display": "公務員",
                                    "value": "公務員",
                                  },
                                  {
                                    "display": "自営業",
                                    "value": "自営業",
                                  },
                                  {
                                    "display": "会社役員",
                                    "value": "会社役員",
                                  },
                                  {
                                    "display": "会社経営",
                                    "value": "会社経営",
                                  },
                                  {
                                    "display": "自由業",
                                    "value": "自由業",
                                  },
                                  {
                                    "display": "専業主婦（夫）",
                                    "value": "専業主婦（夫）",
                                  },
                                  {
                                    "display": "学生",
                                    "value": "学生",
                                  },
                                  {
                                    "display": "パート・アルバイト",
                                    "value": "パート・アルバイト",
                                  },
                                  {
                                    "display": "無職",
                                    "value": "無職",
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        enabled: false,
                        autofocus: false,
                        //maxLength: 10,
                        controller: phoneNumberController,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: '電話番号',
                          /*hintText: '電話番号 *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),*/
                          labelStyle: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'NotoSansJP',
                              fontSize: 14),
                          focusColor: Colors.grey[100],
                          border: HealingMatchConstants.textFormInputBorder,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          disabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        ),
                        // validator: (value) => _validateEmail(value),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        autofocus: false,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: 'メールアドレス',
                          labelStyle: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: 'NotoSansJP',
                              fontSize: 14),
                          focusColor: Colors.grey[100],
                          border: HealingMatchConstants.textFormInputBorder,
                          focusedBorder:
                              HealingMatchConstants.textFormInputBorder,
                          disabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                          enabledBorder:
                              HealingMatchConstants.textFormInputBorder,
                        ),
                        // validator: (value) => _validateEmail(value),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Drop down address input type
                    Form(
                      key: _addressTypeKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: DropDownFormField(
                                hintText: '検索地点の登録',
                                value: _myAddressInputType,
                                onSaved: (value) {
                                  setState(() {
                                    _myAddressInputType = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _myAddressInputType = value;
                                    if (_myAddressInputType != null &&
                                        _myAddressInputType
                                            .contains('現在地を取得する')) {
                                      _showCurrentLocationInput = true;
                                      gpsAddressController.clear();
                                      buildingNameController.clear();
                                      roomNumberController.clear();
                                    } else if (_myAddressInputType != null &&
                                        _myAddressInputType
                                            .contains('直接入力する')) {
                                      _showCurrentLocationInput = false;
                                      cityDropDownValues.clear();
                                      stateDropDownValues.clear();
                                      buildingNameController.clear();
                                      roomNumberController.clear();
                                      _myPrefecture = '';
                                      _myCity = '';
                                      _isGPSLocation = false;
                                      _getStates();
                                    }
                                    print(
                                        'Address type : ${_myAddressInputType.toString()}');
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "現在地を取得する",
                                    "value": "現在地を取得する",
                                  },
                                  {
                                    "display": "直接入力する",
                                    "value": "直接入力する",
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    _myAddressInputType.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _placeOfAddressKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: DropDownFormField(
                                          hintText: '登録する地点のカテゴリー ',
                                          value: _myCategoryPlaceForMassage,
                                          onSaved: (value) {
                                            setState(() {
                                              _myCategoryPlaceForMassage =
                                                  value;
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _myCategoryPlaceForMassage =
                                                  value;
                                            });
                                          },
                                          dataSource: [
                                            {
                                              "display": "自宅",
                                              "value": "自宅",
                                            },
                                            {
                                              "display": "オフィス",
                                              "value": "オフィス",
                                            },
                                            {
                                              "display": "実家",
                                              "value": "実家",
                                            },
                                            {
                                              "display": "その他（直接入力）",
                                              "value": "その他（直接入力）",
                                            },
                                          ],
                                          textField: 'display',
                                          valueField: 'value',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              !_showCurrentLocationInput
                                  ? SizedBox(height: 5)
                                  : SizedBox(height: 15),
                              Visibility(
                                visible: _showCurrentLocationInput,
                                child: Container(
                                  // height: MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: TextFormField(
                                    controller: gpsAddressController,
                                    decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      labelText: '現在地を取得する',
                                      /*hintText: '現在地を取得する *',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),*/
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
                                      labelStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                      focusColor: Colors.grey[100],
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                    ),
                                    style: TextStyle(color: Colors.black54),
                                    // validator: (value) => _validateEmail(value),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: !_showCurrentLocationInput,
                                  child: SizedBox(height: 10)),
                              Visibility(
                                visible: !_showCurrentLocationInput,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Form(
                                    key: _perfectureKey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                              child: stateDropDownValues != null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: DropDownFormField(
                                                          hintText: '府県',
                                                          value: _myPrefecture,
                                                          onSaved: (value) {
                                                            setState(() {
                                                              _myPrefecture =
                                                                  value;
                                                            });
                                                          },
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _myPrefecture =
                                                                  value;
                                                              print(
                                                                  'Prefecture value : ${_myPrefecture.toString()}');
                                                              _prefId = stateDropDownValues
                                                                      .indexOf(
                                                                          value) +
                                                                  1;
                                                              print(
                                                                  'prefID : ${_prefId.toString()}');
                                                              cityDropDownValues
                                                                  .clear();
                                                              _myCity = '';
                                                              _getCities(
                                                                  _prefId);
                                                            });
                                                          },
                                                          dataSource:
                                                              stateDropDownValues,
                                                          isList: true,
                                                          textField: 'display',
                                                          valueField: 'value'),
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: DropDownFormField(
                                                          hintText: '府県',
                                                          value: _myPrefecture,
                                                          onSaved: (value) {
                                                            setState(() {
                                                              _myPrefecture =
                                                                  value;
                                                            });
                                                          },
                                                          dataSource: [],
                                                          isList: true,
                                                          textField: 'display',
                                                          valueField: 'value'),
                                                    )),
                                        ),
                                        Expanded(
                                          child: Form(
                                              key: _cityKey,
                                              child: cityDropDownValues != null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: DropDownFormField(
                                                          hintText: '市',
                                                          value: _myCity,
                                                          onSaved: (value) {
                                                            setState(() {
                                                              _myCity = value;
                                                            });
                                                          },
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _myCity = value;
                                                              //print(_myBldGrp.toString());
                                                            });
                                                          },
                                                          dataSource:
                                                              cityDropDownValues,
                                                          isList: true,
                                                          textField: 'display',
                                                          valueField: 'value'),
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: DropDownFormField(
                                                          hintText: '市',
                                                          value: _myCity,
                                                          onSaved: (value) {
                                                            setState(() {
                                                              _myCity = value;
                                                            });
                                                          },
                                                          dataSource: [],
                                                          isList: true,
                                                          textField: 'display',
                                                          valueField: 'value'),
                                                    )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              !_showCurrentLocationInput
                                  ? Visibility(
                                      visible: true,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Center(
                                                child: Container(
                                                  // height: MediaQuery.of(context).size.height * 0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.39,
                                                  child: TextFormField(
                                                    //enableInteractiveSelection: false,
                                                    autofocus: false,
                                                    controller:
                                                        userAreaController,
                                                    decoration:
                                                        new InputDecoration(
                                                      filled: true,
                                                      fillColor: ColorConstants
                                                          .formFieldFillColor,
                                                      labelText: '丁目, 番地',
                                                      /*hintText: '都、県選 *',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),*/
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily: 'NotoSansJP',
                                                          fontSize: 14),
                                                      focusColor:
                                                          Colors.grey[100],
                                                      border: HealingMatchConstants
                                                          .textFormInputBorder,
                                                      focusedBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      disabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      enabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                    ),
                                                    // validator: (value) => _validateEmail(value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // height: MediaQuery.of(context).size.height * 0.07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.39,
                                                child: TextFormField(
                                                  //enableInteractiveSelection: false,
                                                  // keyboardType: TextInputType.number,
                                                  autofocus: false,
                                                  controller:
                                                      buildingNameController,
                                                  decoration:
                                                      new InputDecoration(
                                                    filled: true,
                                                    fillColor: ColorConstants
                                                        .formFieldFillColor,
                                                    labelText: '建物名',
                                                    /*hintText: 'ビル名 *',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),*/
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontFamily: 'NotoSansJP',
                                                        fontSize: 14),
                                                    focusColor:
                                                        Colors.grey[100],
                                                    border: HealingMatchConstants
                                                        .textFormInputBorder,
                                                    focusedBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    disabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    enabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                  ),
                                                  // validator: (value) => _validateEmail(value),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Visibility(
                                      visible: true,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Center(
                                                child: Container(
                                                  // height: MediaQuery.of(context).size.height * 0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.39,
                                                  child: TextFormField(
                                                    //enableInteractiveSelection: false,
                                                    // keyboardType: TextInputType.number,
                                                    autofocus: false,
                                                    controller:
                                                        buildingNameController,
                                                    decoration:
                                                        new InputDecoration(
                                                      filled: true,
                                                      fillColor: ColorConstants
                                                          .formFieldFillColor,
                                                      labelText: '建物名',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily: 'NotoSansJP',
                                                          fontSize: 14),
                                                      focusColor:
                                                          Colors.grey[100],
                                                      border: HealingMatchConstants
                                                          .textFormInputBorder,
                                                      focusedBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      disabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      enabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                    ),
                                                    // validator: (value) => _validateEmail(value),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // height: MediaQuery.of(context).size.height * 0.07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.39,
                                                child: TextFormField(
                                                  //enableInteractiveSelection: false,
                                                  autofocus: false,
                                                  controller:
                                                      roomNumberController,
                                                  decoration:
                                                      new InputDecoration(
                                                    filled: true,
                                                    fillColor: ColorConstants
                                                        .formFieldFillColor,
                                                    labelText: '部屋番号',
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontFamily: 'NotoSansJP',
                                                        fontSize: 14),
                                                    focusColor:
                                                        Colors.grey[100],
                                                    border: HealingMatchConstants
                                                        .textFormInputBorder,
                                                    focusedBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    disabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    enabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                  ),
                                                  // validator: (value) => _validateEmail(value),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              Visibility(
                                  visible: !_showCurrentLocationInput,
                                  child: SizedBox(height: 15)),
                              Visibility(
                                visible: !_showCurrentLocationInput,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            child: TextFormField(
                                              //enableInteractiveSelection: false,
                                              autofocus: false,
                                              controller: roomNumberController,
                                              decoration: new InputDecoration(
                                                filled: true,
                                                fillColor: ColorConstants
                                                    .formFieldFillColor,
                                                labelText: '号室',
                                                labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontFamily: 'NotoSansJP',
                                                    fontSize: 14),
                                                focusColor: Colors.grey[100],
                                                border: HealingMatchConstants
                                                    .textFormInputBorder,
                                                focusedBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                disabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                enabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                              ),
                                              // validator: (value) => _validateEmail(value),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    _myAddressInputType.isNotEmpty
                        ? SizedBox(height: 15)
                        : SizedBox(),
                    otherUserAddress != null
                        ? Container(
                            // height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.formFieldFillColor,
                                hintText: 'その他の登録場所',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add,
                                      size: 28, color: Colors.black),
                                  onPressed: () {
                                    if (otherUserAddress.length == 3) {
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        backgroundColor:
                                            ColorConstants.snackBarColor,
                                        duration: Duration(seconds: 3),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                  'メインの地点以外に3箇所まで地点登録ができます。',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontFamily: 'NotoSansJP')),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _scaffoldKey.currentState
                                                    .hideCurrentSnackBar();
                                              },
                                              child: Text('はい',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'NotoSansJP',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration: TextDecoration
                                                          .underline)),
                                            ),
                                          ],
                                        ),
                                      ));
                                    } else {
                                      _updateUserFormKey.currentState.save();
                                      NavigationRouter
                                          .switchToUserAddAddressScreen(
                                              context);
                                    }
                                  },
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14),
                                focusColor: Colors.grey[100],
                                border:
                                    HealingMatchConstants.textFormInputBorder,
                                focusedBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                disabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                enabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                              ),
                              style: TextStyle(color: Colors.black54),
                              // validator: (value) => _validateEmail(value),
                            ),
                          )
                        : Container(
                            // height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: ColorConstants.formFieldFillColor,
                                hintText: 'その他の登録場所',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add,
                                      size: 28, color: Colors.black),
                                  onPressed: () {
                                    _updateUserFormKey.currentState.save();
                                    NavigationRouter
                                        .switchToUserAddAddressScreen(context);
                                  },
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14),
                                focusColor: Colors.grey[100],
                                border:
                                    HealingMatchConstants.textFormInputBorder,
                                focusedBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                disabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                                enabledBorder:
                                    HealingMatchConstants.textFormInputBorder,
                              ),
                              style: TextStyle(color: Colors.black54),
                              // validator: (value) => _validateEmail(value),
                            ),
                          ),
                    SizedBox(height: 15),
                    Text(
                      'メインの地点以外に3箇所まで地点登録ができます',
                      style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 15),

                    otherUserAddress != null
                        ? Container(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: otherUserAddress.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: TextFormField(
                                          //display the address
                                          initialValue: otherUserAddress[index]
                                              .subAddress,
                                          decoration: new InputDecoration(
                                              filled: true,
                                              fillColor: ColorConstants
                                                  .formFieldFillColor,
                                              hintText:
                                                  '${otherUserAddress[index]}',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14),
                                              focusColor: Colors.grey[100],
                                              border: HealingMatchConstants
                                                  .textFormInputBorder,
                                              focusedBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                              disabledBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                              enabledBorder:
                                                  HealingMatchConstants
                                                      .textFormInputBorder,
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    //Delete Value at index
                                                    otherUserAddress
                                                        .removeAt(index);
                                                  });
                                                },
                                              )),
                                          style:
                                              TextStyle(color: Colors.black54),
                                          onChanged: (value) {
                                            setState(() {
                                              otherUserAddress[index]
                                                  .subAddress = value;
                                            });
                                          },
                                          // validator: (value) => _validateEmail(value),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  );
                                }),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'セラピスト検索範囲',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.normal),
                          ),
                          Form(
                            key: _searchRadiusKey,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: DropDownFormField(
                                  hintText: '検索範囲値',
                                  value: _mySearchRadiusDistance,
                                  onSaved: (value) {
                                    setState(() {
                                      _mySearchRadiusDistance = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _mySearchRadiusDistance = value;
                                      //print(_myBldGrp.toString());
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "display": "５Ｋｍ圏内",
                                      "value": "5.0",
                                    },
                                    {
                                      "display": "１０Ｋｍ圏内",
                                      "value": "10.0",
                                    },
                                    {
                                      "display": "１５Ｋｍ圏内",
                                      "value": "15.0",
                                    },
                                    {
                                      "display": "２０Ｋｍ圏内",
                                      "value": "20.0",
                                    },
                                  ],
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.black),
                        ),
                        color: Colors.lime,
                        onPressed: () {
                          _updateUserDetails();
                          setState(() {});
                        },
                        child: new Text(
                          '更新',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Get current address from Latitude Longitude
  _getCurrentLocation() {
    ProgressDialogBuilder.showLocationProgressDialog(context);
    geoLocator
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
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      currentLocationPlaceMark = p[0];

      HealingMatchConstants.editCurrentLatitude = _currentPosition.latitude;
      HealingMatchConstants.editCurrentLongitude = _currentPosition.longitude;

      setState(() {
        _currentAddress =
            '${currentLocationPlaceMark.locality},${currentLocationPlaceMark.subAdministrativeArea},${currentLocationPlaceMark.administrativeArea},${currentLocationPlaceMark.postalCode}'
            ',${currentLocationPlaceMark.country}';
        if (_currentAddress != null && _currentAddress.isNotEmpty) {
          print(
              'Current address : $_currentAddress : ${HealingMatchConstants.currentLatitude} && '
              '${HealingMatchConstants.currentLongitude}');
          gpsAddressController.value = TextEditingValue(text: _currentAddress);
          setState(() {
            _isGPSLocation = true;
          });
          HealingMatchConstants.userEditCity =
              currentLocationPlaceMark.locality;
          HealingMatchConstants.userEditPrefecture =
              currentLocationPlaceMark.administrativeArea;
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
    final pickedImage = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      if (pickedImage != null) {
        _profileImage = File(pickedImage.path);
        print('image camera path : ${_profileImage.path}');
      } else {
        print('No camera image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedImage != null) {
        _profileImage = File(pickedImage.path);
        print('image gallery path : ${_profileImage.path}');
      } else {
        print('No gallery image selected.');
      }
    });
  }

  _getStates() async {
    await http.get(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesListResponseModel.fromJson(json.decode(response.body));
      print(states.toJson());
      for (var stateList in states.data) {
        setState(() {
          stateDropDownValues.add(stateList.prefectureJa);
        });
      }
    });
  }

  // CityList cityResponse;
  _getCities(var prefId) async {
    ProgressDialogBuilder.showGetCitiesProgressDialog(context);
    await http.post(HealingMatchConstants.CITY_PROVIDER_URL,
        body: {'prefecture_id': prefId.toString()}).then((response) {
      cities = CitiesListResponseModel.fromJson(json.decode(response.body));
      print(cities.toJson());
      for (var cityList in cities.data) {
        setState(() {
          cityDropDownValues.add(cityList.cityJa + cityList.specialDistrictJa);
        });
      }
      ProgressDialogBuilder.hideGetCitiesProgressDialog(context);
      print('Response City list : ${response.body}');
    });
  }

  _updateUserDetails() async {
    var userName = userNameController.text.toString();
    var email = emailController.text.toString();
    var userPhoneNumber = phoneNumberController.text.toString();
    var userDOB = _userDOBController.text.toString();
    var userAge = ageController.text.toString().trim();
    int ageOfUser = int.tryParse(userAge);
    //var _myAddressInputTypeVal = _myAddressInputType;
    var buildingName = buildingNameController.text.toString();
    var userArea = userAreaController.text.toString();
    var roomNumber = roomNumberController.text.toString();
    int userRoomNumber = int.tryParse(roomNumber);
    int phoneNumber = int.tryParse(userPhoneNumber);

    print('searchRadius: ${_mySearchRadiusDistance}');
    var userGPSAddress = gpsAddressController.text.toString().trim();

    // user perfecture validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (_myPrefecture == null || _myPrefecture.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な府県を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // user city validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (_myCity == null || _myCity.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な市を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // user area validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (userArea == null || userArea.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な都、県選 を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // Manual address building name validation
    if (_myAddressInputType.contains("直接入力する") && buildingName == null ||
        buildingName.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効なビル名を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // Manual address room number validation
    if (_myAddressInputType.contains("直接入力する") && roomNumber == null ||
        roomNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な号室を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    // GPS ADDRESS validation
    if (_myAddressInputType.contains("現在地を取得する") &&
        userGPSAddress == null &&
        userGPSAddress.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な現在地の住所を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    // GPS ADDRESS building name validation
    if (_myAddressInputType.contains("現在地を取得する") && buildingName == null ||
        buildingName.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効なビル名を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // GPS ADDRESS room number validation
    if (_myAddressInputType.contains("現在地を取得する") && roomNumber == null ||
        roomNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な号室を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // user perfecture validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (_myPrefecture != null || _myPrefecture.isNotEmpty)) {
      print('prefecture : $_myPrefecture');
    }

    // user city validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (_myCity != null || _myCity.isNotEmpty)) {
      print('city : $_myCity');
    }

    // user area validation
    if ((_myAddressInputType != "現在地を取得する") &&
        (_myAddressInputType.contains("直接入力する")) &&
        (userArea != null || userArea.isNotEmpty)) {
      print('userArea : $userArea');
    }
    // Address input type validation
    if (_myAddressInputType != null || _myAddressInputType.isNotEmpty) {
      print('_myAddressInputType : $_myAddressInputType');
    }

    if (userName.isNotEmpty && userName.length > 20) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('ユーザー名は20文字以内で入力してください。',
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      color: Colors.black,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
    }

    // user DOB validation
    if (userDOB != null || userDOB.isNotEmpty) {
      print('dob user : $userDOB');
    }
    // user gender validation
    if (_myGender != null || _myGender.isNotEmpty) {
      print('_myGender : $_myGender');
    }
    // user Occupation validation
    if (_myOccupation != null || _myOccupation.isNotEmpty) {
      print('_myOccupation : $_myOccupation');
    }
    // user phone number validation
    if (userPhoneNumber != null &&
        userPhoneNumber.isNotEmpty &&
        userPhoneNumber.length < 10) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('正しい電話番号を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    // user phone number validation
    if (userPhoneNumber != null &&
        userPhoneNumber.isNotEmpty &&
        userPhoneNumber.length > 10) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('正しい電話番号を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    // user phone number validation
    if (userPhoneNumber != null || userPhoneNumber.isNotEmpty) {
      print('userPhoneNumber : $userPhoneNumber');
    }

    // Email Validation
    if (email.isNotEmpty && !(email.contains(regexMail))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効なメールアドレスを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (email.isNotEmpty && email.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('メールアドレスは50文字以内で入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (email.isNotEmpty && (email.contains(regexEmojis))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効なメールアドレスを入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if (email.isNotEmpty || email != null) {
      print('email : $email');
    }

    // user place for massage validation
    if (_myCategoryPlaceForMassage != null ||
        _myCategoryPlaceForMassage.isNotEmpty) {
      print('_myCategoryPlaceForMassage : $_myCategoryPlaceForMassage');
    }

    // user building name validation
    if (buildingName != null || buildingName.isNotEmpty) {
      print('buildingName : $buildingName');
    }

    // room number validation
    if (roomNumber != null || roomNumber.isNotEmpty) {
      print('numbers : $roomNumber');
    }
    if (_myAddressInputType.isNotEmpty &&
        _myAddressInputType.contains('現在地を取得する')) {
      setState(() {
        print('gowtham');
        addUpdateAddress = UpdateAddress(
          id: _userAddressID,

          userId: rUserID,

          addressTypeSelection: _myAddressInputType,
          address: gpsAddressController.text.toString(),
          userRoomNumber: roomNumberController.text.toString(),
          userPlaceForMassage: _myCategoryPlaceForMassage,
          cityName: HealingMatchConstants.userEditCity,
          buildingName: buildingNameController.text.toString(),
          // postalCode: '',
          // lat: HealingMatchConstants.editCurrentLatitude,
          // lon: HealingMatchConstants.editCurrentLongitude,
        );
        updateAddress.add(addUpdateAddress);
      });
    }
    print('Id: ${HealingMatchConstants.userEditToken}');
    print('Id: $rID');
    print('Address ID : $_userAddressID');
    print('UserId: $rUserID');
    print('Name: $userName');
    print('Dob: $userDOB');
    print('Age: ${userAge}');
    print('occupation: $_myOccupation');
    print('phn: $userPhoneNumber');
    print('email: $email');
    if (_myAddressInputType.isNotEmpty &&
        _myAddressInputType.contains('直接入力する')) {
      setState(() {
        addUpdateAddress = UpdateAddress(
          id: _userAddressID,

          userId: rUserID,

          addressTypeSelection: _myAddressInputType,
          address: gpsAddressController.text.toString(),
          userRoomNumber: roomNumberController.text.toString(),
          userPlaceForMassage: _myCategoryPlaceForMassage,
          capitalAndPrefecture: _myPrefecture,
          cityName: _myCity,
          // citiesId: '',
          area: userAreaController.text.toString(),
          buildingName: buildingNameController.text.toString(),
          // postalCode: '',
          // lat: HealingMatchConstants.mEditCurrentLatitude,
          // lon: HealingMatchConstants.mEditCurrentLongitude,
        );
        updateAddress.add(addUpdateAddress);
      });
    }

    // Getting user GPS Address value
    if (_myAddressInputType.contains('現在地を取得する') && _isGPSLocation) {
      print('GPS Address : $userGPSAddress');
      String userCurrentLocation =
          roomNumber + ',' + buildingName + ',' + userGPSAddress;
      print('GPS Modified Address : ${userCurrentLocation.trim()}');
    } else if (userGPSAddress.isEmpty || userGPSAddress == null) {
      String manualUserAddress = roomNumber +
          ',' +
          buildingName +
          ',' +
          userArea +
          ',' +
          _myCity +
          ',' +
          _myPrefecture;

      List<Placemark> userAddress =
          await geoLocator.placemarkFromAddress(manualUserAddress);
      userAddedAddressPlaceMark = userAddress[0];
      Position addressPosition = userAddedAddressPlaceMark.position;
      HealingMatchConstants.mEditCurrentLatitude = addressPosition.latitude;
      HealingMatchConstants.mEditCurrentLongitude = addressPosition.longitude;
      var serviceUserCity = userAddedAddressPlaceMark.locality;
      var serviceUserPrefecture = userAddedAddressPlaceMark.administrativeArea;
      HealingMatchConstants.userEditAddress = manualUserAddress;
      print(
          'Manual Address lat lon : ${HealingMatchConstants.currentLatitude} && '
          '${HealingMatchConstants.currentLongitude}');
      print('Manual Place Json : ${userAddedAddressPlaceMark.toJson()}');
      print('Manual Address : ${HealingMatchConstants.userAddress}');
      print('Manual Modified Address : ${manualUserAddress.trim()}');
    }

    print('Id: $rID');
    print('Address ID : $_userAddressID');

    print('UserId: $rUserID');

    print("json Converted:" + json.encode(otherUserAddress));
    print("json Converted Address:" + json.encode(updateAddress));

    ProgressDialogBuilder.showUserDetailsUpdateProgressDialog(context);
    Uri updateProfile =
        Uri.parse(HealingMatchConstants.UPDATE_USER_DETAILS_URL);
    var request = http.MultipartRequest('POST', updateProfile);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "x-access-token": HealingMatchConstants.userEditToken
    };
    if (_profileImage != null) {
      var profileImage = await http.MultipartFile.fromPath(
          'uploadProfileImgUrl', _profileImage.path);
      print('Image upload filename : $profileImage');
      request.files.add(profileImage);
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": rID,
        "userName": userName,
        "age": userAge,
        "userOccupation": _myOccupation,
        "dob": userDOB,
        "phoneNumber": userPhoneNumber,
        "email": email,
        "gender": _myGender,
        "uploadProfileImgUrl": _profileImage.path,
        "isTherapist": "0",
        "userSearchRadiusDistance": _mySearchRadiusDistance,
        "address": json.encode(updateAddress),
        "subAddress": json.encode(otherUserAddress)
      });
    } else {
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": rID,
        "userName": userName,
        "age": userAge,
        "userOccupation": _myOccupation,
        "dob": userDOB,
        "phoneNumber": userPhoneNumber,
        "email": email,
        "gender": _myGender,
        "isTherapist": "0",
        "userSearchRadiusDistance": _mySearchRadiusDistance,
        "address": json.encode(updateAddress),
        "subAddress": json.encode(otherUserAddress)
      });
    }

    final userDetailsRequest = await request.send();
    final response = await http.Response.fromStream(userDetailsRequest);

    print('Success response code : ${response.statusCode}');
    print('SuccessMessage : ${response.reasonPhrase}');
    print('Response : ${response.body}');

    if (response.statusCode == 200) {
      final Map userDetailsResponse = json.decode(response.body);
      final profileUpdateResponseModel =
          ProfileUpdateResponseModel.fromJson(userDetailsResponse);
      print(profileUpdateResponseModel.status);
      _sharedPreferences.then((value) {
        // value.clear();
        // value.setString('accessToken', profileUpdateResponseModel.accessToken);
        value.setString('did', profileUpdateResponseModel.data.id.toString());
        value.setString('profileImage',
            profileUpdateResponseModel.data.uploadProfileImgUrl);
        value.setString('userName', profileUpdateResponseModel.data.userName);
        value.setString('userPhoneNumber',
            profileUpdateResponseModel.data.phoneNumber.toString());
        value.setString(
            'userEmailAddress', profileUpdateResponseModel.data.email);
        value.setString(
            'userDOB',
            DateFormat("yyyy-MM-dd")
                .format(profileUpdateResponseModel.data.dob)
                .toString()
                .toString());
        value.setString(
            'userAge', profileUpdateResponseModel.data.age.toString());
        value.setString('userGender', profileUpdateResponseModel.data.gender);
        value.setString(
            'userOccupation', profileUpdateResponseModel.data.userOccupation);
        value.setString(
            'userAddress', profileUpdateResponseModel.address.address);
        value.setString(
            'buildingName', profileUpdateResponseModel.address.buildingName);
        value.setString(
            'roomNumber', profileUpdateResponseModel.address.userRoomNumber);
        value.setString('area', profileUpdateResponseModel.address.area);
        value.setString('addressType',
            profileUpdateResponseModel.address.addressTypeSelection);
        value.setString(
            'addressID', profileUpdateResponseModel.address.id.toString());
        value.setString(
            'userID', profileUpdateResponseModel.address.userId.toString());
        value.setString('userPlaceForMassage',
            profileUpdateResponseModel.address.userPlaceForMassage);
        value.setString(
            'cityName', profileUpdateResponseModel.address.cityName);
        value.setString('capitalAndPrefecture',
            profileUpdateResponseModel.address.capitalAndPrefecture);
        /*  for (var userAddressData in profileUpdateResponseModel.subAddress) {
          /*  value.setString(
              'subUserAddress', userAddressData.);*/
        }*/
      });
      updateAddress.clear();
      ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
      DialogHelper.showUserProfileUpdatedSuccessDialog(context);
    } else {
      print('User Edit failed !!');
      ProgressDialogBuilder.hideUserDetailsUpdateProgressDialog(context);
    }
  }

  getUserProfileData() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    try {
      _sharedPreferences.then((value) {
        print('Getting values...EPF');
        // userProfileImage = value.getString('profileImage');

        rUserName = value.getString('userName');
        rUserPhoneNumber = value.getString('userPhoneNumber');
        rEmailAddress = value.getString('userEmailAddress');
        rDob = value.getString('userDOB');
        rUserAge = value.getString('userAge');
        _myGender = value.getString('userGender');
        _myOccupation = value.getString('userOccupation');
        rUserAddress = value.getString('userAddress');
        rUserBuildName = value.getString('buildingName');
        rUserRoomNo = value.getString('roomNumber');
        _myCategoryPlaceForMassage = value.getString('userPlaceForMassage');
        _myCity = value.getString('cityName');
        _myPrefecture = value.getString('capitalAndPrefecture');
        rUserArea = value.getString('area');
        rUserID = value.getString('userID');
        rID = value.getString('did');

        // Convert string url of image to base64 format
        // convertBase64ProfileImage(userProfileImage);

        setState(() {
          /* HealingMatchConstants.userEditUserName = rUserName;
          HealingMatchConstants.userEditPhoneNumber = rUserPhoneNumber;
          HealingMatchConstants.userEditEmailAddress = rEmailAddress;
          HealingMatchConstants.userEditDob = rDob;
          HealingMatchConstants.userEditUserAge = rUserAge;
          HealingMatchConstants.userEditUserAddress = rUserAddress;
          HealingMatchConstants.userEditBuildName = rUserBuildName;
          HealingMatchConstants.userEditRoomNo = rUserRoomNo;
          HealingMatchConstants.userEditArea = rUserArea;
          HealingMatchConstants.userEditToken = raccessToken;
<<<<<<< HEAD
          HealingMatchConstants.userEditId = rUserID;*/
          HealingMatchConstants.userEditToken = value.getString('accessToken');
          userNameController.text = rUserName;
          phoneNumberController.text = rUserPhoneNumber;
          emailController.text = rEmailAddress;
          ageController.text = rUserAge;
          _userDOBController.text = rDob;
          buildingNameController.text = rUserBuildName;
          roomNumberController.text = rUserRoomNo;
          gpsAddressController.text = rUserAddress;
          userAreaController.text = rUserArea;

          /*userNameController.text = HealingMatchConstants.userEditUserName;
=======
          HealingMatchConstants.userEditId = rUserID;

          userNameController.text = HealingMatchConstants.userEditUserName;
>>>>>>> origin/origin/DEV/devYogesh
          phoneNumberController.text =
              HealingMatchConstants.userEditPhoneNumber;
          emailController.text = HealingMatchConstants.userEditEmailAddress;
          ageController.text = HealingMatchConstants.userEditUserAge;
          _userDOBController.text = HealingMatchConstants.userEditDob;
          buildingNameController.text = HealingMatchConstants.userEditBuildName;
          roomNumberController.text = HealingMatchConstants.userEditRoomNo;
          gpsAddressController.text = HealingMatchConstants.userEditUserAddress;
          userAreaController.text = HealingMatchConstants.userEditArea;*/
        });
        print(_myCategoryPlaceForMassage);
        print('Prefectute: $_myPrefecture');
        print('City: $_myCity');
        print('Token: ${HealingMatchConstants.userEditToken}');
        print('Id: $rID');
        print('Address ID : $_userAddressID');

        print('UserId: $rUserID');
        print('UserBuildName: $rUserBuildName');
        print('UserRoomNo: $rUserRoomNo');
      });
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }

  Future<String> networkImageToBase64RightFront(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  getEditUserFields() async {
    _sharedPreferences.then((value) {
      bool isUserVerified = value.getBool('isUserVerified');

      if (isUserVerified != null && isUserVerified) {
        accessToken = value.getString('accessToken');
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        print('User Address Type : $_myAddressInputType');
        print('User Address ID : $_userAddressID');
        if (_myAddressInputType.contains('現在地を取得する')) {
          setState(() {
            _showCurrentLocationInput = true;
          });
        } else if (_myAddressInputType.contains('直接入力する')) {
          setState(() {
            _showCurrentLocationInput = false;
          });
        } else {
          return;
        }
      } else {
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        print('User Address Type : $_myAddressInputType');
        print('User Address ID : $_userAddressID');
        if (_myAddressInputType.contains('現在地を取得する')) {
          setState(() {
            _showCurrentLocationInput = true;
          });
        } else if (_myAddressInputType.contains('直接入力する')) {
          setState(() {
            _showCurrentLocationInput = false;
          });
        } else {
          print('No addresstype mentioned');
        }
        print('Entering address fields....');

        //! Need to add to otherAddressList Value Here from Login/Register

      }
    });
    // updateAddress.add(addUpdateAddress);
  }
}

class AddAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final Geolocator addAddressgeoLocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _addAddressPosition;
  String _addedAddress = '';
  String _myAddedAddressInputType = '';
  String _myAddedPrefecture = '';
  String _myAddedCity = '';
  Placemark userGPSAddressPlaceMark;
  Placemark userManualAddressPlaceMark;
  final _addedAddressTypeKey = new GlobalKey<FormState>();
  final _addedPrefectureKey = new GlobalKey<FormState>();
  final _addedCityKey = new GlobalKey<FormState>();
  final additionalAddressController = new TextEditingController();
  final addedBuildingNameController = new TextEditingController();
  final addedUserAreaController = new TextEditingController();
  final addedRoomNumberController = new TextEditingController();
  List<dynamic> addedAddressStateDropDownValues = List();
  List<dynamic> addedAddressCityDropDownValues = List();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AddUserSubAddress addUserAddress;

  StatesListResponseModel states;
  CitiesListResponseModel cities;
  var _addedAddressPrefId;
  bool _isAddedGPSLocation = false;
  bool _showRequiredFields = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: new AnimatedContainer(
            // Define how long the animation should take.
            duration: Duration(seconds: 3),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.bounceIn,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(16.0),
              color: Colors.grey[300],
              boxShadow: [
                new BoxShadow(
                    color: Colors.lime,
                    blurRadius: 3.0,
                    offset: new Offset(1.0, 1.0))
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Text(
                            '住所を追加する',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'NotoSansJP'),
                          ),
                        ),
                        SizedBox(height: 10),
                        Form(
                          key: _addedAddressTypeKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: DropDownFormField(
                                  hintText: '検索地点の登録',
                                  value: _myAddedAddressInputType,
                                  onSaved: (value) {
                                    setState(() {
                                      _myAddedAddressInputType = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myAddedAddressInputType = value;
                                      if (_myAddedAddressInputType != null &&
                                          _myAddedAddressInputType
                                              .contains('現在地を取得する')) {
                                        additionalAddressController.clear();
                                        addedBuildingNameController.clear();
                                        addedRoomNumberController.clear();
                                        _isAddedGPSLocation = true;
                                        // _additionalAddressCurrentLocation();
                                      } else if (_myAddedAddressInputType !=
                                              null &&
                                          _myAddedAddressInputType
                                              .contains('直接入力する')) {
                                        _isAddedGPSLocation = false;
                                        addedAddressCityDropDownValues.clear();
                                        addedAddressStateDropDownValues.clear();
                                        addedBuildingNameController.clear();
                                        addedRoomNumberController.clear();
                                        _myAddedPrefecture = '';
                                        _myAddedCity = '';
                                        _getAddedAddressStates();
                                      }
                                      print(
                                          'Added Address type : ${_myAddedAddressInputType.toString()}');
                                    });
                                  },
                                  dataSource: [
                                    {
                                      "showDisplay": "現在地を取得する",
                                      "value": "現在地を取得する",
                                    },
                                    {
                                      "showDisplay": "直接入力する",
                                      "value": "直接入力する",
                                    },
                                  ],
                                  textField: 'showDisplay',
                                  valueField: 'value',
                                ),
                              ),
                              _myAddedAddressInputType.contains('現在地を取得する')
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Visibility(
                                          visible: _isAddedGPSLocation,
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: TextFormField(
                                              controller:
                                                  additionalAddressController,
                                              decoration: new InputDecoration(
                                                filled: true,
                                                fillColor: ColorConstants
                                                    .formFieldFillColor,
                                                hintText: '現在地を取得する',
                                                /*hintText: '現在地を取得する *',
                                        hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        ),*/
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.location_on,
                                                      size: 28),
                                                  onPressed: () {
                                                    _additionalAddressCurrentLocation();
                                                  },
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 14),
                                                focusColor: Colors.grey[100],
                                                border: HealingMatchConstants
                                                    .textFormInputBorder,
                                                focusedBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                disabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                                enabledBorder:
                                                    HealingMatchConstants
                                                        .textFormInputBorder,
                                              ),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              // validator: (value) => _validateEmail(value),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  // height: MediaQuery.of(context).size.height * 0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.39,
                                                  child: TextFormField(
                                                    //enableInteractiveSelection: false,
                                                    // keyboardType: TextInputType.number,
                                                    autofocus: false,
                                                    controller:
                                                        addedBuildingNameController,
                                                    decoration:
                                                        new InputDecoration(
                                                      filled: true,
                                                      fillColor: ColorConstants
                                                          .formFieldFillColor,
                                                      labelText: '建物名',
                                                      /*hintText: 'ビル名 *',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                ),*/
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontFamily: 'NotoSansJP',
                                                          fontSize: 14),
                                                      focusColor:
                                                          Colors.grey[100],
                                                      border: HealingMatchConstants
                                                          .textFormInputBorder,
                                                      focusedBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      disabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                      enabledBorder:
                                                          HealingMatchConstants
                                                              .textFormInputBorder,
                                                    ),
                                                    // validator: (value) => _validateEmail(value),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    // height: MediaQuery.of(context).size.height * 0.07,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                    child: TextFormField(
                                                      //enableInteractiveSelection: false,
                                                      autofocus: false,
                                                      maxLength: 4,
                                                      controller:
                                                          addedRoomNumberController,
                                                      decoration:
                                                          new InputDecoration(
                                                        counterText: '',
                                                        filled: true,
                                                        fillColor: ColorConstants
                                                            .formFieldFillColor,
                                                        labelText: '部屋番号',
                                                        /*hintText: '都、県選 *',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),*/
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontFamily:
                                                                'NotoSansJP',
                                                            fontSize: 14),
                                                        focusColor:
                                                            Colors.grey[100],
                                                        border: HealingMatchConstants
                                                            .textFormInputBorder,
                                                        focusedBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                        disabledBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                        enabledBorder:
                                                            HealingMatchConstants
                                                                .textFormInputBorder,
                                                      ),
                                                      // validator: (value) => _validateEmail(value),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : _myAddedAddressInputType.contains('直接入力する')
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 10),
                                            Visibility(
                                              visible: _isAddedGPSLocation,
                                              child: Container(
                                                // height: MediaQuery.of(context).size.height * 0.07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                child: TextFormField(
                                                  controller:
                                                      additionalAddressController,
                                                  decoration:
                                                      new InputDecoration(
                                                    filled: true,
                                                    fillColor: ColorConstants
                                                        .formFieldFillColor,
                                                    hintText: '現在地を取得する',
                                                    /*hintText: '現在地を取得する *',
                                        hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        ),*/
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          Icons.location_on,
                                                          size: 28),
                                                      onPressed: () {
                                                        _additionalAddressCurrentLocation();
                                                      },
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 14),
                                                    focusColor:
                                                        Colors.grey[100],
                                                    border: HealingMatchConstants
                                                        .textFormInputBorder,
                                                    focusedBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    disabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                    enabledBorder:
                                                        HealingMatchConstants
                                                            .textFormInputBorder,
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  // validator: (value) => _validateEmail(value),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Form(
                                                key: _addedPrefectureKey,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Center(
                                                          child:
                                                              addedAddressStateDropDownValues !=
                                                                      null
                                                                  ? Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '府県',
                                                                          value: _myAddedPrefecture,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                            });
                                                                          },
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                              print('Prefecture value : ${_myAddedPrefecture.toString()}');
                                                                              _addedAddressPrefId = addedAddressStateDropDownValues.indexOf(value) + 1;
                                                                              print('prefID : ${_addedAddressPrefId.toString()}');
                                                                              addedAddressCityDropDownValues.clear();
                                                                              _myAddedCity = '';
                                                                              _getAddedAddressCities(_addedAddressPrefId);
                                                                            });
                                                                          },
                                                                          dataSource: addedAddressStateDropDownValues,
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )
                                                                  : Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '府県',
                                                                          value: _myAddedPrefecture,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedPrefecture = value;
                                                                            });
                                                                          },
                                                                          dataSource: [],
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )),
                                                    ),
                                                    SizedBox(width: 3),
                                                    Expanded(
                                                      child: Form(
                                                          key: _addedCityKey,
                                                          child:
                                                              addedAddressCityDropDownValues !=
                                                                      null
                                                                  ? Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '市',
                                                                          value: _myAddedCity,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                            });
                                                                          },
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                              //print(_myBldGrp.toString());
                                                                            });
                                                                          },
                                                                          dataSource: addedAddressCityDropDownValues,
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )
                                                                  : Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.39,
                                                                      child: DropDownFormField(
                                                                          hintText: '市',
                                                                          value: _myAddedCity,
                                                                          onSaved: (value) {
                                                                            setState(() {
                                                                              _myAddedCity = value;
                                                                            });
                                                                          },
                                                                          dataSource: [],
                                                                          isList: true,
                                                                          textField: 'display',
                                                                          valueField: 'value'),
                                                                    )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        // height: MediaQuery.of(context).size.height * 0.07,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                        child: TextFormField(
                                                          //enableInteractiveSelection: false,
                                                          autofocus: false,
                                                          controller:
                                                              addedUserAreaController,
                                                          decoration:
                                                              new InputDecoration(
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .formFieldFillColor,
                                                            labelText: '丁目, 番地',
                                                            /*hintText: '都、県選 *',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),*/
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    'NotoSansJP',
                                                                fontSize: 14),
                                                            focusColor: Colors
                                                                .grey[100],
                                                            border: HealingMatchConstants
                                                                .textFormInputBorder,
                                                            focusedBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            disabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            enabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                          ),
                                                          // validator: (value) => _validateEmail(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // height: MediaQuery.of(context).size.height * 0.07,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.39,
                                                      child: TextFormField(
                                                        //enableInteractiveSelection: false,
                                                        // keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        controller:
                                                            addedBuildingNameController,
                                                        decoration:
                                                            new InputDecoration(
                                                          filled: true,
                                                          fillColor: ColorConstants
                                                              .formFieldFillColor,
                                                          labelText: '建物名',
                                                          /*hintText: 'ビル名 *',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                ),*/
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[400],
                                                              fontFamily:
                                                                  'NotoSansJP',
                                                              fontSize: 14),
                                                          focusColor:
                                                              Colors.grey[100],
                                                          border: HealingMatchConstants
                                                              .textFormInputBorder,
                                                          focusedBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                          disabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                          enabledBorder:
                                                              HealingMatchConstants
                                                                  .textFormInputBorder,
                                                        ),
                                                        // validator: (value) => _validateEmail(value),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        // height: MediaQuery.of(context).size.height * 0.07,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.39,
                                                        child: TextFormField(
                                                          //enableInteractiveSelection: false,
                                                          autofocus: false,
                                                          maxLength: 4,
                                                          controller:
                                                              addedRoomNumberController,
                                                          decoration:
                                                              new InputDecoration(
                                                            counterText: '',
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .formFieldFillColor,
                                                            labelText: '部屋番号',
                                                            labelStyle: TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    'NotoSansJP',
                                                                fontSize: 14),
                                                            focusColor: Colors
                                                                .grey[100],
                                                            border: HealingMatchConstants
                                                                .textFormInputBorder,
                                                            focusedBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            disabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                            enabledBorder:
                                                                HealingMatchConstants
                                                                    .textFormInputBorder,
                                                          ),
                                                          // validator: (value) => _validateEmail(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              _addUserAddress();
                            },
                            child: new Text(
                              '追加',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
              // child:
            )),
      ),
    );
  }

  // Get current address from Latitude Longitude
  _additionalAddressCurrentLocation() {
    ProgressDialogBuilder.showLocationProgressDialog(context);
    addAddressgeoLocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _addAddressPosition = position;
      });
      _getAdditionalAddressLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAdditionalAddressLatLng() async {
    try {
      List<Placemark> p = await addAddressgeoLocator.placemarkFromCoordinates(
          _addAddressPosition.latitude, _addAddressPosition.longitude);

      userGPSAddressPlaceMark = p[0];

      HealingMatchConstants.addedCurrentLatitude = _addAddressPosition.latitude;
      HealingMatchConstants.addedCurrentLongitude =
          _addAddressPosition.longitude;

      setState(() {
        _addedAddress =
            '${userGPSAddressPlaceMark.locality},${userGPSAddressPlaceMark.subAdministrativeArea},'
            '${userGPSAddressPlaceMark.administrativeArea},${userGPSAddressPlaceMark.postalCode}'
            ',${userGPSAddressPlaceMark.country}';
        if (_addedAddress != null && _addedAddress.isNotEmpty) {
          print(
              'Additional address GPS location : $_addedAddress : ${HealingMatchConstants.addedCurrentLatitude} && '
              '${HealingMatchConstants.addedCurrentLongitude}');
          additionalAddressController.value =
              TextEditingValue(text: _addedAddress);
          setState(() {
            _isAddedGPSLocation = true;
          });
          HealingMatchConstants.addedServiceUserCity =
              userGPSAddressPlaceMark.locality;
          HealingMatchConstants.addedServiceUserPrefecture =
              userGPSAddressPlaceMark.administrativeArea;
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

  _getAddedAddressStates() async {
    await http.get(HealingMatchConstants.STATE_PROVIDER_URL).then((response) {
      states = StatesListResponseModel.fromJson(json.decode(response.body));
      print(states.toJson());
      for (var stateList in states.data) {
        setState(() {
          addedAddressStateDropDownValues.add(stateList.prefectureJa);
        });
      }
    });
  }

  // CityList cityResponse;
  _getAddedAddressCities(var prefId) async {
    ProgressDialogBuilder.showGetCitiesProgressDialog(context);
    await http.post(HealingMatchConstants.CITY_PROVIDER_URL,
        body: {'prefecture_id': prefId.toString()}).then((response) {
      cities = CitiesListResponseModel.fromJson(json.decode(response.body));
      print(cities.toJson());
      for (var cityList in cities.data) {
        setState(() {
          addedAddressCityDropDownValues
              .add(cityList.cityJa + cityList.specialDistrictJa);
        });
      }
      ProgressDialogBuilder.hideGetCitiesProgressDialog(context);
      print('Response City list : ${response.body}');
    });
  }

  _addUserAddress() async {
    if (_myAddedAddressInputType.isNotEmpty &&
        _myAddedAddressInputType.contains('現在地を取得する')) {
      if (addedRoomNumberController.text.isEmpty ||
          addedBuildingNameController.text.isEmpty) {
        print('Room number empty');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('必須値を入力してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontFamily: 'NotoSansJP')),
              ),
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                },
                child: Text('はい',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ));
        return;
      } else {
        String gpsUserAddress =
            '${addedRoomNumberController.text.toString()},${addedBuildingNameController.text.toString() + ',' + _addedAddress}';
        print('GPS FINAL ADDRESS : $gpsUserAddress');

        if (otherUserAddress.length <= 2) {
          setState(() {
            print('Entering if...');
            addUserAddress = AddUserSubAddress(
              gpsUserAddress,
              HealingMatchConstants.addedCurrentLatitude.toString(),
              HealingMatchConstants.addedCurrentLongitude.toString(),
              _myAddedAddressInputType,
              userGPSAddressPlaceMark.administrativeArea,
              userGPSAddressPlaceMark.subAdministrativeArea,
              addedRoomNumberController.text.toString(),
              addedBuildingNameController.text.toString(),
              userGPSAddressPlaceMark.locality,
            );

            Navigator.pop(context);
            /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UpdateServiceUserDetails()));*/
          });
        } else {
//メインの地点以外に3箇所まで地点登録ができます
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('メインの地点以外に3箇所まで地点登録ができます。',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontFamily: 'NotoSansJP')),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateServiceUserDetails()));*/
                    Navigator.pop(context);
                  },
                  child: Text('はい',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ));
          return;
        }
      }
    } else if (_myAddedAddressInputType.isNotEmpty &&
        _myAddedAddressInputType.contains('直接入力する')) {
      if (addedRoomNumberController.text.isEmpty ||
          addedBuildingNameController.text.isEmpty ||
          addedUserAreaController.text.isEmpty ||
          _myAddedCity.isEmpty ||
          _myAddedPrefecture.isEmpty) {
        print('Manual address empty fields');
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: ColorConstants.snackBarColor,
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('必須値を入力してください。',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontFamily: 'NotoSansJP')),
              ),
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                },
                child: Text('はい',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ));
        return;
      } else {
        String manualAddedAddress = addedRoomNumberController.text.toString() +
            ',' +
            addedBuildingNameController.text.toString() +
            ',' +
            addedUserAreaController.text.toString() +
            ',' +
            _myAddedCity +
            ',' +
            _myAddedPrefecture;
        print('USER MANUAL ADDRESS : $manualAddedAddress');
        List<Placemark> userManualAddress =
            await addAddressgeoLocator.placemarkFromAddress(manualAddedAddress);
        userManualAddressPlaceMark = userManualAddress[0];
        Position addressPosition = userManualAddressPlaceMark.position;
        HealingMatchConstants.manualAddressCurrentLatitude =
            addressPosition.latitude;
        HealingMatchConstants.manualAddressCurrentLongitude =
            addressPosition.longitude;
        HealingMatchConstants.serviceUserCity =
            userManualAddressPlaceMark.locality;
        HealingMatchConstants.serviceUserPrefecture =
            userManualAddressPlaceMark.administrativeArea;
        HealingMatchConstants.manualUserAddress = manualAddedAddress;

        print(
            'Manual Address lat lon : ${HealingMatchConstants.manualAddressCurrentLatitude} && '
            '${HealingMatchConstants.manualAddressCurrentLongitude}');
        print('Manual Place Json : ${userManualAddressPlaceMark.toJson()}');
        print('Manual Address : ${HealingMatchConstants.manualUserAddress}');

        if (otherUserAddress.length <= 2) {
          String city = _myAddedCity;
          setState(() {
            addUserAddress = AddUserSubAddress(
              manualAddedAddress,
              HealingMatchConstants.manualAddressCurrentLatitude.toString(),
              HealingMatchConstants.manualAddressCurrentLongitude.toString(),
              _myAddedAddressInputType,
              _myAddedCity,
              _myAddedPrefecture,
              addedRoomNumberController.text.toString(),
              addedBuildingNameController.text.toString(),
              addedUserAreaController.text.toString(),
            );
            print(_myAddedAddressInputType);
            Navigator.pop(context);
            /*   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UpdateServiceUserDetails()));*/
          });
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('メインの地点以外に3箇所まで地点登録ができます。',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontFamily: 'NotoSansJP')),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    Navigator.pop(context);
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateServiceUserDetails()));*/
                  },
                  child: Text('はい',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ));
          return;
        }
      }
    } else {
      print('Address Type is Empty....');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('検索地点の登録を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return;
    }

    otherUserAddress.add(addUserAddress);
    _sharedPreferences.then((value) {
      value.setBool('isUserVerified', false);
    });
  }
}
