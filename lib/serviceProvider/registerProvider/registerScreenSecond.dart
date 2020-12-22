import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSecondScreen.dart';
import 'package:gps_massageapp/utils/widgets.dart';
import 'package:gps_massageapp/utils/password-input.dart';
import 'package:gps_massageapp/utils/rounded-button.dart';
import 'package:gps_massageapp/utils/pallete.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreenSecond extends StatefulWidget {
  @override
  _RegisterScreenSecondState createState() => _RegisterScreenSecondState();
}

class _RegisterScreenSecondState extends State<RegisterScreenSecond> {
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
  ListItem _selectedItem5;
  ListItem _selectedItem6;
  ListItem _selectedItem7;
  ListItem _selectedItem8;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    _selectedItem1 = _dropdownMenuItems[0].value;
    _selectedItem2 = _dropdownMenuItems[0].value;
    _selectedItem3 = _dropdownMenuItems[0].value;
    _selectedItem4 = _dropdownMenuItems[0].value;
    _selectedItem5 = _dropdownMenuItems[0].value;
    _selectedItem6 = _dropdownMenuItems[0].value;
    _selectedItem7 = _dropdownMenuItems[0].value;
    _selectedItem8 = _dropdownMenuItems[0].value;
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

  final _controller = new TextEditingController();
  final _controller1 = new TextEditingController();
  final _controller2 = new TextEditingController();
  final _controller3 = new TextEditingController();
  final _controller4 = new TextEditingController();
  final _controller5 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        children: [
        Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: size.width * 0.2),
          Center(
            child: Text(
              "計算したい日付を選択し",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Center(
            child: Text(
              "日付を選択し",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: size.width * 0.1),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black12,
                border: Border.all(color: Colors.black12)),
            child: Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedItem = value;
                      });
                    }),
              ),
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            child: TextFormField(
              controller: _controller,
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
                      onPressed: () {}, icon: Icon(Icons.file_upload)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                  hintText: "本人確認書のアップロード",
                  fillColor: Colors.white),

            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '保有資格の種類を選択し、\n証明書をアップロードしてください。',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black12,
                border: Border.all(color: Colors.black12)),
            child: Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedItem = value;
                      });
                    }),
              ),
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            width: size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(8.0),
                  //shadowColor: Colors.grey,
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('abcd'),
                        Text('abcdefgh'),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.file_upload),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '保有資格の種類を選択し',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
              height: size.height * 0.06,
              width: size.width * 0.9,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(splashColor: Colors.black12),
                child: TextFormField(
                    controller: _controller1,
                    decoration: InputDecoration(
                      labelText: "その他",
                      filled: true,
                      fillColor: Colors.black12,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    )),
              )),
          SizedBox(height: size.width * 0.03),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            child: TextFormField(
              controller: _controller2,
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
                      onPressed: () {}, icon: Icon(Icons.file_upload)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                  hintText: "本人確認書のアップロード",
                  fillColor: Colors.white),

            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            width: size.width * 0.9,
            child: Text(
              "日付を選択し日付を選択し日付を選択し日付を選択し",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: size.width * 0.03),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.8,
            //margin: EdgeInsets.all(16.0),
            //margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                          border: Border.all(color: Colors.black12)),
                      child: Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _selectedItem3,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _selectedItem3 = value;
                                });
                              }),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.black12),
                        child: TextFormField(
                            controller: _controller4,
                            decoration: InputDecoration(
                              labelText: "その他",
                              filled: true,
                              fillColor: Colors.black12,
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
                        ),
                      )),
                ),
              ],
            ),
          ), SizedBox(height: size.width * 0.04),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.8,
            //margin: EdgeInsets.all(16.0),
            //margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.black12),
                      child: TextFormField(
                          controller: _controller3,
                          decoration: InputDecoration(
                            labelText: "その他",
                            filled: true,
                            fillColor: Colors.black12,
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
                          )),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.black12),
                        child: TextFormField(
                            controller: _controller4,
                            decoration: InputDecoration(
                              labelText: "その他",
                              filled: true,
                              fillColor: Colors.black12,
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
                        ),
                      )),
                ),
              ],
            ),
          ), SizedBox(height: size.width * 0.04),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.8,
            //margin: EdgeInsets.all(16.0),
            //margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                          border: Border.all(color: Colors.black12)),
                      child: Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _selectedItem3,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  _selectedItem3 = value;
                                });
                              }),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      ),
                ),
              ],
            ),
          ), SizedBox(height: size.width * 0.04),
          Container(
            height: size.height * 0.06,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lime,
            ),
            child: RaisedButton(
              //padding: EdgeInsets.all(15.0),
              child: Text(
                "日付を選択し日付",
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              color: Colors.lime,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RegistrationSecondPage()));
              },
            ),
          ),
          SizedBox(height: size.width * 0.04),
          Container(
            width: size.width * 0.9,
            child: InkWell(
              onTap: () {
                print("User onTapped");
              },
              child: Text(
                "日付を選択し日付を選択し日付を選択し日",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(height: size.width * 0.04),
        ],
        ),
        ),
        )
    ],
    );
  }
}
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}