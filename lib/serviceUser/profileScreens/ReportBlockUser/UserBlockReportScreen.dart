import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:keyboard_service/keyboard_service.dart';

Map<String, dynamic> _formData = {
  'text': null,
  'category': null,
  'date': null,
  'time': null,
};
var selectedBuildingType;

class ReportUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportUserScreenView();
  }
}

class _ReportUserScreenView extends State<ReportUserScreen> {
  String reasonSelect = '報告の理由';
  String reportCategory;
  String reportComments;
  final reasonController = new TextEditingController();

  GlobalKey<ScaffoldState> _snackBarKey = new GlobalKey<ScaffoldState>();

  bool newChoosenVal = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAutoDismiss(
      scaffold: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        key: _snackBarKey,
        appBar: AppBar(
          title: Text(
            'ユーザーを報告する', // Hint App bar text : 虐待ユーザーを報告する
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'NotoSansJP',
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Text(
                        '報告する理由を選択してください',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: 'NotoSansJP'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ReportCategories.initial()
                            .categories
                            .map((ReportCategory category) {
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
                                    _handleCategoryChange(
                                        newChoosenVal, category);
                                  }),
                            ),
                            onTap: () {
                              _handleCategoryChange(true, category);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                AnimatedButton(
                    text: '報告する',
                    width: 350,
                    pressEvent: () {
                      NavigationRouter.switchToServiceUserBottomBar(context);
                    })
              ]),
        ),
      ),
    );
  }

  Future<void> _reportUser() async {}

  void _handleCategoryChange(bool newVal, ReportCategory category) {
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

class ReportCategory {
  final String name;

  ReportCategory({this.name});
}

class ReportCategories {
  final List<ReportCategory> categories;
  List<String> reportUserReason = [
    '不適切な画像',
    'ヌードやポルノが含まれています',
    '子供の危険（搾取）',
    '嫌がらせや脅迫',
  ];

  ReportCategories(this.categories);

  factory ReportCategories.initial() {
    return ReportCategories(
      <ReportCategory>[
        ReportCategory(name: 'ヌードやポルノが含まれています'),
        ReportCategory(name: '子供の危険（搾取）'),
        ReportCategory(name: '嫌がらせや脅迫'),
        ReportCategory(name: '不適切な画像'),
      ],
    );
  }
}
