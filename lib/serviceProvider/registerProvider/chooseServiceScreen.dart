import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:gps_massageapp/models/apiResponseModels/estheticDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/fitnessDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/relaxationDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/treatmentDropDownModel.dart';
import 'package:gps_massageapp/models/messageServicePriceModel.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController sampleOthersController = TextEditingController();
  EstheticDropDownModel estheticDropDownModel;
  RelaxationDropDownModel relaxationDropDownModel;
  TreatmentDropDownModel treatmentDropDownModel;
  FitnessDropDownModel fitnessDropDownModel;
  ProgressDialog _progressDialog = ProgressDialog();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  HealingMatchConstants.chooseServiceFirstText,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                ),

                //Esthetic DropDown
                InkWell(
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
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        HealingMatchConstants.chooseServiceEstheticDropDown,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
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
                SizedBox(
                  height: 15,
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
                  height: 20.0,
                ),

                //Relaxation DropDown
                InkWell(
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
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        HealingMatchConstants.chooseServiceRelaxationDropDown,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
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
                SizedBox(
                  height: 15,
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
                  height: 20.0,
                ),

                //Treatment DropDown
                InkWell(
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
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        HealingMatchConstants.chooseServiceTreatmentDropDown,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
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
                SizedBox(
                  height: 15,
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
                  height: 20.0,
                ),

                //Fitness DropDown
                InkWell(
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
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        HealingMatchConstants.chooseServiceFitnessDropDown,
                    decoration: new InputDecoration(
                      focusedBorder: HealingMatchConstants.textFormInputBorder,
                      disabledBorder: HealingMatchConstants.textFormInputBorder,
                      enabledBorder: HealingMatchConstants.textFormInputBorder,
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
                SizedBox(
                  height: 15,
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
                  height: 20.0,
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
                          color: Colors.lime,
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
                  Checkbox(
                    tristate: true,
                    activeColor: Colors.lime,
                    checkColor: Colors.lime,
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
                            selectedDropdownValues.remove(val.toLowerCase());
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
                            showTimeandPriceDialog(
                                val, checkValue, indexPos, mindex, index);
                          }
                        }
                      });
                    },
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
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showTimeandPriceDialog(
                                  val, checkValue, indexPos, mindex, index);
                            }),
                      )
                    ],
                  )
                : Container()
          ],
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
                        controller: sampleOthersController,
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
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
                                  //Logic: check the value is already present, if not insert before other field index
                                  if (mindex == 0) {
                                    if (estheticDropDownValues.contains(
                                        sampleOthersController.text)) {
                                      showErrorMessage();
                                    } else {
                                      estheticDropDownValues.insert(
                                          index, sampleOthersController.text);
                                      otherEstheticDropDownValues
                                          .add(sampleOthersController.text);
                                    }
                                  } else if (mindex == 1) {
                                    if (relaxationDropDownValues.contains(
                                        sampleOthersController.text)) {
                                      showErrorMessage();
                                    } else {
                                      relaxationDropDownValues.insert(
                                          index, sampleOthersController.text);
                                      otherRelaxationDropDownValues
                                          .add(sampleOthersController.text);
                                    }
                                  } else if (mindex == 2) {
                                    if (treatmentDropDownValues.contains(
                                        sampleOthersController.text)) {
                                      showErrorMessage();
                                    } else {
                                      treatmentDropDownValues.insert(
                                          index, sampleOthersController.text);
                                      otherTreatmentDropDownValues
                                          .add(sampleOthersController.text);
                                    }
                                  } else if (mindex == 3) {
                                    if (fitnessDropDownValues.contains(
                                        sampleOthersController.text)) {
                                      showErrorMessage();
                                    } else {
                                      fitnessDropDownValues.insert(
                                          index, sampleOthersController.text);
                                      otherFitnessDropDownValues
                                          .add(sampleOthersController.text);
                                    }
                                  }
                                  sampleOthersController.clear();
                                });
                              },
                              child: Text(
                                HealingMatchConstants
                                    .chooseServiceAddtoDropdownButton,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.lime,
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
                padding: const EdgeInsets.all(8.0),
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
      width: 110.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥$price/$min分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                        "計算したい日付を選択し",
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
                                        textAlign: TextAlign.center,
                                        controller: sixtyMinutesController,
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
                                        textAlign: TextAlign.center,
                                        controller: nintyMinuteController,
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
                                        controller: oneTwentyMinuteController,
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
                                        textAlign: TextAlign.center,
                                        controller: oneFiftyController,
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
                                        textAlign: TextAlign.center,
                                        controller: oneEightyMinuteController,
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
                                      color: Colors.lime,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0)),
                                      onPressed: () {
                                        print(estheticServicePriceModel);
                                        //if checkbox slected for the first time
                                        if (!selected) {
                                          //check if any values or entered or all empty
                                          if (sixtyMinutesController.text !=
                                                  "" ||
                                              nintyMinuteController.text !=
                                                  "" ||
                                              oneTwentyMinuteController.text !=
                                                  "" ||
                                              oneFiftyController.text != "" ||
                                              oneEightyMinuteController.text !=
                                                  "") {
                                            //if entered then the empty values are treated as 0
                                            servicePriceModel.add(
                                              ServicePriceModel(
                                                  val,
                                                  sixtyMinutesController.text != ""
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
                                                          oneEightyMinuteController
                                                              .text)
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
                                                    .addAll(servicePriceModel);
                                              } else if (mindex == 1) {
                                                selectedRelaxationDropdownValues
                                                    .clear();
                                                relaxationServicePriceModel
                                                    .clear();
                                                selectedRelaxationDropdownValues
                                                    .addAll(
                                                        selectedDropdownValues);
                                                relaxationServicePriceModel
                                                    .addAll(servicePriceModel);
                                              } else if (mindex == 2) {
                                                selectedTreatmentDropdownValues
                                                    .clear();
                                                treatmentServicePriceModel
                                                    .clear();
                                                selectedTreatmentDropdownValues
                                                    .addAll(
                                                        selectedDropdownValues);
                                                treatmentServicePriceModel
                                                    .addAll(servicePriceModel);
                                              } else if (mindex == 3) {
                                                selectedFitnessDropdownValues
                                                    .clear();
                                                fitnessServicePriceModel
                                                    .clear();
                                                selectedFitnessDropdownValues
                                                    .addAll(
                                                        selectedDropdownValues);
                                                fitnessServicePriceModel
                                                    .addAll(servicePriceModel);
                                              }
                                            });
                                          }
                                        }
                                        //if checkbox already selected then update logic is used
                                        else {
                                          servicePriceModel[indexPos].sixtyMin =
                                              sixtyMinutesController.text != ""
                                                  ? int.parse(
                                                      sixtyMinutesController
                                                          .text)
                                                  : 0;
                                          servicePriceModel[indexPos].nintyMin =
                                              nintyMinuteController.text != ""
                                                  ? int.parse(
                                                      nintyMinuteController
                                                          .text)
                                                  : 0;
                                          servicePriceModel[indexPos]
                                                  .oneTwentyMin =
                                              oneTwentyMinuteController.text !=
                                                      ""
                                                  ? int.parse(
                                                      oneTwentyMinuteController
                                                          .text)
                                                  : 0;
                                          servicePriceModel[indexPos]
                                                  .oneFiftyMin =
                                              oneFiftyController.text != ""
                                                  ? int.parse(
                                                      oneFiftyController.text)
                                                  : 0;
                                          servicePriceModel[indexPos]
                                                  .oneEightyMin =
                                              oneEightyMinuteController.text !=
                                                      ""
                                                  ? int.parse(
                                                      oneEightyMinuteController
                                                          .text)
                                                  : 0;
                                          setState(() {
                                            if (mindex == 0) {
                                              estheticServicePriceModel.clear();
                                              estheticServicePriceModel
                                                  .addAll(servicePriceModel);
                                            } else if (mindex == 1) {
                                              relaxationServicePriceModel
                                                  .clear();
                                              relaxationServicePriceModel
                                                  .addAll(servicePriceModel);
                                            } else if (mindex == 2) {
                                              treatmentServicePriceModel
                                                  .clear();
                                              treatmentServicePriceModel
                                                  .addAll(servicePriceModel);
                                            } else if (mindex == 3) {
                                              fitnessServicePriceModel.clear();
                                              fitnessServicePriceModel
                                                  .addAll(servicePriceModel);
                                            }
                                          });
                                        }
                                        Navigator.pop(context);
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
      if (servicePriceModel[i].name == val.toLowerCase()) {
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

  //show the SnackBar Error
  void showErrorMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorConstants.snackBarColor,
      content: Text('Value already exists',
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
              estheticDropDownModel.data.length -
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
              estheticDropDownModel.data.length -
                  2)) //minus 2 for indexing and removing the others field out of equation
      {
        id = constantID;
      } else {
        id = treatmentDropDownModel.data.elementAt(index).id;
      }
    } else if (mindex == 3) {
      if ((fitnessDropDownModel.data.length < fitnessDropDownValues.length) &&
          (index >
              estheticDropDownModel.data.length -
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
