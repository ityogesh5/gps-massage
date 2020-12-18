import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:convert';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class RegisterUserScreen extends StatefulWidget {
  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  double age = 0.0;
  var selectedYear;
  final ageController = TextEditingController();
  var _ageOfUser;
  var _myGender;
  var _myOccupation;
  var _myAddressInputType;
  var _myCategoryPlaceForMassage;
  var _myPrefecture;
  var _myCity;
  var _myBuildingNumber;

  var _myArea;

  var _myRoomNumber;

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

  //final gpsAddressController = new TextEditingController();

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
      age = (2020 - selectedYear).toDouble();
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
      body: Container(
        child: Form(
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('サービスセラピストに関する情報を入力する',
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
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        maxRadius: 40,
                        child: IconButton(
                          icon: SvgPicture.asset(
                              'assets/images_gps/profile_pic_user.svg',
                              height: 70,
                              width: 70,
                              color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        right: 15.0,
                        top: 40,
                        left: 45,
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          maxRadius: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.white60,
                            child: Icon(Icons.upload_outlined,
                                color: Colors.grey[500], size: 20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      //enableInteractiveSelection: false,
                      maxLength: 20,
                      autofocus: false,
                      controller: userNameController,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: '名前 *',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          focusColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
                      // validator: (value) => _validateEmail(value),
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
                                      fillColor: Colors.white,
                                      labelText: '生年月日 *',
                                      labelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Color.fromRGBO(211, 211, 211, 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                        borderRadius: BorderRadius.circular(1),
                                      )),
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
                                  fillColor: Colors.white,
                                  labelText: '年齢',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1.0),
                                    borderRadius: BorderRadius.circular(1),
                                  )),
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
                            width: MediaQuery.of(context).size.width * 0.40,
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
                      maxLength: 11,
                      controller: phoneNumberController,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: '電話番号 *',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          focusColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
                      // validator: (value) => _validateEmail(value),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      maxLength: 50,
                      //enableInteractiveSelection: false,
                      autofocus: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'メールアドレス',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          focusColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
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
                      maxLength: 14,
                      obscureText: _secureText,
                      controller: passwordController,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'パスワード *',
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
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
                      // validator: (value) => _validateEmail(value),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      maxLength: 14,
                      //enableInteractiveSelection: false,
                      autofocus: false,
                      controller: confirmPasswordController,
                      obscureText: _secureText,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'パスワード (確認用) *',
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
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
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
                                    _showCurrentLocationInput =
                                        !_showCurrentLocationInput;
                                  } else {
                                    _showCurrentLocationInput =
                                        !_showCurrentLocationInput;
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
                            fillColor: Colors.white,
                            labelText: '現在地を取得する *',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.location_on),
                              onPressed: () {
                                print('location getting....');
                                _getCurrentLocation();
                              },
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            focusColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(0),
                            )),
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
                  Form(
                    key: _perfectureKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.38,
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
                                  //print(_myBldGrp.toString());
                                });
                              },
                              dataSource: [
                                {
                                  "display": "名古屋市",
                                  "value": "男性",
                                },
                                {
                                  "display": "豊橋市",
                                  "value": "女性",
                                },
                                {
                                  "display": "岡崎市",
                                  "value": "どちらでもない",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                        ),
                        Form(
                          key: _cityKey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.38,
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
                              dataSource: [
                                {
                                  "display": "名古屋市",
                                  "value": "男性",
                                },
                                {
                                  "display": "豊橋市",
                                  "value": "女性",
                                },
                                {
                                  "display": "一宮市",
                                  "value": "どちらでもない",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                            //enableInteractiveSelection: false,
                            autofocus: false,
                            controller: buildingNameController,
                            decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'ビル名 *',
                                labelStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                focusColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(0),
                                )),
                            // validator: (value) => _validateEmail(value),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: TextFormField(
                          //enableInteractiveSelection: false,
                          autofocus: false,
                          controller: userAreaController,
                          decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: '都、県選 *',
                              labelStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                              focusColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(0),
                              )),
                          // validator: (value) => _validateEmail(value),
                        ),
                      ),
                    ],
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
                          fillColor: Colors.white,
                          labelText: '部屋番号 *',
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          focusColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(0),
                          )),
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
                        print('Register User');
                        _registerUserDetails();
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
                  Text('すでにアカウントをお持ちの方',
                      style: new TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.underline)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Get current address from Latitude Longitude
  _getCurrentLocation() {
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
      setState(() {
        _currentAddress =
            '${place.locality},${place.subAdministrativeArea},${place.postalCode},${place.country}';
        print('Place Json : ${place.toJson()}');
        if (_currentAddress != null && _currentAddress.isNotEmpty) {
          print('Current address : $_currentAddress');
          setState(() {
            _isGPSLocation = true;
          });
          gpsAddressController.value = TextEditingValue(text: _currentAddress);
        } else {
          return null;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  _registerUserDetails() async {
    var userName = userNameController.text.toString();
    var email = emailController.text.toString();
    var userPhoneNumber = phoneNumberController.text.toString();
    var password = passwordController.text.toString();
    var confirmPassword = confirmPasswordController.text.toString();

    var userDOB = _userDOBController.text.toString();
    var userAge = ageController.text.toString();
    int ageOfUser = int.tryParse(userAge);
    print('User Age : $ageOfUser');

    var userGender = _myGender.toString();
    var userOccupation = _myOccupation.toString();
    var userAddressType = _myAddressInputType.toString();
    var placeForMassage = _myCategoryPlaceForMassage.toString();
    var city = _myCity.toString();
    var _userPrefecture = _myPrefecture.toString();
    var buildingName = buildingNameController.text.toString();
    var userArea = userAreaController.text.toString();
    var roomNumber = roomNumberController.text.toString();
    int userRoomNumber = int.tryParse(roomNumber);
    print('Room number : $userRoomNumber');

    var userGPSAddress = gpsAddressController.text.toString();
    if (_isGPSLocation) {
      HealingMatchConstants.gpsAddress = userGPSAddress;
    } else {}

    if (userName.length > 20) {
      //print('en 1');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('ユーザー名は20文字以内で入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
    if (userName.length == 0 || userName.isEmpty || userName == null) {
      //print('en 2');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('有効なユーザー名を入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
    if (!(email.contains(regexMail))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('有効なメールアドレスを入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
    if (email.length > 50) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('メールアドレスは100文字以内で入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
    if ((email.contains(regexEmojis))) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("有効なメールアドレスを入力してください。",
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }

    if (password.length < 8 || confirmPassword.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('パスワードは8文字以上で入力してください。  ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }

    if (password.length > 14 || confirmPassword.length > 14) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('パスワードは15文字以内で入力してください。 ',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }

    // Combination password

    // print('Password regex value : $password');
    if (!passwordRegex.hasMatch(password)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('パスワードには、大文字、小文字、数字、特殊文字を1つ含める必要があります。'),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }

    if (password != confirmPassword) {
      //print("Entering password state");
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('パスワードと確認パスワードの入力が一致しません。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
    if (password.contains(regexEmojis)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('有効な文字でパスワードを入力してください。',
            style: TextStyle(fontFamily: 'Open Sans')),
        action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'Ok',
        ),
      ));
      return;
    }
  }
}
