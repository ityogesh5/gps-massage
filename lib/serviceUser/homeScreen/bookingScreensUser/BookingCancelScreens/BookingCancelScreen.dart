import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/customRadioButtonList/roundedRadioButton.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class BookingCancelScreen extends StatefulWidget {
  final int bookingId;

  BookingCancelScreen(this.bookingId);
  @override
  State<StatefulWidget> createState() {
    return _BookingCancelScreenState();
  }
}

class _BookingCancelScreenState extends State<BookingCancelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [ConfirmCancelScreen(widget.bookingId)],
      ),
    );
  }
}

class ConfirmCancelScreen extends StatefulWidget {
  final int bookingId;
  ConfirmCancelScreen(this.bookingId);
  @override
  State<StatefulWidget> createState() {
    return _ConfirmCancelScreenState();
  }
}

class _ConfirmCancelScreenState extends State<ConfirmCancelScreen> {
  Map<String, dynamic> _formData = {
    'text': null,
    'category': null,
    'date': null,
    'time': null,
  };
  String selectedBuildingType;
  bool isOtherSelected = false;
  final _cancelReasonController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CancelPopupScreen();
  }

  Widget CancelPopupScreen() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.87,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          boxShadow: [
            new BoxShadow(
                color: Colors.grey[300],
                blurRadius: 3.0,
                offset: new Offset(1.0, 1.0))
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.grey[200],
                      child: CircleAvatar(
                        maxRadius: 39,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        child: Image.asset('assets/images_gps/calendar.png'),
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          maxRadius: 9.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            maxRadius: 8.0,
                            child: Icon(Icons.clear,
                                size: 12, color: Colors.black),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 7),
                Text(
                  'キャシセルする語を記入ください',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'NotoSansJP'),
                ),
                SizedBox(height: 7),
                massageBuildTypeDisplayContent(),
                SizedBox(height: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        HealingMatchConstants.bookingCancelStatus == 6
                            ? '${HealingMatchConstants.cancellationFeeCost}'
                            : '',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'NotoSansJP'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * 0.30,
                            child: CustomToggleButton(
                              elevation: 0,
                              height: 55.0,
                              width: MediaQuery.of(context).size.width * 0.35,
                              autoWidth: false,
                              buttonColor: Colors.grey[300],
                              enableShape: true,
                              customShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.transparent)),
                              buttonLables: ["はい", "いいえ"],
                              fontSize: 16.0,
                              buttonValues: [
                                "Y",
                                "N",
                              ],
                              radioButtonValue: (value) {
                                if (value == 'Y') {
                                  cancelBooking();
                                } else if (value == 'N') {
                                  Navigator.pop(context);
                                }
                              },
                              selectedColor: Colors.lime,
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cancelBooking() {
    String otherCategory = _cancelReasonController.text;
    String cancelReason =
        selectedBuildingType == "その他" ? otherCategory : selectedBuildingType;
    if (selectedBuildingType == null || selectedBuildingType == '') {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセルの理由を選択してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if ((selectedBuildingType == "その他") &&
        (otherCategory == null || otherCategory == '')) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセルの理由を入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }
    if ((selectedBuildingType == "その他") && (otherCategory.length > 125)) {
      ProgressDialogBuilder.hideLoader(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('キャンセル理由を125以内で入力してください。',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'NotoSansJP')),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              },
              child: Text('はい',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ));
      return null;
    }

    try {
      ProgressDialogBuilder.showOverlayLoader(context);
      ServiceUserAPIProvider.removeEvent(
              HealingMatchConstants.calEventId, context)
          .then((value) {
        if (value) {
          ServiceUserAPIProvider.updateBookingCompeted(
              widget.bookingId, cancelReason);
          ProgressDialogBuilder.hideLoader(context);

          DialogHelper.showUserBookingCancelDialog(context);
        } else {
          ProgressDialogBuilder.hideLoader(context);
        }
      });
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('cancelException : ${e.toString()}');
    }
  }

  Widget massageBuildTypeDisplayContent() {
    bool newChoosenVal = false;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      )),
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
