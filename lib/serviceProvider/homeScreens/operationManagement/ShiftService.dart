import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/statusCodeResponseHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/estheticDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/fitnessDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/loginResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/relaxationDropDownModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/treatmentDropDownModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';

class ShiftService extends StatefulWidget {
  @override
  _ShiftServiceState createState() => _ShiftServiceState();
}

class _ShiftServiceState extends State<ShiftService> {
  var updateResponseModel = new LoginResponseModel();
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
  List<TherapistSubCategory> estheticServicePriceModel =
      List<TherapistSubCategory>();
  List<TherapistSubCategory> relaxationServicePriceModel =
      List<TherapistSubCategory>();
  List<TherapistSubCategory> treatmentServicePriceModel =
      List<TherapistSubCategory>();
  List<TherapistSubCategory> fitnessServicePriceModel =
      List<TherapistSubCategory>();
  List<String> selectedStoreTypeDisplayValues = List<String>();
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
  ProgressDialog _progressDialog = ProgressDialog();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TherapistSubCategory> deletedEstheticList = List<TherapistSubCategory>();
  List<TherapistSubCategory> deletedTreatmentList =
      List<TherapistSubCategory>();
  List<TherapistSubCategory> deletedRelaxationList =
      List<TherapistSubCategory>();
  List<TherapistSubCategory> deletedFitnessList = List<TherapistSubCategory>();

  @override
  void initState() {
    super.initState();
    getSavedValues();
    otherSelected = [false, false, false, false];
  }

  void showProgressDialog() {
    _progressDialog.showProgressDialog(context,
        textToBeDisplayed: '読み込み中...', dismissAfter: Duration(seconds: 5));
  }

