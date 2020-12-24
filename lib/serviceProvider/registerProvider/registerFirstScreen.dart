import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSecondScreen.dart';
import 'package:gps_massageapp/utils/widgets.dart';
import 'package:gps_massageapp/utils/password-input.dart';
import 'package:gps_massageapp/utils/rounded-button.dart';
import 'package:gps_massageapp/utils/pallete.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gps_massageapp/customLibraryClasses/multiSelectDropdown/multiselectDropDownField.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class RegisterFirstScreen extends StatefulWidget {
  @override
  _RegisterFirstScreenState createState() => _RegisterFirstScreenState();
}

class _RegisterFirstScreenState extends State<RegisterFirstScreen> {
  File _image;
  final picker = ImagePicker();
  bool passwordVisibility = true;
  bool passwordConfirmVisibility = true;

  bool visible = false;

  List<ListItem> _dropdownItems = [
    ListItem(1, "施術店舗あり"),
    ListItem(2, "施術店舗あり 施術従業員なし（個人経営）"),
    ListItem(3, "施術店舗なし 施術従業員あり（出張のみ"),
    ListItem(4, "施術店舗なし 施術従業員なし（個人")
  ];
  List<ListItem> _numberOfEmployees = [
    ListItem(1, "　1　"),
    ListItem(2, "　2　"),
    ListItem(3, "　3　　"),
    ListItem(4, "4")
  ];
  List<ListItem> _businessTrip = [
    ListItem(1, "　はい　"),
    ListItem(2, "　いいえ　"),
  ];
  List<ListItem> _coronaTest = [
    ListItem(1, "　はい　"),
    ListItem(2, "　いいえ　"),
  ];

