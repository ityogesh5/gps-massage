import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
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
List<UpdateAddress> updateAddress = new List<UpdateAddress>();
List<AddUserSubAddress> constantUserAddressValuesList =
    new List<AddUserSubAddress>();

class UpdateServiceUserDetails extends StatefulWidget {
  String userProfileImage;

  UpdateServiceUserDetails({Key key, @required this.userProfileImage})
      : super(key: key);

  @override
  _UpdateServiceUserDetailsState createState() =>
      _UpdateServiceUserDetailsState();
}

class _UpdateServiceUserDetailsState extends State<UpdateServiceUserDetails> {
  UpdateAddress addUpdateAddress;

  //var constantUserAddressValuesList = new List<AddUserSubAddress>();

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
  String rOtherOption = '';

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
  TextEditingController _editAddressController = new TextEditingController();

  String _selectedDOBDate = 'Tap to select date';
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  final Geolocator addAddressgeoLocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _currentPosition;
  Position _addAddressPosition;
  String _currentAddress = '';
  String _addedAddress = '';
  int age = 0;
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
  bool readonly = false;
  final picker = ImagePicker();
  Placemark currentLocationPlaceMark;
  Placemark userAddedAddressPlaceMark;

  bool visible = false;
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
  final otherController = new TextEditingController();
  final userAreaController = new TextEditingController();
  final gpsAddressController = new TextEditingController();
  final roomNumberController = new TextEditingController();

