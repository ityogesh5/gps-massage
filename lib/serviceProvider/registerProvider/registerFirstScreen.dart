import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_massageapp/utils/widgets.dart';
import 'package:gps_massageapp/utils/password-input.dart';
import 'package:gps_massageapp/utils/rounded-button.dart';
import 'package:gps_massageapp/utils/pallete.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(RegisterFirstScreen());
}

/*class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ヒーリングマッチ',
      home: RegisterFirstScreen(),
    );
  }
}*/

class RegisterFirstScreen extends StatefulWidget {
  @override
  _RegisterFirstScreenState createState() => _RegisterFirstScreenState();
}

class _RegisterFirstScreenState extends State<RegisterFirstScreen> {

  File _image;
  final picker = ImagePicker();
  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;

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
  final _controller6 = new TextEditingController();
  final _controller7 = new TextEditingController();
  final _controller8 = new TextEditingController();
  final _controller9 = new TextEditingController();
  final _controller10 = new TextEditingController();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Container(
        child: Text('ヒーリングマッチ'),
      ),
    );*/
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.2,
                ),
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "計算したい日付を選択し",
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.03,
                ),
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "日付を選択し",
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                /*Stack(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Container(
                            height: 100,
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.75,
                            margin: EdgeInsets.only(top: 45),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 1),
                                      Color.fromRGBO(255, 255, 255, 1),
                                    ]),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                    color: Colors.grey.shade300)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 10, right: 10),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor:
                                  Color.fromRGBO(251, 72, 227, 1),
                                  inactiveTrackColor:
                                  Color.fromRGBO(169, 233, 250, 1),
                                  trackShape:
                                  RoundedRectSliderTrackShape(),
                                  trackHeight: 2.0,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 8.0),
                                  thumbColor:
                                  Color.fromRGBO(251, 72, 227, 1),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                  tickMarkShape:
                                  RoundSliderTickMarkShape(),
                                  activeTickMarkColor: Colors.red[700],
                                  inactiveTickMarkColor: Colors.red[100],
                                  valueIndicatorShape:
                                  PaddleSliderValueIndicatorShape(),
                                  valueIndicatorColor: Colors.redAccent,
                                  valueIndicatorTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Open Sans'),
                                ),
                                child: RangeSlider(
                                  min: 1,
                                  max: 100,
                                  values: values,
                                  divisions: 1,
                                  labels: labels,
                                  activeColor:
                                  Color.fromRGBO(253, 99, 232, 100),
                                  inactiveColor:
                                  Color.fromRGBO(169, 233, 250, 1),
                                  onChanged: (value) {
                                    //print('START: ${value.start}, END: ${value.end}');
                                    setState(() {
                                      values = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: InkWell(
                            onTap: () {
                              _showPicker(context);
                              print("User onTapped");
                            },
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(0.4),
                              child: _image != null
                                  ? ClipRRect(
                                //borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                ),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  color: kWhite,
                                  size: size.width * 0.1,
                                ),
                              ),
                              /*child: Icon(
                                FontAwesomeIcons.user,
                                color: kWhite,
                                size: size.width * 0.1,
                              ),*/
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.width * 0.1),
                Stack(
                  children: [
                    Container(
                      width: 280,
                      child: Center(
                        child: Text(
                          "日付を選択し日付を選択し日付を選択し日付を選択し 日付を選択し日付を選択し日付を選択し日付を選択し", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                                setState(() {
                                  _selectedItem = value;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      //margin: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(
                            "計算したい日付を選択し",
                            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          ),
                          SizedBox(width: 10.0,),
                          Container(
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      //margin: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(
                            "計算したい日付を選択し",
                            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          ),
                          SizedBox(width: 10.0,),
                          Container(
                            //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black12,
                                border: Border.all(color: Colors.black12)),
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                              value: _selectedItem5,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem5 = value;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                              value: _selectedItem6,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem6 = value;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し 日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し 日付を選択し日付を選択し日付を選択し日付を選択し", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.black12),
                        child: TextFormField(
                            controller: _controller,
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
                            )
                        ),
                      )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.black12),
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
                            )
                        ),
                      )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      //margin: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: _controller2,
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
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.calendar_today,size: 28),
                                        onPressed: () {
                                          debugPrint('222');
                                        })
                                )
                            ),
                          )
                          ),
                          SizedBox(width: 10.0,),
                          Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: FlatButton(
                              //textColor: Colors.grey,
                              //disabledTextColor: Colors.grey,
                              onPressed: () {},
                              child: Text(
                                "計算",
                                style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                //kBodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      //margin: EdgeInsets.all(16.0),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(
                            "計算したい日付を選択し",
                            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          ),
                          SizedBox(width: 10.0,),
                          Container(
                            //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black12,
                                border: Border.all(color: Colors.black12)),
                            child: Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: _selectedItem7,
                                    items: _dropdownMenuItems,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItem7 = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller3,
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
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
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
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller5,
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
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller6,
                              obscureText: passwordVisibility,
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
                                suffixIcon: IconButton(
                                    icon: passwordVisibility
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisibility = !passwordVisibility;
                                      });
                                    }),
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller7,
                              obscureText: passwordConfirmVisibility,
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
                                suffixIcon: IconButton(
                                    icon: passwordConfirmVisibility
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        passwordConfirmVisibility = !passwordConfirmVisibility;
                                      });
                                    }),
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
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
                              value: _selectedItem8,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem8 = value;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し 日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し ", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.8,
                        child: Theme(
                          data: Theme.of(context).copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller8,
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
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.add_location_alt_outlined,size: 28),
                                      onPressed: () {
                                        debugPrint('222');
                                      })
                              )
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.8,
                      //margin: EdgeInsets.all(16.0),
                      //margin: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        children: [
                          Expanded(child: Theme(
                            data: Theme.of(context).copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: _controller9,
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
                          SizedBox(width: 10.0,),
                          Expanded(
                            child: Container(
                                child: Theme(
                                  data: Theme.of(context).copyWith(splashColor: Colors.black12),
                                  child: TextFormField(
                                      controller: _controller10,
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
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し 日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し日付を選択し ", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lime,
                      ),
                      child: RaisedButton(
                        //padding: EdgeInsets.all(15.0),
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: InkWell(
                        onTap: () {
                          _showPicker(context);
                          print("User onTapped");
                        },
                        child: Text(
                          "日付を選択し日付を選択し日付を選択し日", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}