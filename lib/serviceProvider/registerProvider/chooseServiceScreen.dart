import 'package:flutter/material.dart';

class ChooseServiceScreen extends StatefulWidget {
  @override
  _ChooseServiceScreenState createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  List<String> dropdownValues = List<String>();
  List<String> selectedDropdownValues = List<String>();
  List<int> priceValues = List<int>();
  int status = 0;
  TextEditingController sampleOthersController = TextEditingController();
  final sixtyMinutesController = new TextEditingController();
  final nintyMinuteController = new TextEditingController();
  final oneMinuteController = new TextEditingController();
  final oneFiftyController = new TextEditingController();
  final oneEightyMinuteController = new TextEditingController();

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
    checkValue = selectedDropdownValues.contains(val.toLowerCase());
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
                          selectedDropdownValues.remove(val.toLowerCase());
                        } else {
                          checkValue = newValue;
                          if (newValue) {
                            selectedDropdownValues.add(val.toLowerCase());
                          }
                          showTimeandPriceDialog();
                        }
                      });
                    },
                  ),
                  Text("$val", style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  //  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showTimeandPriceDialog();
                      }),
                )
              ],
            ))
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
                                });
                              },
                              child: Text("Add"),
                              color: Colors.lime,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "others",
                          fillColor: Colors.grey[200]),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
            : (checkValue == true && val == "one")
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: buildCheckBoxTimePriceChip(),
                    ),
                  )
                : Container(),
      ],
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

  showTimeandPriceDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      controller: oneMinuteController,
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      borderRadius: BorderRadius.circular(10.0),
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
        );
      },
    );
  }
}