  List<ListItem> _childrenTest = [
    ListItem(1, "　キッズスペースの完備　"),
    ListItem(2, "　保育士の常駐　"),
    ListItem(3, "　子供同伴OK　"),
  ];
  List<ListItem> _genderTreatment = [
    ListItem(1, "　男性女性両方　"),
    ListItem(2, "　女性のみ　"),
    ListItem(3, "　男性のみ　"),
  ];
  List<ListItem> _gender = [
    ListItem(1, "　男性　"),
    ListItem(2, "　女性　"),
    ListItem(3, "　どちらでもない　"),
  ];
  List<ListItem> _address = [
    ListItem(1, "　現在地を取得する　"),
    ListItem(2, "　直接入力　"),
  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems1;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems2;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems3;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems4;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems5;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems6;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems7;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems8;

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
    _dropdownMenuItems1 = buildDropDownMenuItems(_numberOfEmployees);
    _dropdownMenuItems2 = buildDropDownMenuItems(_businessTrip);
    _dropdownMenuItems3 = buildDropDownMenuItems(_coronaTest);
    _dropdownMenuItems4 = buildDropDownMenuItems(_childrenTest);
    _dropdownMenuItems5 = buildDropDownMenuItems(_genderTreatment);
    _dropdownMenuItems6 = buildDropDownMenuItems(_gender);
    _dropdownMenuItems7 = buildDropDownMenuItems(_address);
    _dropdownMenuItems8 = buildDropDownMenuItems(_dropdownItems);
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
                        HealingMatchConstants.registrationFirstText,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                        HealingMatchConstants.registrationSecondText,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                              backgroundColor:
                                  Colors.grey[400].withOpacity(0.4),
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
                          HealingMatchConstants.registrationFacePhtoText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem1,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedItem1 = value;
                              });
                            }),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem2,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedItem2 = value;
                              });
                            }),
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
                          Expanded(
                            child: Text(
                              HealingMatchConstants.registrationBuisnessTrip,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black12,
                                border: Border.all(color: Colors.black12)),
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
                          Expanded(
                            child: Text(
                              HealingMatchConstants.registrationCoronaTxt,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black12,
                                border: Border.all(color: Colors.black12)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _selectedItem4,
                                  items: _dropdownMenuItems,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _selectedItem4 = value;
                                    });
                                  }),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem5,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedItem5 = value;
                              });
                            }),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem6,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedItem6 = value;
                              });
                            }),
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
                        HealingMatchConstants.registrationJapanAssociationTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.registrationName,
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        HealingMatchConstants.registrationStoreTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller1,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.registrationStoreName,
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
                          Expanded(
                              child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: _controller2,
                                decoration: InputDecoration(
                                    labelText:
                                        HealingMatchConstants.registrationDob,
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
                                        icon: Icon(Icons.calendar_today,
                                            size: 28),
                                        onPressed: () {
                                          debugPrint('222');
                                        }))),
                          )),
                          SizedBox(
                            width: 10.0,
                          ),
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
                                HealingMatchConstants.registrationAge,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        HealingMatchConstants.registrationGender,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black12,
                          border: Border.all(color: Colors.black12)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem7,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                _selectedItem7 = value;
                              });
                            }),
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller3,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.registrationPhnNum,
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        HealingMatchConstants.registrationStorePhnText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller4,
                              decoration: InputDecoration(
                                labelText: HealingMatchConstants
                                    .registrationStorePhnNum,
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller5,
                              decoration: InputDecoration(
                                labelText: HealingMatchConstants
                                    .registrationMailAdress,
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
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller6,
                              obscureText: passwordVisibility,
                              decoration: InputDecoration(
                                labelText:
                                    HealingMatchConstants.registrationPassword,
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
                                        passwordVisibility =
                                            !passwordVisibility;
                                      });
                                    }),
                              )),
                        )),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                /*   Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        "日付を選択し日付を選択し日付を選択し日付を選択し",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),*/
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller7,
                              obscureText: passwordConfirmVisibility,
                              decoration: InputDecoration(
                                labelText: HealingMatchConstants
                                    .registrationConfirmPassword,
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
                                        passwordConfirmVisibility =
                                            !passwordConfirmVisibility;
                                      });
                                    }),
                              )),
                        )),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _selectedItem8,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              print(value);
                              if (value == "Second Item") {
                                setState(() {
                                  _selectedItem8 = value;
                                  visible = true; // !visible;
                                });
                              } else {
                                setState(() {
                                  _selectedItem8 = value;
                                  visible = false;
                                });
                              }
                              /*setState(() {
                                _selectedItem8 = value;
                              });*/
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.width * 0.04),
                Visibility(
                  visible: visible,
                  child: Column(
                    children: [],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        HealingMatchConstants.registrationIndividualText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
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
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.black12),
                          child: TextFormField(
                              controller: _controller8,
                              decoration: InputDecoration(
                                  labelText: "♪101-0041東京都千代田区",
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
                                      icon: Icon(
                                          Icons.add_location_alt_outlined,
                                          size: 28),
                                      onPressed: () {
                                        debugPrint('222');
                                      }))),
                        )),
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
                          Expanded(
                              child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.black12),
                            child: TextFormField(
                                controller: _controller9,
                                decoration: InputDecoration(
                                  labelText: HealingMatchConstants
                                      .registrationBuildingName,
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
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.black12),
                              child: TextFormField(
                                  controller: _controller10,
                                  decoration: InputDecoration(
                                    labelText: HealingMatchConstants
                                        .registrationRoomNo,
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
                        HealingMatchConstants.registrationPointTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
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
                        child: Text(
                          HealingMatchConstants.registrationNextBtn,
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
                          HealingMatchConstants.registrationAlreadyActTxt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
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
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

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

/* class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _myActivities;
  List _esteticActivities,
      _relaxationActivities,
      _OsteopathicActivities,
      _fitnessActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _esteticActivities = [];
    _relaxationActivities = [];
    _OsteopathicActivities = [];
    _fitnessActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _esteticActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectDropDownField(
                  autovalidate: false,
                  chipBackGroundColor: Colors.lime,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.lime,
                  checkBoxCheckColor: Colors.lime,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text(
                    "Aesthetic",
                    style: TextStyle(fontSize: 16),
                  ),
                  /*validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },*/
                  dataSource: [
                    {
                      "display": "Running #120/120分",
                      "value": "Running #120/120分",
                    },
                    {
                      "display": "Running ell #120/120分",
                      "value": "Running ell #120/120分",
                    },
                    {
                      "display": "Running half #120/120分",
                      "value": "Running half #120/120分",
                    },
                    {
                      "display": "Running full #120/120分",
                      "value": "Running full #120/120分",
                    },
                    {
                      "display": "Soccer Practice #120/120分",
                      "value": "Soccer Practice #120/120分",
                    },
                    {
                      "display": "Baseball Practice #120/120分",
                      "value": "Baseball Practice #120/120分",
                    },
                    {
                      "display": "Football Practice #120/120分",
                      "value": "Football Practice #120/120分",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}

 */