  final additionalAddressController = new TextEditingController();
  DateTime selectedDate = DateTime.now();

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
  int id = 0;
  bool img = false;

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
      DateTime currentDate = DateTime.now();
      age = currentDate.year - selectedDate.year;
      int month1 = currentDate.month;
      int month2 = selectedDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = selectedDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      _ageOfUser = age.toString();
      //print('Age : $ageOfUser');
      ageController.value = TextEditingValue(text: _ageOfUser);
      FocusScope.of(context).requestFocus(new FocusNode());
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
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
                        _profileImage != null
                            ? InkWell(
                                onTap: () {
                                  _showPicker(context, 0);
                                },
                                child: Container(
                                    width: 95.0,
                                    height: 95.0,
                                    decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: new FileImage(_profileImage)),
                                    )),
                              )
                            : InkWell(
                                onTap: () {
                                  _showPicker(context, 0);
                                },
                                child: widget.userProfileImage != null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.userProfileImage,
                                        filterQuality: FilterQuality.high,
                                        fadeInCurve: Curves.easeInSine,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 95.0,
                                          height: 95.0,
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
                                          width: 95.0,
                                          height: 95.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black12),
                                            image: DecorationImage(
                                                image: new AssetImage(
                                                    'assets/images_gps/placeholder_image.png'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 95.0,
                                        height: 95.0,
                                        decoration: new BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: new AssetImage(
                                                  'assets/images_gps/placeholder_image.png')),
                                        )),
                              ),
                        Visibility(
                          visible: true,
                          child: Positioned(
                            right: -70.0,
                            top: 65,
                            left: 10.0,
                            child: InkWell(
                              onTap: () {
                                _showPicker(context, 0);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[500],
                                radius: 13,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  radius: 12,
                                  child: Icon(Icons.edit,
                                      color: Colors.grey[400], size: 20.0),
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
                        enabled: false,
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
                    Column(
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
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: DropDownFormField(
                                    hintText: '登録する地点のカテゴリー ',
                                    value: _myCategoryPlaceForMassage,
                                    onSaved: (value) {
                                      setState(() {
                                        _myCategoryPlaceForMassage = value;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "その他（直接入力）") {
                                          setState(() {
                                            _myCategoryPlaceForMassage = value;
                                            visible = true; // !visible;
                                          });
                                        } else {
                                          setState(() {
                                            _myCategoryPlaceForMassage = value;
                                            visible = false;
                                          });
                                        }
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
                        SizedBox(
                          height: 15,
                        ),
                        _myCategoryPlaceForMassage == "その他（直接入力）"
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextFormField(
                                  controller: otherController,
                                  style: HealingMatchConstants.formTextStyle,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding:
                                        EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    border: HealingMatchConstants
                                        .textFormInputBorder,
                                    focusedBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    disabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    enabledBorder: HealingMatchConstants
                                        .textFormInputBorder,
                                    filled: true,
                                    labelText: '登録する地点のカテゴリー (直接入力)',
                                    labelStyle: HealingMatchConstants
                                        .formLabelTextStyle,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Form(
                            key: _perfectureKey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                      child: stateDropDownValues != null
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.39,
                                              child: DropDownFormField(
                                                  hintText: '府県',
                                                  value: _myPrefecture,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      _myPrefecture = value;
                                                    });
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _myPrefecture = value;
                                                      print(
                                                          'Prefecture value : ${_myPrefecture.toString()}');
                                                      _prefId =
                                                          stateDropDownValues
                                                                  .indexOf(
                                                                      value) +
                                                              1;
                                                      print(
                                                          'prefID : ${_prefId.toString()}');
                                                      cityDropDownValues
                                                          .clear();
                                                      _myCity = '';
                                                      _getCities(_prefId);
                                                    });
                                                  },
                                                  dataSource:
                                                      stateDropDownValues,
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
                                                  value: _myPrefecture,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      _myPrefecture = value;
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
                                              width: MediaQuery.of(context)
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.39,
                                              child: DropDownFormField(
                                                  hintText: '市 *',
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
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.39,
                                    child: TextFormField(
                                      //enableInteractiveSelection: false,
                                      autofocus: false,
                                      controller: userAreaController,
                                      decoration: new InputDecoration(
                                        filled: true,
                                        fillColor:
                                            ColorConstants.formFieldFillColor,
                                        labelText: '丁目, 番地',
                                        /*hintText: '都、県選 *',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),*/
                                        labelStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: 'NotoSansJP',
                                            fontSize: 14),
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
                                      // validator: (value) => _validateEmail(value),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  // height: MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.39,
                                  child: TextFormField(
                                    //enableInteractiveSelection: false,
                                    // keyboardType: TextInputType.number,
                                    autofocus: false,
                                    controller: buildingNameController,
                                    decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      labelText: '建物名',
                                      /*hintText: 'ビル名 *',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),*/
                                      labelStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontFamily: 'NotoSansJP',
                                          fontSize: 14),
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
                                    // validator: (value) => _validateEmail(value),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width *
                                        0.39,
                                    child: TextFormField(
                                      //enableInteractiveSelection: false,
                                      autofocus: false,
                                      controller: roomNumberController,
                                      decoration: new InputDecoration(
                                        filled: true,
                                        fillColor:
                                            ColorConstants.formFieldFillColor,
                                        labelText: '部屋番号',
                                        labelStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: 'NotoSansJP',
                                            fontSize: 14),
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
                    ),

                    SizedBox(height: 15),

                    constantUserAddressValuesList != null
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
                                    if (constantUserAddressValuesList.length ==
                                        3) {
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
                                                      fontFamily:
                                                          'NotoSansJP')),
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
                                              context, refreshPage);
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
                                        .switchToUserAddAddressScreen(
                                            context, refreshPage);
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

                    constantUserAddressValuesList != null
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 12.0),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      constantUserAddressValuesList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        FittedBox(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.86,
                                                child: TextFormField(
                                                  //display the address
                                                  readOnly: true,
                                                  autofocus: false,
                                                  initialValue:
                                                      constantUserAddressValuesList[
                                                              index]
                                                          .subAddress,
                                                  decoration:
                                                      new InputDecoration(
                                                          filled: true,
                                                          fillColor: ColorConstants
                                                              .formFieldFillColor,
                                                          hintText:
                                                              '${constantUserAddressValuesList[index]}',
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[400],
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
                                                          prefixIcon: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                        Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                      ]),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                            .grey[
                                                                        100],
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0),
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                ),
                                                                child: Text(
                                                                  '${constantUserAddressValuesList[index].addressCategory}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                  ),
                                                                )),
                                                          ),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_sharp,
                                                                size: 30,
                                                                color: Colors
                                                                    .black),
                                                            onPressed: () {
                                                              //Delete Value at index
                                                              /*constantUserAddressValuesList
                                                                .removeAt(index);*/
                                                              var position =
                                                                  constantUserAddressValuesList[
                                                                      index];
                                                              print(
                                                                  'Position of other address : $position');
                                                              openAddressEditDialog(
                                                                  constantUserAddressValuesList[
                                                                          index]
                                                                      .subAddress,
                                                                  constantUserAddressValuesList
                                                                      .indexOf(
                                                                          position));
                                                            },
                                                          )),
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      constantUserAddressValuesList[
                                                              index]
                                                          .subAddress = value;
                                                    });
                                                  },
                                                  // validator: (value) => _validateEmail(value),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  }),
                            ),
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
                                    {
                                      "display": "２５Ｋｍ圏内",
                                      "value": "25.0",
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

  // Edit address dialog
  void openAddressEditDialog(String subAddress, var position) {
    _editAddressController.text = subAddress;
    bool isDelete = false;
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              '住所の編集',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                controller: _editAddressController,
                //initialValue: subAddress,
                autofocus: false,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: '新しい住所を入力してください。',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _editAddressController.clear();
                      isDelete = true;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedButton(
                text: 'Ok',
                pressEvent: () {
                  if (_editAddressController.text != null &&
                      _editAddressController.text.isNotEmpty &&
                      isDelete == false) {
                    constantUserAddressValuesList[position].subAddress =
                        _editAddressController.text.toString();
                    dialog.dissmiss();
                    NavigationRouter.switchToServiceUserEditProfileScreen(
                        context, widget.userProfileImage);
                    //print('Edit address value : ${_editAddressController.text.toString()} && ${constantUserAddressValuesList[position].subAddress}');
                  } else {
                    dialog.dissmiss();
                  }
                })
          ],
        ),
      ),
    )..show();
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

  _imgFromGallery(int index) async {
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
    if ((_myPrefecture == null || _myPrefecture.isEmpty)) {
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
    if ((_myCity == null || _myCity.isEmpty)) {
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
    if ((userArea == null || userArea.isEmpty)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な丁目と番地を入力してください。',
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

    // room number validation
    if (roomNumber == null || roomNumber.isEmpty) {
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

    // user city validation
    if (_myCity != null || _myCity.isNotEmpty) {
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
    if (userArea != null || userArea.isNotEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('丁目と番地を入力してください。',
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
    // Getting user GPS Address value
    if (_myAddressInputType.contains('現在地を取得する') && _isGPSLocation) {
      print('GPS Address : $userGPSAddress');
      String userCurrentLocation =
          roomNumber + ',' + buildingName + ',' + userGPSAddress;
      print('GPS Modified Address : ${userCurrentLocation.trim()}');
    } else if (HealingMatchConstants.userEditAddress.isEmpty) {
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
          address: HealingMatchConstants.userEditAddress,
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

    print('Id: $rID');
    print('Id: ${HealingMatchConstants.userEditAddress}');
    print('Address ID : $_userAddressID');

    print('UserId: $rUserID');

    print("json Converted:" + json.encode(constantUserAddressValuesList));
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
        "subAddress": json.encode(constantUserAddressValuesList)
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
        "subAddress": json.encode(constantUserAddressValuesList)
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
        print("address: ${profileUpdateResponseModel.address.address}");
        // print("searchRadius: ${profileUpdateResponseModel.address.address}");
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
        rOtherOption = value.getString('otherOption');
        _myCity = value.getString('cityName');
        _myPrefecture = value.getString('capitalAndPrefecture');

        rUserArea = value.getString('area');
        rUserID = value.getString('userID');
        rID = value.getString('did');

        // Convert string url of image to base64 format
        // convertBase64ProfileImage(userProfileImage);

        setState(() {
          HealingMatchConstants.userEditToken = value.getString('accessToken');
          userNameController.text = rUserName;
          phoneNumberController.text = rUserPhoneNumber;
          emailController.text = rEmailAddress;
          ageController.text = rUserAge;
          _userDOBController.text = rDob;
          buildingNameController.text = rUserBuildName;
          roomNumberController.text = rUserRoomNo;
          gpsAddressController.text = rUserAddress;
          otherController.text = rOtherOption;
          userAreaController.text = rUserArea;

          var addressData = value.getString('addressData');
          var addressValues = jsonDecode(addressData) as List;
          constantUserAddressValuesList = addressValues
              .map((address) => AddUserSubAddress.fromJson(address))
              .toList();
          print(
              'Address List data : ${constantUserAddressValuesList.length} && ${constantUserAddressValuesList.toString()}');
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

  getEditUserFields() async {
    _sharedPreferences.then((value) {
      bool isUserVerified = value.getBool('isUserVerified');

      if (isUserVerified != null && isUserVerified) {
        accessToken = value.getString('accessToken');
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        print('User Address Type : $_myAddressInputType');
        print('User Address ID : $_userAddressID');
        /*     if (_myAddressInputType.contains('現在地を取得する')) {
          setState(() {
            _showCurrentLocationInput = true;
          });
        } else if (_myAddressInputType.contains('直接入力する')) {
          setState(() {
            _showCurrentLocationInput = false;
          });
        } else {
          return;
        }*/
      } else {
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        print('User Address Type : $_myAddressInputType');
        print('User Address ID : $_userAddressID');
        /*if (_myAddressInputType.contains('現在地を取得する')) {
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
*/
        //! Need to add to otherAddressList Value Here from Login/Register

      }
    });
    // updateAddress.add(addUpdateAddress);
  }

  refreshPage() {
    setState(() {});
  }
}

class AddAddress extends StatefulWidget {
  final callBack;

  AddAddress(this.callBack);

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
  String _myCategoryPlaceForMassage = '';
  Placemark userGPSAddressPlaceMark;
  Placemark userManualAddressPlaceMark;
  final _addedAddressTypeKey = new GlobalKey<FormState>();
  final _addedPrefectureKey = new GlobalKey<FormState>();
  final _placeOfAddressKey = new GlobalKey<FormState>();
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
  bool visible = false;
  final otherController = new TextEditingController();
  double containerHeight = 48.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddedAddressStates();
  }

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
                              /*  Container(
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
                              ),*/

                              Form(
                                key: _placeOfAddressKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: DropDownFormField(
                                          hintText: '登録する地点のカテゴリー *',
                                          value: _myCategoryPlaceForMassage,
                                          onSaved: (value) {
                                            setState(() {
                                              _myCategoryPlaceForMassage =
                                                  value;
                                            });
                                          },
                                          onChanged: (value) {
                                            if (value == "その他（直接入力）") {
                                              setState(() {
                                                _myCategoryPlaceForMassage =
                                                    value;
                                                visible = true; // !visible;
                                              });
                                            } else {
                                              setState(() {
                                                _myCategoryPlaceForMassage =
                                                    value;
                                                visible = false;
                                              });
                                            }
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
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: visible,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: containerHeight,
                                  child: TextFormField(
                                    controller: otherController,
                                    style: HealingMatchConstants.formTextStyle,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(6, 3, 6, 3),
                                      border: HealingMatchConstants
                                          .textFormInputBorder,
                                      focusedBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      disabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      enabledBorder: HealingMatchConstants
                                          .textFormInputBorder,
                                      filled: true,
                                      /* labelText: HealingMatchConstants
                                          .loginPhoneNumber,
                                      labelStyle: HealingMatchConstants
                                          .formLabelTextStyle,*/
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Form(
                                      key: _addedPrefectureKey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                                child:
                                                    addedAddressStateDropDownValues !=
                                                            null
                                                        ? Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                DropDownFormField(
                                                                    hintText:
                                                                        '府県',
                                                                    value:
                                                                        _myAddedPrefecture,
                                                                    onSaved:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedPrefecture =
                                                                            value;
                                                                      });
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedPrefecture =
                                                                            value;
                                                                        print(
                                                                            'Prefecture value : ${_myAddedPrefecture.toString()}');
                                                                        _addedAddressPrefId =
                                                                            addedAddressStateDropDownValues.indexOf(value) +
                                                                                1;
                                                                        print(
                                                                            'prefID : ${_addedAddressPrefId.toString()}');
                                                                        addedAddressCityDropDownValues
                                                                            .clear();
                                                                        _myAddedCity =
                                                                            '';
                                                                        _getAddedAddressCities(
                                                                            _addedAddressPrefId);
                                                                      });
                                                                    },
                                                                    dataSource:
                                                                        addedAddressStateDropDownValues,
                                                                    isList:
                                                                        true,
                                                                    textField:
                                                                        'display',
                                                                    valueField:
                                                                        'value'),
                                                          )
                                                        : Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                DropDownFormField(
                                                                    hintText:
                                                                        '府県',
                                                                    value:
                                                                        _myAddedPrefecture,
                                                                    onSaved:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedPrefecture =
                                                                            value;
                                                                      });
                                                                    },
                                                                    dataSource: [],
                                                                    isList:
                                                                        true,
                                                                    textField:
                                                                        'display',
                                                                    valueField:
                                                                        'value'),
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
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                DropDownFormField(
                                                                    hintText:
                                                                        '市',
                                                                    value:
                                                                        _myAddedCity,
                                                                    onSaved:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedCity =
                                                                            value;
                                                                      });
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedCity =
                                                                            value;
                                                                        //print(_myBldGrp.toString());
                                                                      });
                                                                    },
                                                                    dataSource:
                                                                        addedAddressCityDropDownValues,
                                                                    isList:
                                                                        true,
                                                                    textField:
                                                                        'display',
                                                                    valueField:
                                                                        'value'),
                                                          )
                                                        : Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                DropDownFormField(
                                                                    hintText:
                                                                        '市',
                                                                    value:
                                                                        _myAddedCity,
                                                                    onSaved:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _myAddedCity =
                                                                            value;
                                                                      });
                                                                    },
                                                                    dataSource: [],
                                                                    isList:
                                                                        true,
                                                                    textField:
                                                                        'display',
                                                                    valueField:
                                                                        'value'),
                                                          )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
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
                                              height: containerHeight,
                                              child: TextFormField(
                                                //enableInteractiveSelection: false,
                                                autofocus: false,
                                                controller:
                                                    addedUserAreaController,
                                                decoration: new InputDecoration(
                                                  filled: true,
                                                  fillColor: ColorConstants
                                                      .formFieldFillColor,
                                                  labelText: '丁目, 番地',
                                                  /*hintText: '都、県選 *',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),*/
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
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            height: containerHeight,
                                            child: TextFormField(
                                              //enableInteractiveSelection: false,
                                              // keyboardType: TextInputType.number,
                                              autofocus: false,
                                              controller:
                                                  addedBuildingNameController,
                                              decoration: new InputDecoration(
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                              // height: MediaQuery.of(context).size.height * 0.07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.39,
                                              height: containerHeight,
                                              child: TextFormField(
                                                //enableInteractiveSelection: false,
                                                autofocus: false,
                                                maxLength: 4,
                                                controller:
                                                    addedRoomNumberController,
                                                decoration: new InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  fillColor: ColorConstants
                                                      .formFieldFillColor,
                                                  labelText: '部屋番号',
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
                                ],
                              ),
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
    ProgressDialogBuilder.showAddAddressProgressDialog(context);

    if (addedRoomNumberController.text.isEmpty ||
        _myCategoryPlaceForMassage.isEmpty ||
        addedBuildingNameController.text.isEmpty ||
        addedUserAreaController.text.isEmpty ||
        _myAddedCity.isEmpty ||
        _myAddedPrefecture.isEmpty) {
      ProgressDialogBuilder.hideAddAddressProgressDialog(context);
      print('Manual address empty fields');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('全ての項目を入力してください。',
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

      if (constantUserAddressValuesList.length <= 2) {
        String city = _myAddedCity;
        setState(() {
          addUserAddress = AddUserSubAddress(
            manualAddedAddress,
            HealingMatchConstants.manualAddressCurrentLatitude.toString(),
            HealingMatchConstants.manualAddressCurrentLongitude.toString(),
            _myAddedAddressInputType,
            _myCategoryPlaceForMassage,
            _myAddedCity,
            _myAddedPrefecture,
            addedRoomNumberController.text.toString(),
            addedBuildingNameController.text.toString(),
            addedUserAreaController.text.toString(),
          );
          print(_myAddedAddressInputType);
          widget.callBack();
          Navigator.pop(context);
          /*   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UpdateServiceUserDetails()));*/
        });
      } else {
        ProgressDialogBuilder.hideAddAddressProgressDialog(context);
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
    /*else {
      ProgressDialogBuilder.hideAddAddressProgressDialog(context);
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
    }*/

    _sharedPreferences.then((value) {
      setState(() {
        constantUserAddressValuesList.add(addUserAddress);
        value.setBool('isUserVerified', false);
        var addressData = json.encode(constantUserAddressValuesList);
        value.setString('addressData', addressData);
      });
    });

    ProgressDialogBuilder.hideAddAddressProgressDialog(context);
  }
}
