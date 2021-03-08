import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

bool isOtherSelected = false;
final _cancelReasonController = new TextEditingController();
Map<String, dynamic> _formData = {
  'text': null,
  'category': null,
  'date': null,
  'time': null,
};
var selectedBuildingType;
bool isCancelSelected = false;

class BookingApproveThirdScreen extends StatefulWidget {
  @override
  State createState() {
    return _BookingApproveThirdScreenState();
  }
}

class _BookingApproveThirdScreenState extends State<BookingApproveThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ApprovalSecondScreen(),
    );
  }
}

class ApprovalSecondScreen extends StatefulWidget {
  @override
  State createState() {
    return _ApprovalSecondScreenState();
  }
}

class _ApprovalSecondScreenState extends State<ApprovalSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DottedBorder(
                    dashPattern: [2, 2],
                    strokeWidth: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.Circle,
                    radius: Radius.circular(5),
                    child: CircleAvatar(
                      maxRadius: 55,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      child: SvgPicture.asset('assets/images_gps/calendar.svg',
                          height: 45, width: 45, color: Colors.lime),
                    )),
                SizedBox(height: 10),
                Text(
                  'セラピストからリクエストがありました。',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'NotoSansJP'),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(242, 242, 242, 1),
                            Color.fromRGBO(242, 242, 242, 1)
                          ]),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey[100],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[100]),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      new Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          new Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      'assets/images_gps/profile.png'),
                                ),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            'お名前',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansJP'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          Image.asset('assets/images_gps/calendar.png',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            '10月17',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansJP'),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          Text(
                            '月曜日出張',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                                fontFamily: 'NotoSansJP'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/clock.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          new Text(
                            '09:  00～10:  00',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'NotoSansJP'),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          new Text(
                            '60分',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontFamily: 'NotoSansJP'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/cost.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Chip(
                            label: Text('足つぼ'),
                            backgroundColor: Colors.grey[200],
                          ),
                          Text(
                            "\t\t¥4,500",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            '(交通費込み-1,000)',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                                fontFamily: 'NotoSansJP'),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Divider(),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 1),
                                  child: SvgPicture.asset(
                                      'assets/images_gps/chat.svg',
                                      height: 30,
                                      width: 30)),
                            ),
                          ]),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/gps.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            '施術を受ける場所',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansJP'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(255, 255, 255, 1),
                                          Color.fromRGBO(255, 255, 255, 1)
                                        ]),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '店舗',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'NotoSansJP'),
                                  ),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Flexible(
                              child: Text(
                                '埼玉県浦和区高砂4丁目4',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                    fontFamily: 'NotoSansJP'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Text(
              'リクエストの詳細',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(242, 242, 242, 1),
                      Color.fromRGBO(242, 242, 242, 1)
                    ]),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey[100],
                ),
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey[100]),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.27,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                new Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Text(
                      '提案時間',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                    Spacer(),
                    Text(
                      '10:  00~11:  00',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Icon(Icons.arrow_forward,
                        color: Colors.grey[400], size: 20),
                    Spacer(),
                    Text(
                      '10:  30~11:  30',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    new Text(
                      'サービス料金',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'NotoSansJP'),
                    ),
                    Spacer(),
                    //¥4,500
                    new Text(
                      '¥3,500',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    new Text(
                      '交通費',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                    Spacer(),
                    Text(
                      '¥0',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Icon(Icons.arrow_forward,
                        color: Colors.grey[400], size: 20),
                    Spacer(),
                    new Text(
                      '¥1,000',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  ],
                ),
                Expanded(
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(),
                    )),
                  ]),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    new Text(
                      '合計',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Spacer(),
                    Text(
                      '¥3,500',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Icon(Icons.arrow_forward,
                        color: Colors.grey[400], size: 20),
                    Spacer(),
                    new Text(
                      '¥4,500',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontFamily: 'NotoSansJP'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.35,
                  child: CustomToggleButton(
                    elevation: 0,
                    height: 55.0,
                    width: 170.0,
                    autoWidth: false,
                    buttonColor: Color.fromRGBO(217, 217, 217, 1),
                    enableShape: true,
                    customShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.transparent)),
                    buttonLables: ["キャンセルする", "支払に進む"],
                    fontSize: 16.0,
                    buttonValues: [
                      "Y",
                      "N",
                    ],
                    radioButtonValue: (value) {
                      if (value == 'Y') {
                        setState(() {
                          isCancelSelected = true;
                        });
                      } else {
                        setState(() {
                          isCancelSelected = !isCancelSelected;
                        });
                      }
                      print('Radio value : $isCancelSelected');
                    },
                    selectedColor: Color.fromRGBO(200, 217, 33, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Visibility(
              visible: isCancelSelected,
              child: massageBuildTypeDisplayContent())
        ],
      ),
    );
  }

  Widget massageBuildTypeDisplayContent() {
    bool newChoosenVal = false;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Text(
            'キャンセルする理由を選択してください',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
                fontFamily: 'NotoSansJP'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: BuildingCategories.initial()
                .categories
                .map((BuildingCategory category) {
              final bool selected =
                  _formData['category']?.name == category.name;
              return ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: new Text('${category.name}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'NotoSansJP')),
                    ),
                  ],
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomRadioButton(
                      color: Colors.black,
                      selected: selected,
                      onChange: (newVal) {
                        newChoosenVal = newVal;
                        _handleCategoryChange(newChoosenVal, category);
                        if (category.name.contains('その他')) {
                          print(
                              'SELECTED VALUE IF ON CHANGE : ${category.name}');

                          setState(() {
                            isOtherSelected = true;
                          });
                        } else {
                          _handleCategoryChange(true, category);
                          print(
                              'SELECTED VALUE ELSE ON CHANGE : ${category.name}');
                          setState(() {
                            isOtherSelected = false;
                          });
                        }
                      }),
                ),
                onTap: () {
                  _handleCategoryChange(true, category);
                  if (category.name.contains('その他')) {
                    print('SELECTED VALUE IF ON TAP : ${category.name}');
                    setState(() {
                      isOtherSelected = true;
                    });
                  } else {
                    _handleCategoryChange(true, category);
                    print('SELECTED VALUE ELSE ON TAP : ${category.name}');
                    setState(() {
                      isOtherSelected = false;
                    });
                  }
                },
              );
            }).toList(),
          ),
          Visibility(
            visible: isOtherSelected,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: TextField(
                        controller: _cancelReasonController,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        decoration: new InputDecoration(
                            filled: false,
                            fillColor: Colors.white,
                            hintText: 'キャシセルする理由を記入ください',
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    ),
                    Positioned(
                      top: 95,
                      left: 300,
                      right: 10,
                      bottom: 5,
                      child: CircleAvatar(
                        maxRadius: 30.0,
                        backgroundColor: Colors.grey[300],
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 20.0,
                          child: IconButton(
                            icon: Icon(Icons.send, color: Colors.lime),
                            iconSize: 25.0,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCategoryChange(bool newVal, BuildingCategory category) {
    setState(() {
      if (newVal) {
        _formData['category'] = category;
        selectedBuildingType = category.name;
        print('Chosen value : $newVal : name : $selectedBuildingType');
      } else {
        _formData['category'] = null;
      }
    });
  }
}

class BuildingCategory {
  final String name;

  BuildingCategory({this.name});
}

class BuildingCategories {
  final List<BuildingCategory> categories;

  BuildingCategories(this.categories);

  factory BuildingCategories.initial() {
    return BuildingCategories(
      <BuildingCategory>[
        BuildingCategory(name: '都合が悪くなったため'),
        BuildingCategory(name: '提案のあった追加料金が高かったため'),
        BuildingCategory(name: '提案のあった時間は都合が悪いため'),
        BuildingCategory(name: 'その他'),
      ],
    );
  }
}