  void hideProgressDialog() {
    _progressDialog.dismissProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  '施術メニューをアレンジできます。',
                  style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1), fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                //Esthetic DropDown
                selectedStoreTypeDisplayValues.contains('エステ')
                    ? InkWell(
                        onTap: () {
                          if (estheticDropDownValues.length == 0) {
                            showProgressDialog();
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
                                      showProgressDialog();
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
                  height:
                      selectedStoreTypeDisplayValues.contains('エステ') ? 15.0 : 0,
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
                  height:
                      selectedStoreTypeDisplayValues.contains('エステ') ? 20.0 : 0,
                ),

                //Relaxation DropDown
                selectedStoreTypeDisplayValues.contains('リラクゼーション')
                    ? InkWell(
                        onTap: () {
                          if (relaxationDropDownValues.length == 0) {
                            showProgressDialog();
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
                                      showProgressDialog();
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
                  height: selectedStoreTypeDisplayValues.contains('リラクゼーション')
                      ? 15.0
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
                  height: selectedStoreTypeDisplayValues.contains('リラクゼーション')
                      ? 20.0
                      : 0,
                ),

                //Treatment DropDown
                selectedStoreTypeDisplayValues.contains('接骨・整体')
                    ? InkWell(
                        onTap: () {
                          if (treatmentDropDownValues.length == 0) {
                            showProgressDialog();
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
                                      showProgressDialog();
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
                  height: selectedStoreTypeDisplayValues.contains('接骨・整体')
                      ? 15.0
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
                  height: selectedStoreTypeDisplayValues.contains('接骨・整体')
                      ? 20.0
                      : 0,
                ),

                //Fitness DropDown
                selectedStoreTypeDisplayValues.contains('フィットネス')
                    ? InkWell(
                        onTap: () {
                          if (fitnessDropDownValues.length == 0) {
                            showProgressDialog();
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
                                      showProgressDialog();
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
                  height: selectedStoreTypeDisplayValues.contains('フィットネス')
                      ? 15.0
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
                  height: selectedStoreTypeDisplayValues.contains('フィットネス')
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
                            "保存",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          color: Color.fromRGBO(200, 217, 33, 1),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            /*  deleteUnSelectedValues(); */
                            saveSelectedValues();
                          },
                        ),
                      ),
                    ),
                  ],
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
    List<TherapistSubCategory> servicePriceModel = List<TherapistSubCategory>();
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
    }
    if (checkValue) {
      indexPos = getIndex(val, servicePriceModel);
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
                                    showConfirmationDialog(
                                        context,
                                        selectedDropdownValues,
                                        servicePriceModel,
                                        indexPos,
                                        val,
                                        mindex);
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
                              color: Color.fromRGBO(200, 217, 33, 1),
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
  checkAddedPrice(int indexPos, List<TherapistSubCategory> servicePriceModel) {
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
    if ((servicePriceModel[indexPos].oneFifityMin) != 0) {
      values.add(
          buildCheckBoxChip(servicePriceModel[indexPos].oneFifityMin, 150));
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
    List<TherapistSubCategory> servicePriceModel = List<TherapistSubCategory>();
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

      if (servicePriceModel[indexPos].oneFifityMin != 0) {
        oneFiftyController.text =
            (servicePriceModel[indexPos].oneFifityMin).toString();
      }

      if (servicePriceModel[indexPos].oneEightyMin != 0) {
        oneEightyMinuteController.text =
            (servicePriceModel[indexPos].oneEightyMin).toString();
      }
    }
    return showDialog(
      context: context,
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
                                        enableInteractiveSelection: false,
                                        textAlign: TextAlign.center,
                                        controller: sixtyMinutesController,
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
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
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
                                        color: Color.fromRGBO(245, 245, 245, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
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
                                        enableInteractiveSelection: false,
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
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
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
                                        color: Color.fromRGBO(245, 245, 245, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
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
                                        enableInteractiveSelection: false,
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
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
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
                                        color: Color.fromRGBO(245, 245, 245, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
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
                                        enableInteractiveSelection: false,
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
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
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
                                        color: Color.fromRGBO(245, 245, 245, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
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
                                        enableInteractiveSelection: false,
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
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
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
                                        color: Color.fromRGBO(245, 245, 245, 1),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(245, 245, 245, 1),
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
                                      color: Color.fromRGBO(200, 217, 33, 1),
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
                                                  int lengthModel =
                                                      servicePriceModel.length;
                                                  servicePriceModel.add(
                                                    TherapistSubCategory(
                                                      userId:
                                                          HealingMatchConstants
                                                              .userId,
                                                      name: val,
                                                      sixtyMin:
                                                          sixtyMinutesController
                                                                      .text !=
                                                                  ""
                                                              ? int.parse(
                                                                  sixtyMinutesController
                                                                      .text)
                                                              : 0,
                                                      nintyMin:
                                                          nintyMinuteController
                                                                      .text !=
                                                                  ""
                                                              ? int.parse(
                                                                  nintyMinuteController
                                                                      .text)
                                                              : 0,
                                                      oneTwentyMin:
                                                          oneTwentyMinuteController
                                                                      .text !=
                                                                  ""
                                                              ? int.parse(
                                                                  oneTwentyMinuteController
                                                                      .text)
                                                              : 0,
                                                      oneFifityMin:
                                                          oneFiftyController
                                                                      .text !=
                                                                  ""
                                                              ? int.parse(
                                                                  oneFiftyController
                                                                      .text)
                                                              : 0,
                                                      oneEightyMin:
                                                          oneEightyMinuteController
                                                                      .text !=
                                                                  ""
                                                              ? int.parse(
                                                                  oneEightyMinuteController
                                                                      .text)
                                                              : 0,
                                                      createdAt: DateTime.now(),
                                                      updatedAt: DateTime.now(),
                                                    ),
                                                  );
                                                  if (mindex == 0) {
                                                    servicePriceModel[
                                                                lengthModel]
                                                            .subCategoryId =
                                                        getID(index, mindex);
                                                  } else if (mindex == 1) {
                                                    servicePriceModel[
                                                                lengthModel]
                                                            .subCategoryId =
                                                        getID(index, mindex);
                                                  } else if (mindex == 2) {
                                                    servicePriceModel[
                                                                lengthModel]
                                                            .subCategoryId =
                                                        getID(index, mindex);
                                                  } else if (mindex == 3) {
                                                    servicePriceModel[
                                                                lengthModel]
                                                            .subCategoryId =
                                                        getID(index, mindex);
                                                  }

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
                                                        .oneFifityMin =
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
  int getIndex(String val, List<TherapistSubCategory> servicePriceModel) {
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
        hideProgressDialog();
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
        hideProgressDialog();
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
        hideProgressDialog();
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
        hideProgressDialog();
        fitnessStatus == 0 ? fitnessStatus = 1 : fitnessStatus = 0;
      });
    });
  }

  //show the SnackBar Empty Error
  void showEmptyErrorMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content:
          Text('追加する値を入力してください。', style: TextStyle(fontFamily: 'Open Sans')),
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
    int constantID = 999;
    if (mindex == 0) {
      if ((estheticDropDownModel.data.length < estheticDropDownValues.length) &&
          (index > estheticDropDownModel.data.length - 2))
      //minus 2 for indexing and removing the others field out of equation
      {
        id = constantID;
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
        id = constantID;
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
        id = constantID;
      } else {
        id = treatmentDropDownModel.data.elementAt(index).id;
      }
    } else if (mindex == 3) {
      if ((fitnessDropDownModel.data.length < fitnessDropDownValues.length) &&
          (index >
              fitnessDropDownModel.data.length -
                  2)) //minus 2 for indexing and removing the others field out of equation
      {
        id = constantID;
      } else {
        id = fitnessDropDownModel.data.elementAt(index).id;
      }
    }
    return id;
  }

  getSavedValues() {
    selectedStoreTypeDisplayValues =
        HealingMatchConstants.userData.storeType.split(',');

    for (TherapistSubCategory therapistSubCategory
        in HealingMatchConstants.userData.therapistSubCategories) {
      if (therapistSubCategory.categoryId == 1) {
        estheticServicePriceModel.add(therapistSubCategory);
        if (therapistSubCategory.subCategoryId == 999) {
          otherEstheticDropDownValues.add(therapistSubCategory.name);
        } else {
          selectedEstheticDropdownValues.add(therapistSubCategory.name);
        }
      } else if (therapistSubCategory.categoryId == 2) {
        if (therapistSubCategory.subCategoryId == 999) {
          otherFitnessDropDownValues.add(therapistSubCategory.name);
        } else {
          selectedFitnessDropdownValues.add(therapistSubCategory.name);
        }
        fitnessServicePriceModel.add(therapistSubCategory);
      } else if (therapistSubCategory.categoryId == 3) {
        if (therapistSubCategory.subCategoryId == 999) {
          otherTreatmentDropDownValues.add(therapistSubCategory.name);
        } else {
          selectedTreatmentDropdownValues.add(therapistSubCategory.name);
        }
        treatmentServicePriceModel.add(therapistSubCategory);
      } else if (therapistSubCategory.categoryId == 4) {
        if (therapistSubCategory.subCategoryId == 999) {
          otherRelaxationDropDownValues.add(therapistSubCategory.name);
        } else {
          selectedRelaxationDropdownValues.add(therapistSubCategory.name);
        }
        relaxationServicePriceModel.add(therapistSubCategory);
      }
    }

    /* //Get the Price Model
    for (var serviceItem in HealingMatchConstants.userData.estheticLists) {
      if (serviceItem.estheticId == 999) //for user added Service name
      {}
      selectedEstheticDropdownValues.add(serviceItem.name);
    }
    for (var serviceItem in HealingMatchConstants.userData.relaxationLists) {
      if (serviceItem.relaxationId == 999) {
        otherRelaxationDropDownValues.add(serviceItem.name);
      }
      selectedRelaxationDropdownValues.add(serviceItem.name);
    }
    for (var serviceItem in HealingMatchConstants.userData.orteopathicLists) {
      if (serviceItem.orteopathicId == 999) {
        otherTreatmentDropDownValues.add(serviceItem.name);
      }
      selectedTreatmentDropdownValues.add(serviceItem.name);
    }
    for (var serviceItem in HealingMatchConstants.userData.fitnessLists) {
      if (serviceItem.fitnessId == 999) {
        otherFitnessDropDownValues.add(serviceItem.name);
      }
      selectedFitnessDropdownValues.add(serviceItem.name);
    } */
  }

  saveSelectedValues() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    SharedPreferences instances = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'x-access-token': HealingMatchConstants.accessToken
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(HealingMatchConstants.THERAPIST_UPDATE_SERVICE_TYPE));
    request.fields.addAll({
      'id': HealingMatchConstants.userId.toString(),
      'estheticList': json.encode(estheticServicePriceModel),
      'relaxationList': json.encode(relaxationServicePriceModel),
      'orteopathicList': json.encode(
        treatmentServicePriceModel,
      ),
      'fitnessList': json.encode(
        fitnessServicePriceModel,
      ),
      'deleteEstheticList': json.encode(deletedEstheticList),
      'deleteRelaxationList': json.encode(deletedRelaxationList),
      'deleteOrteopathicList': json.encode(deletedTreatmentList),
      'deleteFitnessList': json.encode(
        deletedFitnessList,
      ),
    });
    request.headers.addAll(headers);
    try {
      final serviceUpdateRequest = await request.send();
      print("This is request : ${serviceUpdateRequest.request}");
      final response = await http.Response.fromStream(serviceUpdateRequest);
      print("This is response: ${response.statusCode}\n${response.body}");
      if (StatusCodeHelper.isTherpaistServiceUpdateSuccess(
          response.statusCode, context, response.body)) {
        final Map updateResponse = json.decode(response.body);
        updateResponseModel = LoginResponseModel.fromJson(updateResponse);
        HealingMatchConstants.userData = updateResponseModel.data;
        instances.setString("userData", json.encode(updateResponseModel.data));
      } else {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        print('Response error occured!');
      }
    } on SocketException catch (_) {
      //handle socket Exception
      ProgressDialogBuilder.hideCommonProgressDialog(context);
      NavigationRouter.switchToNetworkHandler(context);
      print('Network error !!');
    } catch (_) {
      //handle other error
      print("Error");
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }

  deleteUnSelectedValues() async {
    ProgressDialogBuilder.showCommonProgressDialog(context);
    SharedPreferences instances = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'x-access-token': HealingMatchConstants.accessToken
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(HealingMatchConstants.THERAPIST_DELETE_SERVICE_TYPE));
    request.fields.addAll({
      'id': HealingMatchConstants.userId.toString(),
      'estheticList': json.encode(deletedEstheticList),
      'relaxationList': json.encode(deletedRelaxationList),
      'orteopathicList': json.encode(deletedTreatmentList),
      'fitnessList': json.encode(
        deletedFitnessList,
      ),
    });
    request.headers.addAll(headers);
    try {
      final serviceDeleteRequest = await request.send();
      print("This is request : ${serviceDeleteRequest.request}");
      final response = await http.Response.fromStream(serviceDeleteRequest);
      print("This is response: ${response.statusCode}\n${response.body}");

      if (StatusCodeHelper.isTherpaistServiceUpdateSuccess(
          response.statusCode, context, response.body)) {
        final Map updateResponse = json.decode(response.body);
        updateResponseModel = LoginResponseModel.fromJson(updateResponse);
        HealingMatchConstants.userData = updateResponseModel.data;
        instances.setString("userData", json.encode(updateResponseModel.data));
      } else {
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        print('Response error occured!');
      }
    } on SocketException catch (_) {
      //handle socket Exception
      ProgressDialogBuilder.hideCommonProgressDialog(context);
      NavigationRouter.switchToNetworkHandler(context);
      print('Network error !!');
    } catch (_) {
      //handle other error
      print("Error");
      ProgressDialogBuilder.hideCommonProgressDialog(context);
    }
  }

  // Delete Confirmation Dialog
  void showConfirmationDialog(
      BuildContext context,
      List<String> selectedDropdownValues,
      List<TherapistSubCategory> servicePriceModel,
      int indexPos,
      String val,
      int mindex) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Stack(
              children: [
                Container(
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
                          'サービスの価格情報を削除してもよろしいでしょうか？',
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
                              initialValue: 0,
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
                                  Navigator.pop(context);
                                  removeSelectedServices(selectedDropdownValues,
                                      servicePriceModel, indexPos, val, mindex);
                                } else {
                                  Navigator.pop(context);
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
                )
              ],
            ),
          );
        });
  }

  removeSelectedServices(
      List<String> selectedDropdownValues,
      List<TherapistSubCategory> servicePriceModel,
      int indexPos,
      String val,
      int mindex) {
    selectedDropdownValues.remove(val.toLowerCase());
    setState(() {
      if (mindex == 0) {
        try {
          deletedEstheticList.add(servicePriceModel[indexPos]);
          servicePriceModel.removeAt(indexPos);
          //   deleteUnSelectedValues();
        } catch (e) {}
        selectedEstheticDropdownValues.clear();
        estheticServicePriceModel.clear();
        selectedEstheticDropdownValues.addAll(selectedDropdownValues);
        estheticServicePriceModel.addAll(servicePriceModel);
      } else if (mindex == 1) {
        try {
          deletedRelaxationList.add(servicePriceModel[indexPos]);
          servicePriceModel.removeAt(indexPos);
          //    deleteUnSelectedValues();
        } catch (e) {}
        selectedRelaxationDropdownValues.clear();
        relaxationServicePriceModel.clear();
        selectedRelaxationDropdownValues.addAll(selectedDropdownValues);
        relaxationServicePriceModel.addAll(servicePriceModel);
      } else if (mindex == 2) {
        try {
          deletedTreatmentList.add(servicePriceModel[indexPos]);
          servicePriceModel.removeAt(indexPos);
          //  deleteUnSelectedValues();
        } catch (e) {}
        selectedTreatmentDropdownValues.clear();
        treatmentServicePriceModel.clear();
        selectedTreatmentDropdownValues.addAll(selectedDropdownValues);
        treatmentServicePriceModel.addAll(servicePriceModel);
      } else if (mindex == 3) {
        try {
          deletedFitnessList.add(servicePriceModel[indexPos]);
          servicePriceModel.removeAt(indexPos);
          //  deleteUnSelectedValues();
        } catch (e) {}
        selectedFitnessDropdownValues.clear();
        fitnessServicePriceModel.clear();
        selectedFitnessDropdownValues.addAll(selectedDropdownValues);
        fitnessServicePriceModel.addAll(servicePriceModel);
      }
    });
  }
}
