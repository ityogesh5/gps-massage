import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/responseModels/serviceUser/register/serviceUserRegisterResponseModel.dart';
import 'package:gps_massageapp/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class RegisterServiceUserScreen extends StatefulWidget {
  @override
  _RegisterServiceUserScreenState createState() =>
      _RegisterServiceUserScreenState();
}

class _RegisterServiceUserScreenState extends State<RegisterServiceUserScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ヒーリングマッチ',
      debugShowCheckedModeBanner: false,
      home: RegisterUser(),
    );
  }
}

class RegisterUser extends StatefulWidget {
  @override
  State createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController _userDOBController = new TextEditingController();

  String _selectedDOBDate = 'Tap to select date';
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = '';
  double age = 0.0;
  var selectedYear;
  final ageController = TextEditingController();
  var _ageOfUser = '';
  String _myGender = '';
  String _myOccupation = '';
  String _myAddressInputType = '';
  String _myCategoryPlaceForMassage = '';
  String _myPrefecture = '';
  String _myCity = '';
  File _profileImage;
  final picker = ImagePicker();
  Placemark currentLocationPlaceMark;
  Placemark userAddedAddressPlaceMark;

  bool _showCurrentLocationInput = false;
  bool _secureText = true;
  bool _isLoggedIn = false;
  bool _isGPSLocation = false;
  final _registerUserFormKey = new GlobalKey<FormState>();
  final _genderKey = new GlobalKey<FormState>();
  final _occupationKey = new GlobalKey<FormState>();
  final _addressTypeKey = new GlobalKey<FormState>();
  final _placeOfAddressKey = new GlobalKey<FormState>();
  final _perfectureKey = new GlobalKey<FormState>();
  final _cityKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final userNameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = TextEditingController();
  final buildingNameController = new TextEditingController();
  final userAreaController = new TextEditingController();
  final gpsAddressController = new TextEditingController();
  final roomNumberController = new TextEditingController();

  List<String> serviceUserDetails = [];

  //final gpsAddressController = new TextEditingController();

  bool _changeProgressText = false;

  List<dynamic> stateDropDownValues = List();
  List<dynamic> cityDropDownValues = List();

  StatesListResponseModel states;
  CitiesListResponseModel cities;
  var _prefId;

