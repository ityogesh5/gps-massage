import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/estheticDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/fitnessDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/messageServicePriceModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/relaxationDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/treatmentDropDownModel.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ChooseServiceScreen extends StatefulWidget {
  @override
  _ChooseServiceScreenState createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  List<String> selectedEstheticDropdownValues = List<String>();
  List<String> selectedRelaxationDropdownValues = List<String>();
  List<String> selectedTreatmentDropdownValues = List<String>();
  List<String> selectedFitnessDropdownValues = List<String>();
  List<String> estheticDropDownValues = List<String>();
  List<String> treatmentDropDownValues = List<String>();
  List<String> relaxationDropDownValues = List<String>();
  List<String> fitnessDropDownValues = List<String>();
  List<String> otherEstheticDropDownValues = List<String>();
  List<String> otherTreatmentDropDownValues = List<String>();
  List<String> otherRelaxationDropDownValues = List<String>();
  List<String> otherFitnessDropDownValues = List<String>();
  List<ServicePriceModel> estheticServicePriceModel = List<ServicePriceModel>();
  List<ServicePriceModel> relaxationServicePriceModel =
      List<ServicePriceModel>();
  List<ServicePriceModel> treatmentServicePriceModel =
      List<ServicePriceModel>();
  List<ServicePriceModel> fitnessServicePriceModel = List<ServicePriceModel>();
  List<bool> otherSelected = List<bool>();
  bool estheticOtherSelected = false;
  bool relaxtionOtherSelected = false;
  bool treatmentOtherSelected = false;
  bool fitnessOtherSelected = false;
  int estheticStatus = 0;
  int relaxtionStatus = 0;
  int treatmentStatus = 0;
  int fitnessStatus = 0;

  // TextEditingController sampleOthersController = TextEditingController();
  String otherValueText;
  EstheticDropDownModel estheticDropDownModel;
  RelaxationDropDownModel relaxationDropDownModel;
  TreatmentDropDownModel treatmentDropDownModel;
  FitnessDropDownModel fitnessDropDownModel;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getSavedValues();
    otherSelected = [false, false, false, false];
  }

  /*  void showProgressDialog() {
    _progressDialog.showProgressDialog(context,
        textToBeDisplayed: '読み込み中...', dismissAfter: Duration(seconds: 5));
  }

  void hideProgressDialog() {
    _progressDialog.dismissProgressDialog(context);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0.0,
          title: Text(
            HealingMatchConstants.registrationChooseServiceNavBtn,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  HealingMatchConstants.chooseServiceFirstText,
                  style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1), fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                //Esthetic DropDown
                HealingMatchConstants.serviceProviderStoreType.contains('エステ')
                    ? InkWell(
                        onTap: () {
                          if (estheticDropDownValues.length == 0) {
                            ProgressDialogBuilder.showCommonProgressDialog(
                                context);
                            getEstheticList();
                          } else {
                            setState(() {
                              estheticStatus == 0
                                  ? estheticStatus = 1
                                  : estheticStatus = 0;
                            });
                          }
                        },
                        child: SizedBox(
                          height: 51.0,
                          child: TextFormField(
                            enabled: false,
                            initialValue: HealingMatchConstants
                                .chooseServiceEstheticDropDown,
                            style: HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              focusedBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              disabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              enabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              suffixIcon: IconButton(
                                  icon: estheticStatus == 0
                                      ? Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        )
                                      : Icon(
                                          Icons.keyboard_arrow_up,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        ),
                                  onPressed: () {
                                    if (estheticDropDownValues.length == 0) {
                                      ProgressDialogBuilder
                                          .showCommonProgressDialog(context);
                                      getEstheticList();
                                    } else {
                                      setState(() {
                                        estheticStatus == 0
                                            ? estheticStatus = 1
                                            : estheticStatus = 0;
                                      });
                                    }
                                  }),
                              filled: true,
                              fillColor: ColorConstants.formFieldFillColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('エステ')
                      ? 15
                      : 0,
                ),
                estheticStatus == 1
                    ? Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: estheticDropDownValues.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return buildCheckBoxContent(
                                  estheticDropDownValues[index], index, 0);
                            }),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('エステ')
                      ? 20.0
                      : 0,
                ),

                //Relaxation DropDown
                HealingMatchConstants.serviceProviderStoreType
                        .contains('リラクゼーション')
                    ? InkWell(
                        onTap: () {
                          if (relaxationDropDownValues.length == 0) {
                            ProgressDialogBuilder.showCommonProgressDialog(
                                context);
                            getRelaxationList();
                          } else {
                            setState(() {
                              relaxtionStatus == 0
                                  ? relaxtionStatus = 1
                                  : relaxtionStatus = 0;
                            });
                          }
                        },
                        child: SizedBox(
                          height: 51.0,
                          child: TextFormField(
                            enabled: false,
                            initialValue: HealingMatchConstants
                                .chooseServiceRelaxationDropDown,
                            style: HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              focusedBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              disabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              enabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              suffixIcon: IconButton(
                                  icon: relaxtionStatus == 0
                                      ? Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        )
                                      : Icon(
                                          Icons.keyboard_arrow_up,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        ),
                                  onPressed: () {
                                    if (relaxationDropDownValues.length == 0) {
                                      ProgressDialogBuilder
                                          .showCommonProgressDialog(context);
                                      getRelaxationList();
                                    } else {
                                      setState(() {
                                        relaxtionStatus == 0
                                            ? relaxtionStatus = 1
                                            : relaxtionStatus = 0;
                                      });
                                    }
                                  }),
                              filled: true,
                              fillColor: ColorConstants.formFieldFillColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('リラクゼーション')
                      ? 15
                      : 0,
                ),
                relaxtionStatus == 1
                    ? Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: relaxationDropDownValues.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return buildCheckBoxContent(
                                  relaxationDropDownValues[index], index, 1);
                            }),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('リラクゼーション')
                      ? 20.0
                      : 0,
                ),

                //Treatment DropDown
                HealingMatchConstants.serviceProviderStoreType.contains('接骨・整体')
                    ? InkWell(
                        onTap: () {
                          if (treatmentDropDownValues.length == 0) {
                            ProgressDialogBuilder.showCommonProgressDialog(
                                context);
                            getTreatmentList();
                          } else {
                            setState(() {
                              treatmentStatus == 0
                                  ? treatmentStatus = 1
                                  : treatmentStatus = 0;
                            });
                          }
                        },
                        child: SizedBox(
                          height: 51.0,
                          child: TextFormField(
                            enabled: false,
                            initialValue: HealingMatchConstants
                                .chooseServiceTreatmentDropDown,
                            style: HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              focusedBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              disabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              enabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              suffixIcon: IconButton(
                                  icon: treatmentStatus == 0
                                      ? Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        )
                                      : Icon(
                                          Icons.keyboard_arrow_up,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        ),
                                  onPressed: () {
                                    if (treatmentDropDownValues.length == 0) {
                                      ProgressDialogBuilder
                                          .showCommonProgressDialog(context);
                                      getTreatmentList();
                                    } else {
                                      setState(() {
                                        treatmentStatus == 0
                                            ? treatmentStatus = 1
                                            : treatmentStatus = 0;
                                      });
                                    }
                                  }),
                              filled: true,
                              fillColor: ColorConstants.formFieldFillColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('接骨・整体')
                      ? 15
                      : 0,
                ),
                treatmentStatus == 1
                    ? Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: treatmentDropDownValues.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return buildCheckBoxContent(
                                  treatmentDropDownValues[index], index, 2);
                            }),
                      )
                    : Container(),

                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('接骨・整体')
                      ? 20.0
                      : 0,
                ),

                //Fitness DropDown
                HealingMatchConstants.serviceProviderStoreType
                        .contains('フィットネス')
                    ? InkWell(
                        onTap: () {
                          if (fitnessDropDownValues.length == 0) {
                            ProgressDialogBuilder.showCommonProgressDialog(
                                context);
                            getFitnessList();
                          } else {
                            setState(() {
                              fitnessStatus == 0
                                  ? fitnessStatus = 1
                                  : fitnessStatus = 0;
                            });
                          }
                        },
                        child: SizedBox(
                          height: 51.0,
                          child: TextFormField(
                            enabled: false,
                            initialValue: HealingMatchConstants
                                .chooseServiceFitnessDropDown,
                            style: HealingMatchConstants.formHintTextStyle,
                            decoration: new InputDecoration(
                              focusedBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              disabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              enabledBorder:
                                  HealingMatchConstants.textFormInputBorder,
                              suffixIcon: IconButton(
                                  icon: fitnessStatus == 0
                                      ? Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        )
                                      : Icon(
                                          Icons.keyboard_arrow_up,
                                          size: 35.0,
                                          color: Colors
                                              .black, //Color.fromRGBO(200, 200, 200, 1),
                                        ),
                                  onPressed: () {
                                    if (fitnessDropDownValues.length == 0) {
                                      ProgressDialogBuilder
                                          .showCommonProgressDialog(context);
                                      getFitnessList();
                                    } else {
                                      setState(() {
                                        fitnessStatus == 0
                                            ? fitnessStatus = 1
                                            : fitnessStatus = 0;
                                      });
                                    }
                                  }),
                              filled: true,
                              fillColor: ColorConstants.formFieldFillColor,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('フィットネス')
                      ? 15
                      : 0,
                ),
                fitnessStatus == 1
                    ? Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: fitnessDropDownValues.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return buildCheckBoxContent(
                                  fitnessDropDownValues[index], index, 3);
                            }),
                      )
                    : Container(),
                SizedBox(
                  height: HealingMatchConstants.serviceProviderStoreType
                          .contains('フィットネス')
                      ? 20.0
                      : 0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            "更新",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          color: ColorConstants.buttonColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            saveSelectedValues();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "税込価格を入力して保存してください",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Build CheckBox Contents for the Dropdown Function for the list got from APi
  //mindex represents the dropdown values 0-Esthetic 1-Relaxation 2-Treatment 3-Fitness
  buildCheckBoxContent(String val, int index, int mindex) {
    bool checkValue = false;
    int indexPos = 0;
    List<String> selectedDropdownValues = List<String>();
    List<ServicePriceModel> servicePriceModel = List<ServicePriceModel>();
    if (mindex == 0) {
      selectedDropdownValues.addAll(selectedEstheticDropdownValues);
      servicePriceModel.addAll(estheticServicePriceModel);
    } else if (mindex == 1) {
      selectedDropdownValues.addAll(selectedRelaxationDropdownValues);
      servicePriceModel.addAll(relaxationServicePriceModel);
    } else if (mindex == 2) {
      selectedDropdownValues.addAll(selectedTreatmentDropdownValues);
      servicePriceModel.addAll(treatmentServicePriceModel);
    } else if (mindex == 3) {
      selectedDropdownValues.addAll(selectedFitnessDropdownValues);
      servicePriceModel.addAll(fitnessServicePriceModel);
    }
    if (val == HealingMatchConstants.chooseServiceOtherDropdownFiled) {
      checkValue = otherSelected[mindex];
    } else {
      checkValue = selectedDropdownValues.contains(val.toLowerCase());
      if (checkValue) {
        indexPos = getIndex(val, servicePriceModel);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
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
                            onChanged: (bool newValue) {
                              setState(() {
                                if (newValue == null) {
                                  //if the value gets unselected in checkbox
                                  checkValue = false;
                                  if (val !=
                                      HealingMatchConstants
                                          .chooseServiceOtherDropdownFiled) {
                                    //for values other than the field "other"
                                    selectedDropdownValues
                                        .remove(val.toLowerCase());
                                    servicePriceModel.removeAt(indexPos);
                                    if (mindex == 0) {
                                      selectedEstheticDropdownValues.clear();
                                      estheticServicePriceModel.clear();
                                      selectedEstheticDropdownValues
                                          .addAll(selectedDropdownValues);
                                      estheticServicePriceModel
                                          .addAll(servicePriceModel);
                                    } else if (mindex == 1) {
                                      selectedRelaxationDropdownValues.clear();
                                      relaxationServicePriceModel.clear();
                                      selectedRelaxationDropdownValues
                                          .addAll(selectedDropdownValues);
                                      relaxationServicePriceModel
                                          .addAll(servicePriceModel);
                                    } else if (mindex == 2) {
                                      selectedTreatmentDropdownValues.clear();
                                      treatmentServicePriceModel.clear();
                                      selectedTreatmentDropdownValues
                                          .addAll(selectedDropdownValues);
                                      treatmentServicePriceModel
                                          .addAll(servicePriceModel);
                                    } else if (mindex == 3) {
                                      selectedFitnessDropdownValues.clear();
                                      fitnessServicePriceModel.clear();
                                      selectedFitnessDropdownValues
                                          .addAll(selectedDropdownValues);
                                      fitnessServicePriceModel
                                          .addAll(servicePriceModel);
                                    }
                                  } else {
                                    otherSelected[mindex] = false;
                                  }
                                } else {
                                  //if the value is selected
                                  if (val ==
                                      HealingMatchConstants
                                          .chooseServiceOtherDropdownFiled) {
                                    // for the field other
                                    checkValue = true;
                                    otherSelected[mindex] = true;
                                  } else {
                                    //for the remaining fields
                                    showTimeandPriceDialog(val, checkValue,
                                        indexPos, mindex, index);
                                  }
                                }
                              });
                            },
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            //if the value is selected
                            if (val ==
                                HealingMatchConstants
                                    .chooseServiceOtherDropdownFiled) {
                              // for the field other
                              setState(() {
                                checkValue = true;
                                otherSelected[mindex] = true;
                              });
                            } else {
                              //for the remaining fields
                              showTimeandPriceDialog(
                                  val, checkValue, indexPos, mindex, index);
                            }
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
                  Text("$val", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            //for the Edit option displayed
            val != HealingMatchConstants.chooseServiceOtherDropdownFiled &&
                    checkValue == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[400],
                            ),
                            shape: BoxShape.circle),
                        child: Center(
                          child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/images_gps/edit_button.svg",
                                height: 20.0,
                                width: 20.0,
                              ),
                              onPressed: () {
                                showTimeandPriceDialog(
                                    val, checkValue, indexPos, mindex, index);
                              }),
                        ),
                      )
                    ],
                  )
                : Container()
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        //other addition field display
        (checkValue == true &&
                val == HealingMatchConstants.chooseServiceOtherDropdownFiled)
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 50.0,
                      child: TextFormField(
                        //  controller: sampleOthersController,
                        onChanged: (val) {
                          otherValueText = val;
                        },
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey[400],
                              width: 0.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey[400],
                              width: 0.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey[400],
                              width: 0.0,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, right: 8.0, top: 8.0, bottom: 8.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  otherValueText = otherValueText.toLowerCase();
                                  //Logic: check the value is empty
                                  if (otherValueText.isEmpty ||
                                      otherValueText == '') {
                                    showEmptyErrorMessage();
                                  } else {
                                    //Logic: check the value is already present, if not insert before other field index
                                    if (mindex == 0) {
                                      if (estheticDropDownValues
                                          .contains(otherValueText)) {
                                        showDuplicateErrorMessage();
                                      } else {
                                        estheticDropDownValues.insert(
                                            index, otherValueText);
                                        otherEstheticDropDownValues
                                            .add(otherValueText);
                                      }
                                    } else if (mindex == 1) {
                                      if (relaxationDropDownValues
                                          .contains(otherValueText)) {
                                        showDuplicateErrorMessage();
                                      } else {
                                        relaxationDropDownValues.insert(
                                            index, otherValueText);
                                        otherRelaxationDropDownValues
                                            .add(otherValueText);
                                      }
                                    } else if (mindex == 2) {
                                      if (treatmentDropDownValues
                                          .contains(otherValueText)) {
                                        showDuplicateErrorMessage();
                                      } else {
                                        treatmentDropDownValues.insert(
                                            index, otherValueText);
                                        otherTreatmentDropDownValues
                                            .add(otherValueText);
                                      }
                                    } else if (mindex == 3) {
                                      if (fitnessDropDownValues
                                          .contains(otherValueText)) {
                                        showDuplicateErrorMessage();
                                      } else {
                                        fitnessDropDownValues.insert(
                                            index, otherValueText);
                                        otherFitnessDropDownValues
                                            .add(otherValueText);
                                      }
                                    }
                                  }
                                  otherValueText = "";
                                  //  sampleOthersController.clear();
                                });
                              },
                              child: Text(
                                HealingMatchConstants
                                    .chooseServiceAddtoDropdownButton,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: ColorConstants.buttonColor,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: HealingMatchConstants
                              .chooseServiceAddTextFormField,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            : Container(),
        //Build the MultiSelect Chips below the selected CheckBox
        (checkValue == true &&
                val != HealingMatchConstants.chooseServiceOtherDropdownFiled)
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 18.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: checkAddedPrice(indexPos, servicePriceModel),
                ),
              )
            : Container(),
      ],
    );
  }

  //Build the chips for the price greater than 0
  //indexpos represents the postion of the List Item in the pricemodel
  checkAddedPrice(int indexPos, List<ServicePriceModel> servicePriceModel) {
    List<Widget> values = List<Widget>();
    if ((servicePriceModel[indexPos].sixtyMin) != 0) {
      values.add(buildCheckBoxChip(servicePriceModel[indexPos].sixtyMin, 60));
    }
    if ((servicePriceModel[indexPos].nintyMin) != 0) {
      values.add(buildCheckBoxChip(servicePriceModel[indexPos].nintyMin, 90));
    }
    if ((servicePriceModel[indexPos].oneTwentyMin) != 0) {
      values.add(
          buildCheckBoxChip(servicePriceModel[indexPos].oneTwentyMin, 120));
    }
    if ((servicePriceModel[indexPos].oneFiftyMin) != 0) {
      values
          .add(buildCheckBoxChip(servicePriceModel[indexPos].oneFiftyMin, 150));
    }
    if ((servicePriceModel[indexPos].oneEightyMin) != 0) {
      values.add(
          buildCheckBoxChip(servicePriceModel[indexPos].oneEightyMin, 180));
    }
    return values;
  }

  //Design for the chips built which price greater than 0
  //min - minutes for which price is set.
  buildCheckBoxChip(int price, int min) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      // width: 110.0,
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
              "¥$price/$min分",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  //Popup Screen for setting the price
  //used mindex for checking which List should the selected value be stored
  //0-Esthetic 1-Relaxation 2-Treatment 3-Fitness
  showTimeandPriceDialog(
      String val, bool selected, int indexPos, int mindex, int index) {
    TextEditingController sixtyMinutesController = new TextEditingController();
    TextEditingController nintyMinuteController = new TextEditingController();
    TextEditingController oneTwentyMinuteController =
        new TextEditingController();
    TextEditingController oneFiftyController = new TextEditingController();
    TextEditingController oneEightyMinuteController =
        new TextEditingController();
    List<String> selectedDropdownValues = List<String>();
    List<ServicePriceModel> servicePriceModel = List<ServicePriceModel>();
    if (mindex == 0) {
      selectedDropdownValues.addAll(selectedEstheticDropdownValues);
      servicePriceModel.addAll(estheticServicePriceModel);
    } else if (mindex == 1) {
      selectedDropdownValues.addAll(selectedRelaxationDropdownValues);
      servicePriceModel.addAll(relaxationServicePriceModel);
    } else if (mindex == 2) {
      selectedDropdownValues.addAll(selectedTreatmentDropdownValues);
      servicePriceModel.addAll(treatmentServicePriceModel);
    } else if (mindex == 3) {
      selectedDropdownValues.addAll(selectedFitnessDropdownValues);
      servicePriceModel.addAll(fitnessServicePriceModel);
    }

    if (selected) {
      if (servicePriceModel[indexPos].sixtyMin != 0) {
        sixtyMinutesController.text =
            (servicePriceModel[indexPos].sixtyMin).toString();
      }

      if (servicePriceModel[indexPos].nintyMin != 0) {
        nintyMinuteController.text =
            (servicePriceModel[indexPos].nintyMin).toString();
      }

      if (servicePriceModel[indexPos].oneTwentyMin != 0) {
        oneTwentyMinuteController.text =
            (servicePriceModel[indexPos].oneTwentyMin).toString();
      }

      if (servicePriceModel[indexPos].oneFiftyMin != 0) {
        oneFiftyController.text =
            (servicePriceModel[indexPos].oneFiftyMin).toString();
      }

      if (servicePriceModel[indexPos].oneEightyMin != 0) {
        oneEightyMinuteController.text =
            (servicePriceModel[indexPos].oneEightyMin).toString();
      }
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    //SizedBox(height: 5),
                    Center(
                      child: Text(
                        "$val",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40.0,
                            //margin: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        enableInteractiveSelection: true,
                                        textAlign: TextAlign.center,
                                        controller: sixtyMinutesController,
                                        showCursor: true,

                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "¥0",
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.0,
                                    //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color:
                                            ColorConstants.formFieldFillColor,
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        )),
                                    child: Center(
                                      child: Text(
                                        "60分",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40.0,
                            //margin: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        enableInteractiveSelection: true,
                                        textAlign: TextAlign.center,
                                        controller: nintyMinuteController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "¥0",
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.0,
                                    //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color:
                                            ColorConstants.formFieldFillColor,
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        )),
                                    child: Center(
                                      child: Text(
                                        "90分",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40.0,
                            //margin: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        enableInteractiveSelection: true,
                                        controller: oneTwentyMinuteController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: "¥0",
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.0,
                                    //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color:
                                            ColorConstants.formFieldFillColor,
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        )),
                                    child: Center(
                                      child: Text(
                                        "120分",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40.0,
                            //margin: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        enableInteractiveSelection: true,
                                        textAlign: TextAlign.center,
                                        controller: oneFiftyController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "¥0",
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.0,
                                    //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color:
                                            ColorConstants.formFieldFillColor,
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        )),
                                    child: Center(
                                      child: Text(
                                        "150分",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40.0,
                            //margin: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        enableInteractiveSelection: true,
                                        textAlign: TextAlign.center,
                                        controller: oneEightyMinuteController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "¥0",
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40.0,
                                    //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color:
                                            ColorConstants.formFieldFillColor,
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        )),
                                    child: Center(
                                      child: Text(
                                        "180分",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Container(
                                    height: 40.0,
                                    child: RaisedButton(
                                      child: Text(
                                        "保存",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: ColorConstants.buttonColor,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0)),
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        print(estheticServicePriceModel);
                                        try {
                                          //check if any 0 value is entered
                                          if (sixtyMinutesController.text !=
                                                  "0" &&
                                              nintyMinuteController.text !=
                                                  "0" &&
                                              oneTwentyMinuteController.text !=
                                                  "0" &&
                                              oneFiftyController.text != "0" &&
                                              oneEightyMinuteController.text !=
                                                  "0") {
                                            //check any less or high value is entered
                                            int sixtyMinCon =
                                                sixtyMinutesController.text ==
                                                        ""
                                                    ? 0
                                                    : int.parse(
                                                        sixtyMinutesController
                                                            .text);
                                            int nintyMinCon =
                                                nintyMinuteController.text == ""
                                                    ? 0
                                                    : int.parse(
                                                        nintyMinuteController
                                                            .text);
                                            int oneTwentyMinCon =
                                                oneTwentyMinuteController
                                                            .text ==
                                                        ""
                                                    ? 0
                                                    : int.parse(
                                                        oneTwentyMinuteController
                                                            .text);
                                            int oneFiftyMinCon =
                                                oneFiftyController.text == ""
                                                    ? 0
                                                    : int.parse(
                                                        oneFiftyController
                                                            .text);
                                            int oneEightyMinCon =
                                                oneEightyMinuteController
                                                            .text ==
                                                        ""
                                                    ? 0
                                                    : int.parse(
                                                        oneEightyMinuteController
                                                            .text);

                                            if ((sixtyMinCon == 0
                                                    ? true
                                                    : sixtyMinCon >= 2500 &&
                                                        sixtyMinCon <= 50000) &&
                                                (nintyMinCon == 0
                                                    ? true
                                                    : nintyMinCon >= 2500 &&
                                                        nintyMinCon <= 50000) &&
                                                (oneTwentyMinCon == 0
                                                    ? true
                                                    : oneTwentyMinCon >= 2500 &&
                                                        oneTwentyMinCon <=
                                                            50000) &&
                                                (oneFiftyMinCon == 0
                                                    ? true
                                                    : oneFiftyMinCon >= 2500 &&
                                                        oneFiftyMinCon <=
                                                            50000) &&
                                                (oneEightyMinCon == 0
                                                    ? true
                                                    : oneEightyMinCon >= 2500 &&
                                                        oneEightyMinCon <=
                                                            50000)) {
                                              //if checkbox slected for the first time
                                              if (!selected) {
                                                //check if any values or entered or all empty
                                                if (sixtyMinutesController
                                                            .text !=
                                                        "" ||
                                                    nintyMinuteController
                                                            .text !=
                                                        "" ||
                                                    oneTwentyMinuteController
                                                            .text !=
                                                        "" ||
                                                    oneFiftyController.text !=
                                                        "" ||
                                                    oneEightyMinuteController
                                                            .text !=
                                                        "") {
                                                  //if entered then the empty values are treated as 0

                                                  servicePriceModel.add(
                                                    ServicePriceModel(
                                                        val,
                                                        sixtyMinutesController
                                                                    .text !=
                                                                ""
                                                            ? int.parse(
                                                                sixtyMinutesController
                                                                    .text)
                                                            : 0,
                                                        nintyMinuteController.text != ""
                                                            ? int.parse(
                                                                nintyMinuteController
                                                                    .text)
                                                            : 0,
                                                        oneTwentyMinuteController
                                                                    .text !=
                                                                ""
                                                            ? int.parse(
                                                                oneTwentyMinuteController
                                                                    .text)
                                                            : 0,
                                                        oneFiftyController.text != ""
                                                            ? int.parse(
                                                                oneFiftyController
                                                                    .text)
                                                            : 0,
                                                        oneEightyMinuteController
                                                                    .text !=
                                                                ""
                                                            ? int.parse(
                                                                oneEightyMinuteController.text)
                                                            : 0,
                                                        getID(index, mindex)),
                                                  );

                                                  selectedDropdownValues
                                                      .add(val.toLowerCase());
                                                  setState(() {
                                                    //checking with the mindex the values are added to corresponding lists
                                                    if (mindex == 0) {
                                                      selectedEstheticDropdownValues
                                                          .clear();
                                                      estheticServicePriceModel
                                                          .clear();
                                                      selectedEstheticDropdownValues
                                                          .addAll(
                                                              selectedDropdownValues);
                                                      estheticServicePriceModel
                                                          .addAll(
                                                              servicePriceModel);
                                                    } else if (mindex == 1) {
                                                      selectedRelaxationDropdownValues
                                                          .clear();
                                                      relaxationServicePriceModel
                                                          .clear();
                                                      selectedRelaxationDropdownValues
                                                          .addAll(
                                                              selectedDropdownValues);
                                                      relaxationServicePriceModel
                                                          .addAll(
                                                              servicePriceModel);
                                                    } else if (mindex == 2) {
                                                      selectedTreatmentDropdownValues
                                                          .clear();
                                                      treatmentServicePriceModel
                                                          .clear();
                                                      selectedTreatmentDropdownValues
                                                          .addAll(
                                                              selectedDropdownValues);
                                                      treatmentServicePriceModel
                                                          .addAll(
                                                              servicePriceModel);
                                                    } else if (mindex == 3) {
                                                      selectedFitnessDropdownValues
                                                          .clear();
                                                      fitnessServicePriceModel
                                                          .clear();
                                                      selectedFitnessDropdownValues
                                                          .addAll(
                                                              selectedDropdownValues);
                                                      fitnessServicePriceModel
                                                          .addAll(
                                                              servicePriceModel);
                                                    }
                                                    Navigator.pop(context);
                                                  });
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              }
                                              //if checkbox already selected then update logic is used
                                              else {
                                                servicePriceModel[indexPos]
                                                        .sixtyMin =
                                                    sixtyMinutesController
                                                                .text !=
                                                            ""
                                                        ? int.parse(
                                                            sixtyMinutesController
                                                                .text)
                                                        : 0;
                                                servicePriceModel[indexPos]
                                                        .nintyMin =
                                                    nintyMinuteController
                                                                .text !=
                                                            ""
                                                        ? int.parse(
                                                            nintyMinuteController
                                                                .text)
                                                        : 0;
                                                servicePriceModel[indexPos]
                                                        .oneTwentyMin =
                                                    oneTwentyMinuteController
                                                                .text !=
                                                            ""
                                                        ? int.parse(
                                                            oneTwentyMinuteController
                                                                .text)
                                                        : 0;
                                                servicePriceModel[indexPos]
                                                        .oneFiftyMin =
                                                    oneFiftyController.text !=
                                                            ""
                                                        ? int.parse(
                                                            oneFiftyController
                                                                .text)
                                                        : 0;
                                                servicePriceModel[indexPos]
                                                        .oneEightyMin =
                                                    oneEightyMinuteController
                                                                .text !=
                                                            ""
                                                        ? int.parse(
                                                            oneEightyMinuteController
                                                                .text)
                                                        : 0;
                                                setState(() {
                                                  if (mindex == 0) {
                                                    estheticServicePriceModel
                                                        .clear();
                                                    estheticServicePriceModel
                                                        .addAll(
                                                            servicePriceModel);
                                                  } else if (mindex == 1) {
                                                    relaxationServicePriceModel
                                                        .clear();
                                                    relaxationServicePriceModel
                                                        .addAll(
                                                            servicePriceModel);
                                                  } else if (mindex == 2) {
                                                    treatmentServicePriceModel
                                                        .clear();
                                                    treatmentServicePriceModel
                                                        .addAll(
                                                            servicePriceModel);
                                                  } else if (mindex == 3) {
                                                    fitnessServicePriceModel
                                                        .clear();
                                                    fitnessServicePriceModel
                                                        .addAll(
                                                            servicePriceModel);
                                                  }
                                                });
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              showLowPriceError();
                                            }
                                          } else {
                                            showLowPriceError();
                                          }
                                        } catch (e) {
                                          showDecimalError();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //get the index of the String on the List
  int getIndex(String val, List<ServicePriceModel> servicePriceModel) {
    int indexPos;
    for (int i = 0; i < servicePriceModel.length; i++) {
      if (servicePriceModel[i].name.toLowerCase() == val.toLowerCase()) {
        indexPos = i;
        break;
      }
    }
    return indexPos;
  }

  getEstheticList() async {
    await http
        .get(HealingMatchConstants.ESTHETIC_PROVIDER_URL)
        .then((response) {
      estheticDropDownModel =
          EstheticDropDownModel.fromJson(json.decode(response.body));
      print(estheticDropDownModel.toJson());
      for (var estheticList in estheticDropDownModel.data) {
        estheticDropDownValues.add(estheticList.value);
        print(estheticDropDownValues);
      }
      estheticDropDownValues.insertAll(
          estheticDropDownValues.length - 1, otherEstheticDropDownValues);
      setState(() {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        estheticStatus == 0 ? estheticStatus = 1 : estheticStatus = 0;
      });
    });
  }

  getRelaxationList() async {
    await http
        .get(HealingMatchConstants.RELAXATION_PROVIDER_URL)
        .then((response) {
      relaxationDropDownModel =
          RelaxationDropDownModel.fromJson(json.decode(response.body));
      print(relaxationDropDownModel.toJson());
      for (var relaxationList in relaxationDropDownModel.data) {
        relaxationDropDownValues.add(relaxationList.value);
        print(relaxationDropDownValues);
      }
      relaxationDropDownValues.insertAll(
          relaxationDropDownValues.length - 1, otherRelaxationDropDownValues);
      setState(() {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        relaxtionStatus == 0 ? relaxtionStatus = 1 : relaxtionStatus = 0;
      });
    });
  }

  getTreatmentList() async {
    await http
        .get(HealingMatchConstants.TREATMENT_PROVIDER_URL)
        .then((response) {
      treatmentDropDownModel =
          TreatmentDropDownModel.fromJson(json.decode(response.body));
      print(treatmentDropDownModel.toJson());
      for (var treatmentList in treatmentDropDownModel.data) {
        treatmentDropDownValues.add(treatmentList.value);
        print(treatmentDropDownValues);
      }
      treatmentDropDownValues.insertAll(
          treatmentDropDownValues.length - 1, otherTreatmentDropDownValues);
      setState(() {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        treatmentStatus == 0 ? treatmentStatus = 1 : treatmentStatus = 0;
      });
    });
  }

  getFitnessList() async {
    await http.get(HealingMatchConstants.FITNESS_PROVIDER_URL).then((response) {
      fitnessDropDownModel =
          FitnessDropDownModel.fromJson(json.decode(response.body));
      print(fitnessDropDownModel.toJson());
      for (var fitnessList in fitnessDropDownModel.data) {
        fitnessDropDownValues.add(fitnessList.value);
        print(fitnessDropDownValues);
      }
      fitnessDropDownValues.insertAll(
          fitnessDropDownValues.length - 1, otherFitnessDropDownValues);
      setState(() {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        fitnessStatus == 0 ? fitnessStatus = 1 : fitnessStatus = 0;
      });
    });
  }

  //show the SnackBar Empty Error
  void showEmptyErrorMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content:
          Text('追加する値を入力してください。', style: TextStyle(fontFamily: 'NotoSansJP')),
      action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'はい',
          textColor: Colors.white),
    ));
    return;
  }

  //show the SnackBar Already Contains Error
  void showDuplicateErrorMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('このサービスはもう追加されてあります。',
          style: TextStyle(fontFamily: 'NotoSansJP')),
      action: SnackBarAction(
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
          label: 'はい',
          textColor: Colors.white),
    ));
    return;
  }

  //show price can't be zero
  void showZeroError() {
    Toast.show("価格値をゼロにすることはできません。", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white);

    return;
  }

  //check prize range
  void showLowPriceError() {
    Toast.show("価格は￥2500円から￥50000円までに設定してください。", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white);

    return;
  }

  //price values can't be decimal
  void showDecimalError() {
    Toast.show("価格の値を10進数にすることはできません。", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white);

    return;
  }

  //get the id of the Message Value
  int getID(int index, int mindex) {
    int id;
    if (mindex == 0) {
      if ((estheticDropDownModel.data.length < estheticDropDownValues.length) &&
          (index > estheticDropDownModel.data.length - 2))
      //minus 2 for indexing and removing the others field out of equation
      {
        id = 996;
      } else {
        id = estheticDropDownModel.data.elementAt(index).id;
      }
    } else if (mindex == 1) {
      if ((relaxationDropDownModel.data.length <
              relaxationDropDownValues.length) &&
          (index >
              relaxationDropDownModel.data.length -
                  2)) //minus 2 for indexing and removing the others field out of equation
      {
        id = 999;
      } else {
        id = relaxationDropDownModel.data.elementAt(index).id;
      }
    } else if (mindex == 2) {
      if ((treatmentDropDownModel.data.length <
              treatmentDropDownValues.length) &&
          (index >
              treatmentDropDownModel.data.length -
                  2)) //minus 2 for indexing and removing the others field out of equation
      {
        id = 998;
      } else {
        id = treatmentDropDownModel.data.elementAt(index).id;
      }
    } else if (mindex == 3) {
      if ((fitnessDropDownModel.data.length < fitnessDropDownValues.length) &&
          (index >
              fitnessDropDownModel.data.length -
                  2)) //minus 2 for indexing and removing the others field out of equation
      {
        id = 997;
      } else {
        id = fitnessDropDownModel.data.elementAt(index).id;
      }
    }
    return id;
  }

  getSavedValues() {
    //Get the Price Model
    estheticServicePriceModel
        .addAll(HealingMatchConstants.estheticServicePriceModel);
    relaxationServicePriceModel
        .addAll(HealingMatchConstants.relaxationServicePriceModel);
    treatmentServicePriceModel
        .addAll(HealingMatchConstants.treatmentServicePriceModel);
    fitnessServicePriceModel
        .addAll(HealingMatchConstants.fitnessServicePriceModel);
    //Get the Selected CheckBox Values
    selectedEstheticDropdownValues
        .addAll(HealingMatchConstants.selectedEstheticDropdownValues);
    selectedRelaxationDropdownValues
        .addAll(HealingMatchConstants.selectedRelaxationDropdownValues);
    selectedTreatmentDropdownValues
        .addAll(HealingMatchConstants.selectedTreatmentDropdownValues);
    selectedFitnessDropdownValues
        .addAll(HealingMatchConstants.selectedFitnessDropdownValues);
    //Get the other added CheckBox Values
    otherEstheticDropDownValues
        .addAll(HealingMatchConstants.otherEstheticDropDownValues);
    otherTreatmentDropDownValues
        .addAll(HealingMatchConstants.otherTreatmentDropDownValues);
    otherRelaxationDropDownValues
        .addAll(HealingMatchConstants.otherRelaxationDropDownValues);
    otherFitnessDropDownValues
        .addAll(HealingMatchConstants.otherFitnessDropDownValues);
  }

  saveSelectedValues() {
    //Clear and Saving the Price Model
    HealingMatchConstants.estheticServicePriceModel.clear();
    HealingMatchConstants.relaxationServicePriceModel.clear();
    HealingMatchConstants.treatmentServicePriceModel.clear();
    HealingMatchConstants.fitnessServicePriceModel.clear();
    HealingMatchConstants.estheticServicePriceModel
        .addAll(estheticServicePriceModel);
    HealingMatchConstants.relaxationServicePriceModel
        .addAll(relaxationServicePriceModel);
    HealingMatchConstants.treatmentServicePriceModel
        .addAll(treatmentServicePriceModel);
    HealingMatchConstants.fitnessServicePriceModel
        .addAll(fitnessServicePriceModel);
    //Clear and save the Selected CheckBox Values
    HealingMatchConstants.selectedEstheticDropdownValues.clear();
    HealingMatchConstants.selectedRelaxationDropdownValues.clear();
    HealingMatchConstants.selectedTreatmentDropdownValues.clear();
    HealingMatchConstants.selectedFitnessDropdownValues.clear();
    HealingMatchConstants.selectedEstheticDropdownValues
        .addAll(selectedEstheticDropdownValues);
    HealingMatchConstants.selectedRelaxationDropdownValues
        .addAll(selectedRelaxationDropdownValues);
    HealingMatchConstants.selectedTreatmentDropdownValues
        .addAll(selectedTreatmentDropdownValues);
    HealingMatchConstants.selectedFitnessDropdownValues
        .addAll(selectedFitnessDropdownValues);
    //Clear and Select the other added CheckBox Values
    HealingMatchConstants.otherEstheticDropDownValues.clear();
    HealingMatchConstants.otherTreatmentDropDownValues.clear();
    HealingMatchConstants.otherRelaxationDropDownValues.clear();
    HealingMatchConstants.otherFitnessDropDownValues.clear();
    HealingMatchConstants.otherEstheticDropDownValues
        .addAll(otherEstheticDropDownValues);
    HealingMatchConstants.otherTreatmentDropDownValues
        .addAll(otherTreatmentDropDownValues);
    HealingMatchConstants.otherRelaxationDropDownValues
        .addAll(otherRelaxationDropDownValues);
    HealingMatchConstants.otherFitnessDropDownValues
        .addAll(otherFitnessDropDownValues);

    Navigator.pop(context);
  }
}
