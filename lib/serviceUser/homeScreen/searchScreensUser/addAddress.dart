import 'dart:convert';
import 'dart:io';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/ListViewAnimation/ListAnimationClass.dart';
import 'package:gps_massageapp/customLibraryClasses/dropdowns/dropDownServiceUserRegisterScreen.dart';
import 'package:gps_massageapp/models/customModels/userAddressAdd.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/cityListResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/register/stateListResponseModel.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';
import 'package:http/http.dart' as http;

class SearchAddAddress extends StatefulWidget {
  final callBack;
  final List<String> addressDropDownValues;

  SearchAddAddress(this.callBack, this.addressDropDownValues);

  @override
  State<StatefulWidget> createState() => new _AddAddressState();
}

class _AddAddressState extends State<SearchAddAddress> {
  final Geolocator addAddressgeoLocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _addAddressPosition;
  String _addedAddress = '';
  String _myAddedAddressInputType = '';
  String _myAddedPrefecture = '';
  String _myAddedCity = '';
  String _myCategoryPlaceForMassage = '';
  int _stateID;
  int _cityID;
  var stopLoading;
  final _addedAddressTypeKey = new GlobalKey<FormState>();
  final _addedPrefectureKey = new GlobalKey<FormState>();
  final _placeOfAddressKey = new GlobalKey<FormState>();
  final _addedCityKey = new GlobalKey<FormState>();
  final additionalAddressController = new TextEditingController();
  final addedBuildingNameController = new TextEditingController();
  final addedUserAreaController = new TextEditingController();
  final addedRoomNumberController = new TextEditingController();
  final otherController = new TextEditingController();
  List<dynamic> addedAddressStateDropDownValues = List();
  List<dynamic> addedAddressCityDropDownValues = List();
  List<String> addressDropDownValues = List<String>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AddUserSubAddress addUserAddress;
  StatesListResponseModel states;
  CitiesListResponseModel cities;
  var _addedAddressPrefId;
  bool visible = false;
  double containerHeight = 48.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressDropDownValues.addAll(widget.addressDropDownValues);
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
                                            requiredField: true,
                                            hintText: '登録する地点のカテゴリー ',
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
                                            dataSource: addressDropDownValues,
                                            isList: true,
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
                                                                  requiredField:
                                                                      true,
                                                                  hintText:
                                                                      '都道府県',
                                                                  value:
                                                                      _myAddedPrefecture,
                                                                  onSaved:
                                                                      (value) {
                                                                    _stateID =
                                                                        addedAddressStateDropDownValues.indexOf(value) +
                                                                            1;
                                                                    setState(
                                                                        () {
                                                                      _myAddedPrefecture =
                                                                          value;
                                                                    });
                                                                  },
                                                                  onChanged:
                                                                      (value) {
                                                                    _stateID =
                                                                        addedAddressStateDropDownValues.indexOf(value) +
                                                                            1;
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
                                                                      '都道府県',
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
                                                                  requiredField:
                                                                      true,
                                                                  hintText:
                                                                      '市区町村',
                                                                  value:
                                                                      _myAddedCity,
                                                                  onSaved:
                                                                      (value) {
                                                                    _cityID =
                                                                        addedAddressCityDropDownValues.indexOf(value) +
                                                                            1;
                                                                    setState(
                                                                        () {
                                                                      _myAddedCity =
                                                                          value;
                                                                    });
                                                                  },
                                                                  onChanged:
                                                                      (value) {
                                                                    _cityID =
                                                                        addedAddressCityDropDownValues.indexOf(value) +
                                                                            1;
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
                                                                  hintText:
                                                                      '市区町村',
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
                          child: ArgonButton(
                            height: 45,
                            width:
                                MediaQuery.of(context).size.width - 20.0, //350,
                            borderRadius: 5.0,
                            color: ColorConstants.buttonColor,
                            child: new Text(
                              '追加',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'NotoSansJP',
                                  fontSize: 16),
                            ),
                            loader: Container(
                              padding: EdgeInsets.all(10),
                              child: SpinKitRotatingCircle(
                                color: Colors.white,
                                // size: loaderWidth ,
                              ),
                            ),
                            onTap: (startLoading, stopLoading, btnState) {
                              if (btnState == ButtonState.Idle) {
                                this.stopLoading = stopLoading;
                                startLoading();
                                validateAddress();
                              }
                            },
                          ), /* new RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                            color: Colors.lime,
                            onPressed: () {
                              validateAddress();
                            },
                            child: new Text(
                              '追加',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ), */
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

  //validateSelection
  validateAddress() {
    if (_myCategoryPlaceForMassage.isEmpty) {
      stopLoading();
      print('Manual address empty fields');
      displaySnackBar("登録する地点のカテゴリーを選択してください。");

      return;
    }

    if (_myAddedPrefecture.isEmpty) {
      stopLoading();
      print('Manual address empty fields');
      displaySnackBar("有効な都道府県を選択してください。");

      return;
    }

    if (_myAddedCity.isEmpty) {
      stopLoading();
      print('Manual address empty fields');
      displaySnackBar("有効な市区町村を選択してください。");

      return;
    }

    if (addedUserAreaController.text.isEmpty) {
      stopLoading();
      print('Manual address empty fields');
      displaySnackBar("有効な丁目と番地を入力してください。");

      return;
    }

    if (_myCategoryPlaceForMassage == 'その他（直接入力）') {}
    if (_myCategoryPlaceForMassage == 'その他（直接入力）' &&
        otherController.text.isEmpty) {
      stopLoading();
      print('Manual address empty fields');
      displaySnackBar("登録する地点のカテゴリーを入力してください。");

      return;
    }

    saveNewAddress();
  }

  saveNewAddress() async {
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
    // print('Manual Place Json : ${manualUserAddress.toJson()}');
    print('Manual Address : ${HealingMatchConstants.manualUserAddress}');
    addUserAddress = AddUserSubAddress(
        HealingMatchConstants.serviceUserID,
        manualAddedAddress,
        HealingMatchConstants.manualAddressCurrentLatitude.toString(),
        HealingMatchConstants.manualAddressCurrentLongitude.toString(),
        otherController.text,
        _myCategoryPlaceForMassage,
        _myAddedCity,
        _myAddedPrefecture,
        addedRoomNumberController.text,
        addedBuildingNameController.text,
        addedUserAreaController.text,
        prefectureID: _stateID,
        cityID: _cityID);
    ServiceUserAPIProvider.addUserAddress(context, addUserAddress);
  }

  void displaySnackBar(String errorText) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      duration: Duration(seconds: 4),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text('$errorText',
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
  }
}