  //CityListResponseModel city;

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

//Date picker

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
  void initState() {
    super.initState();
    _getStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20),
            child: InkWell(
              onTap: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RegistrationScreen()));*/
              },
              child: Text(
                'スキップ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 18.0,
                    decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Form(
            key: _registerUserFormKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('サービス利用者情報の入力',
                        style: new TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w100)),
                    SizedBox(height: 5),
                    RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: '* ',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          new TextSpan(
                              text: '値は必須です',
                              style: new TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w100)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Stack(
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
                                  _showPicker(context);
                                },
                                child: new Container(
                                    width: 95.0,
                                    height: 95.0,
                                    decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: new AssetImage(
                                            'assets/images_gps/placeholder.png'),
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
                                  child: Icon(Icons.add_a_photo_rounded,
                                      color: Colors.blue, size: 30.0),
                                ),
                              )
                            : Visibility(
                                visible: true,
                                child: Positioned(
                                  right: -60.0,
                                  top: 60,
                                  left: 10.0,
                                  child: Icon(Icons.add_a_photo_rounded,
                                      color: Colors.blue, size: 30.0),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        //maxLength: 20,
                        autofocus: false,
                        controller: userNameController,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: 'お名前 *',
                          hintText: 'お名前 *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                                        fontFamily: 'Open Sans'),
                                    cursorColor: Colors.redAccent,
                                    readOnly: true,
                                    decoration: new InputDecoration(
                                      filled: true,
                                      fillColor:
                                          ColorConstants.formFieldFillColor,
                                      labelText: '生年月日 *',
                                      hintText: '生年月日 *',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
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
                              height: MediaQuery.of(context).size.height * 0.07,
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
                                  ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '性別 *',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Form(
                          key: _genderKey,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: DropDownFormField(
                                hintText: '性別 *',
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
                                    "value": "M",
                                  },
                                  {
                                    "display": "女性",
                                    "value": "F",
                                  },
                                  {
                                    "display": "どちらでもない",
                                    "value": "O",
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
                                hintText: '職業 *',
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        autofocus: false,
                        //maxLength: 11,
                        controller: phoneNumberController,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: '電話番号 *',
                          hintText: '電話番号 *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
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
                      height: MediaQuery.of(context).size.height * 0.07,
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
                          ),
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        autofocus: false,
                        //maxLength: 14,
                        obscureText: _secureText,
                        controller: passwordController,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: 'パスワード *',
                          hintText: 'パスワード *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        // maxLength: 14,
                        //enableInteractiveSelection: false,
                        autofocus: false,
                        controller: confirmPasswordController,
                        obscureText: _secureText,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: 'パスワード (確認用) *',
                          hintText: 'パスワード (確認用) *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
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
                                hintText: '検索地点の登録 *',
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
                                      gpsAddressController.clear();
                                      _showCurrentLocationInput = true;
                                    } else if (_myAddressInputType != null &&
                                        _myAddressInputType
                                            .contains('直接入力する')) {
                                      _isGPSLocation = false;
                                      _showCurrentLocationInput = false;
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
                    SizedBox(height: 10),
                    Visibility(
                      visible: _showCurrentLocationInput,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextFormField(
                          controller: gpsAddressController,
                          readOnly: true,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: ColorConstants.formFieldFillColor,
                            labelText: '現在地を取得する *',
                            hintText: '現在地を取得する *',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.location_on),
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
                            ),
                            focusColor: Colors.grey[100],
                            border: HealingMatchConstants.textFormInputBorder,
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
                    SizedBox(height: 10),
                    // Drop down address input type
                    Form(
                      key: _placeOfAddressKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: DropDownFormField(
                                hintText: '登録する地点のカテゴリー *',
                                value: _myCategoryPlaceForMassage,
                                onSaved: (value) {
                                  setState(() {
                                    _myCategoryPlaceForMassage = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _myCategoryPlaceForMassage = value;
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
                                    "display": "その他（直接入力",
                                    "value": "その他（直接入力",
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
                                              hintText: '府県 *',
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
                                                  _prefId = stateDropDownValues
                                                          .indexOf(value) +
                                                      1;
                                                  print(
                                                      'prefID : ${_prefId.toString()}');
                                                  cityDropDownValues.clear();
                                                  _myCity = '';
                                                  _getCities(_prefId);
                                                });
                                              },
                                              dataSource: stateDropDownValues,
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
                                              hintText: '府県 *',
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
                                              hintText: '市 *',
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
                                              dataSource: cityDropDownValues,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.39,
                                child: TextFormField(
                                  //enableInteractiveSelection: false,
                                  autofocus: false,
                                  controller: userAreaController,
                                  decoration: new InputDecoration(
                                    filled: true,
                                    fillColor:
                                        ColorConstants.formFieldFillColor,
                                    labelText: '都、県選 *',
                                    hintText: '都、県選 *',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
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
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.39,
                              child: TextFormField(
                                //enableInteractiveSelection: false,
                                autofocus: false,
                                controller: buildingNameController,
                                decoration: new InputDecoration(
                                  filled: true,
                                  fillColor: ColorConstants.formFieldFillColor,
                                  labelText: 'ビル名 *',
                                  hintText: 'ビル名 *',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
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
                                // validator: (value) => _validateEmail(value),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        //enableInteractiveSelection: false,
                        autofocus: false,
                        controller: roomNumberController,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.formFieldFillColor,
                          labelText: '部屋番号 *',
                          hintText: '部屋番号 *',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
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
                    RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: '* ',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          new TextSpan(
                              text: '登録した場所周辺のセラピストが表示されます',
                              style: new TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300)),
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
                          _changeProgressText = false;
                          _registerUserDetails();
                          //NavigationRouter.switchToServiceUserHomeScreen(context);
                        },
                        child: new Text(
                          '入力完了',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        NavigationRouter.switchToUserLogin(context);
                      },
                      child: Text('すでにアカウントをお持ちの方',
                          style: new TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w100,
                              decoration: TextDecoration.underline)),
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

      HealingMatchConstants.currentLatitude = _currentPosition.latitude;
      HealingMatchConstants.currentLongitude = _currentPosition.longitude;

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
          HealingMatchConstants.serviceUserCity =
              currentLocationPlaceMark.locality;
          HealingMatchConstants.serviceUserPrefecture =
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

  Future<Map<String, dynamic>> _registerUserDetails() async {
    var userName = userNameController.text.toString();
    var email = emailController.text.toString();
    var userPhoneNumber = phoneNumberController.text.toString();
    var password = passwordController.text.toString().trim();
    var confirmPassword = confirmPasswordController.text.toString().trim();

    var userDOB = _userDOBController.text.toString();
    var userAge = ageController.text.toString().trim();
    int ageOfUser = int.tryParse(userAge);
    print('User Age : $ageOfUser');

    var buildingName = buildingNameController.text.toString();
    var userArea = userAreaController.text.toString();
    var roomNumber = roomNumberController.text.toString();
    int userRoomNumber = int.tryParse(roomNumber);
    print('Room number : $userRoomNumber');
    int phoneNumber = int.tryParse(userPhoneNumber);

    var userGPSAddress = gpsAddressController.text.toString().trim();

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

    if (userName.length > 20) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('ユーザー名は20文字以内で入力してください。',
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
    if (userName.length == 0 || userName.isEmpty || userName == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効なユーザー名を入力してください。',
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

    // user gender validation
    if (_myGender == null || _myGender.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('有効な性別を選択してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    // user Occupation validation
    if (_myOccupation == null || _myOccupation.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('有効な職業を選択してください。', style: TextStyle(fontFamily: 'Open Sans')),
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
    if (userPhoneNumber.length > 11 ||
        userPhoneNumber == null ||
        userPhoneNumber.isEmpty ||
        userPhoneNumber.length < 11) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('11文字以上の電話番号を入力してください。',
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

    if (!(email.contains(regexMail))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効なメールアドレスを入力してください。',
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
    if (email.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('メールアドレスは100文字以内で入力してください。',
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
      return null;
    }

    if (password.length < 8 || confirmPassword.length < 8) {
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
      return null;
    }

    if (password.length > 14 || confirmPassword.length > 14) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードは14文字以内で入力してください。 ',
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
      return null;
    }

    if (password != confirmPassword) {
      //print("Entering password state");
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('パスワードと確認パスワードの入力が一致しません。',
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
      return null;
    }

    if (_myAddressInputType == null || _myAddressInputType.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な住所の種類を選択してください。',
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

    // user place for massage validation
    if (_myCategoryPlaceForMassage == null ||
        _myCategoryPlaceForMassage.isEmpty) {
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

    // user perfecture validation
    if (_myPrefecture == null || _myPrefecture.isEmpty) {
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

    // user city validation
    if (_myCity == null || _myCity.isEmpty) {
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

    // user area validation
    if (userArea == null || userArea.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な都、県選 を入力してください。',
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
    // user building name validation
    if (buildingName == null || buildingName.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content:
            Text('有効なビル名を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return null;
    }

    // room number validation
    if (roomNumber == null || roomNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('有効な部屋番号を入力してください。',
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

    // Getting user GPS Address value
    if (_myAddressInputType.contains('現在地を取得する') && _isGPSLocation) {
      HealingMatchConstants.userAddress = userGPSAddress;
      print('GPS Address : ${HealingMatchConstants.userAddress}');
    } else if (HealingMatchConstants.userAddress.isEmpty) {
      String address = roomNumber +
          ',' +
          buildingName +
          ',' +
          userArea +
          ',' +
          _myCity +
          ',' +
          _myPrefecture;

      List<Placemark> userAddress =
          await geoLocator.placemarkFromAddress(address);
      userAddedAddressPlaceMark = userAddress[0];
      Position addressPosition = userAddedAddressPlaceMark.position;
      HealingMatchConstants.currentLatitude = addressPosition.latitude;
      HealingMatchConstants.currentLongitude = addressPosition.longitude;
      HealingMatchConstants.serviceUserCity =
          userAddedAddressPlaceMark.locality;
      HealingMatchConstants.serviceUserPrefecture =
          userAddedAddressPlaceMark.administrativeArea;
      HealingMatchConstants.userAddress = address;

      print(
          'Manual Address lat lon : ${HealingMatchConstants.currentLatitude} && '
          '${HealingMatchConstants.currentLongitude}');
      print('Manual Place Json : ${userAddedAddressPlaceMark.toJson()}');
      print('Manual Address : ${HealingMatchConstants.userAddress}');
    }

    ProgressDialogBuilder.showRegisterProgressDialog(context);

    //Calling Service User API for Register
    try {
      //MultiPart request
      Uri registerUser = Uri.parse(HealingMatchConstants.REGISTER_USER_URL);
      var request = http.MultipartRequest('POST', registerUser);
      Map<String, String> headers = {"Content-Type": "multipart/form-data"};
      var profileImage = await http.MultipartFile.fromPath(
          'uploadProfileImgUrl', _profileImage.path);
      request.headers.addAll(headers);
      request.files.add(profileImage);
      print('Image upload filename : $_profileImage');
      request.fields.addAll({
        "userName": userName,
        "dob": userDOB,
        "age": userAge,
        "userOccupation": _myOccupation,
        "phoneNumber": userPhoneNumber,
        "email": email,
        "gender": _myGender,
        "uploadProfileImgUrl": _profileImage.path,
        "password": password,
        "password_confirmation": confirmPassword,
        "isTherapist": "0",
        "userPlaceForMassage": _myCategoryPlaceForMassage,
        "address": HealingMatchConstants.userAddress,
        "userPrefecture": HealingMatchConstants.serviceUserPrefecture,
        "city": HealingMatchConstants.serviceUserCity,
        "buildingName": buildingName,
        "area": userArea,
        "userRoomNumber": roomNumber,
        "lat": HealingMatchConstants.currentLatitude.toString(),
        "lon": HealingMatchConstants.currentLongitude.toString()
      });

      final userDetailsRequest = await request.send();
      final response = await http.Response.fromStream(userDetailsRequest);
      print("This is response: ${response.statusCode}\n${response.body}");
      if (StatusCodeHelper.isRegisterSuccess(response.statusCode, context)) {
        final Map userDetailsResponse = json.decode(response.body);
        final serviceUserDetails =
            ServiceUserRegisterModel.fromJson(userDetailsResponse);
        print('Response Status Message : ${serviceUserDetails.status}');
        Toast.show("正常にログインしました", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.CENTER,
            backgroundColor: Colors.lime,
            textColor: Colors.white);
        ProgressDialogBuilder.hideRegisterProgressDialog(context);
        NavigationRouter.switchToServiceUserBottomBar(context);
      } else {
        ProgressDialogBuilder.hideRegisterProgressDialog(context);
        print('Response error occured!');
      }
    } catch (e) {
      print(e.toString());
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
          cityDropDownValues.add(cityList.cityJa);
        });
      }
      ProgressDialogBuilder.hideGetCitiesProgressDialog(context);
      print('Response City list : ${response.body}');
    });
  }
}
