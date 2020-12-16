import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:gps_massageapp/utils/dropdown.dart';

void main() {
  runApp(Popup());
}

class Popup extends StatefulWidget {
  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation; // Option 2

  var currentSelectedValue;
  List<String> deviceTypes = ["Mac", "Windows", "Mobile"];

  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  ListItem _selectedItem1;
  ListItem _selectedItem2;
  ListItem _selectedItem3;
  ListItem _selectedItem4;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    _selectedItem1 = _dropdownMenuItems[0].value;
    _selectedItem2 = _dropdownMenuItems[0].value;
    _selectedItem3 = _dropdownMenuItems[0].value;
    _selectedItem4 = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  bool readonly = false;
  bool visible = false;

  String userName,
      email,
      password,
      confirmPassword,
      companyName,
      department,
      sateLocation,
      _myActivity,
      _myState,
      departmentName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Testing")),
      body: Center(
        child: RaisedButton(
          child: Text("Show PopUp"),
          onPressed: () {
            //showChooseServiceAlert(context);
            showDropDownAlert1(context);
          },
        ),
      ),
    );
  }

  showChooseServiceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "計算したい日付を選択し",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                //print("LAT: ${test}");
                                print("User onTapped");
                              },
                              child: Image.asset(
                                'assets/images/user.png',
                                height: 150.0,
                                //width: 150.0,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap:() {
                                print("Provider onTapped");
                              },
                              child: Image.asset(
                                'assets/images/provider.png',
                                height: 150.0,
                                //width: 150.0,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              "不動産カレンダー",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],),*/
                  Text(
                    "不動産カレンダー不動産カレンダー",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            margin: const EdgeInsets.all(0.0),
            //height: 300.0,
            //width: 450.0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'assets/images/successpopuptop.png',
                      height: 150.0,
                      //width: 150.0,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "計算したい日付を選択し",
                      style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("OK",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            color: Colors.lime,
                            textColor: Colors.white,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Dialog Title'),
                                    content: Text('This is my content'),
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final _controller = new TextEditingController();
  final _controller1 = new TextEditingController();
  final _controller2 = new TextEditingController();
  final _controller3 = new TextEditingController();
  final _controller4 = new TextEditingController();

  /*void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }*/
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  showDropDownAlert1(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                          controller: _controller,
                                          decoration: InputDecoration(
                                            labelText: "その他",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          )
                                      )),
                                      SizedBox(width: 16.0,),
                                      Container(
                                        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey,
                                            border: Border.all()),
                                        child: Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                value: _selectedItem,
                                                items: _dropdownMenuItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItem = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  //margin: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                          controller: _controller1,
                                          decoration: InputDecoration(
                                            labelText: "その他",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          )
                                      )),
                                      SizedBox(width: 16.0,),
                                      Container(
                                        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey,
                                            border: Border.all()),
                                        child: Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                value: _selectedItem1,
                                                items: _dropdownMenuItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItem1 = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  //margin: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                          controller: _controller2,
                                          decoration: InputDecoration(
                                            labelText: "その他",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          )
                                      )),
                                      SizedBox(width: 16.0,),
                                      Container(
                                        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey,
                                            border: Border.all()),
                                        child: Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                value: _selectedItem2,
                                                items: _dropdownMenuItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItem2 = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  //margin: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                          controller: _controller3,
                                          decoration: InputDecoration(
                                            labelText: "その他",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          )
                                      )),
                                      SizedBox(width: 16.0,),
                                      Container(
                                        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey,
                                            border: Border.all()),
                                        child: Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                value: _selectedItem3,
                                                items: _dropdownMenuItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItem3 = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40.0,
                                  //margin: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: TextFormField(
                                          controller: _controller4,
                                          decoration: InputDecoration(
                                            labelText: "その他",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                          )
                                      )),
                                      SizedBox(width: 16.0,),
                                      Container(
                                        //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.grey,
                                            border: Border.all()),
                                        child: Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                value: _selectedItem4,
                                                items: _dropdownMenuItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItem4 = value;
                                                  });
                                                }),
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
                                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text("賃貸管理",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                          color: Colors.lime,
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: Text('Dialog Title'),
                                                  content: Text('This is my content'),
                                                )
                                            );
                                          },
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
    );
  }

  showDropDownAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(child: TextFormField(
                                  controller: _controller,
                                 decoration: InputDecoration(
                                    labelText: "その他",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                              )),
                              SizedBox(width: 16.0,),
                              Container(
                                //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey,
                                    border: Border.all()),
                                child: Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: _selectedItem,
                                        items: _dropdownMenuItems,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedItem = value;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40.0,
                          //margin: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(child: TextFormField(
                                  controller: _controller1,
                                  decoration: InputDecoration(
                                    labelText: "その他",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                              )),
                              SizedBox(width: 16.0,),
                              Expanded(
                                child: Container(
                                  //margin: EdgeInsets.all(0.0),
                                  color: Colors.transparent,
                                  //width: 100.0,
                                  child: DropDownFormField(
                                    //contentPadding: EdgeInsets.all(16.0),
                                    titleText: null,
                                    hintText:
                                    readonly ? _myActivity : '部署名 ',
                                    onSaved: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    value: _myActivity,
                                    onChanged: (value) {
                                      if (value == "その他") {
                                        setState(() {
                                          _myActivity = value;
                                          visible = true; // !visible;
                                        });
                                      } else {
                                        setState(() {
                                          _myActivity = value;
                                          visible = false;
                                        });
                                      }
                                    },
                                    dataSource: [
                                      {
                                        "display": "賃貸",
                                        "value": "賃貸",
                                      },
                                      {
                                        "display": "販売（売買）",
                                        "value": "販売（売買）",
                                      },
                                      {
                                        "display": "企画開発",
                                        "value": "企画開発",
                                      },
                                      {
                                        "display": "資産運用",
                                        "value": "資産運用",
                                      },
                                      {
                                        "display": "賃貸管理",
                                        "value": "賃貸管理",
                                      },
                                      {
                                        "display": "物流",
                                        "value": "物流",
                                      },
                                      {
                                        "display": "総務・経理",
                                        "value": "総務・経理",
                                      },
                                      {
                                        "display": "その他",
                                        "value": "その他",
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
                        Container(
                          height: 40.0,
                          //margin: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(child: TextFormField(
                                  controller: _controller2,
                                  decoration: InputDecoration(
                                    labelText: "その他",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                              )),
                              SizedBox(width: 16.0,),
                              Expanded(
                                child: Container(
                                  //margin: EdgeInsets.all(0.0),
                                  color: Colors.transparent,
                                  //width: 100.0,
                                  child: DropDownFormField(
                                    //contentPadding: EdgeInsets.all(16.0),
                                    titleText: null,
                                    hintText:
                                    readonly ? _myActivity : '部署名 ',
                                    onSaved: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    value: _myActivity,
                                    onChanged: (value) {
                                      if (value == "その他") {
                                        setState(() {
                                          _myActivity = value;
                                          visible = true; // !visible;
                                        });
                                      } else {
                                        setState(() {
                                          _myActivity = value;
                                          visible = false;
                                        });
                                      }
                                    },
                                    dataSource: [
                                      {
                                        "display": "賃貸",
                                        "value": "賃貸",
                                      },
                                      {
                                        "display": "販売（売買）",
                                        "value": "販売（売買）",
                                      },
                                      {
                                        "display": "企画開発",
                                        "value": "企画開発",
                                      },
                                      {
                                        "display": "資産運用",
                                        "value": "資産運用",
                                      },
                                      {
                                        "display": "賃貸管理",
                                        "value": "賃貸管理",
                                      },
                                      {
                                        "display": "物流",
                                        "value": "物流",
                                      },
                                      {
                                        "display": "総務・経理",
                                        "value": "総務・経理",
                                      },
                                      {
                                        "display": "その他",
                                        "value": "その他",
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
                        Container(
                          height: 40.0,
                          //margin: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(child: TextFormField(
                                  controller: _controller3,
                                  decoration: InputDecoration(
                                    labelText: "その他",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                              )),
                              SizedBox(width: 16.0,),
                              Expanded(
                                child: Container(
                                  //margin: EdgeInsets.all(0.0),
                                  color: Colors.transparent,
                                  //width: 100.0,
                                  child: DropDownFormField(
                                    //contentPadding: EdgeInsets.all(16.0),
                                    titleText: null,
                                    hintText:
                                    readonly ? _myActivity : '部署名 ',
                                    onSaved: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    value: _myActivity,
                                    onChanged: (value) {
                                      if (value == "その他") {
                                        setState(() {
                                          _myActivity = value;
                                          visible = true; // !visible;
                                        });
                                      } else {
                                        setState(() {
                                          _myActivity = value;
                                          visible = false;
                                        });
                                      }
                                    },
                                    dataSource: [
                                      {
                                        "display": "賃貸",
                                        "value": "賃貸",
                                      },
                                      {
                                        "display": "販売（売買）",
                                        "value": "販売（売買）",
                                      },
                                      {
                                        "display": "企画開発",
                                        "value": "企画開発",
                                      },
                                      {
                                        "display": "資産運用",
                                        "value": "資産運用",
                                      },
                                      {
                                        "display": "賃貸管理",
                                        "value": "賃貸管理",
                                      },
                                      {
                                        "display": "物流",
                                        "value": "物流",
                                      },
                                      {
                                        "display": "総務・経理",
                                        "value": "総務・経理",
                                      },
                                      {
                                        "display": "その他",
                                        "value": "その他",
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
                        Container(
                          height: 40.0,
                          //margin: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(child: TextFormField(
                                  controller: _controller4,
                                  decoration: InputDecoration(
                                    labelText: "その他",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  )
                              )),
                              SizedBox(width: 16.0,),
                              Expanded(
                                child: Container(
                                  //margin: EdgeInsets.all(0.0),
                                  color: Colors.transparent,
                                  //width: 100.0,
                                  child: DropDownFormField(
                                    //contentPadding: EdgeInsets.all(16.0),
                                    titleText: null,
                                    hintText:
                                    readonly ? _myActivity : '部署名 ',
                                    onSaved: (value) {
                                      setState(() {
                                        _myActivity = value;
                                      });
                                    },
                                    value: _myActivity,
                                    onChanged: (value) {
                                      if (value == "その他") {
                                        setState(() {
                                          _myActivity = value;
                                          visible = true; // !visible;
                                        });
                                      } else {
                                        setState(() {
                                          _myActivity = value;
                                          visible = false;
                                        });
                                      }
                                    },
                                    dataSource: [
                                      {
                                        "display": "賃貸",
                                        "value": "賃貸",
                                      },
                                      {
                                        "display": "販売（売買）",
                                        "value": "販売（売買）",
                                      },
                                      {
                                        "display": "企画開発",
                                        "value": "企画開発",
                                      },
                                      {
                                        "display": "資産運用",
                                        "value": "資産運用",
                                      },
                                      {
                                        "display": "賃貸管理",
                                        "value": "賃貸管理",
                                      },
                                      {
                                        "display": "物流",
                                        "value": "物流",
                                      },
                                      {
                                        "display": "総務・経理",
                                        "value": "総務・経理",
                                      },
                                      {
                                        "display": "その他",
                                        "value": "その他",
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
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("OK",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                  color: Colors.lime,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Dialog Title'),
                                          content: Text('This is my content'),
                                        )
                                    );
                                  },
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

  Widget _buildName({String imageAsset, String name, double score}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageAsset),
                radius: 30,
              ),
              SizedBox(width: 12),
              Text(name),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text("${score}"),
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showDateSelectAlert(BuildContext context) {
}
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}