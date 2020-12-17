import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:intl/intl.dart';

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
  TextEditingController _date = new TextEditingController();

  String _selectedDOBDate = 'Tap to select date';
  double age = 0.0;
  var selectedYear;
  final ageController = TextEditingController();
  String ageOfUser;
  String _myGender;
  String _myOccupation;
  String _myAddressInputType;
  String _myCategoryPlaceForMassage;
  String _myPrefecture;
  String _myCity;
  bool _showCurrentLocationInput = false;
  bool _secureText = true;
  final _genderKey = new GlobalKey<FormState>();

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  bool _isLoggedIn = false;

//Date picker

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2021),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _selectedDOBDate = new DateFormat("yyyy-MM-dd").format(picked);
        _date.value = TextEditingValue(text: _selectedDOBDate.toString());
        //print(_selectedDOBDate);
        selectedYear = picked.year;
        calculateAge();
      });
    }
  }

  void calculateAge() {
    setState(() {
      age = (2020 - selectedYear).toDouble();
      ageOfUser = age.toString();
      //print('Age : $ageOfUser');
      ageController.value = TextEditingValue(text: age.toStringAsFixed(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    maxRadius: 40,
                    child: Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      //enableInteractiveSelection: false,
                      autofocus: false,
                      //controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                                  controller: _date,
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
                      Center(
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
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Drop down occupation user
                  Form(
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
                      //controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                      //enableInteractiveSelection: false,
                      autofocus: false,
                      //controller: emailController,
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
                      obscureText: _secureText,
                      //controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                      //enableInteractiveSelection: false,
                      autofocus: false,
                      //controller: emailController,
                      obscureText: _secureText,
                      keyboardType: TextInputType.emailAddress,
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
                        readOnly: true,
                        decoration: new InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: '現在地を取得する *',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.location_on),
                              onPressed: () {
                                print('location getting....');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: DropDownFormField(
                            hintText: 'エリア *',
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
                      Container(
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
                    ],
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
                            //controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                          //controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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
                      //controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                      onPressed: () => print("Button Pressed"),
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
}
