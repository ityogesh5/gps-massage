import 'dart:convert';
import 'dart:math' as math;
import 'package:gps_massageapp/customLibraryClasses/progressDialogs/custom_dialog.dart';
import 'package:gps_massageapp/models/apiResponseModels/estheticDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/relaxationDropDownModel.dart';
import 'package:gps_massageapp/models/apiResponseModels/treatmentDropDownModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class ServicePriceModel {
  String _name;
  int _sixtyMin;
  int _nintyMin;
  int _oneTwentyMin;
  int _oneFifityMin;
  int _oneEightyMin;

  ServicePriceModel(this._name, this._sixtyMin, this._nintyMin,
      this._oneTwentyMin, this._oneFifityMin, this._oneEightyMin);

  String get name => _name;

  int get sixtyMin => _sixtyMin;

  int get nintyMin => _nintyMin;

  int get oneTwentyMin => _oneTwentyMin;

  int get oneFiftyMin => _oneFifityMin;

  int get oneEightyMin => _oneEightyMin;

  set name(String name) {
    this._name = name;
  }

  set sixtyMin(int price) {
    this._sixtyMin = price;
  }

  set nintyMin(int price) {
    this._nintyMin = price;
  }

  set oneTwentyMin(int price) {
    this._oneTwentyMin = price;
  }

  set oneFiftyMin(int price) {
    this._oneFifityMin = price;
  }

  set oneEightyMin(int price) {
    this._oneEightyMin = price;
  }
}

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
  List<String> dropDownMenuItems = List<String>();
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
  List<String> dropDownValues = List<String>();
  EstheticDropDownModel estheticListModel;
  RelaxationDropDownModel relaxationDropDownModel;
  TreatmentDropDownModel treatmentDropDownModel;
  ProgressDialog _progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();
    dropDownValues = [
      'はり（足）',
      '美容鍼（顔）',
      'きゅう（足）',
      'マッサージ（全身）',
      HealingMatchConstants.chooseServiceOtherDropdownFiled
    ];
    fitnessDropDownValues = [
      "ヨガ",
      "ホットヨガ",
      "ピラティス",
      "トレーニング,"
          "エクササイズ",
      HealingMatchConstants.chooseServiceOtherDropdownFiled
    ];
    dropDownMenuItems = [
      HealingMatchConstants.chooseServiceEstheticDropDown,
      HealingMatchConstants.chooseServiceRelaxationDropDown,
      HealingMatchConstants.chooseServiceTreatmentDropDown,
      HealingMatchConstants.chooseServiceFitnessDropDown
    ];
    otherSelected = [false, false, false, false];
  }

  void showProgressDialog() {
    _progressDialog.showProgressDialog(context,
        textToBeDisplayed: '住所を取得しています...', dismissAfter: Duration(seconds: 5));
  }

  void hideProgressDialog() {
    _progressDialog.dismissProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Container(
            padding: EdgeInsets.all(10),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            icon: estheticStatus == 0
                                ? Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ),
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
                        fillColor: Colors.grey[200]),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            icon: relaxtionStatus == 0
                                ? Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ),
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
                        fillColor: Colors.grey[200]),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            icon: treatmentStatus == 0
                                ? Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ),
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
                        fillColor: Colors.grey[200]),
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
                    setState(() {
                      fitnessStatus == 0
                          ? fitnessStatus = 1
                          : fitnessStatus = 0;
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        HealingMatchConstants.chooseServiceFitnessDropDown,
                    decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            icon: fitnessStatus == 0
                                ? Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Transform.rotate(
                                    angle: 270 * math.pi / 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            onPressed: () {
                              setState(() {
                                fitnessStatus == 0
                                    ? fitnessStatus = 1
                                    : fitnessStatus = 0;
                              });
                            }),
                        filled: true,
                        fillColor: Colors.grey[200]),
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
                            Navigator.pop(context);
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
                          checkValue = false;
                          if (val !=
                              HealingMatchConstants
                                  .chooseServiceOtherDropdownFiled) {
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
                          if (val ==
                              HealingMatchConstants
                                  .chooseServiceOtherDropdownFiled) {
                            checkValue = true;
                            otherSelected[mindex] = true;
                          } else {
                            showTimeandPriceDialog(
                                val, checkValue, indexPos, mindex);
                          }
                        }
                      });
                    },
                  ),
                  Text("$val", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            val != HealingMatchConstants.chooseServiceOtherDropdownFiled &&
                    checkValue == true
                ? Expanded(
                    child: Row(
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
                                  val, checkValue, indexPos, mindex);
                            }),
                      )
                    ],
                  ))
                : Container()
          ],
        ),
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
                                  estheticDropDownValues = List<String>();
                                  if (mindex == 0) {
                                    estheticDropDownValues.insert(
                                        index, sampleOthersController.text);
                                  } else if (mindex == 1) {
                                    relaxationDropDownValues.insert(
                                        index, sampleOthersController.text);
                                  } else if (mindex == 2) {
                                    treatmentDropDownValues.insert(
                                        index, sampleOthersController.text);
                                  } else if (mindex == 3) {
                                    fitnessDropDownValues.insert(
                                        index, sampleOthersController.text);
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
    //For Alignment Purposes
    /*   if (values.length < 3) {
      if (values.length == 1) {
        values.add(Container());
      } else {
        values.add(Container());
        values.add(Container());
      }
    } */
    return values;
  }

  buildCheckBoxChip(int price, int min) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      width: 110.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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

  showTimeandPriceDialog(String val, bool selected, int indexPos, int mindex) {
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
      sixtyMinutesController.text =
          (servicePriceModel[indexPos].sixtyMin).toString();
      nintyMinuteController.text =
          (servicePriceModel[indexPos].nintyMin).toString();
      oneTwentyMinuteController.text =
          (servicePriceModel[indexPos].oneTwentyMin).toString();
      oneFiftyController.text =
          (servicePriceModel[indexPos].oneFiftyMin).toString();
      oneEightyMinuteController.text =
          (servicePriceModel[indexPos].oneEightyMin).toString();
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
              //height: 300.0,
              //width: 450.0,
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
                                        controller: sixtyMinutesController,
                                        decoration: InputDecoration(
                                          labelText: "¥0",
                                          fillColor: Colors.white,
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
                                        color: Colors.grey[200],
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
                                        controller: nintyMinuteController,
                                        decoration: InputDecoration(
                                          labelText: "¥0",
                                          fillColor: Colors.white,
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
                                        color: Colors.grey[200],
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
                                        decoration: InputDecoration(
                                          labelText: "¥0",
                                          fillColor: Colors.white,
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
                                        color: Colors.grey[200],
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
                                        controller: oneFiftyController,
                                        decoration: InputDecoration(
                                          labelText: "¥0",
                                          fillColor: Colors.white,
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
                                        color: Colors.grey[200],
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
                                        controller: oneEightyMinuteController,
                                        decoration: InputDecoration(
                                          labelText: "¥0",
                                          fillColor: Colors.white,
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
                                        color: Colors.grey[200],
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
                                        if (!selected) {
                                          if (sixtyMinutesController.text !=
                                                  "" ||
                                              nintyMinuteController.text !=
                                                  "" ||
                                              oneTwentyMinuteController.text !=
                                                  "" ||
                                              oneFiftyController.text != "" ||
                                              oneEightyMinuteController.text !=
                                                  "") {
                                            servicePriceModel.add(
                                              ServicePriceModel(
                                                val,
                                                sixtyMinutesController.text !=
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
                                                        oneFiftyController.text)
                                                    : 0,
                                                oneEightyMinuteController
                                                            .text !=
                                                        ""
                                                    ? int.parse(
                                                        oneEightyMinuteController
                                                            .text)
                                                    : 0,
                                              ),
                                            );
                                            selectedDropdownValues
                                                .add(val.toLowerCase());
                                            setState(() {
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
                                        } else {
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
        .post(HealingMatchConstants.ESTHETIC_PROVIDER_URL)
        .then((response) {
      estheticListModel =
          EstheticDropDownModel.fromJson(json.decode(response.body));
      print(estheticListModel.toJson());
      for (var estheticList in estheticListModel.estheticData) {
        estheticDropDownValues.add(estheticList.value);
        print(estheticDropDownValues);
      }
      setState(() {
        hideProgressDialog();
        estheticStatus == 0 ? estheticStatus = 1 : estheticStatus = 0;
      });
    });
  }

  getRelaxationList() async {
    await http
        .post(HealingMatchConstants.RELAXATION_PROVIDER_URL)
        .then((response) {
      relaxationDropDownModel =
          RelaxationDropDownModel.fromJson(json.decode(response.body));
      print(relaxationDropDownModel.toJson());
      for (var relaxationList in relaxationDropDownModel.relaxationData) {
        relaxationDropDownValues.add(relaxationList.value);
        print(relaxationDropDownValues);
      }
      setState(() {
        hideProgressDialog();
        relaxtionStatus == 0 ? relaxtionStatus = 1 : relaxtionStatus = 0;
      });
    });
  }

  getTreatmentList() async {
    await http
        .post(HealingMatchConstants.TREATMENT_PROVIDER_URL)
        .then((response) {
      treatmentDropDownModel =
          TreatmentDropDownModel.fromJson(json.decode(response.body));
      print(treatmentDropDownModel.toJson());
      for (var treatmentList in treatmentDropDownModel.osteopathicData) {
        treatmentDropDownValues.add(treatmentList.value);
        print(treatmentDropDownValues);
      }
      setState(() {
        hideProgressDialog();
        treatmentStatus == 0 ? treatmentStatus = 1 : treatmentStatus = 0;
      });
    });
  }
}
