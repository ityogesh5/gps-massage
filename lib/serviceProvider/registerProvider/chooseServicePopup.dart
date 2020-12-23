import 'package:flutter/material.dart';

import '../popup.dart';

class ChooseServicePopup extends StatefulWidget {
  @override
  _ChooseServicePopupState createState() => _ChooseServicePopupState();
}

class _ChooseServicePopupState extends State<ChooseServicePopup> {
  final _controller = new TextEditingController();
  final _controller1 = new TextEditingController();
  final _controller2 = new TextEditingController();
  final _controller3 = new TextEditingController();
  final _controller4 = new TextEditingController();
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

  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
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
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      labelText: "その他",
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
                            Container(
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all()),
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
                                    controller: _controller1,
                                    decoration: InputDecoration(
                                      labelText: "その他",
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
                            Container(
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all()),
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
                                    controller: _controller2,
                                    decoration: InputDecoration(
                                      labelText: "その他",
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
                            Container(
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all()),
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
                                    controller: _controller3,
                                    decoration: InputDecoration(
                                      labelText: "その他",
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
                            Container(
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all()),
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
                                    controller: _controller4,
                                    decoration: InputDecoration(
                                      labelText: "その他",
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
                            Container(
                              //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey,
                                  border: Border.all()),
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
                              child: RaisedButton(
                                padding: EdgeInsets.all(15.0),
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
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text('Dialog Title'),
                                            content: Text('This is my content'),
                                          ));
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
      ),
    );
  }
}
