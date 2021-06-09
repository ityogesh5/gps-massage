import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/models/customModels/address.dart';
import 'package:gps_massageapp/models/customModels/userAddressAdd.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/profile/ErrorClass/UpdateErrorModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/profile/profileUpdateResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
List<UpdateAddress> updateAddress = new List<UpdateAddress>();
List<AddUserSubAddress> constantUserAddressValuesList =
    new List<AddUserSubAddress>();
Map<String, String> addedAddressType = Map<String, String>();

var deletePosition, editPosition;
var addressID;

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
  var constantListPositionType, userAddressListPositionType;

  String imgBase64ProfileImage;
  Uint8List profileImageInBytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getEditUserFields();
    getUserProfileData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showOverlayLoader() {
    Loader.show(context,
        progressIndicator: SpinKitThreeBounce(color: Colors.lime));
  }

  hideLoader() {
    Future.delayed(Duration(seconds: 0), () {
      Loader.hide();
    });
  }

  var userAddressType;
  final _searchRadiusKey = new GlobalKey<FormState>();
  var _mySearchRadiusDistance;
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
  final _editPlaceOfAddressKey = new GlobalKey<FormState>();
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
  int cityStatus = 0;
  int id = 0;
  bool img = false;

  //CityListResponseModel city;

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<Null> _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context,
        locale: LocaleType.jp,
        currentTime: selectedDate,
        minTime: DateTime(1901, 1),
        maxTime: DateTime.now(), onConfirm: (DateTime picked) {
      if (picked != null) {
        setState(() {
          selectedDate = picked;
          _selectedDOBDate = new DateFormat("yyyy-MM-dd").format(picked);
          _userDOBController.value =
              TextEditingValue(text: _selectedDOBDate.toString());

          //print(_selectedDOBDate);
          selectedYear = picked.year;
          calculateAge();
        });
      }
    });
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
                                child: HealingMatchConstants.userProfileImage !=
                                        null
                                    ? CachedNetworkImage(
                                        imageUrl: HealingMatchConstants
                                            .userProfileImage,
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
                      child: WidgetAnimator(
                        TextFormField(
                          //enableInteractiveSelection: false,
                          maxLength: 20,
                          autofocus: false,
                          controller: userNameController,
                          decoration: new InputDecoration(
                            counterText: '',
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
                                  child: WidgetAnimator(
                                    TextFormField(
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
                                          color:
                                              Color.fromRGBO(211, 211, 211, 1),
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
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //age
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.20,
                              alignment: Alignment.topCenter,
                              child: WidgetAnimator(
                                TextFormField(
                                  //enableInteractiveSelection: false,
                                  controller: ageController,
                                  autofocus: false,
                                  readOnly: true,
                                  decoration: new InputDecoration(
                                    filled: true,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                    labelText: '年齢',
                                    labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontFamily: 'NotoSansJP',
                                        fontSize: 14),
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
                          WidgetAnimator(
                            Text(
                              '性別',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'NotoSansJP',
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Form(
                            key: _genderKey,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: WidgetAnimator(
                                  DropDownFormField(
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
                              child: WidgetAnimator(
                                DropDownFormField(
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: WidgetAnimator(
                        TextFormField(
                          //enableInteractiveSelection: false,
                          enabled: false,
                          autofocus: false,
                          maxLength: 10,
                          controller: phoneNumberController,
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          onEditingComplete: () {
                            var phnNum = phoneNumberController.text.toString();
                            var userPhoneNumber =
                                phnNum.replaceFirst(RegExp(r'^0+'), "");
                            print('Phone number after edit : $userPhoneNumber');
                            phoneNumberController.text = userPhoneNumber;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: ColorConstants.formFieldFillColor,
                            labelText: '電話番号',
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
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: WidgetAnimator(
                        TextFormField(
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
                                  child: WidgetAnimator(
                                    DropDownFormField(
                                      filled: true,
                                      hintText: '登録する地点のカテゴリー ',
                                      value: _myCategoryPlaceForMassage,
                                      onSaved: (value) {
                                        setState(() {
                                          _myCategoryPlaceForMassage = value;
                                        });
                                      },
                                      onChanged: (value) {
                                        /*setState(() {
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
                                        });*/
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
                                child: WidgetAnimator(
                                  TextFormField(
                                    controller: otherController,
                                    enabled: false,
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
                                      child:
                                          /*stateDropDownValues != null
                                                ? */
                                          Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.39,
                                    child: WidgetAnimator(
                                      DropDownFormField(
                                          hintText: '府県',
                                          value: _myPrefecture,
                                          onSaved: (value) {
                                            setState(() {
                                              _myPrefecture = value;
                                            });
                                          },
                                          onChanged: (value) {
                                            /*setState(() {
                                              _myPrefecture = value;
                                              print(
                                                  'Prefecture value : ${_myPrefecture.toString()}');
                                              _prefId = stateDropDownValues
                                                      .indexOf(value) +
                                                  1;
                                              print(
                                                  'prefID : ${_prefId.toString()}');
                                              cityDropDownValues.clear();
                                              _myCity = '';
                                              getCities(_prefId);
                                            });*/
                                          },
                                          dataSource: [_myPrefecture],
                                          isList: true,
                                          textField: 'display',
                                          valueField: 'value'),
                                    ),
                                  )),
                                ),
                                Expanded(
                                  child: Form(
                                      key: _cityKey,
                                      child:
                                          /* cityDropDownValues != null
                                                ?*/
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.39,
                                        child: WidgetAnimator(
                                          DropDownFormField(
                                              hintText:
                                                  readonly ? _myCity : '市',
                                              value: _myCity,
                                              onSaved: (value) {
                                                setState(() {
                                                  _myCity = value;
                                                });
                                              },
                                              onChanged: (value) {
                                                /*setState(() {
                                                  _myCity = value;
                                                  //print(_myBldGrp.toString());
                                                });*/
                                              },
                                              dataSource: [_myCity],
                                              isList: true,
                                              textField: 'display',
                                              valueField: 'value'),
                                        ),
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
                                    child: WidgetAnimator(
                                      TextFormField(
                                        //enableInteractiveSelection: false,
                                        readOnly: true,
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
                              ),
                              Expanded(
                                child: Container(
                                  // height: MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.39,
                                  child: WidgetAnimator(
                                    TextFormField(
                                      //enableInteractiveSelection: false,
                                      // keyboardType: TextInputType.number,
                                      autofocus: false,
                                      controller: buildingNameController,
                                      readOnly: true,
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
                                    child: WidgetAnimator(
                                      TextFormField(
                                        //enableInteractiveSelection: false,
                                        readOnly: true,
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

                    constantUserAddressValuesList != null ||
                            HealingMatchConstants.userAddressesList != null
                        ? Container(
                            // height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: WidgetAnimator(
                              TextFormField(
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
                                      if (HealingMatchConstants
                                              .userAddressesList.length ==
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
                                                        fontFamily:
                                                            'NotoSansJP',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .underline)),
                                              ),
                                            ],
                                          ),
                                        ));
                                        return;
                                      }
                                      if (constantUserAddressValuesList
                                                  .length ==
                                              1 &&
                                          HealingMatchConstants
                                                  .userAddressesList.length ==
                                              2) {
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
                                                    'ユーザーは3つの住所のみを更新できます！',
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
                                                        fontFamily:
                                                            'NotoSansJP',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .underline)),
                                              ),
                                            ],
                                          ),
                                        ));
                                        return;
                                      }
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
                          )
                        : Container(
                            // height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: WidgetAnimator(
                              TextFormField(
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
                          ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: constantUserAddressValuesList != null &&
                          constantUserAddressValuesList.isNotEmpty,
                      child: Text(
                        '更新用に追加された住所を表示します。',
                        style: TextStyle(
                            fontFamily: 'NotoSansJP',
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ),
                    Visibility(
                        visible: constantUserAddressValuesList != null &&
                            constantUserAddressValuesList.isNotEmpty,
                        child: SizedBox(height: 15)),
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
                                    bool isFocus = false;
                                    return WidgetAnimator(
                                      Column(
                                        children: [
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.86,
                                                  child: WidgetAnimator(
                                                    TextFormField(
                                                      //display the address
                                                      readOnly: false,
                                                      autofocus: isFocus,
                                                      initialValue:
                                                          constantUserAddressValuesList[
                                                                  index]
                                                              .subAddress,
                                                      decoration:
                                                          new InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  ColorConstants
                                                                      .formFieldFillColor,
                                                              hintText:
                                                                  '${constantUserAddressValuesList[index]}',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
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
                                                              prefixIcon:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                8.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                              begin: Alignment.topCenter,
                                                                              end: Alignment.bottomCenter,
                                                                              colors: [
                                                                                Color.fromRGBO(255, 255, 255, 1),
                                                                                Color.fromRGBO(255, 255, 255, 1),
                                                                              ]),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey[100],
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(6.0),
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '${constantUserAddressValuesList[index].addressCategory}',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
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
                                                                        .remove_circle,
                                                                    size: 25,
                                                                    color: Colors
                                                                        .black),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    constantUserAddressValuesList
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                              )),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          constantUserAddressValuesList[
                                                                      index]
                                                                  .subAddress =
                                                              value;
                                                        });
                                                      },
                                                      // validator: (value) => _validateEmail(value),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : Container(),
                    Text(
                      'メインの地点以外に3箇所まで地点登録ができます',
                      style: TextStyle(
                          fontFamily: 'NotoSansJP',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 15),

                    HealingMatchConstants.userAddressesList != null
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 12.0),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: HealingMatchConstants
                                      .userAddressesList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    addedAddressType[HealingMatchConstants
                                            .userAddressesList[index]
                                            .userPlaceForMassage] =
                                        HealingMatchConstants
                                            .userAddressesList[index]
                                            .userPlaceForMassage;
                                    return WidgetAnimator(
                                      Column(
                                        children: [
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.86,
                                                  child: WidgetAnimator(
                                                    TextFormField(
                                                      //display the address
                                                      readOnly: true,
                                                      autofocus: false,
                                                      initialValue:
                                                          HealingMatchConstants
                                                              .userAddressesList[
                                                                  index]
                                                              .address,
                                                      decoration:
                                                          new InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  ColorConstants
                                                                      .formFieldFillColor,
                                                              hintText:
                                                                  '${HealingMatchConstants.userAddressesList[index]}',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
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
                                                              prefixIcon:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                8.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                              begin: Alignment.topCenter,
                                                                              end: Alignment.bottomCenter,
                                                                              colors: [
                                                                                Color.fromRGBO(255, 255, 255, 1),
                                                                                Color.fromRGBO(255, 255, 255, 1),
                                                                              ]),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey[100],
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(6.0),
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '${HealingMatchConstants.userAddressesList[index].userPlaceForMassage}',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
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
                                                                      HealingMatchConstants
                                                                              .userAddressesList[
                                                                          index];
                                                                  print(
                                                                      'Position of sub edit list position : $position');
                                                                  print(
                                                                      'Position of sub edit list addressType : ${position.addressTypeSelection}');
                                                                  openAddressEditDialog(
                                                                      position
                                                                          .address,
                                                                      HealingMatchConstants
                                                                          .userAddressesList
                                                                          .indexOf(
                                                                              position));
                                                                },
                                                              )),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          HealingMatchConstants
                                                              .userAddressesList[
                                                                  index]
                                                              .address = value;
                                                        });
                                                      },
                                                      // validator: (value) => _validateEmail(value),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
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
                                child: WidgetAnimator(
                                  DropDownFormField(
                                    hintText: '検索範囲値',
                                    value: HealingMatchConstants
                                        .searchDistanceRadius,
                                    onSaved: (value) {
                                      setState(() {
                                        _mySearchRadiusDistance = value;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _mySearchRadiusDistance = value;
                                        print(
                                            'Search distance : ${_mySearchRadiusDistance.toString()}');
                                        HealingMatchConstants
                                                .searchDistanceRadius =
                                            _mySearchRadiusDistance;
                                      });
                                    },
                                    dataSource: [
                                      {
                                        "display": "５Ｋｍ圏内",
                                        "value": 5,
                                      },
                                      {
                                        "display": "１０Ｋｍ圏内",
                                        "value": 10,
                                      },
                                      {
                                        "display": "１５Ｋｍ圏内",
                                        "value": 15,
                                      },
                                      {
                                        "display": "２０Ｋｍ圏内",
                                        "value": 20,
                                      },
                                      {
                                        "display": "２５Ｋｍ圏内",
                                        "value": 25,
                                      },
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),
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
                          print(
                              'JSON LIST SUB ADDRESS CONST LIST : ${json.encode(HealingMatchConstants.userAddressesList)}');
                          print(
                              'JSON LIST SUB ADDRESS LOCAL LIST : ${json.encode(constantUserAddressValuesList)}');
                          _updateUserDetails();
                          print(
                              'User id : ${HealingMatchConstants.serviceUserID}');
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
    AwesomeDialog dialog;
    bool isFocus = false;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.QUESTION,
      keyboardAware: true,
      width: MediaQuery.of(context).size.width,
      dismissOnTouchOutside: true,
      showCloseIcon: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: WidgetAnimator(
                TextFormField(
                  controller: _editAddressController,
                  //initialValue: subAddress,
                  autofocus: isFocus,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: '新しい住所を入力してください。',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.33,
                  child: CustomToggleButton(
                    initialValue: 0,
                    elevation: 0,
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.33,
                    autoWidth: false,
                    buttonColor: Color.fromRGBO(217, 217, 217, 1),
                    enableShape: true,
                    customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.transparent)),
                    buttonLables: ["編集する", "削除する"],
                    fontSize: 16.0,
                    buttonValues: [
                      "Y",
                      "N",
                    ],
                    radioButtonValue: (value) {
                      if (value == 'Y') {
                        ProgressDialogBuilder.showOverlayLoader(context);
                        if (_editAddressController.text != null &&
                            _editAddressController.text.isNotEmpty) {
                          HealingMatchConstants.userAddressesList[position]
                              .address = _editAddressController.text.toString();
                          editPosition = position;
                          _getLatLngFromAddress(
                              _editAddressController.text.toString(), position);
                        } else {
                          ProgressDialogBuilder.hideLoader(context);
                        }
                      } else {
                        ProgressDialogBuilder.showOverlayLoader(context);
                        deletePosition = position;
                        addressID = HealingMatchConstants
                            .userAddressesList[position].id;
                        print(
                            'Delete values :${_editAddressController.text} && $addressID');
                        var deleteSubAddress =
                            ServiceUserAPIProvider.deleteUserSubAddress(
                                context, addressID);
                        deleteSubAddress.then((value) {
                          if (value != null && value.status == 'success') {
                            print('Delete Success');
                            ProgressDialogBuilder.hideLoader(context);
                            dialog.dissmiss();
                            NavigationRouter
                                .switchToServiceUserEditProfileScreen(
                                    context, widget.userProfileImage);
                          }
                        }).catchError((onError) {
                          ProgressDialogBuilder.hideLoader(context);
                          dialog.dissmiss();
                          print('Delete error : $onError');
                        });
                      }
                      print('Radio value : $value');
                    },
                    selectedColor: Color.fromRGBO(200, 217, 33, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )..show();
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
        if (this.mounted) {
          setState(() {
            stateDropDownValues.add(stateList.prefectureJa);
            cityStatus = 1;
          });
        }
      }
      if (this.mounted) {
        setState(() {
          _prefId = stateDropDownValues.indexOf(_myPrefecture) + 1;
          getCities(_prefId);
        });
      }
    });
  }

  // CityList cityResponse;
  getCities(var prefId) async {
    await http.post(HealingMatchConstants.CITY_PROVIDER_URL,
        body: {'prefecture_id': prefId.toString()}).then((response) {
      cities = CitiesListResponseModel.fromJson(json.decode(response.body));
      print(cities.toJson());
      for (var cityList in cities.data) {
        if (this.mounted) {
          setState(() {
            cityDropDownValues
                .add(cityList.cityJa + cityList.specialDistrictJa);
          });
        }
      }

      print('Response City list : ${response.body}');
    });
  }

  getSubAddressList() async {
    var userListApiProvider = ServiceUserAPIProvider.getUserDetails(
        context, HealingMatchConstants.serviceUserID);

    userListApiProvider.then((value) {
      setState(() {
        for (int i = 0; i < value.data.addresses.length; i++) {
          HealingMatchConstants.userAddressesList = value.data.addresses;
        }
        HealingMatchConstants.userAddressesList.removeAt(0);
      });
    }).catchError((onError) {
      print('Edit user response : ${onError.toString()}');
    });
  }

  _updateUserDetails() async {
    ProgressDialogBuilder.showOverlayLoader(context);
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
    var userPhNumber = userPhoneNumber.replaceFirst(RegExp(r'^0+'), "");
    print('phnNumber: $userPhNumber');

    print('searchRadius: ${_mySearchRadiusDistance}');
    var userGPSAddress = gpsAddressController.text.toString().trim();

    // user perfecture validation
    if ((_myPrefecture == null || _myPrefecture.isEmpty)) {
      ProgressDialogBuilder.hideLoader(context);
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
      ProgressDialogBuilder.hideLoader(context);
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
      ProgressDialogBuilder.hideLoader(context);
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

    // user city validation
    if (_myCity == null || _myCity.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
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
    if (userArea == null || userArea.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
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
    if (userName.length == 0 || userName.isEmpty || userName == null) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効なユーザー名を入力してください。',
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
    if (userName.length > 20) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('名前は20文字数以内に入力してください。。',
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

    // user DOB validation
    if (userDOB == null || userDOB.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('有効な生年月日を選択してください。',
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
    //age validation
    if (ageOfUser < 18) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('大変申し訳ありませんが１８歳未満の方の登録はできません。',
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
      ProgressDialogBuilder.hideLoader(context);
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
    if (_mySearchRadiusDistance != null) {
      print('Search distance : $_mySearchRadiusDistance');
    } else {
      _mySearchRadiusDistance = 10;
      print('Search distance else null : $_mySearchRadiusDistance');
    }

    // user building name validation
    if (buildingName != null || buildingName.isNotEmpty) {
      print('buildingName : $buildingName');
    }

    // room number validation
    if (roomNumber != null || roomNumber.isNotEmpty) {
      print('numbers : $roomNumber');
    }

    if (HealingMatchConstants.userEditAddress.isEmpty) {
      String manualUserAddress = _myPrefecture +
          " " +
          _myCity +
          " " +
          userArea +
          " " +
          buildingName +
          " " +
          roomNumber;
      String queryAddress = roomNumber +
          ',' +
          buildingName +
          ',' +
          userArea +
          ',' +
          _myCity +
          ',' +
          _myPrefecture;
      String address =
          Platform.isIOS ? _myCity + ',' + _myPrefecture : manualUserAddress;
      List<Location> userAddress =
          await locationFromAddress(address, localeIdentifier: "ja_JP");
      HealingMatchConstants.mEditCurrentLatitude = userAddress[0].latitude;
      HealingMatchConstants.mEditCurrentLongitude = userAddress[0].longitude;
      var serviceUserCity = _myCity;
      var serviceUserPrefecture = _myPrefecture;
      HealingMatchConstants.userEditAddress = manualUserAddress;
      print(
          'Manual Address lat lon : ${HealingMatchConstants.currentLatitude} && '
          '${HealingMatchConstants.currentLongitude}');
      //  print('Manual Place Json : ${userAddedAddressPlaceMark.toJson()}');
      print('Manual Address : ${HealingMatchConstants.userAddress}');
      print('Manual Modified Address : ${manualUserAddress.trim()}');
    }

    print('Id: ${HealingMatchConstants.accessToken}');
    print('Id: $HealingMatchConstants.serviceUserById');
    print('Address ID : $_userAddressID');
    print('UserId: $rUserID');
    print('Name: $userName');
    print('Dob: $userDOB');
    print('Age: ${userAge}');
    print('occupation: $_myOccupation');
    print('phn: $userPhoneNumber');
    print('email: $email');
    if (HealingMatchConstants.userEditAddress.isNotEmpty) {
      if (this.mounted) {
        setState(() {
          addUpdateAddress = UpdateAddress(
            id: HealingMatchConstants.userAddressId,
            userId: HealingMatchConstants.serviceUserID,
            addressTypeSelection: _myAddressInputType,
            address: HealingMatchConstants.userEditAddress,
            userRoomNumber: roomNumberController.text.toString(),
            userPlaceForMassage: _myCategoryPlaceForMassage,
            capitalAndPrefecture: _myPrefecture,
            cityName: _myCity,
            area: userAreaController.text.toString(),
            buildingName: buildingNameController.text.toString(),
            lat: HealingMatchConstants.mEditCurrentLatitude,
            lon: HealingMatchConstants.mEditCurrentLongitude,
          );
          updateAddress.add(addUpdateAddress);
          print("json Converted sub address :" +
              json.encode(constantUserAddressValuesList));
          print("json Converted Address:" + json.encode(updateAddress));
        });
      }
    }

    print('Id: ${HealingMatchConstants.serviceUserById}');
    print('Id: ${HealingMatchConstants.userEditAddress}');
    print('Address ID : $_userAddressID');

    print('UserId: $rUserID');

    try {
      Uri updateProfile =
          Uri.parse(HealingMatchConstants.UPDATE_USER_DETAILS_URL);
      var request = http.MultipartRequest('POST', updateProfile);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-access-token": HealingMatchConstants.accessToken
      };
      if (_profileImage != null) {
        var profileImage = await http.MultipartFile.fromPath(
            'uploadProfileImgUrl', _profileImage.path);
        print('Image upload filename : $profileImage');
        request.files.add(profileImage);
        request.headers.addAll(headers);
        request.fields.addAll({
          "id": HealingMatchConstants.serviceUserID,
          "userName": userName,
          "age": userAge,
          "userOccupation": _myOccupation,
          "dob": userDOB,
          "phoneNumber": userPhoneNumber,
          "email": email,
          "gender": _myGender,
          "uploadProfileImgUrl": _profileImage.path,
          "isTherapist": "0",
          "userSearchRadiusDistance": _mySearchRadiusDistance.toString(),
          "address": json.encode(updateAddress),
          "subAddress": json.encode(constantUserAddressValuesList)
        });
      } else {
        request.headers.addAll(headers);
        request.fields.addAll({
          "id": HealingMatchConstants.serviceUserID,
          "userName": userName,
          "age": userAge,
          "userOccupation": _myOccupation,
          "dob": userDOB,
          "phoneNumber": userPhoneNumber,
          "email": email,
          "gender": _myGender,
          "isTherapist": "0",
          "userSearchRadiusDistance": _mySearchRadiusDistance.toString(),
          "address": json.encode(updateAddress),
          "subAddress": json.encode(constantUserAddressValuesList)
        });
      }

      final userDetailsRequest = await request.send();
      await http.Response.fromStream(userDetailsRequest).then((value) {
        if (value != null && value.statusCode == 200) {
          print('Response Success : ${value.body.toString()}');
          final Map userDetailsResponse = json.decode(value.body);
          final profileUpdateResponseModel =
              UserUpdateResponseModel.fromJson(userDetailsResponse);
          HealingMatchConstants.editUserSubAddressList =
              profileUpdateResponseModel.subAddress;
          print(profileUpdateResponseModel.toJson());
          print(
              'Profile response list : ${profileUpdateResponseModel.subAddress} && ${profileUpdateResponseModel.data.addresses}');
          updateAddress.clear();
          constantUserAddressValuesList.clear();
          HealingMatchConstants.userAddressesList.clear();
          ProgressDialogBuilder.hideLoader(context);
          DialogHelper.showUserProfileUpdatedSuccessDialog(context);
        } else if (value.statusCode == 400) {
          print('Error Response inside : ${value.body}');
          final Map errorResponse = json.decode(value.body);
          final editErrorUpdateResponse =
              UpdateErrorModel.fromJson(errorResponse);
          print('Error Message : ${editErrorUpdateResponse.message}');
          ProgressDialogBuilder.hideLoader(context);

          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 5),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('選択した住所のカテゴリタイプはすでに追加されています。',
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
          return;
        } else {
          updateAddress.clear();
          ProgressDialogBuilder.hideLoader(context);
          return;
        }
      }).catchError((onError) {
        ProgressDialogBuilder.hideLoader(context);
        print('Catch error : ${onError.toString()}');
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Edit user Exception : ${e.toString()}');
    }
  }

  getUserProfileData() async {
    List<AddUserSubAddress> deletedDataListSubAddress =
        new List<AddUserSubAddress>();
    try {
      HealingMatchConstants.userAddressesList.clear();
      print('Getting values...EPF');
      setState(() {
        _myCity = HealingMatchConstants.userEditCity;
        print('City: $_myCity');
        _myGender = HealingMatchConstants.serviceUserGender;
        _myOccupation = HealingMatchConstants.userEditUserOccupation;

        _myCategoryPlaceForMassage =
            HealingMatchConstants.userEditPlaceForMassage;
        addedAddressType[_myCategoryPlaceForMassage] =
            _myCategoryPlaceForMassage;
        _myPrefecture = HealingMatchConstants.userEditPrefecture;
        rID = HealingMatchConstants.serviceUserById;
        userNameController.text = HealingMatchConstants.serviceUserName;
        phoneNumberController.text =
            HealingMatchConstants.serviceUserPhoneNumber;
        emailController.text = HealingMatchConstants.serviceUserEmailAddress;
        ageController.text = HealingMatchConstants.serviceUserAge;
        _userDOBController.text = HealingMatchConstants.serviceUserDOB;
        buildingNameController.text = HealingMatchConstants.userEditBuildName;
        roomNumberController.text = HealingMatchConstants.userEditRoomNo;
        gpsAddressController.text = HealingMatchConstants.serviceUserAddress;
        otherController.text =
            HealingMatchConstants.userEditPlaceForMassageOther;
        userAreaController.text = HealingMatchConstants.userEditArea;
        _mySearchRadiusDistance = HealingMatchConstants.searchDistanceRadius;
        _getStates();
        getSubAddressList();
      });

      print(_myCategoryPlaceForMassage);
      print('Prefectute: $_myPrefecture');
      print('City: $_myCity');
      print('Token: ${HealingMatchConstants.accessToken}');
      print('Id: $rID');
      print('Address ID : $_userAddressID');

      print('Address ID : $_userAddressID');

      print('UserId: $rUserID');
      print('UserBuildName: $rUserBuildName');
      print('UserRoomNo: $rUserRoomNo');
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideLoader(context);
    }
  }

  getEditUserFields() async {
    _sharedPreferences.then((value) {
      bool isUserVerified = value.getBool('isUserVerified');

      if (isUserVerified != null && isUserVerified) {
        accessToken = value.getString('accessToken');
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        rUserID = value.getString('userID');
        print('User Address Type Verified : $_myAddressInputType');
        print('User Address ID Verified : $_userAddressID');
      } else {
        _myAddressInputType = value.getString('addressType');
        _userAddressID = value.getString('addressID');
        print('User Address Type : $_myAddressInputType');
        print('User Address ID : $_userAddressID');
      }
    });
  }

  refreshPage() {
    setState(() {});
  }

  openActionDialog(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.98,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              10.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'この住所を削除してもよろしいですか？',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Open Sans'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.30,
                child: CustomToggleButton(
                  elevation: 0,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.30,
                  autoWidth: false,
                  buttonColor: Color.fromRGBO(217, 217, 217, 1),
                  enableShape: true,
                  customShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent)),
                  buttonLables: ["はい", "いいえ"],
                  fontSize: 16.0,
                  buttonValues: [
                    "Y",
                    "N",
                  ],
                  radioButtonValue: (value) {
                    if (value == 'Y') {
                    } else {}
                    print('Radio value : $value');
                  },
                  selectedColor: Color.fromRGBO(200, 217, 33, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getLatLngFromAddress(String subAddress, var position) async {
    try {
      List<Location> address =
          await locationFromAddress(subAddress, localeIdentifier: "ja_JP");

      var searchAddressLatitude = address[0].latitude;
      var searchAddressLongitude = address[0].longitude;

      print(
          'Address location points : $searchAddressLatitude && $searchAddressLongitude');
      addressID = HealingMatchConstants.userAddressesList[position].id;
      print('Edit values :${_editAddressController.text} && $addressID');

      if (searchAddressLatitude != null && searchAddressLongitude != null) {
        var editSubAddress = ServiceUserAPIProvider.editUserSubAddress(
            context,
            addressID,
            subAddress,
            searchAddressLatitude,
            searchAddressLongitude);
        editSubAddress.then((value) {
          if (value != null && value.status == 'success') {
            print('Sub address edited!!');
            ProgressDialogBuilder.hideLoader(context);
            NavigationRouter.switchToServiceUserEditProfileScreen(
                context, widget.userProfileImage);
          }
        }).catchError((onError) {
          print('Delete error : $onError');
          ProgressDialogBuilder.hideLoader(context);
        });
      }
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideLoader(context);
    }
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

  showOverlayLoader() {
    Loader.show(context,
        progressIndicator: SpinKitThreeBounce(color: Colors.lime));
  }

  hideLoader() {
    Future.delayed(Duration(seconds: 1), () {
      Loader.hide();
    });
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
                                        child: WidgetAnimator(
                                          DropDownFormField(
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
                                  child: WidgetAnimator(
                                    TextFormField(
                                      controller: otherController,
                                      style:
                                          HealingMatchConstants.formTextStyle,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            ColorConstants.formFieldFillColor,
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
                                        labelText: '登録する地点のカテゴリー',
                                        labelStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: 'NotoSansJP',
                                            fontSize: 14),
                                        focusColor: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: visible,
                                child: SizedBox(
                                  height: 10,
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
                                                                WidgetAnimator(
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
                                                                  isList: true,
                                                                  textField:
                                                                      'display',
                                                                  valueField:
                                                                      'value'),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                WidgetAnimator(
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
                                                                  isList: true,
                                                                  textField:
                                                                      'display',
                                                                  valueField:
                                                                      'value'),
                                                            ),
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
                                                                WidgetAnimator(
                                                              DropDownFormField(
                                                                  hintText: '市',
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
                                                                  isList: true,
                                                                  textField:
                                                                      'display',
                                                                  valueField:
                                                                      'value'),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.39,
                                                            child:
                                                                WidgetAnimator(
                                                              DropDownFormField(
                                                                  hintText: '市',
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
                                                                  isList: true,
                                                                  textField:
                                                                      'display',
                                                                  valueField:
                                                                      'value'),
                                                            ),
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
                                              child: WidgetAnimator(
                                                TextFormField(
                                                  //enableInteractiveSelection: false,
                                                  autofocus: false,
                                                  controller:
                                                      addedUserAreaController,
                                                  decoration:
                                                      new InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 3, 6, 3),
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
                                        ),
                                        Expanded(
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            height: containerHeight,
                                            child: WidgetAnimator(
                                              TextFormField(
                                                //enableInteractiveSelection: false,
                                                // keyboardType: TextInputType.number,
                                                autofocus: false,
                                                controller:
                                                    addedBuildingNameController,
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          6, 3, 6, 3),
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
                                              child: WidgetAnimator(
                                                TextFormField(
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
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontFamily:
                                                            'NotoSansJP',
                                                        fontSize: 14),
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 3, 6, 3),
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
    ProgressDialogBuilder.showOverlayLoader(context);
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
      ProgressDialogBuilder.hideLoader(context);
      print('Response City list : ${response.body}');
    });
  }

  _addUserAddress() async {
    print(
        'Categories : $_myCategoryPlaceForMassage && ${HealingMatchConstants.userEditPlaceForMassage} '
        '&& ${HealingMatchConstants.userEditPlaceForMassageOther}');

    if (_myCategoryPlaceForMassage.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      print('Manual address empty fields');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('登録する地点のカテゴリーを選択してください。',
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

    if (_myAddedPrefecture.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      print('Manual address empty fields');
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
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return;
    }

    if (_myAddedCity.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      print('Manual address empty fields');
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
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return;
    }

    if (addedUserAreaController.text.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      print('Manual address empty fields');
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
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return;
    }

    if (_myCategoryPlaceForMassage == 'その他（直接入力）') {}
    if (_myCategoryPlaceForMassage == 'その他（直接入力）' &&
        otherController.text.isEmpty) {
      ProgressDialogBuilder.hideLoader(context);
      print('Manual address empty fields');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('登録する地点のカテゴリーを入力してください。',
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

    if (addedAddressType[_myCategoryPlaceForMassage] ==
        _myCategoryPlaceForMassage) {
      print('Address cat same');
      setState(() {
        _myCategoryPlaceForMassage = '';
        visible = false;
      });

      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('選択した登録する地点のカテゴリーがすでに追加されました。',
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

    /* if (_myCategoryPlaceForMassage ==
        HealingMatchConstants.userEditPlaceForMassage) {
      print('Address cat same');
      setState(() {
        _myCategoryPlaceForMassage = '';
        visible = false;
      });

      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('選択した登録する地点のカテゴリーがすでに追加されました。',
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
    if (_myCategoryPlaceForMassage ==
        HealingMatchConstants.userEditPlaceForMassageOther) {
      print('Other cat same');
      setState(() {
        _myCategoryPlaceForMassage = '';
        visible = false;
      });
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('選択した登録する地点のカテゴリーがすでに追加されました。',
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
    } */
    ProgressDialogBuilder.showOverlayLoader(context);
    String manualAddedAddress = _myAddedPrefecture +
        " " +
        _myAddedCity +
        " " +
        addedUserAreaController.text +
        " " +
        addedBuildingNameController.text +
        " " +
        addedRoomNumberController.text;
    String queryAddress = addedRoomNumberController.text.toString() +
        ',' +
        addedBuildingNameController.text.toString() +
        ',' +
        addedUserAreaController.text.toString() +
        ',' +
        _myAddedCity +
        ',' +
        _myAddedPrefecture;
    print('USER MANUAL ADDRESS : $manualAddedAddress');
    String address =
        Platform.isIOS ? _myAddedCity + ',' + _myAddedPrefecture : queryAddress;
    List<Location> userManualAddress =
        await locationFromAddress(address, localeIdentifier: "ja_JP");
    HealingMatchConstants.manualAddressCurrentLatitude =
        userManualAddress[0].latitude;
    HealingMatchConstants.manualAddressCurrentLongitude =
        userManualAddress[0].longitude;
    HealingMatchConstants.serviceUserCity = _myAddedCity;
    HealingMatchConstants.serviceUserPrefecture = _myAddedPrefecture;
    HealingMatchConstants.manualUserAddress = manualAddedAddress;
    print(
        'Manual Address lat lon : ${HealingMatchConstants.manualAddressCurrentLatitude} && '
        '${HealingMatchConstants.manualAddressCurrentLongitude}');
    //print('Manual Place Json : ${userManualAddressPlaceMark.toJson()}');
    print('Manual Address : ${HealingMatchConstants.manualUserAddress}');

    /*  if (HealingMatchConstants.userAddressesList.length <= 2 &&
        constantUserAddressValuesList.length <= 1) {
      ProgressDialogBuilder.hideLoader(context);
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

    if (constantUserAddressValuesList.length <= 2) {
      String city = _myAddedCity;
      setState(() {
        addUserAddress = AddUserSubAddress(
          HealingMatchConstants.serviceUserID,
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
      });
      ProgressDialogBuilder.hideLoader(context);
    } else {
      ProgressDialogBuilder.hideLoader(context);
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
    _sharedPreferences.then((value) {
      setState(() {
        if (constantUserAddressValuesList
            .contains(_myCategoryPlaceForMassage)) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: ColorConstants.snackBarColor,
            duration: Duration(seconds: 3),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('選択した登録する地点のカテゴリーがすでに追加されました。',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontFamily: 'NotoSansJP')),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
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
        } else {
          constantUserAddressValuesList.add(addUserAddress);
          value.setBool('subAddressDeleted', false);
          value.setBool('isUserVerified', false);
        }
      });
    });
  }
}
