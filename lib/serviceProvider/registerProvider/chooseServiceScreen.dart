import 'package:flutter/material.dart';

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
  List<String> dropdownValues = List<String>();
  List<String> selectedDropdownValues = List<String>();
  List<ServicePriceModel> servicePriceModel = List<ServicePriceModel>();
  int status = 0;
  TextEditingController sampleOthersController = TextEditingController();
  bool otherSelected = false;

  @override
  void initState() {
    super.initState();
    dropdownValues = ['one', 'two', 'three', 'four', 'other'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '提供するサービスを選択し料金を設定してください。',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    status == 0 ? status = 1 : status = 0;
                  });
                },
                child: TextFormField(
                  enabled: false,
                  initialValue: "sample",
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
                          icon: status == 0
                              ? Icon(Icons.arrow_drop_down_sharp)
                              : Icon(Icons.arrow_drop_up_sharp),
                          onPressed: () {
                            setState(() {
                              status == 0 ? status = 1 : status = 0;
                            });
                          }),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      hintText: "パスワード",
                      fillColor: Colors.grey[200]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              status == 1
                  ? Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dropdownValues.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return buildCheckBoxContent(
                                dropdownValues[index], index);
                          }),
                    )
                  : Container(),
              /* Checkbox(
                    activeColor: Colors.lime,
                    checkColor: Colors.lime,
                    value: _value,
                    onChanged: (bool newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                  ), */
            ],
          ),
        ),
      ),
    );
  }

  buildCheckBoxContent(String val, int index) {
    bool checkValue = false;
    int indexPos = 0;
    if (val == "other") {
      checkValue = otherSelected;
    } else {
      checkValue = selectedDropdownValues.contains(val.toLowerCase());
      if (checkValue) {
        indexPos = getIndex(val);
      }
    }

    return Column(
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
                          if (val != "other") {
                            selectedDropdownValues.remove(val.toLowerCase());
                            servicePriceModel.removeAt(indexPos);
                          } else {
                            otherSelected = false;
                          }
                        } else {
                          if (val == "other") {
                            checkValue = true;
                            otherSelected = true;
                          } else {
                            showTimeandPriceDialog(val, checkValue, indexPos);
                          }
                        }
                      });
                    },
                  ),
                  Text("$val", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            val != "other" && checkValue == true
                ? Expanded(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showTimeandPriceDialog(val, checkValue, indexPos);
                            }),
                      )
                    ],
                  ))
                : Container()
          ],
        ),
        (checkValue == true && val == "other")
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                    child: TextFormField(
                      controller: sampleOthersController,
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  dropdownValues.insert(
                                      index, sampleOthersController.text);
                                  sampleOthersController.clear();
                                });
                              },
                              child: Text("Add"),
                              color: Colors.lime,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "add others",
                          fillColor: Colors.grey[200]),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            : Container(),
        (checkValue == true && val != "other")
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0, runSpacing: 8.0,
                  children: checkAddedPrice(indexPos), // [
                  //buildCheckBoxTimePriceChip(),

                  /*  (servicePriceModel[indexPos].sixtyMin) != 0
                      ? buildCheckBoxChip(
                          servicePriceModel[indexPos].sixtyMin, 60)
                      : Container(),

                  (servicePriceModel[indexPos].nintyMin) != 0
                      ? buildCheckBoxChip(
                          servicePriceModel[indexPos].nintyMin, 90)
                      : Container(),

                  (servicePriceModel[indexPos].oneTwentyMin) != 0
                      ? buildCheckBoxChip(
                          servicePriceModel[indexPos].oneTwentyMin, 120)
                      : Container(),

                  (servicePriceModel[indexPos].oneFiftyMin) != 0
                      ? buildCheckBoxChip(
                          servicePriceModel[indexPos].oneFiftyMin, 150)
                      : Container(),

                  (servicePriceModel[indexPos].oneEightyMin) != 0
                      ? buildCheckBoxChip(
                          servicePriceModel[indexPos].oneEightyMin, 180)
                      : Container(), */
                  // ]
                ),
              )
            : Container(),
      ],
    );
  }

  checkAddedPrice(int indexPos) {
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

  buildCheckBoxTimePriceChip() {
    List<Widget> values = List<Widget>();
    values.add(Container(
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      width: 100.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥100/60分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));
    values.add(Container(
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      width: 100.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥100/90分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));
    values.add(Container(
      padding: EdgeInsets.all(10.0),
      height: 40.0, width: 100.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥100/120分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));
    values.add(Container(
      width: 100.0,
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥100/150分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));
    values.add(Container(
      width: 100.0,
      padding: EdgeInsets.all(10.0),
      height: 40.0,
      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          "¥100/180分",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ));

    return values;
  }

  showTimeandPriceDialog(String val, bool selected, int indexPos) {
    TextEditingController sixtyMinutesController = new TextEditingController();
    TextEditingController nintyMinuteController = new TextEditingController();
    TextEditingController oneTwentyMinuteController =
        new TextEditingController();
    TextEditingController oneFiftyController = new TextEditingController();
    TextEditingController oneEightyMinuteController =
        new TextEditingController();

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
                                        "賃貸管理",
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
                                            setState(() {
                                              selectedDropdownValues
                                                  .add(val.toLowerCase());
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
                                          setState(() {});
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

  int getIndex(String val) {
    int indexPos;
    for (int i = 0; i < servicePriceModel.length; i++) {
      if (servicePriceModel[i].name == val.toLowerCase()) {
        indexPos = i;
        break;
      }
    }
    return indexPos;
  }
}
